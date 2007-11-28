From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Tue, 27 Nov 2007 17:13:58 -0800
Message-ID: <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
	<Pine.LNX.4.64.0711271617350.27959@racer.site>
	<20071128000731.GD9174@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaQ==?= Ngoc Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxBVU-0001p7-NO
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 02:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413AbXK1BOK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 20:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbXK1BOI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 20:14:08 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33912 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbXK1BOH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 20:14:07 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 397D62EF;
	Tue, 27 Nov 2007 20:14:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 97C9E9A849;
	Tue, 27 Nov 2007 20:14:23 -0500 (EST)
In-Reply-To: <20071128000731.GD9174@efreet.light.src> (Jan Hudec's message of
	"Wed, 28 Nov 2007 01:07:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66281>

Jan Hudec <bulb@ucw.cz> writes:

> On Tue, Nov 27, 2007 at 16:18:01 +0000, Johannes Schindelin wrote:
>> Hi,
>>=20
>> On Tue, 27 Nov 2007, Nguy=E1=BB=85n Th=C3=A1i Ngoc Duy wrote:
>>=20
>> >  Both configure and make-only ways should work now
>>=20
>> I thought your plan was to put the non-porcelain into the libexecdir=
 only?
>
> I had the impression that deprecating the dash notation for /all/ use=
 was
> approved some time ago. Though I don't want to search through the lis=
t
> archives this late in the night to check it.

Yes.  Moving the dash-form commands out of end user's PATH was somethin=
g
distros and users have been allowed to do since forever, and strictly
speaking, using dash form from the command line was already deprecated
at that point.

If your script runs git-foo without first asking "git --exec-path" and
prepending it to the path, your script would not find git-foo if the
installation uses gitexecdir that is not on the usual $PATH, either.

I essentially just said that your patch is unnecessary, but at the same
time, your patch does not go far enough.  As Nico earlier pointed out,
we ship a sample rpm spec, which would also need to be updated.  We do
not ship a sample debian/rules anymore, thank $DEITY ;-)

Also, because we do not remove existing files from the installation
target directory when we do "make install", the commit log message
should carry a big fat warning that says "remove old installation of gi=
t
from your $(bindir) when you try this," for people who build from the
source, and we need to repeat the deprecation notice in bold red letter=
s
in the Release Notes for perhaps git 1.6.0.

In case somebody is thinking about 36e5e70e0f40 (Start deprecating
"git-command" in favor of "git command"), that is a somewhat different
issue.  What Linus suggested is not installing git-foo link for built-i=
n
commands _anywhere_ on the filesystem.  Not just "out of user's PATH".
That is not deprecating dash form but removing the support for it.  We
need to give ample time for users to adjust to such a change.
