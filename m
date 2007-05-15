From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add an option to git-ls-tree to display also the size of object
Date: Tue, 15 May 2007 19:20:17 -0400
Message-ID: <20070515232017.GP3141@spearce.org>
References: <11792246701367-git-send-email-jnareb@gmail.com> <7vy7jpj4lr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 01:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho6Jf-0002Hz-Fv
	for gcvg-git@gmane.org; Wed, 16 May 2007 01:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbXEOXUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 19:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756223AbXEOXUW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 19:20:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35660 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880AbXEOXUV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 19:20:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Ho6JM-0005xk-Jr; Tue, 15 May 2007 19:20:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 60C2520FBAE; Tue, 15 May 2007 19:20:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vy7jpj4lr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47385>

Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Add -l/--long/--size option to git-ls-tree command, which displays
> > object size of an entry after object id (left-justified with minimum
> > width of 7 characters).
> 
>   Also I suspect that having to show the size of a tree object,
>   expressed in terms of the canonical representation, might
>   force packv4 aware ls-tree to convert its traversal efficient
>   representation to the canonical one only to get its size.

Yes, you are right Junio.  In pack v4 we don't know the size of
the canonical representation.  We compute it on the fly when its
needed by summing up the lengths of the names of each element in
the tree, so it requires us to expand the delta chain and is thus
O(delta_depth * entry_count) or something like that.

I didn't see this as a huge problem, as the only in-tree caller at
the time that needed the size and did not also want the canonical
representation was the -s flag to cat-file.

So I'm kind of against adding something that would want to print
that canonical representation for every subtree in a parent tree,
as it would make either pack v4 less efficient for that operation
or force it to store the canonical size, for no other good reason.

-- 
Shawn.
