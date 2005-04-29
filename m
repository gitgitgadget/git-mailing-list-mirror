From: Tom Lord <lord@emf.net>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 08:44:30 -0700 (PDT)
Message-ID: <200504291544.IAA23584@emf.net>
References: <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
Cc: mpm@selenic.com, seanlkml@sympatico.ca,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 17:40:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRXa3-0003nl-3E
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 17:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVD2Pok (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 11:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVD2Pok
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 11:44:40 -0400
Received: from emf.emf.net ([205.149.0.19]:4361 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262801AbVD2Poc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 11:44:32 -0400
Received: (from lord@localhost) by emf.net (K/K) id IAA23584; Fri, 29 Apr 2005 08:44:30 -0700 (PDT)
To: torvalds@osdl.org
In-reply-to: <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org> (message from Linus Torvalds on Fri, 29 Apr 2005 07:34:15 -0700 (PDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



  > ie does mercurial do distributed merges, which git was designed for, and 
  > does mercurial notice single-bit errors in a reasonably secure manner, or 
  > can people just mess with history willy-nilly?

  > For the latter, the cryptographic nature of sha1 is an added bonus - the
  > _big_ issue is that it is a good hash, and an _exteremely_ effective CRC
  > of the data. You can't mess up an archive and lie about it later.

On the other hand, you're asking people to sign whole trees and not just at
first-import time but also for every change.

That's an impedence mismatch and undermines the security features of the
approach you're taking and here is why:

I shouldn't sign anything I haven't reviewed pretty carefully.  For
the kernel and in many other situations, it is too expensive to review
the whole tree.  Thus, the thing actually signed and the thing meant
by the signature are not equal.  I sign a tree, in this system,
because I think the right diffs and only the right diffs have been
applied to it.   My signature is intended to mean, though, that I vouche
for the *diffs*, not the tree.

If I've changed five files, I should be signing a statement of:

	1) my belief about the identity of the immediate ancestor tree
	2) a robust summary of my changes, sufficient to recreate my
	   new tree given a faithful copy of the ancestor

That's a short enough amount of data that a human can really review it
and thus it makes the signatures much more meaningful.

Probably doesn't matter much other than in cases where a mainline
is undergoing massive batch-patching based mostly on a web of trust.

But in that case --- someone or something generates purported diffs of
a tree; someone or something else scans those diffs and decides they
look good ---- and then on this basis, something distinct from
directly using those diffs occurs.  The diffs were used to vette the
change; the signature asserts that a certain tree is a faithful result
of applying those diffs.  Nothing checks that second assertion -- it's
taken on faith.

-t

