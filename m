From: Jeff King <peff@peff.net>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 08:33:53 -0500
Message-ID: <20070127133352.GB2417@coredump.intra.peff.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <7vbqkklv3h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 14:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAngs-0002BJ-Sr
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 14:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbXA0Ndz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 08:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbXA0Ndz
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 08:33:55 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1475 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752268AbXA0Ndz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 08:33:55 -0500
Received: (qmail 16175 invoked from network); 27 Jan 2007 08:34:17 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Jan 2007 08:34:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Jan 2007 08:33:53 -0500
Content-Disposition: inline
In-Reply-To: <7vbqkklv3h.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37955>

On Sat, Jan 27, 2007 at 12:41:54AM -0800, Junio C Hamano wrote:

> > Based on some (limited) profiling with Shark it seems we spend about
> > 50% of our CPU time doing zlib decompression of objects and almost
> > another 14% parsing the tree objects to apply the path limiter.
> 
> I once tried to use zlib compression level 0 for tree objects
> and did not see much difference -- maybe I should dig it up and
> find out why.

I don't know exactly what Shawn meant, but a considerable amount of time
in a blame is spent decompressing the blobs. Just for fun, some numbers:

Fully packed, warm cache, core.compression = -1:
$ time git blame Makefile >/dev/null
real    0m5.537s
user    0m5.500s
sys     0m0.032s

Fully packed, warm cache, core.compression = 0:
$ time git blame Makefile >/dev/null
real    0m3.001s
user    0m2.984s
sys     0m0.012s

That's 45% savings. The resulting pack sizes are 11932K compressed and
22308 uncompressed.

-Peff
