From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 17:37:10 -0400
Message-ID: <20070403213710.GK27706@spearce.org>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org> <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704031625050.28181@xanadu.home> <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org> <20070403210319.GH27706@spearce.org> <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org> <20070403211709.GJ27706@spearce.org> <alpine.LFD.0.98.0704031730300.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqh2-00059d-53
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945967AbXDCVh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945980AbXDCVh3
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:37:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52129 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945967AbXDCVh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:37:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYqgZ-0004Lf-4Y; Tue, 03 Apr 2007 17:37:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7BBA120FBAE; Tue,  3 Apr 2007 17:37:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704031730300.28181@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43674>

Nicolas Pitre <nico@cam.org> wrote:
> First, I truly believe we should have a 64-bit pack index and fewer 
> larger packs than many small packs.

I'll buy that.  ;-)
 
> Which leaves us with the actual pack index lookup.  At that point the 
> cost of finding an existing object and finding that a given object 
> doesn't exist is about the same thing, isn't it?

Here's the rub:  in the missing object case we didn't find it
in the pack index, but it could be loose.  That's one failed
syscall per object if the object isn't loose.  If the object
isn't loose, it could be that it was *just* removed by a
running prune-packed, and the packfile that it was moved
to was created after we scanned for packfiles, so time to
rescan...

-- 
Shawn.
