From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack v4 status
Date: Tue, 27 Feb 2007 22:45:55 -0500
Message-ID: <20070228034555.GA5597@spearce.org>
References: <20070227155042.GB3230@spearce.org> <Pine.LNX.4.64.0702271348260.12485@woody.linux-foundation.org> <alpine.LRH.0.82.0702271717080.29426@xanadu.home> <7vwt23b54a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 04:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMFli-0008Aq-Of
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 04:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbXB1DqP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 22:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbXB1DqP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 22:46:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32922 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbXB1DqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 22:46:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMFlE-00075h-Ag; Tue, 27 Feb 2007 22:45:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B06D520FBAE; Tue, 27 Feb 2007 22:45:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vwt23b54a.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40884>

Junio C Hamano <junkio@cox.net> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> > The idea is to deal with only tree objects containing the 64K most 
> > frequently used base names and fall back to the current tree object 
> > encoding for objects that couldn't be represented that way.
> 
> Ah, I was wondering the same thing as Linus after seeing shawn
> talked about the 2-byte prefix on #git. Falling back to an
> alternate encoding for rarer cases makes sense.

Right.  Git is already fast, and already compresses the object data
very well.  But I think we can make things faster without violating
the basic assumptions of "whole project history", and it just turns
out that those encodings are also making the data smaller for the
common case of human maintained source code.  Which of course is
one of the primary uses for Git, but is obviously not the only use.

In the worst case scenario we'll be doing exactly what we are
doing today with regards to encoding. That performance and disk
space usage is already known and considered "very, very fast" and
"very small".  ;-)

In the best case scenario (human managed source like linux.git,
git.git) we'll scream with pack v4.  The rev-list stats I posted
from just the tree encoding switch not only saved 3 MiB of disk
space but improved total running time by 12.5%.  Nico and I know
we can still do better.

With 15k basenames in linux.git we're filling only 23.6% of the
available namespace within a single packfile.  I think that by the
time we have enough basenames to break 64K we'll be several years
out and be talking about historical packs vs. active packs.

-- 
Shawn.
