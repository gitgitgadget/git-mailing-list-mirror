From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 11/22] entry.c: optionally checkout submodules
Date: Thu, 24 May 2007 03:18:19 -0400
Message-ID: <20070524071819.GN28023@spearce.org>
References: <11799589913153-git-send-email-skimo@liacs.nl> <11799589922243-git-send-email-skimo@liacs.nl> <81b0412b0705232359g34321bb9hda50c3e29d7d3473@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "skimo@liacs.nl" <skimo@liacs.nl>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 09:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7ak-0002Du-8R
	for gcvg-git@gmane.org; Thu, 24 May 2007 09:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbXEXHSb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 03:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbXEXHSb
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 03:18:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57920 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbXEXHSb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 03:18:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hr7aW-0003JN-Dx; Thu, 24 May 2007 03:18:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 96A0120FBAE; Thu, 24 May 2007 03:18:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0705232359g34321bb9hda50c3e29d7d3473@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48229>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 5/24/07, skimo@liacs.nl <skimo@liacs.nl> wrote:
> 
> >+       args[argc++] = "checkout";
> >+       if (state->force)
> >+           args[argc++] = "-f";
> >+       args[argc++] = sha1_to_hex(ce->sha1);
> >+       args[argc] = NULL;
> 
> You should consider passing "-v" if the superprojects read-tree
> had it. Some submodules will be annoyingly big

In 1.5.2 that -v shouldn't be necessary.  The read-tree should
start a timer, and if it has not reached 50% of its processing
within 2 seconds it starts showing progress.  Unless !istty(2),
in which case it just sits there, chugging away at your drive.

I'm actually really unhappy with our !istty(2) means disable
progress thing.  git-gui knows how to read and show the progress
meters, but nobody prints them anymore as 2 is a pipe.  I have the
same problem with a Java build tool that sometimes starts up an
expensive Git operation (like a clone over SSH of a 60+ MiB project).

I've been considering adding a GIT_ISTTY environment variable to
forcefully override the istty result, just to get the progress
meters turned back on...

-- 
Shawn.
