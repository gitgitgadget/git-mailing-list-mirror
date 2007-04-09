From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 9 Apr 2007 13:43:05 -0400
Message-ID: <20070409174305.GU5436@spearce.org>
References: <11760951973172-git-send-email-nico@cam.org> <20070409171925.GS5436@spearce.org> <alpine.LFD.0.98.0704091328130.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 22:56:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Haxtb-00062a-UN
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 19:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbXDIRnN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 13:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253AbXDIRnN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 13:43:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38817 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbXDIRnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 13:43:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HaxtM-00079S-CW; Mon, 09 Apr 2007 13:43:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 891FC20FBAE; Mon,  9 Apr 2007 13:43:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704091328130.28181@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44067>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 9 Apr 2007, Shawn O. Pearce wrote:
> 
> > It is unfortunate that we are changing the index file format without
> > also bringing in packv4 support at the same time.  I have just been
> > too swamped in useless bulls**t in day-job work to spend time on
> > Git lately.
> 
> Well... I still did index v2 with pack v4 in mind.  The diference 
> between index v2 and v3 would be minimal.
> 
> Pack v4 is coming along.  Slowly but still coming.

I take it you are working on it alone at this point?  I'd love
to get back into it, but I don't think I've got the cycles for at
least a couple of weeks.


Here's something we didn't think about, but that occurred to me today
when reading this series: If we move the SHA-1 table out of the index
and into the packfile (like we are planning) dumb commit-walkers
(http-fetch) will have problems.  Right now they download the
indexes of every available packfile to determine if they need to
download the corresponding packfile to obtain a needed object.

Moving the SHA-1 table from the index into the packfile will mean
the client cannot do this `optimization'.  Instead it will need to
perform a byte-range request for part of the packfile to decide
if it needs to fetch the remainder of that packfile; or it must
download the entire packfile.  Since not all HTTP servers support
byte-range requests the former may not always be viable and the
latter is obviously not a good idea.

-- 
Shawn.
