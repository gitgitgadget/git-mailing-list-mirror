From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Tue, 15 Jul 2008 04:19:29 +0000
Message-ID: <20080715041929.GC2432@spearce.org>
References: <20080713011512.GB31050@spearce.org> <1216001267-33235-1-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0807132220570.12484@xanadu.home> <20080714031242.GA14542@spearce.org> <alpine.LSU.1.00.0807141216390.32392@wbgn129.biozentrum.uni-wuerzburg.de> <m31w1wu1hc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 06:20:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIc1d-0004Om-DA
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 06:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbYGOETa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 00:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbYGOETa
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 00:19:30 -0400
Received: from george.spearce.org ([209.20.77.23]:50252 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbYGOETa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 00:19:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 73F073836B; Tue, 15 Jul 2008 04:19:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m31w1wu1hc.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88516>

Jakub Narebski <jnareb@gmail.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
> 
> > > The only other alternative I can come up with is to change pack-objects 
> > > (or at least its defaults) so we don't generate these massive delta 
> > > chains.  But there are already packs in the wild that use these chains, 
> > > resulting in performance problems for clients.
> > 
> > But the long chains make the pack actually as efficient as it is...
> 
> Perhaps Shawn thought here about limiting delta chain not by its
> *length*, but by its *size* (as required when unpacking last object
> in a delta chanin).
> 
> What do you think about this idea?

I was talking about that.  Or at least thinking it.  But its not a
good solution, as Dscho points out those long chains is what makes
the pack file such a powerful source code compressor.

IMHO the right solution is to continue to allow these long chains,
especially since they are typically used for the older, less often
accessed objects, and use bounded caching where necessary in the
readers to avoid unpacking costs.  We already have a bounded cache
for the random access case used by most programs.  What we missed
was the bounded cache in index-pack, and my 4 patch series is an
attempt to define that.

-- 
Shawn.
