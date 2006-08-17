From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 19:05:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608171900130.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <20060817040719.GC18500@spearce.org> <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910608170736y4863e0ebr55c6c822ae548cca@mail.gmail.com>
 <Pine.LNX.4.63.0608171738490.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0608171220260.11359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, Shawn Pearce <spearce@spearce.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 19:06:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDlJd-000562-JB
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 19:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWHQRFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 13:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWHQRFt
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 13:05:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:41382 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965056AbWHQRFs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 13:05:48 -0400
Received: (qmail invoked by alias); 17 Aug 2006 17:05:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 17 Aug 2006 19:05:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0608171220260.11359@localhost.localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25592>

Hi,

On Thu, 17 Aug 2006, Nicolas Pitre wrote:

> On Thu, 17 Aug 2006, Johannes Schindelin wrote:
> 
> > On Thu, 17 Aug 2006, Jon Smirl wrote:
> > 
> > > On 8/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > At least, the delta-chains should be limited by size (_not_ by number of
> > > > deltas: you can have huge deltas, and if you have to unpack 5 huge deltas
> > > > before getting to the huge delta you really need, it takes really long).
> > > 
> > > This is not an obvious conclusion.
> > 
> > The big win is bought by having _one_ zlib stream for multiple deltas, 
> > right?
> > 
> > So, everytime you want to access the _last_ delta in the chain, you unpack 
> > _all_ of them.
> 
> This is the case whether deltas are separately deflated or not.

Oh, now I get it! The delta chain is comprised of exactly those deltas 
which are needed to reconstruct a certain object from another object which 
was stored undeltified in the pack.

Now it makes sense to me that they could be bundled before being deflated. 
In the pack-index, the objects of that delta-chain could just point to 
the delta-chain object. Which has a mini-index in its extended header.

Or did I misunderstand again?

Ciao,
Dscho
