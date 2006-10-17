From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 07:38:39 -0400
Message-ID: <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 13:38:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZnHR-0001rv-U8
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 13:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWJQLin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 07:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423095AbWJQLin
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 07:38:43 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:3473 "EHLO
	BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1750858AbWJQLim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 07:38:42 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP02.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 17 Oct 2006 04:38:41 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZmLI-0005VU-8R; Tue, 17 Oct 2006 06:38:40 -0400
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Message-Id: <20061017073839.3728d1e7.seanlkml@sympatico.ca>
In-Reply-To: <vpqejt76vgz.fsf@ecrins.imag.fr>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 11:38:41.0759 (UTC) FILETIME=[CB9BC6F0:01C6F1E0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 Oct 2006 13:19:08 +0200
Matthieu Moy <Matthieu.Moy@imag.fr> wrote:

> 1) a working tree without any history information, pointing to some
>    other location for the history itself (a la svn/CVS/...).
>    (this is "light checkout")

Git can do this from a local repository, it just can't do it from
a remote repo (at least over the git native protocol).  However,
over gitweb you can grab and unpack a tarball from a remote repo.
In practice this is probably enough support for such a feature.

> 2) a bound branch. It's not _very_ different from a normal branch, but
>    mostly "commit" behaves differently:
>    - it commits both on the local and the remote branch (equivalent to
>      "commit" + "push", but in a transactional way).
>    - it refuses to commit if you're out of date with the branch you're
>      bound to.
>    (this is "heavy checkout")

This doesn't sound right, at least in the spirit of git.  Git really
wants to have a local commit which you may or may not push to a
remote repo at a later time.  There is no upside to forcing it all to
happen in one step, and a lot of downsides.  Gits focus is to support
distributed offline development, not requiring a remote repo to be
available at commit time.
 
> In both cases, this has the side effect that you can't commit if the
> "upstream" branch is read-only. That's not fundamental, but handy.

Again this seems really anti-git.  There is no reason for your local
branch to be marked read only just because some upstream branch is
so marked.

> I use it for example to have several "checkouts" of the same branch on
> different machines. When I commit, bzr tells me "hey, boss, you're out
> of date, why don't you update first" if I'm out of date. And if commit
> succeeds, I'm sure it is already commited to the main branch. I'm sure
> I won't pollute my history with merges which would only be the result
> of forgetting to update.

This is exactly the same in Git.  You really only ever push upstream
when your local changes fast forward the remote, (ie. you're up to date).
Git will warn you if your changes don't fast forward the remote.
 
> The more fundamental thing I suppose is that it allows people to work
> in a centralized way (checkout/commit/update/...), and Bazaar was
> designed to allow several different workflows, including the
> centralized one.

While Git really isn't meant to work in a centralized way there's nothing
preventing such a work flow.  It just requires the use of some surrounding
infrastructure.

Sean
