From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] always start looking up objects in the last used pack first
Date: Thu, 31 May 2007 01:02:11 -0400
Message-ID: <20070531050211.GV7044@spearce.org>
References: <alpine.LFD.0.99.0705302152180.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 31 07:02:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htcnt-0004aG-Pw
	for gcvg-git@gmane.org; Thu, 31 May 2007 07:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbXEaFCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 01:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756447AbXEaFCW
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 01:02:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51225 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbXEaFCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 01:02:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Htcng-0005IK-Sa; Thu, 31 May 2007 01:02:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7611020FBAE; Thu, 31 May 2007 01:02:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99.0705302152180.11491@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48800>

Nicolas Pitre <nico@cam.org> wrote:
> 	Pack Sort			w/o this patch	w/ this patch
> 	-------------------------------------------------------------
> 	recent objects last		26.4s		20.9s
> 	recent objects first		24.9s		18.4s

Looks pretty good.
 
> +		next:
> +		if (p == last_found)
> +			p = packed_git;
> +		else
> +			p = p->next;
> +		if (p == last_found)
> +			p = p->next;
> +	} while (p);

So if we didn't find the object in the pack that we found the
last object in, we restart our search with the most recent pack?
Why not just go to p->next and loop around?  If we missed in this
pack and the packs are sorted by recency, wouldn't we want to just
search the next pack?

-- 
Shawn.
