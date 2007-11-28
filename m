From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Wed, 28 Nov 2007 15:14:56 -0800
Message-ID: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
	<Pine.LNX.4.64.0711271617350.27959@racer.site>
	<20071128000731.GD9174@efreet.light.src>
	<7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jan Hudec" <bulb@ucw.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:15:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxW81-0000NI-JG
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124AbXK1XPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755878AbXK1XPH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:15:07 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55528 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbXK1XPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:15:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1C26F2FA;
	Wed, 28 Nov 2007 18:15:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CD6E9ACFB;
	Wed, 28 Nov 2007 18:15:20 -0500 (EST)
In-Reply-To: <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Wed, 28 Nov 2007 15:36:23 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66460>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On Nov 28, 2007 8:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> In case somebody is thinking about 36e5e70e0f40 (Start deprecating
>> "git-command" in favor of "git command"), that is a somewhat different
>> issue.  What Linus suggested is not installing git-foo link for built-in
>> commands _anywhere_ on the filesystem.  Not just "out of user's PATH".
>> That is not deprecating dash form but removing the support for it.  We
>> need to give ample time for users to adjust to such a change.
>
> A little note on this one. I've been using git without builtin links
> for a while with my git-box port. There are still some builtin fixups
> needed. And because execv_git_cmd() always uses dash form, so it's
> impossible to use vanilla git without builtin links.

Thanks for a heads up.

Would people agree with a rough roadmap like this?

 - v1.5.4 will ship with gitexecdir=$(bindir) in Makefile.  But the
   release notes for the version will warn users that:

   (1) using git-foo from the command line, and

   (2) using git-foo from your scripts without first prepending the
       return value of "git --exec-path" to the PATH

   is now officially deprecated (it has been deprecated for a long time
   since January 2006, v1.2.0~149) and upcoming v1.5.5 will ship with
   the default configuration that does not install git-foo form in
   user's PATH.

 - Post v1.5.4, start cooking gitexecdir=$(libexecdir)/git-core, aiming
   for inclusion in v1.5.5, perhaps in Mar-Feb 2008 timeframe.

 - The release notes for v1.5.5 will warn users that git-foo will be
   removed in v1.6.0 for many commands and it will be merely an accident
   if some of them still work.

 - Post v1.5.5, start cooking the change that does not install hardlinks
   for built-in commands, aiming for inclusion in v1.6.0, by the end of
   2008.
