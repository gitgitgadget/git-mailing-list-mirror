From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 3 May 2005 12:09:51 -0400
Message-ID: <200505031209.52460.mason@suse.com>
References: <200505030657.38309.alonz@nolaviz.org> <200505030724.57827.mason@suse.com> <Pine.LNX.4.58.0505030804170.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 18:05:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSzse-0006cY-JC
	for gcvg-git@gmane.org; Tue, 03 May 2005 18:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVECQKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 12:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVECQKS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 12:10:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:17102 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261814AbVECQJ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 12:09:58 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8542F9D75;
	Tue,  3 May 2005 18:09:56 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 33FD31509EC; Tue,  3 May 2005 18:09:56 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0505030804170.3594@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 03 May 2005 11:07, Linus Torvalds wrote:
> On Tue, 3 May 2005, Chris Mason wrote:
> > On the full import of all the bk->cvs changesets, the average file size
> > in .git is 4074 bytes.  73% of the files are 4096 bytes or smaller.
>
> Have you checked how many of those are blobs?
>
I've got cg-admin-lsobj running (effectively find .git -type f | xargs 
cat-file), it is taking a looong time but the ratios seem to stay pretty 
constant as it makes progress:

total: 186863
blob: 93688     (6.6 per commit)
commit: 14172
tree: 79003      (5.5 per commit)

> For many commits, we generate as many (or more) _tree_ objects as we
> generate blobs.
>
> And tree obejcts from the same "supertree" really is something that I
> wouldn't mind packing some way, because they really tend to be very much
> related (since they refer to each other). Eg the commit and the top-level
> tree are almost always a pair, since you'd get a shared top-level tree
> only with two commits that have the exact same content (which definitely
> happens, don't get me wrong, but it we get some duplication for that case,
> we'd still be winning).
>

The packed item patch wouldn't duplicate info in this case.  When it initially 
creates the packed buffer (before compression), it checks for an existing 
file with the same sha1 and returns if one is found.  This is to preserve the 
optimizations for write_tree case where it frequently tries to create files 
that already exist.

-chris
