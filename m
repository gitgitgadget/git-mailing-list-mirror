From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Support of "make -s": do not output anything of the build itself
Date: Tue, 6 Mar 2007 18:29:27 -0500
Message-ID: <20070306232927.GB25785@spearce.org>
References: <81b0412b0703061514m2f2b3237yd1192dd651a1109e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:29:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOj68-0006tb-A8
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030709AbXCFX3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030710AbXCFX3d
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:29:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45847 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030709AbXCFX3c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:29:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOj5r-0003FB-Ob; Tue, 06 Mar 2007 18:29:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B062E20FBAE; Tue,  6 Mar 2007 18:29:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0703061514m2f2b3237yd1192dd651a1109e@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41619>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> Makefile         |   10 +++++++---
> git-gui/Makefile |    5 -----
> 2 files changed, 7 insertions(+), 8 deletions(-)

Nack.  You need to split any git-gui changes into their own patch
so that I can apply them to the git-gui repository directly.
Junio then merges that into git.git.

> +QUIET_SUBDIR0  = $(MAKE) -C # space to separate -C and subdir
> +QUIET_SUBDIR1  =
> +
> +ifneq ($(findstring $(MAKEFLAGS),s),s)

This is a good idea.

>  ifndef V
>  	QUIET_CC       = @echo '   ' CC $@;
>  	QUIET_AR       = @echo '   ' AR $@;
> @@ -615,9 +620,8 @@ ifndef V
>  			 $(MAKE) --no-print-directory -C $$subdir
>  	export V
>  	export QUIET_GEN
> -else
> -	QUIET_SUBDIR0  = $(MAKE) -C
> -	QUIET_SUBDIR1  =
> +	export QUIET_BUILT_IN
> +endif
>  endif

> diff --git a/git-gui/Makefile b/git-gui/Makefile
> -ifndef V
> -	QUIET_GEN      = @echo '   ' GEN $@;
> -	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
> -endif
> -

git-gui can be built on its own, outside of git.git's make system.
I need the ifneq(...-s...) thing above also here, around the
existing ifndef.

Want to rework the patch as two?  ;-)

-- 
Shawn.
