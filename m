From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Build even if tclsh is not available
Date: Thu, 17 May 2007 18:16:15 -0400
Message-ID: <20070517221615.GA3141@spearce.org>
References: <20070517020616.4722.33946.stgit@rover> <20070517021448.24022.8282.stgit@rover> <20070517021858.GY3141@spearce.org> <20070517023614.GL4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 18 00:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HooGu-0007hW-3Z
	for gcvg-git@gmane.org; Fri, 18 May 2007 00:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524AbXEQWQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 18:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756723AbXEQWQW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 18:16:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45795 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524AbXEQWQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 18:16:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HooGV-0002b4-VV; Thu, 17 May 2007 18:16:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9768920FBAE; Thu, 17 May 2007 18:16:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070517023614.GL4489@pasky.or.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47561>

Petr Baudis <pasky@suse.cz> wrote:
>   (i) Makefile will autodecide on whether git-gui will be
> built+installed or not
> 
>   (ii) ./configure will, people not using configure and building on
> servers will be left to tweak config manually
> 
>   (iii) ./configure will, git-gui will default to not to be built and
> people not using configure and wanting git-gui will be left to tweak
> config manually
> 
> I suspect that (ii) will be chosen, and even though I don't like it
> *personally* I guess it's the most reasonable approach for the general
> public. I didn't know that tclIndex is vital for git-gui when I
> submitted the patch, the /Makefile comment suggests otherwise.

(iv) git-gui 0.7.1, which is now available from repo.or.cz, and
I think you know where that is ;-), makes TCL_PATH strictly an
optimization at compile time.

If TCL_PATH is present and creates a valid tclIndex file then we
use the Tcl auto_load "optimization" to only load the Tcl code we
actually need when we run.  But if it does fail for any reason we
hide the error (can be unhidden with make V=1) and we generate
a listing of the files instead.  In this latter case we load
*everything* on git-gui startup.

This way git-gui works for the user either way, just like before,
but its startup may be slightly slower if the user didn't give us
a good TCL_PATH at build time.

Junio, would you consider merging 0.7.1 soon?  No changes are
needed to git.git's own Makefile, just a subtree pull.

-- 
Shawn.
