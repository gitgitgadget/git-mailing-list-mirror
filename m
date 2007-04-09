From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Mon, 9 Apr 2007 14:40:39 -0400
Message-ID: <20070409184039.GZ5436@spearce.org>
References: <46197950.3080804@gmail.com> <7vwt0m76rv.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704082012220.28181@xanadu.home> <20070409173858.GT5436@spearce.org> <alpine.LFD.0.98.0704091404530.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaynK-0006fY-E5
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbXDISkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbXDISkq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:40:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41155 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbXDISkp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:40:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hayn3-0003b2-Kj; Mon, 09 Apr 2007 14:40:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6B89520FBAE; Mon,  9 Apr 2007 14:40:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704091404530.28181@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44077>

Nicolas Pitre <nico@cam.org> wrote:
> I'd be really tempted to create a pack v4 which only change is to still 
> have the pack header at the beginning of the pack like we do today, but 
> include the header in the pack SHA1 computation at the end of the stream 
> only.  This way the pack SHA1 could be computed as the pack is 
> generated, and the header fixed up without having to read the entire 
> pack back.  I think it was Geert Bosch who proposed this and it makes 
> tons of sense IMHO.

Yes.  If we really are heading in this direction of needing to
correct object counts, we should make that change.  Its trivial
to hang onto that header for the duration of the rest of the data
processing, and tack it onto the end for final SHA-1 computation.

Since pack v4 looks like it will be a dev cycle longer than these
index format changes and pack-splitting changes, I have to say I
agree with you.  Lets move "pack v4" back to "pack v5" and make v4
just a shift of where the header is included in the SHA-1.

We're heading where I said I didn't want to go, which is two
file format changes in 2007.  But I think that ship has already
sailed...  Folks need support for larger repositories now, and pack
v4/v5 (whatever you call our dictionary work) just isn't ready.
Nor does it solve the big packfile problems that this current work
is addressing.

-- 
Shawn.
