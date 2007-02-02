From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Don't leak file descriptors from unavailable pack files.
Date: Fri, 2 Feb 2007 03:53:43 -0500
Message-ID: <20070202085343.GD20832@spearce.org>
References: <20070202080003.GA21094@spearce.org> <7vbqkdhs4d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 09:53:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCuB6-0002Nw-IB
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 09:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbXBBIxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 03:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932852AbXBBIxs
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 03:53:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43283 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823AbXBBIxr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 03:53:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCuAx-00021n-Vc; Fri, 02 Feb 2007 03:53:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0769A20FBAE; Fri,  2 Feb 2007 03:53:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vbqkdhs4d.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38479>

Junio C Hamano <junkio@cox.net> wrote:
> I agree leaking fd is not nice, but I wonder if that should be
> dealt with by the caller.
> 
> Originally it did not matter as open_packed_git() died, but
> shouldn't it be closing the fd and marking p->pack_fd with -1, as
> you made it return instead of die?

Yea, I thought of that when I wrote that evil patch...

But open_packed_git has 12 things that can cause it to return
an error.  That's basically a rewrite of the function.  This was
4 lines added to the only caller which didn't die().

Probably the wrong thing to do.  But the patch was shorter!

Do you want to reject this patch and have me rewrite open_packed_git
instead?

-- 
Shawn.
