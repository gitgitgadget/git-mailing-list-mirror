From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 12:45:18 -0700
Message-ID: <7vlkbup1kh.fsf@gitster.siamese.dyndns.org>
References: <1188319608.6106.63.camel@beauty>
	<20070828172709.GB1219@pasky.or.cz>
	<200708291005.08795.andyparkins@gmail.com>
	<20070829095202.GE1219@pasky.or.cz>
	<b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
To: "Benjamin Collins" <aggieben@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 21:45:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQTU3-0004fO-8Z
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 21:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760370AbXH2Tpf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 15:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760373AbXH2Tpf
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 15:45:35 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962AbXH2Tpd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 15:45:33 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DA434128C83;
	Wed, 29 Aug 2007 15:45:51 -0400 (EDT)
In-Reply-To: <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com>
	(Benjamin Collins's message of "Wed, 29 Aug 2007 08:18:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56974>

"Benjamin Collins" <aggieben@gmail.com> writes:

> On 8/29/07, Petr Baudis <pasky@suse.cz> wrote:
>> But overally, I'm still not convinced that there is a feasible use-case
>> for the cloned hooks at all. Someone has a particular example?
>>
>> --
>>                                 Petr "Pasky" Baudis
>
> My group at work would like this capability.  We have a homogeneous
> environment with well-known NFS shares, and some scripts that do
> things in this common environment (e.g., release scripts).  It would
> be nice if when we do a clone, all the hook scripts (that would be
> valid on any machine, in any directory, for any user) would come with
> it.
>
> Of course, I understand why it's not already like that, particularly
> given the context of Linux development practices.  Still - there are
> those of us that think this would be a great convenience.  Having an
> option to git-clone to retrieve the parent's hook scripts would be
> preferable, and have git-clone just disable them by default.
> 'git-clone -t repo' or some such.

I do think this is project specific, as such:

 - you can have .git/hooks be a symlink to ../git-hooks/
   (i.e. the project toplevel "git-hooks" directory, or
   whereever the project finds convenient);

 - have "git-hooks" tracked

The latter will take care of the distribution issue.  Now, we
would need a generic and convenient way to make sure that the
new repository "clone" makes has .git/hooks as a symlink to
whereever in-tree that follows the project convention.  I think
you could use the existing templates mechanism.  Allow "git
clone" to take 'template=' parameter and pass it down to "git
init" it invokes.  You use project specific template that
arranges the .git/hooks/ symlink when you clone.  We could even
support "[clone] template = this/template/file" variable in your
$HOME/.gitconfig if we go this route.

   
