From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 11:11:22 -0500
Message-ID: <20070227161122.GE3230@spearce.org>
References: <200702261540.27080.ttelford.groups@gmail.com> <20070226235510.GF1639@spearce.org> <alpine.LRH.0.82.0702261916560.29426@xanadu.home> <20070227003118.GH1639@spearce.org> <alpine.LRH.0.82.0702262306100.29426@xanadu.home> <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com> <alpine.LRH.0.82.0702270002100.29426@xanadu.home> <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:44:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9BC-0000mq-Ad
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933804AbXB0Unf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933483AbXB0Unf
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:43:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45634 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933808AbXB0Une (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:43:34 -0500
X-Greylist: delayed 657 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Feb 2007 15:43:33 EST
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HM4v9-0003pa-5x; Tue, 27 Feb 2007 11:11:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0A74E20FBAE; Tue, 27 Feb 2007 11:11:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40794>

Geert Bosch <bosch@adacore.com> wrote:
> When I import a large code-base (such as a *.tar.gz), I don't know
> beforehand how many objects I'm going to create. Ideally, I'd like
> to stream them directly into a new pack without ever having to write
> the expanded source to the filesystem.

See git-fast-import.  If you are coming from a tar, also see
contrib/fast-import/import-tars.perl.  :-)
 
> So for creating a large pack from a stream of data, you have to do  
> the following:
>   1. write out a temporary pack file to disk without correct count
>   2. fix-up the count
>   3. read the entire temporary pack file to compute the final SHA-1
>   4. fix-up the SHA1 at the end of the file
>   5. construct and write out the index

Yes, this is exactly what git-fast-import does.  Yes, it sort of
sucks.  But its not as bad as you think.
 
> There are a few ways to fixing this:
>   - Have a count of 0xffffffff mean: look in the index for the count.
>     Pulling/pushing would still use regular counted pack files.
>   - Have the pack file checksum be the SHA1 of (the count followed
>     by the SHA1 of the compressed data of each object). This would  
> allow 3.
>     to be done without reading back all data.

I don't think it is worth it.  Aside from git-fast-import we
always know the object count before we start writing any data.
But despite that, fast-import runs quite well.

-- 
Shawn.
