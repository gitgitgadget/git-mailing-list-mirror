From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui-i18n: Fix translation of the context menu
Date: Sun, 22 Jul 2007 23:51:22 -0400
Message-ID: <20070723035122.GB32566@spearce.org>
References: <Pine.LNX.4.64.0707221719430.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:51:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICoxF-000726-HQ
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 05:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbXGWDv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 23:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbXGWDv0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 23:51:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40990 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbXGWDvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 23:51:25 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICowx-0006qy-FJ; Sun, 22 Jul 2007 23:51:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C715A20FBAE; Sun, 22 Jul 2007 23:51:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707221719430.14781@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53382>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> There is some funny code generation going on to make the context menu,
> and the messages for this have to be doubly quoted.
> 
> Noticed by Harri Ilari Tapio Liusvaara
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-gui.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

I'll try to rewrite this hunk as a procedure, to get rid of the
double evaluation problem.  However...
 
> diff --git a/git-gui.sh b/git-gui.sh
> index 075a2b9..52170ee 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2457,9 +2457,9 @@ bind_button3 $ui_diff "
>  	set cursorX %x
>  	set cursorY %y
>  	if {\$ui_index eq \$current_diff_side} {
> -		$ctxm entryconf $ui_diff_applyhunk -label [mc {Unstage Hunk From Commit}]
> +		$ctxm entryconf $ui_diff_applyhunk -label \"[mc "Unstage Hunk From Commit"]\"

That's the wrong change to do here, as you are going to eval
the result of the translation.  If the translation had a Tcl
special character (\, $, [) in it then we'd actually execute that.
Instead the [ should be escaped:

> +		$ctxm entryconf $ui_diff_applyhunk -label \[mc "Unstage Hunk From Commit"\]

But you aren't a Tcl programmer, so its OK.  ;-)

-- 
Shawn.
