From: Nicolas Pitre <nico@cam.org>
Subject: Re: Packfile can't be mapped
Date: Mon, 28 Aug 2006 12:43:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608281236130.3683@localhost.localdomain>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
 <20060828024720.GD24204@spearce.org>
 <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
 <Pine.LNX.4.64.0608272133390.27779@g5.osdl.org>
 <20060828060029.GB25285@spearce.org>
 <Pine.LNX.4.64.0608281026110.3683@localhost.localdomain>
 <9e4733910608280844q41ea1a61r33c3eadc3e942604@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 18:43:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHkCw-0005aN-Hc
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 18:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWH1Qn1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 12:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWH1Qn1
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 12:43:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59109 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750811AbWH1Qn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 12:43:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4P00EPVVSEFI50@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 28 Aug 2006 12:43:26 -0400 (EDT)
In-reply-to: <9e4733910608280844q41ea1a61r33c3eadc3e942604@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26165>

On Mon, 28 Aug 2006, Jon Smirl wrote:

> On 8/28/06, Nicolas Pitre <nico@cam.org> wrote:
> > > Of course the major problem with pack-local, stream global
> > > dictionaries is it voids the ability to reuse that zlib'd content
> > > from that pack in another pack without wholesale copying the
> > > dictionary as well.  This is an issue for servers which want to
> > > copy out the pack entry without recompressing it but also want the
> > > storage savings from the global dictionaries.
> >
> > Why would copying the dictionary as well be a problem?  How large might
> > it be?  Can it be stored deflated itself?
> 
> The dictionaries are only 4KB. But they have to match up with the
> objects compressed using them. If you bring an object straight down
> out of a dictionary based pack and make it standalone you won't be
> able to read it. You need the dictionary to decode it. What if the
> local and remote packs have been packed using two different
> dictionaries? You can't directly move objects between them.

I guess we'll be able to reuse the same dictionary when objects are all 
from the same pack.

If not then they could be recompressed which is costly but never as much 
as delta matching initially was when it was always done.

Anyway let's look at the size saving first.  The implied costs could 
then be evaluated and weighted accordingly.


Nicolas
