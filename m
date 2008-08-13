From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Tue, 12 Aug 2008 22:38:03 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808122220500.9984@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <a6b6acf60808111215y45b261d2ra667ea8d9f5f76d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andi Kleen <andi@firstfloor.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Ken Pratt <ken@kenpratt.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 04:39:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT6Gq-0004bp-Gp
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 04:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbYHMCiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 22:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbYHMCiU
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 22:38:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41997 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727AbYHMCiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 22:38:19 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5I00LOQPZHWGB0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Aug 2008 22:38:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <a6b6acf60808111215y45b261d2ra667ea8d9f5f76d2@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92166>

On Mon, 11 Aug 2008, Ken Pratt wrote:

> > As a quick workaround you could try it with a 32bit git executable?
> > (assuming you have a distribution with proper multilib support)
> 
> In this case, I do have control over the server (running Arch Linux,
> which should do 32-bit multilib just fine), but for my workflow I
> cannot assume that the server will have 32-bit git support.
> 
> I will use the previously mentioned solution of doing the packing
> elsewhere for now as a band-aid, with hopes that this will get fixed
> sometime soon.

I'm afraid no fix is "possible" since you said:

> Largest object is ~150MB, and there are a couple 5-10MB objects as 
> well.

If you have only 256 MB of RAM, I'm afraid the machine dives into swap 
the moment it attempts to process that single 150-MB object during 
repacking.  Objects are always allocated entirely, including the 
deflated and inflated copy at some point.  Making git handle partial 
objects in memory would add complexity all over the map so I don't think 
it'll ever be implemented nor be desirable.

If you do repack once with 'git repack -a -f -d' on a bigger machine 
then 256 MB of RAM might be fine for serving clone and fetch requests 
though.


Nicolas
