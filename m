From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 19:22:44 -0400
Message-ID: <20070316232244.GC4508@spearce.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org> <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org> <45FAC75B.3030902@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 00:23:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSLlJ-000770-3N
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 00:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbXCPXXB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 19:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbXCPXXA
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 19:23:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41871 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbXCPXW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 19:22:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HSLkq-0002Aw-U5; Fri, 16 Mar 2007 19:22:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3F21020FBAE; Fri, 16 Mar 2007 19:22:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <45FAC75B.3030902@garzik.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42407>

Jeff Garzik <jeff@garzik.org> wrote:
> Although it sounds like zlib could indeed be optimized to reduce its 
> startup and shutdown overhead, I wonder if switching compression 
> algorithms to a pure Huffman or even RLE compression (with associated 
> lower startup/shutdown costs) would perform better in the face of all 
> those small objects.

As Nico already stated, for pack v4 we are probably heading in a
direction where these really small (except for blobs anyway) objects
aren't compressed at all by zlib.  They are smaller in disk space,
and are faster to reconstruct to their raw format.
 
> And another random thought, though it may be useless in this thread:  I 
> bet using a pre-built (compiled into git) static zlib dictionary for git 
> commit and tree objects might improve things a bit.

I've actually tried this with the Mozilla project.  The improvement
was under 2% on disk space usage and no runtime performance gains.
Not worth the pain involved.  We are seeing much higher disk
space improvements and much better performance gains in the pack
v4 prototype.

Oh, and that was *with* a dictionary that was customized to Mozilla.
Not a static one.  A lot of keywords in the dictionary were Mozilla
project specific, and would actually *hurt* compression for the
Linux kernel, Git, X.org, etc...

-- 
Shawn.
