From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 01:31:58 -0400
Message-ID: <20070810053158.GJ24573@spearce.org>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de> <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 07:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJN6o-0006RC-6D
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 07:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbXHJFcH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 01:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXHJFcG
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 01:32:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52609 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbXHJFcF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 01:32:05 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IJN6L-0007FE-Ue; Fri, 10 Aug 2007 01:31:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4E16520FBAE; Fri, 10 Aug 2007 01:31:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55506>

Steffen Prohaska <prohaska@zib.de> wrote:
> mingw only contains tclsh84 but not tclsh. This causes
> the Makefile in git-gui to fail on the creation of
> lib/tclIndex. Therefore git gui decides to take the slow
> path of sourcing the files in lib explicitly but this failes
> because they are sourced before git-version is defined.
> Therefore blame.tcl reports the error mentioned above.
> 
> Johannes (or someone else from the msysgit team),
> We should modify mingw to contain the symlink to tclsh.
> Or something similar, at least 'tclsh' should be there.
> 
> Shawn,
> The fallback mechanism of sourcing files from lib is broken.
> Either git-version must be defined before sourcing them, or
> the auto_index must always work.

*ouch*.  Yea, that happened when the git-version proc was introduced.
It doesn't get declared until after we have sourced everything,
but the things we are sourcing want it to be declared.

The short-term workaround is the obvious thing of just making
sure the auto_index works in the Makefile.  I'll try to reorder
things in git-gui so that the "source everything fallback" is
done only after git-version is declared.  Though that might be
difficult as that codepath assumes error_popup has been declared
and that's in something we are sourcing.

Ouch.

	me: Doctor, it hurts when I declare circular dependencies!
	dr: Well, don't do that son!

-- 
Shawn.
