From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 22:52:48 -0500
Message-ID: <20070228035248.GB5597@spearce.org>
References: <20070226235510.GF1639@spearce.org> <alpine.LRH.0.82.0702261916560.29426@xanadu.home> <20070227003118.GH1639@spearce.org> <alpine.LRH.0.82.0702262306100.29426@xanadu.home> <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com> <alpine.LRH.0.82.0702270002100.29426@xanadu.home> <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com> <20070227161122.GE3230@spearce.org> <2BBADC5E-7188-4F77-BF5A-28131B435EF0@adacore.com> <alpine.LRH.0.82.0702271235260.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 04:53:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMFsF-0002Pf-Mk
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 04:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbXB1Dwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 22:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbXB1Dwz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 22:52:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33095 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbXB1Dwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 22:52:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMFrq-0007IX-NC; Tue, 27 Feb 2007 22:52:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F188220FBAE; Tue, 27 Feb 2007 22:52:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.0.82.0702271235260.29426@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40886>

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 27 Feb 2007, Geert Bosch wrote:
> > For smaller packs, the I/O is all going to be buffered anyway,
> > but if we're going to have >4GB pack files, it adds a lot of real
> > I/O  and SHA1 computation for no good reason. If we get a rare chance
> > to have a new pack format, why not fix this wart at the same time?
> 
> Fair enough.

OK, so lets say that if both ends of a network transport support
pack v4 then we can use pack v4.  If pack v4 omits the count field
from its header (because its easily derived or obtained from the
index, and doesn't add any additional data protection over the
SHA-1s) why not add some machine-readable sideband that can provide
transfer progress?

I think we would want four values, number of objects (sent/total)
and uncompressed bytes (sent/total), to send to the client.

Estimating the total uncompressed bytes is very easy in pack-objects
before we start sending even the header; actually if we are reusing
a majority of the objects from an existing packfile we even have
a good approximation of the compressed size ready.  That would
give the client a reasonable progress meter; certainly better than
nothing at all!  ;-)

-- 
Shawn.
