From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Set up for better tree diff optimizations
Date: Wed, 21 Mar 2007 08:20:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703210812590.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703181506570.6730@woody.linux-foundation.org>
 <7vircv3wfc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 16:21:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU2cf-0002Al-B1
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 16:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbXCUPVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 11:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbXCUPVF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 11:21:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40014 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932113AbXCUPVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 11:21:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2LFKpcD025511
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 08:20:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2LFKpbd028802;
	Wed, 21 Mar 2007 07:20:51 -0800
In-Reply-To: <7vircv3wfc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42795>



On Wed, 21 Mar 2007, Junio C Hamano wrote:
> 
> I've already applied the patch, but I do not know how much this
> interface would help, as the only easy case the function
> tree_entry_interesting() can say "no subsequent entries will be
> either" without looking ahead is where no pathspecs match the
> base, but that is already prevented by the way you walk the tree
> (you do not descend into an uninteresting tree).

No. You miss the important case.

> If you do:
> 
> 	$ git log arch/i386/ include/asm-i386/

Right. Forget about the paths we're *interested* in. 

Look at the ones we're *not* interested in!

At the top level, what's the tree? It looks like this:

	100644 blob 060a71d41ad7ccc3214065a182e6f67568420071    .gitignore
	100644 blob bf62dbea88e613d8a22a6f9977289b4eb2eb968b    .mailmap
	100644 blob ca442d313d86dc67e0a2e5d584b465bd382cbf5c    COPYING
	100644 blob 6bd8ab86b5bd1b80f2df2ceaf0a4f8d7634639a0    CREDITS
	040000 tree 14499497d9d170b046e5cf9aafeec76647ece9a3    Documentation
	100644 blob 0451f69353bad4d07de34fd4658f40b805bd467a    Kbuild
	100644 blob 6d8d5b917d1fe0f4ff011d738ca9d13947521eb8    MAINTAINERS
	100644 blob 1c018c468e153ac85079f90a209a9bb3a09c5671    Makefile
	100644 blob 159912cf515549455ed5f579b8825d28962bd22e    README
	100644 blob ac02e42a2627f359575ae0e689afca911a75e0ff    REPORTING-BUGS
	040000 tree 46262adf3cfb89b4028a2d4beb17d9089e26902f    arch
	040000 tree 45d8a2724b4414f7fc3a2dac66929fdf0d032986    block
	040000 tree 21696299da054c8ad04c5fc87f21ecc4a7d0e464    crypto
	040000 tree ff75402a4a48101c95e9dc820c7c822767ca2ac3    drivers
	040000 tree 734d24c7dcfbe8d9b03045aebc2148f92c5f4607    fs
	040000 tree e3d0731913e852e7f256af5b6a3cd50bea8d4993    include
	040000 tree e39426d7179d961d96e27f7250fb16a483cc17db    init
	040000 tree 0438f8748d21ad402d305bf469b27f59bc1300b9    ipc
	040000 tree dc33b0bd31bdf49aaa04f3357f20bb1a189bac4a    kernel
	040000 tree 7cfb510f6854fe8c51f15fefbedda66773c0f23a    lib
	040000 tree cfb673c385e328bbdefb60c3ce59c8f3ba7f215e    mm
	040000 tree 30550e7a0676fe13a2e48d5f3c3872112e9634d2    net
	040000 tree 5194f3b70deaa7f98cadfeca300fd140b1086409    scripts
	040000 tree 164b706596d177b15750eb0da157758397195885    security
	040000 tree e5d9e19873759dcccd45dde4d76a0ad75db8fe5c    sound
	040000 tree 09109a71d77e211a4253fdde8afec7f119055e3b    usr

And with your pathspec, we can tell after we see "init", that we're not 
interested in any of the rest. In other words, we could consistently skip 
and not even parse almost 50% of the top-level tree.

And if you only have the first path-spec ("arch/i386") you could skip 
everything after you've seen "block", because you know that the rest of 
the tree simply isn't interesting any more.

Similarly, look at what happens (with your two-entry pathspec) when you 
enter "arch". Obviously the "include" thing will be totally uninteresting, 
so as far as that one is concerned, you can skip the *whole* thing, but 
because we have multiple path-specs we need to skip only when *both* 
decide that it's uninteresting. So look at the "arch" sub-tree, and we 
have

	alpha
	arm
	arm26
	avr32
	cris
	frv
	h8300
	i386
	ia64
	m32r
	m68k
	m68knommu
	mips
	parisc
	powerpc
	ppc
	s390
	sh
	sh64
	sparc
	sparc64
	um
	v850
	x86_64
	xtensa

and again, when we hit ia64, we *could* return -1, because "include" is 
totally uninteresting for all of it, and the "arch/i386/" pathspec can 
tell that anything below ia64 is uninteresting, because ia64 sorts after 
it, and the tree is alphabetically sorted.

So you could skip even parsing half of both the top-level tree _and_ more 
than half of the "arch" tree.

		Linus
