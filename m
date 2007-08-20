From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax mean.
Date: Mon, 20 Aug 2007 02:05:22 -0400
Message-ID: <20070820060522.GA27913@spearce.org>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net> <20070814231422.GA10662@pe.Belkin> <7vps1paceh.fsf@assigned-by-dhcp.cox.net> <46C90C46.1030000@midwinter.com> <20070820055221.GA22993@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Grimm <koreth@midwinter.com>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:06:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN0Ov-0005QD-Kx
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 08:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbXHTGFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 02:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbXHTGFk
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 02:05:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39848 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbXHTGFk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 02:05:40 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IN0OB-0007Ug-Rt; Mon, 20 Aug 2007 02:05:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 72AC120FBAE; Mon, 20 Aug 2007 02:05:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070820055221.GA22993@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56173>

Jeff King <peff@peff.net> wrote:
> On Mon, Aug 20, 2007 at 11:36:38AM +0800, Steven Grimm wrote:
> 
> > The git-rev-parse manpage talks about the :$n:path notation (buried deep in
> > a list of other syntax) but it just says $n is a "stage number" -- someone
> > who is not familiar with the internals of git's merge implementation is
> > never going to be able to figure out that "1", "2", and "3" mean what Junio
> > said.
> 
> I often forget which number corresponds to which source. I seem to
> recall somebody proposing :ours:$path a while ago, but I couldn't find
> any reference in the archive, so perhaps I just dreamed it.
> 
> Am I the only one who messes this up? If not, patch is below.

Maybe.  ;-)

I've memorized it long long ago.  But my coworkers haven't and always
get it wrong, and look at me funny when I tell them "trust me, your
data is in stage 2 and theirs is in stage 3...  because that's the
convention all of the tools you are using follows".

Keywords in that last part: "convention" and "tools you are using".
Someone could redefine what the stages mean and load content into
them using `update index --index-info`.  You might even be able to
load the stages in odd ways yourself from Porcelain.

Oh, like say git-rebase.  During a rebase "theirs" (stage 3) is
your file and "ours" (stage 2) is the upstream.  Confusing now,
ain't it?  Mine is theirs and ours is theirs?  Huh?  Yeeaaaah.

This is why I've never liked most merge tools.  They get hung up on
what is theirs and what is mine and then at some point they wind up
confusing the stages and getting them inverted.  And this is exactly
why git-merge.sh/git-rebase.sh/git-am.sh try to setup GITHEAD_* for
git-merge-recursive, and why they set it up using branch names and
patch subject lines, because it makes the conflict markers easier
to understand.
 
>  	/* sha1:path --> object name of path in ent sha1
>  	 * :path -> object name of path in index
>  	 * :[0-3]:path -> object name of path in index at stage
> +	 * :base|ours|theirs:path -> same as :[1-3]:path
>  	 */

At least document the new syntax in git-rev-parse documentation?

-- 
Shawn.
