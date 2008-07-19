From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Windows: set gitexecdir = $(bindir)
Date: Sat, 19 Jul 2008 21:31:44 +0200
Message-ID: <200807192131.44441.johannes.sixt@telecom.at>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at> <200807191052.20057.johannes.sixt@telecom.at> <7vmykd238a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 21:32:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKIAk-0005kH-A6
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 21:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbYGSTbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 15:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYGSTbu
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 15:31:50 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:55608 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbYGSTbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 15:31:49 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id A0E6ABEE3B;
	Sat, 19 Jul 2008 21:31:45 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0A362269E7;
	Sat, 19 Jul 2008 21:31:45 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vmykd238a.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89128>

On Samstag, 19. Juli 2008, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > Take as an example 'git pull'.
> >
> > - The first call to git will derive the exec-path
> > $prefix/bin/../libexec/git-core and prepend it to $PATH.
> >
> > - Calls to builtin git commands from inside 'git pull' will then derive
> > the exec-path $prefix/bin/../libexec/git-core/../libexec/git-core, that
> > is $prefix/libexec/libexec/git-core, and prepend it to $PATH as well.
> > That directory does not exist - usually - and it does not hurt. But it
> > feels dirty and potentially dangerous.
>
> You run "git" with an argument "pull".  It needs to figure out where
> "git-pull" is, it checks where it came from and adds ../libexec/git-core/.
> Then it runs "git-pull" script.
>
> Then the script may have a call to "git ls-files -u" or "git-merge".
>
>  - The former case, "git" again needs to find out where "git-ls-files"
>    is.
>
>    If "git" is found as bin/git and not as libexec/git-core/git, this
>    should be perfectly fine, isn't it?  Perhaps we install a duplicate
>    copy there by mistake, which is what we need to fix?

Yes, there's libexec/git-core/git. There reason might be that the install 
target is simpler to write (to create the hardlinks) just in case $(bindir) 
and $(gitexecdir) are not on the same mount.

>  - The latter case (our scripts source git-sh-setup so they have libexec
>    one in the PATH when they are started) would find "git-merge" directly
>    and runs it.
>
> In either case, the programs "git-ls-files" and "git-merge" do not need to
> do the same discovery -- are we giving them enough clues when we run them
> to let them avoid that?

Probably the only clue is the name itself, like Steffen proposed.

I'll see how I can improve my earlier exec-path patch series.

-- Hannes
