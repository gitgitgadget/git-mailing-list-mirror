From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: question on merges
Date: Mon, 2 May 2005 11:47:17 -0400 (EDT)
Message-ID: <3294.10.10.10.24.1115048837.squirrel@linux1>
References: <20050502151200.GA4592@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 17:43:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSd30-0000yI-2Y
	for gcvg-git@gmane.org; Mon, 02 May 2005 17:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVEBPrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 11:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVEBPrZ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 11:47:25 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:49849 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261337AbVEBPrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 11:47:18 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050502154717.BDKL1614.simmts5-srv.bellnexxia.net@linux1>;
          Mon, 2 May 2005 11:47:17 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j42FlE1f023773;
	Mon, 2 May 2005 11:47:15 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Mon, 2 May 2005 11:47:17 -0400 (EDT)
In-Reply-To: <20050502151200.GA4592@xi.wantstofly.org>
To: "Lennert Buytenhek" <buytenh@wantstofly.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 2, 2005 11:12 am, Lennert Buytenhek said:
> Hi,
>
> If a git user has X as his most recent local commit, and merges in a
> commit Y from someone else to create commit Z, shouldn't commit Z have
> both commit X and Y as parents?  Or is is the other way round and is it
> perfectly well possible that a 'merge commit' only has one parent?
>
> In the current linux-2.6 git tree, gregkh clones torvalds'
> 7f907d7486f2519c2ff1493bfbcdc36dcacd85b7 and creates a chain of commits
> starting with ac21e9ff08db3d6fac41d356c77fcb531c2e03e1 and ending in
> e838a0d4d5260bce452c96914a6e86b217c53c55.  torvalds merges this chain
> back into his version in a9e4820c4c170b3df0d2185f7b4130b0b2daed2c, but
> that commit has as parents e838a0d4d5260bce452c96914a6e86b217c53c55
> (gregkh's last commit), and c0698f2f6e4839ce9463ce731c892993215ea067,
> one of jejb's intermediate commits.  But now why is
> 7f907d7486f2519c2ff1493bfbcdc36dcacd85b7 not a parent of
> a9e4820c4c170b3df0d2185f7b4130b0b2daed2c?  I would expect it to be,
> since it is linus' most recent local commit when he merges in gregkh's
> tree.
>
> This pattern happens a few more times:
> - davem creates c4d541106bc5d0a2134aaf9e8735eee3c70b0db2 from torvalds'
>   561bbe3235da614562fb26bb14042af684971a2d, and torvalds merges davem's
>   tree back in at a2755a80f40e5794ddc20e00f781af9d6320fafb (v2.6.12-rc3),
>   but that commit only has one parent (even though it's a merge.)
>
> See this image:
> 	http://www.liacs.nl/~buytenh/graph_2cacb3da620a4a93f3a77e1d2c8c06bb3c74bcb0.png

Hi Lennert,

Nice work, the labelled vectors are a nice touch.  How hard would it be to
add a format where all linear commits on a single branch were listed in a
single bubble?  That would reduce the size of the graphic considerably
with no loss of info.

As for your question the top of Linus' tree at that merge was actually
commit c0698f2f6e4839ce9463ce731c892993215ea067  :

tree b05fc8a950ace937460212e996441e4c05a227f6
parent cb624029cab62e5415287d15b2ec907b8f322ff5
parent 7f907d7486f2519c2ff1493bfbcdc36dcacd85b7
author James Bottomley <jejb@titanic> 1113875709 -0500
committer James Bottomley <jejb@titanic> 1113875709 -0500

fully merge up to scsi-misc-2.6

-----

Which includes the 7f90* parent for a9e4* you were expecting.  The graph
kind of hides the fact that c069* actually originated in his tree and was
actually his most recent local commit when he merged with gregkh.

Sean



