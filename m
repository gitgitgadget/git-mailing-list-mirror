From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 13:32:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608171323330.11359@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <20060817040719.GC18500@spearce.org>
 <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910608170736y4863e0ebr55c6c822ae548cca@mail.gmail.com>
 <Pine.LNX.4.63.0608171738490.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910608171017k628ef754s4fcd075d60aaf062@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 19:32:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDljL-0001Pr-0c
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 19:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWHQRc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 13:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWHQRc2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 13:32:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54521 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932348AbWHQRc0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 13:32:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4500BE7KQ2JN30@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Aug 2006 13:32:26 -0400 (EDT)
In-reply-to: <9e4733910608171017k628ef754s4fcd075d60aaf062@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25597>

On Thu, 17 Aug 2006, Jon Smirl wrote:

> Is there a pack format version number built into the server procotol?
> If not there needs to be one. When there is a mismatch with the server
> pack version the client should simply display an error requesting an
> upgrade of the client software.

There is a pack version number.  Reception of an unknown pack already 
produces an error:

        if (!pack_version_ok(hdr->hdr_version))
                die("unknown pack file version %d", ntohl(hdr->hdr_version));

That will occur really early in a pull or clone when using the native 
protocol.

> Git should be designed for forward evolution, not infinite backward
> compatibility. It is easy to upgrade your client to support the new
> protocol. The protocol just needs to ensure that the client reliably
> gets an error about the need to upgrade.
> 
> Forward evolution implies that a client is able to work with older
> servers, but not the inverse, that new servers have to work with old
> clients.

And still, if we really wanted, the server could have the ability to 
stream an old pack format by simply inflating the grouped objects and 
deflating them individually all on the fly, which is not necessarily 
that costly.  But it might still be a good idea to simply have the 
ability to generate both formats and make the grouped deltas the default 
only after a while.


Nicolas
