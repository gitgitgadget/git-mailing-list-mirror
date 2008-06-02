From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up
 git-cherry
Date: Mon, 2 Jun 2008 19:15:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806021913340.13507@racer.site.net>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>  <alpine.DEB.1.00.0806020649110.13507@racer.site.net>  <20080602064218.GA15144@sigill.intra.peff.net>  <7f9d599f0806020735g30722893mb8efed41a6544ab5@mail.gmail.com> 
 <alpine.DEB.1.00.0806021635220.13507@racer.site.net>  <7f9d599f0806020849g567461b2kecd65dbd35d3dc3b@mail.gmail.com>  <alpine.DEB.1.00.0806021717130.13507@racer.site.net> <7f9d599f0806020926j7ac9fb12jefa5a14fe5708226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Mon Jun 02 20:17:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Eau-0001Ht-MB
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 20:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbYFBSQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 14:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbYFBSQ0
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 14:16:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:60287 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751641AbYFBSQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 14:16:25 -0400
Received: (qmail invoked by alias); 02 Jun 2008 18:16:23 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 02 Jun 2008 20:16:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wqRFHgtKwKZCOnXhlRtWUeLy8lmBFs0bLpXzdZP
	+w2ZsfZULMw56F
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7f9d599f0806020926j7ac9fb12jefa5a14fe5708226@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83551>

Hi,

On Mon, 2 Jun 2008, Geoffrey Irving wrote:

> On Mon, Jun 2, 2008 at 9:18 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Mon, 2 Jun 2008, Geoffrey Irving wrote:
> >
> >> On Mon, Jun 2, 2008 at 8:37 AM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> > Another issue that just hit me: this cache is append-only, so if it 
> >> > grows too large, you have no other option than to scratch and 
> >> > recreate it. Maybe this needs porcelain support, too?  (git gc?)
> >>
> >> If so, the correct operation is to go through the hash and remove 
> >> entries that refer to commits that no longer exist.  I can add this 
> >> if you want.  Hopefully somewhere along the way git-gc constructs an 
> >> easy to traverse list of extant commits, and this will be 
> >> straightforward.
> >
> > I don't know... if you have created a cached patch-id for every commit 
> > (by mistake, for example) and do not need it anymore, it might make 
> > git-cherry substantially faster to just scrap the cache.
> 
> Well, ideally hash maps are O(1), but it could be a difference between a 
> "compare 40 bytes" constant and a "read a 4k block into memory" 
> constant, so in practice yes.  Scrapping it entirely will also make the 
> implementation much simpler.
> 
> It seems a little sad to wipe all that effort each time, but 
> regenerating the cache is likely to be less expensive than a git-gc, so 
> it shouldn't change any amortized complexities.

Well, how about only scrapping the cache if it is older than, say, 2 
weeks, and is larger than, say, 200kB?  That should help.

Ciao,
Dscho
