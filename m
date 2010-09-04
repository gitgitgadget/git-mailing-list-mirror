From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 07:46:15 -0400
Message-ID: <5D61124F-21D7-4A98-A1B8-6A013C8CB199@mit.edu>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com> <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com> <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com> <4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com> <alpine.LFD.2.00.1009021249510.19366@xanadu.home> <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com> <alpine.LFD.2.00.1009021624170.19366@xanadu.home> <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu> <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org> <alpine.LFD.2.00.1009031522590.19366@xanadu.home> <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu> <AANLkTikVf=X8cLP9s6W9VGOt0EHE4J5MYsBpgKYhrAri@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 13:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrrHK-00047L-W1
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 13:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab0IDLvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 07:51:21 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:42846 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751706Ab0IDLvU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 07:51:20 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Sep 2010 07:51:20 EDT
X-AuditID: 1209190f-b7bf7ae00000628e-a3-4c82318e2fa6
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id DC.D3.25230.E81328C4; Sat,  4 Sep 2010 07:46:22 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o84BkHQg003323;
	Sat, 4 Sep 2010 07:46:17 -0400
Received: from [10.0.42.101] (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o84BkFpQ011723
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 4 Sep 2010 07:46:16 -0400 (EDT)
In-Reply-To: <AANLkTikVf=X8cLP9s6W9VGOt0EHE4J5MYsBpgKYhrAri@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155316>


On Sep 4, 2010, at 1:23 AM, Kyle Moffett wrote:

> 
> Specifically, let's look at the very reasonable scenario of a
> developer working over a slow DSL or dialup connection.  He's probably
> got many copies of various GIT repositories cloned all over the place
> (hey, disk is cheap!), but right now he just wants a fresh clean copy
> of somebody else's new tree with whatever its 3 feature branches are.
> Furthermore, he's probably even got 80% of the commit objects from
> that tree archived in his last clone from linux-next.
> 
> In theory he could very carefully arrange his repositories with
> judicious use of alternate object directories.  From personal
> experience, though, such arrangements are *VERY* prone to accidentally
> purging wanted objects; unless you *never* ever delete a branch in the
> "reference" repository.

This is a reasonable problem, but there's a much easier solution that's worked for me, and it's very simple.  Simply use Linus's repository as the reference repository.  IOW, whenever I start working on a new computer, I'll do keep a bare repository containing only Linus's repo.  I might pull that down fresh from kernel.org, or if I'm on a local computer, it's usually much easier just to scp -r over a local copy of /usr/projects/linux/bare to my local machine.    That's something like 98% of all of the needed commits right there.  And since Linus never rewinds any branches on his repo.  I'm done.   It works for me.  :-)

For a repo like git which does have a 'pu' branch which rewinds, life is a bit more tricky, I'll admit.   OTOH, the fact that there is a 'pu' branch means that there are few people who keep externally published trees, since it's much easier to let Junio collect people's various patchsets into the 'pu' branch, at which point it's all nicely integrated.  In some ways, the 'pu' branch is really the equivalent of the linux-next tree.  :-)

OK, suppose we have a project which is large enough to have large numbers of downstream trees, but which also has one or more branches that happen to be rewinding.  I can't think of any project which has those characteristics, but OK, it's worth exploring.  Now what?   Well, if I'm doing this all on one machine (the use case is my laptop), and I have a *very* slow external connection (the use case I can think of it is when I am on a cruise ship, where not only the bandwidth slow, but there is also a very long latency since it's a satellite link), what I'd do is find all my trees that might be related to the tree that I want to clone, and hard link them into my target repository.   I'd then create a temp .git/refs/hack directory, and create branch pointers to the tips of all of the branches
  from the donating repositories.  I'd then just do a straightforward git pull, which would transfer over just the objects I need, then delete the .git/refs/hack directory, and then do a git gc.

Ok, so how do we generalize this if we have a large number of local machines?   The first insight is that we want to treat local machines very differently from remote machines, since we obviously want to do as many of the object transfers from the local machines.   The second is to note the reason why I had to hackishly create the .git/refs/hack directory.   That's because git fetch already optimizes things based on branch heads to minimize the need to send vast object sets back and forth to figure out what objects are required.

So I suspect we might be able to do something where the peer2peer downloader first contacts all of its local "buddies", and gets their branch heads, and then, using the standard git protocol, contacts the remote git server (i.e., github, git.kernel.org, etc.), and sends it all of its available branch heads.  It will then be able to assemble what it needs from remote server and from its local buddies.   In effect, this is basically an "octopus fetch", and it seems like most of the machinery can be reused from the git protocol, with only some minor modifications.

I agree this is a very different use case than the "initial download" case.   At least for the Linux kernel, I have a solution that works pretty much well enough.    I suspect for the git tree, I could just as easily solve it by just doing a brute force copy of Junio's tree and then pulling down the extra objects using "git fetch".   The reality is most projects have a canonical tree, and 99% of the time people's subtrees contain very few objects that aren't already in the canonical tree.  So while we could create some complicated design to try to optimize picking a few commits that weren't in Linus's tree, but were in linux-next, when downloading someone's subsystem development tree, how many commits do we expect will be unique in someone's subsystem tree?   A hundred, at most?   Even wit
 h a slow link, simply doing a git clone --bare of a local copy of Linus's tree, and then doing a straightforward "git fetch" is probably going to good enough, even if you are stuck on a cruise ship with a laptop that you smuggled aboard without your partner/spouse knowing so you can get that hacking fix.  :-)

-- Ted
