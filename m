From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Thu, 12 May 2005 17:24:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505121709250.30848-100000@iabervon.org>
References: <20050512205735.GE5914@waste.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 23:20:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWL5b-0006ix-B2
	for gcvg-git@gmane.org; Thu, 12 May 2005 23:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVELV0u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVELV0u
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 17:26:50 -0400
Received: from iabervon.org ([66.92.72.58]:43013 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262130AbVELVYy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 17:24:54 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DWLAR-0002xr-00; Thu, 12 May 2005 17:24:27 -0400
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050512205735.GE5914@waste.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 May 2005, Matt Mackall wrote:

> Does this need an HTTP request (and round trip) per object? It appears
> to. That's 2200 requests/round trips for my 800 patch benchmark.

It requires a request per object, but it should be possible (with
somewhat more complicated code) to overlap them such that it doesn't
require a serial round trip for each. Since the server is sending static
files, the overhead for each should be minimal.

> How does git find the outstanding changesets?

In the present mainline, you first have to find the head commit you
want. I have a patch which does this for you over the same
connection. Starting from that point, it tracks reachability on the
receiving end, and requests anything it doesn't have.

For the case of having nothing to do, it should be a single one-line
request/response for a static file (after which the local end determines
that it has everything it needs without talking to the server).

	-Daniel
*This .sig left intentionally blank*

