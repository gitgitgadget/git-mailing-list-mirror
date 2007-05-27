From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 17:35:25 -0400
Message-ID: <20070527213525.GC28023@spearce.org>
References: <20070526052419.GA11957@spearce.org> <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net> <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com> <20070527033429.GY28023@spearce.org> <56b7f5510705262140rea5e1e5r49bdd5e99c466daa@mail.gmail.com> <alpine.LFD.0.99.0705271127110.3366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun May 27 23:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsQOs-0004gF-IP
	for gcvg-git@gmane.org; Sun, 27 May 2007 23:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbXE0Vfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 17:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbXE0Vfd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 17:35:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57724 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbXE0Vfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 17:35:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HsQOV-0004fw-Fs; Sun, 27 May 2007 17:35:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 68D7A20FBAE; Sun, 27 May 2007 17:35:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99.0705271127110.3366@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48583>

Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 26 May 2007, Dana How wrote:
> 
> > On 5/26/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > In pack v4 we're likely to move the SHA-1 table from the .idx file
> > > into the front of the .pack file.  This makes the .idx file hold
> > > only the offsets and the CRC checkums of each object.  If we start
> > > making a super index, we have to duplicate the SHA-1 table twice
> > > (once in the .pack, again in the super index).
> > 
> > Hmm, hopefully the SHA-1 table can go at the _end_
> > since with split packs that's the only time we know the number
> > of objects in the pack... ;-)
> 
> Hmmm good point to consider.

The problem with putting the SHA-1 table at the end of the pack is
it ruins the streaming for both unpack-objects and index-pack if
we were to ever use pack v4 as a transport format.  Or just try
to run a pack v4 packfile through unpack-objects, just locally,
say to extract megablobs.  ;-)

-- 
Shawn.
