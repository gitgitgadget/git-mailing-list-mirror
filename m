From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] git-fetch: use fetch--tool pick-rref to avoid local fetch from alternate
Date: Thu, 5 Apr 2007 12:15:37 -0400
Message-ID: <20070405161537.GJ5436@spearce.org>
References: <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com> <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org> <alpine.LFD.0.98.0704031625050.28181@xanadu.home> <Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org> <20070403210319.GH27706@spearce.org> <Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org> <20070403211709.GJ27706@spearce.org> <Pine.LNX.4.64.0704031425220.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704031427050.6730@woody.linux-foundation.org> <7v1wizrugw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 18:16:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZUdh-0001lO-Ii
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 18:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbXDEQQD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 12:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbXDEQQC
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 12:16:02 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40319 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbXDEQQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 12:16:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZUcZ-00087V-TQ; Thu, 05 Apr 2007 12:15:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4585A20FBAE; Thu,  5 Apr 2007 12:15:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v1wizrugw.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43840>

Junio C Hamano <junkio@cox.net> wrote:
> +			# This will barf when $theirs reach an object that
> +			# we do not have in our repository.  Otherwise,
> +			# we already have everything the fetch would bring in.
> +			git-rev-list --objects $theirs --not --all 2>/dev/null

OK, I must be missing something here.

That rev-list is going to print out the SHA-1s for the objects we
would have copied, but didn't, isn't it?  So fetch--tool native-store
is going to get a whole lot of SHA-1s it doesn't want to see, right?

Otherwise this is a nice trick.  It doesn't assure us that after the
fetch those objects are still in the alternate.  Meaning someone
could run prune in the alternate between the rev-list and the
native-store, and whack these objects.  Given how small of a window
it is, and the improvements this brings to alternates, I say its
worth that small downside.  Just don't prune while fetching.  ;-)

-- 
Shawn.
