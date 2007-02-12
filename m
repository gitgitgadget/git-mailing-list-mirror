From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 12:06:47 -0500
Message-ID: <20070212170647.GB29621@spearce.org>
References: <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com> <Pine.LNX.4.64.0702112022430.1757@xanadu.home> <7vd54gau3r.fsf@assigned-by-dhcp.cox.net> <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com> <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net> <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com> <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com> <7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702121241130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <9e4733910702120631o1be92037ue89b069b0354c8cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 18:07:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGedv-0006NL-Qr
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 18:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbXBLRHD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 12:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbXBLRHB
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 12:07:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58018 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964971AbXBLRHA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 12:07:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGedX-00063S-Bu; Mon, 12 Feb 2007 12:06:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CF91B20FBAE; Mon, 12 Feb 2007 12:06:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <9e4733910702120631o1be92037ue89b069b0354c8cb@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39416>

Jon Smirl <jonsmirl@gmail.com> wrote:
> Why doesn't clone copy the existing packs down first with sendfile,
> then build a small pack for what is left and avoid the initial step of
> making a giant pack. Isn't clone going to break when the repo exceeds
> 2GB?

Because the network format allows an unlimited packfile size,
at least until you reach the 2^32-1 object count barrier anyway.
It also allows only one packfile to be sent.

The problem is the local system.  We are unable to build an index
file locally on a packfile that is larger than 4 GiB, as the offsets
to positions within the packfile are 32 bit unsigned big-endian
integers.  The index gets built on the client as it receives the
packfile from the server.

-- 
Shawn.
