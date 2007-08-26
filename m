From: Jeff King <peff@peff.net>
Subject: Re: git-daemon on NSLU2
Date: Sun, 26 Aug 2007 05:33:31 -0400
Message-ID: <20070826093331.GC30474@coredump.intra.peff.net>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com> <20070824062106.GV27913@spearce.org> <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com> <alpine.LFD.0.999.0708241618070.16727@xanadu.home> <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com> <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org> <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, jnareb@gmail.com,
	Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 11:34:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPEVR-0006oE-Qh
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 11:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbXHZJde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 05:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbXHZJde
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 05:33:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3774 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbXHZJdd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 05:33:33 -0400
Received: (qmail 19749 invoked by uid 111); 26 Aug 2007 09:33:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Aug 2007 05:33:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Aug 2007 05:33:31 -0400
Content-Disposition: inline
In-Reply-To: <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56681>

On Sat, Aug 25, 2007 at 11:44:07AM -0400, Jon Smirl wrote:

> A very simple solution is to sendfile() existing packs if they contain
> any objects that the client wants and let the client deal with the
> unwanted objects. Yes this does send extra traffic over the net, but
> the only group significantly impacted is #2 which is the most
> infrequent group.
>
> Loose objects are handled as they are currently. To optimize this
> scheme you need to let the loose objects build up at the server and
> then periodically sweep only the older ones into a pack. Packing the
> entire repo into a single pack would cause recent fetches to retrieve
> the entire pack.

I was about to write "but then 'fetch recent' clients will have to get
the entire repo after the upstream does a 'git-repack -a -d'" but you
seem to have figured that out already.

I'm unclear: are you proposing new behavior for git-daemon in general,
or a special mode for resource-constrained servers? If general behavior,
are you suggesting that we never use 'git-repack -a' on repos which
might be cloned?

-Peff
