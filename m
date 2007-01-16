From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to merge FETCH_HEAD?
Date: Tue, 16 Jan 2007 14:59:14 -0500
Message-ID: <20070116195914.GA29100@spearce.org>
References: <20070116162645.GA18894@informatik.uni-freiburg.de> <20070116173706.GB20898@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 20:59:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6uSn-0000zt-CP
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 20:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbXAPT7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 14:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbXAPT7T
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 14:59:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48990 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbXAPT7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 14:59:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6uSa-0003Ur-1l; Tue, 16 Jan 2007 14:59:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 77EAC20FBAE; Tue, 16 Jan 2007 14:59:14 -0500 (EST)
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Content-Disposition: inline
In-Reply-To: <20070116173706.GB20898@mellanox.co.il>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36958>

"Michael S. Tsirkin" <mst@mellanox.co.il> wrote:
> OK, I did a fetch and now I can see remote history by
> 
> $git log FETCH_HEAD

Wow, I'm suprised that works.  Handy feature.  Too bad rev-parse
--verify then chokes on it when we'll somehow consider it a ref
otherwise...
 
> But, how to merge it?

Look at git-pull.sh:

	merge_head=$(sed -e '/  not-for-merge   /d' \
		-e 's/  .*//' "$GIT_DIR"/FETCH_HEAD | \
			tr '\012' ' ')
	merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD")
	git-merge "$merge_name" HEAD $merge_head

The not-for-merge keyword is included on lines that were fetched
into tracking branches during the last fetch and which you don't
want to merge right now.  So those lines get dropped.  Then the
remainder of the line is stripped away, leaving you with only
the sha1 sum.  merge_name is computed from the FETCH_HEAD file,
to get the pretty log message for git-merge.

-- 
Shawn.
