From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] clean up and optimize nth_packed_object_sha1() usage
Date: Thu, 5 Apr 2007 02:27:53 -0400
Message-ID: <20070405062753.GC5436@spearce.org>
References: <alpine.LFD.0.98.0704041639070.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 08:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZLSC-0000Eb-0U
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 08:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898AbXDEG2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 02:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945930AbXDEG2A
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 02:28:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54123 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945898AbXDEG17 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 02:27:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZLRr-0005O1-9x; Thu, 05 Apr 2007 02:27:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4225920FBAE; Thu,  5 Apr 2007 02:27:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704041639070.28181@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43799>

Nicolas Pitre <nico@cam.org> wrote:
> Let's avoid the open coded pack index reference in pack-object and use 
> nth_packed_object_sha1() instead.  This will help encapsulating index
> format differences in one place.
> 
> And while at it there is no reason to copy SHA1's over and over while a 
> direct pointer to it in the index will do just fine.

Ack++.  ;-)

This is a good change.  That API has been bothering me for a while.
 
> @@ -96,14 +96,14 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
>  			last = mid;
>  		}
>  		if (first < num) {
> -			unsigned char now[20], next[20];
> -			nth_packed_object_sha1(p, first, now);
> +			const unsigned char *now, *next;
> +		       now = nth_packed_object_sha1(p, first);
>  			if (match_sha(len, match, now)) {

Uh, there is some sort of werid whitespace indent damage on that
second added line.  It doesn't line up with the first added line,
or with either of the context lines.

-- 
Shawn.
