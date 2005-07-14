From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Getting list of changed objects...
Date: Thu, 14 Jul 2005 10:58:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507141053540.19183@g5.osdl.org>
References: <42D6ACF0.30303@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 19:59:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt7yv-00058O-LY
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 19:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVGNR6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 13:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVGNR6j
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 13:58:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262810AbVGNR6i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2005 13:58:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6EHwUjA011437
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Jul 2005 10:58:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6EHwRwB025852;
	Thu, 14 Jul 2005 10:58:29 -0700
To: James Ketrenos <jketreno@linux.intel.com>
In-Reply-To: <42D6ACF0.30303@linux.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Jul 2005, James Ketrenos wrote:
> 
> The problem is that if I run:
> 
>   git-rev-list --objects B ^C
> 
> It shows me all of the tree and commit objects but also gives a 
> list of all of the files that changed between A and C as if they 
> are needed to move C to B.

Since you haven't merged A and B in the above, they _are_ needed, aren't 
they?

Maybe what you want is 

	git-rev-list --objects B ^A ^C

ie "objects that are in B, but not in A or in C", since you seem to 
consider A uninteresting too?

I don't actually understand what you want to do, and also, "git-rev-list
--objects" is actually not 100% careful - it can include objects that are
in the "not" group, just because it doesn't actually bother to do a full
negative list (it only creates a negative list for the "boundary" objects,
but it won't even do "mark_tree_uninteresting()" for commits that it has
decided cannot be meaningful, so it's not in any way guaranteed to be a
_minimal_ set of objects).

			Linus
