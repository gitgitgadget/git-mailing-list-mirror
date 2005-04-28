From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 21:11:36 +0200
Message-ID: <1114715496.4212.36.camel@localhost.localdomain>
References: <200504271251.00635.mason@suse.com>
	 <200504271423.37433.mason@suse.com>
	 <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org>
	 <200504280745.05505.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 21:06:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DREKv-00031r-Sw
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 21:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVD1TLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 15:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVD1TLk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 15:11:40 -0400
Received: from soundwarez.org ([217.160.171.123]:48299 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262229AbVD1TLh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 15:11:37 -0400
Received: from dhcp-113.off.vrfy.org (c196135.adsl.hansenet.de [213.39.196.135])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 2DB1719C9A;
	Thu, 28 Apr 2005 21:11:36 +0200 (CEST)
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504280745.05505.mason@suse.com>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 07:45 -0400, Chris Mason wrote:
> On Wednesday 27 April 2005 18:19, Linus Torvalds wrote:
> > On Wed, 27 Apr 2005, Chris Mason wrote:
> > > So, new prog attached.  New usage:
> > >
> > > file-changes [-c commit_id] [-s commit_id] file ...
> > >
> > > -c is the commit where you want to start searching
> > > -s is the commit where you want to stop searching
> >
> > Your script will do some funky stuff, because you incorrectly think that
> > the rev-list is sorted linearly. It's not. It's sorted in a rough
> > chronological order, but you really can't do the "last" vs "cur" thing
> > that you do, because two commits after each other in the rev-list listing
> > may well be from two totally different branches, so when you compare one
> > tree against the other, you're really doing something pretty nonsensical.
> 
> One more rev that should work as you suggested Here's the example output 
> from a cogito changeset with merges.  I print the diff-tree lines once for each 
> matching parent and then print the commit once.  It's very primitive, but
> hopefully some day someone will make a gui with happy clicky buttons
> for changesets and filerevs.
> 
> diff-tree -r 2544d7558f0ce94ab9c163f5b67244f71d8c85b8 69eeae031bf5447e99b9274761e2361e8c5a944e
> 618fdb616cebbd2fc9f1cddc0b6b75fd575250a1->3579b5fd1182679a39b83eaaa9dd0e7c970f4545 diff-tree.c
> diff-tree -r 9831d8f86095edde393e495d7a55cab9d35d5d05 69eeae031bf5447e99b9274761e2361e8c5a944e
> 2d2913b6b98ac836b43755b1304d2a838dad87dd->4f01bbbbb3fd0e53e9ce968f167b6dae68fcfa92 Makefile
> cat-file commit 69eeae031bf5447e99b9274761e2361e8c5a944e
>     tree 7510dc1b63e9e690ec73952e40a31e43af4b55bc
>     parent 2544d7558f0ce94ab9c163f5b67244f71d8c85b8
>     parent 9831d8f86095edde393e495d7a55cab9d35d5d05
>     author Petr Baudis <pasky@ucw.cz> 1114544917 +0200
>     committer Petr Baudis <xpasky@machine.sinus.cz> 1114544917 +0200

Can you confirm this with the kernel tree? 
  file-changes -c 9acf6597c533f3d5c991f730c6a1be296679018e drivers/usb/core/usb.c

lists the commit:
  diff-tree -r 1d66c64c3cee10a465cd3f8bd9191bbeb718f650 c79bea07ec4d3ef087962699fe8b2f6dc5ca7754
  f0534ee064901d0108eb7b2b1fcb59a98bb53c2b->c231b4bef314284a168fedb6c5f6c47aec5084fc drivers/usb/core/usb.c
  cat-file commit c79bea07ec4d3ef087962699fe8b2f6dc5ca7754

which seems not to have changed the file asked for.

Thanks,
Kay

