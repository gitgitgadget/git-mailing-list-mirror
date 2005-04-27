From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: The criss-cross merge case
Date: Wed, 27 Apr 2005 19:32:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504271854240.30848-100000@iabervon.org>
References: <Pine.LNX.4.44.0504271254120.4678-100000@wax.eds.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 01:27:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvwN-0002jI-Rh
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVD0Xco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVD0Xcn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:32:43 -0400
Received: from iabervon.org ([66.92.72.58]:20741 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262099AbVD0XcH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 19:32:07 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQw0m-00062b-00; Wed, 27 Apr 2005 19:32:08 -0400
To: Bram Cohen <bram@bitconjurer.org>
In-Reply-To: <Pine.LNX.4.44.0504271254120.4678-100000@wax.eds.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Apr 2005, Bram Cohen wrote:

> The way Git handles this currently is very bad, because it forces the
> common ancestor to be from the same snapshot across all files, so this
> problem will happen if the modifications are made even in different files,
> not just different lines within the same file. That could be improved
> greatly by finding an LCA for each file individually, which is what
> Monotone does.

The git core is perfectly sufficient for getting all LCAs or
per-file best LCAs; merge-base doesn't bother, currently, because the
deficiencies of "merge" (a.k.a. diff3) are worse than the issues with
chosing a suboptimal LCA.

My plan is to implement multi-file diff and merge with a suffix tree-based
algorithm, and then revisit the history stuff once we have a merger that
can do sensible things with this information.

Note that the present very bad merger is actually seems to be sufficient
for the Linux kernel, where patches from different sides of a merge are
generally either unrelated or are identical, and, otherwise, they tend to
be true conflicts where people fixed the same bug independantly in
different ways.

> Darcs, Codeville, and all the Arch descendants have better merge
> algorithms which don't have to pick a single common ancestor.

I've been looking at Darcs (which seems to have a good method, although I
think the underlying diff isn't great), and Codeville still doesn't have
any documentation. Arch's method is strictly weaker than 3-way merge, and
generates more rejects (not even conflicts) in my experience than even
CVS. 

	-Daniel
*This .sig left intentionally blank*

