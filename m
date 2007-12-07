From: Jeff King <peff@peff.net>
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 16:39:28 -0500
Message-ID: <20071207213928.GA11613@coredump.intra.peff.net>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:39:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0kvI-0003CQ-OQ
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbXLGVjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbXLGVjb
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:39:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1766 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbXLGVja (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:39:30 -0500
Received: (qmail 13421 invoked by uid 111); 7 Dec 2007 21:39:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Dec 2007 16:39:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 16:39:28 -0500
Content-Disposition: inline
In-Reply-To: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67469>

On Fri, Dec 07, 2007 at 03:07:05PM -0500, Jon Smirl wrote:

> I noticed two things when doing a repack of the gcc repo. First is
> that the git process is getting to be way too big. Turning off the
> delta caches had minimal impact. Why does the process still grow to
> 4.8GB?
> 
> Putting this in perspective, this is a 4.8GB process constructing a
> 330MB file. Something isn't right. Memory leak or inefficient data
> structure?

Keep in mind that you are trying many different deltas, which are being
held in memory, to find the right one and generate the 330MB file. And
when you multiply that times N threads going at once, _each one_ is
using a bunch of memory.

As Nico suggested, you could probably drop the memory usage by reducing
the size of the delta cache.

-Peff
