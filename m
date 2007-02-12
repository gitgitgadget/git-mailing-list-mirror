From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 01:22:24 -0500
Message-ID: <20070212062224.GD699@spearce.org>
References: <200702111252.28393.bruno@clisp.org> <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200702120041.27419.bruno@clisp.org> <200702120059.17676.robin.rosenberg.lists@dewire.com> <7vmz3kaugq.fsf@assigned-by-dhcp.cox.net> <20070212060641.GC699@spearce.org> <7vmz3jaorx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Bruno Haible <bruno@clisp.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 07:22:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGUaH-00042y-5G
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 07:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028AbXBLGWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 01:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933029AbXBLGWe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 01:22:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35712 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933028AbXBLGWd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 01:22:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGUa2-0003zl-Im; Mon, 12 Feb 2007 01:22:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BFE9620FBAE; Mon, 12 Feb 2007 01:22:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmz3jaorx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39375>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > So I ran three trials, v1.5.0-rc4-26-gcc46a74 with and without
> > NO_MMAP against v1.4.4.4 on a freshly repacked git.git.
> 
> I do not think freshly repacked git.git is a good test case for
> a real-world workload where this really matters.  Doesn't your
> default pack window large enough to cover it with a single
> window, or perhaps two at most?

Its one window, maybe two, as git.git is ~12 MiB and the window
size is 1 MiB (NO_MMAP) or 32 MiB (with mmap).

On linux.git:

v150-mmap:
        2.23 real         1.99 user         0.10 sys
        2.19 real         1.98 user         0.10 sys
        2.19 real         1.98 user         0.10 sys

v150-nommap:
        2.63 real         1.99 user         0.50 sys
        2.67 real         1.98 user         0.51 sys
        2.63 real         1.99 user         0.51 sys

v1444:
        2.15 real         1.94 user         0.09 sys
        2.19 real         1.95 user         0.10 sys
        2.16 real         1.94 user         0.10 sys

Again, we aren't too far away from v1.4.4.4, but the NO_MMAP clearly
is hurting us, even on Mac OS X.

-- 
Shawn.
