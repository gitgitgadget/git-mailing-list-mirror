From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Fri, 1 Jun 2007 00:14:58 -0400
Message-ID: <20070601041458.GC7044@spearce.org>
References: <Pine.LNX.4.64.0705301333410.4011@racer.site> <20070531002030.GA15714@spearce.org> <7vk5uo1rpr.fsf@assigned-by-dhcp.cox.net> <20070601030959.GY7044@spearce.org> <7vvee8z5q9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 06:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtyXp-0008E3-RX
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 06:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbXFAEPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 00:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbXFAEPJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 00:15:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57631 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbXFAEPH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 00:15:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtyXX-00052V-M4; Fri, 01 Jun 2007 00:15:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B109D20FBAE; Fri,  1 Jun 2007 00:14:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vvee8z5q9.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48843>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Why cat?  Tcl is so horribly broken that to get data for both stdout
> > and stderr through a pipe I have to do something sick like:
> >
> > 	git fetch 2>&1 | cat
> >
> > because in Tcl its actually:
> >
> > 	set rdr [open "| git fetch |& cat" r]
> >
> > The |& means 2>&1| in normal shell.  But that means I have to have
> > a process after it to receive the data.  Normally that's cat.
> > But MinGW doesn't have cat.  (Nor do they have dog, but neither
> > does Linux...).  So I need a way to redirect output.
> 
> Wait a minute.  Who interprets |& in the above?  Isn't it a
> shell?

My understanding was it is Tcl itself.  My $SHELL doesn't understand
it:

  $ echo hi |& cat
  -bash: syntax error near unexpected token `&'

> That's why I asked if you are writing for shell-less
> environment.  If you are _not_, can't you do something like this
> instead?

Ideally with MinGW we wouldn't need a UNIX shell to get things
working in git-gui.  But we have to have one for git-merge for
example, as git-gui doesn't have a builtin Grand Unified Merge
Driver.  Also for git-fetch, which is one of the prime uses of this
cat redirect thing.  ;-)

> 	set rdr [open "| sh -c 'git fetch 2>&1'" r]

Yeah, I'm already doing that sh -c trick for a different reason in
another context.  I may have to do just that here too.

-- 
Shawn.
