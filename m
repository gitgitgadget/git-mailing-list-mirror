From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 14:32:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281428300.18901@ppc970.osdl.org>
References: <200504271251.00635.mason@suse.com> <200504280745.05505.mason@suse.com>
 <1114715496.4212.36.camel@localhost.localdomain> <200504281658.39300.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 23:25:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGVc-0004MS-5J
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVD1Vas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVD1Vas
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:30:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:53662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262218AbVD1Vak (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 17:30:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SLUZs4014835
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 14:30:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SLUYGU011076;
	Thu, 28 Apr 2005 14:30:34 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504281658.39300.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Chris Mason wrote:

> On Thursday 28 April 2005 15:11, Kay Sievers wrote:
> >
> > Can you confirm this with the kernel tree?
> >   file-changes -c 9acf6597c533f3d5c991f730c6a1be296679018e drivers/usb/core/usb.c
> >
> > lists the commit:
> >   diff-tree -r 1d66c64c3cee10a465cd3f8bd9191bbeb718f650 c79bea07ec4d3ef087962699fe8b2f6dc5ca7754
> > f0534ee064901d0108eb7b2b1fcb59a98bb53c2b->c231b4bef314284a168fedb6c5f6c47aec5084fc drivers/usb/core/usb.c
> >
> >  cat-file commit c79bea07ec4d3ef087962699fe8b2f6dc5ca7754
> >
> > which seems not to have changed the file asked for.
> 
> Hmmm, that does work here:
> 
> coffee:/src/git # diff-tree -r 1d66c64c3cee10a465cd3f8bd9191bbeb718f650 c79bea07ec4d3ef087962699fe8b2f6dc5ca7754 | grep usb.core.usb.c
> *100644->100644 blob    f0534ee064901d0108eb7b2b1fcb59a98bb53c2b->c231b4bef314284a168fedb6c5f6c47aec5084fc      drivers/usb/core/usb.c

I think Key is confused by the fact that the commit is a -merge- commit, 
and the first parent has _not_ changed that file - it got changed through 
the merge.

Ie:

	cat-file commit c79bea07ec4d3ef087962699fe8b2f6dc5ca7754

gives

	tree 3fbdc4745cfde60df7d05815b343e4a253020530
	parent a9e4820c4c170b3df0d2185f7b4130b0b2daed2c
	parent 1d66c64c3cee10a465cd3f8bd9191bbeb718f650
	author Linus Torvalds <torvalds@ppc970.osdl.org.(none)> 1113921100 -0700
	committer Linus Torvalds <torvalds@ppc970.osdl.org.(none)> 1113921100 -0700

	Merge master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/

and if you do a diff against the _first_ parent you don't see anything 
changing in USB..

		Linus
