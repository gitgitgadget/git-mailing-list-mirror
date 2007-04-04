From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] Fix drop-down menus in the git-gui dialogs.
Date: Wed, 4 Apr 2007 12:37:09 -0400
Message-ID: <20070404163709.GA5167@spearce.org>
References: <20070327103005.GP14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:38:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ8Uq-0004Vw-H9
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 18:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992993AbXDDQhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 12:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992994AbXDDQhW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 12:37:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48667 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992993AbXDDQhT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 12:37:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZ8Tq-00032M-BE; Wed, 04 Apr 2007 12:37:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E2D8920FBAE; Wed,  4 Apr 2007 12:37:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070327103005.GP14837@codelabs.ru>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43754>

git-gui patches should be addressed to me, not Paul.

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> If the drop-down menu (for example "Local Branch" from the dialog
> activated by the "Branch/Create..." menu item) is chosen with the
> left mouse button, then the pointer is moved off the drop-down menu
> while the mouse button is still pressed and then the 'Escape' key
> is pressed, the main menu will be broken. Next time when you will
> try to select any main menu item, the Tcl/Tk interpreter will spawn
> an internal error.
> 
> Error was fixed by "grab"bing the drop-down menu windows on their
> activation. Now all drop-down menus are disappearing once the mouse
> button is depressed, no matter what is the current position of the
> mouse pointer.

This fix actually horribly breaks on Mac OS X.  The problem
appears to be that the <Visibility> event on that system doesn't
get delivered until after the menu is destroyed, yet I'm getting
a %s of VisibilityUnobscured in the event handler.  Go figure.

So anyway, I cannot apply this patch as-is, because it breaks
my main development system.  I understand and feel your pain,
but you either need to make this binding apply only on your OS,
or find another way to workaround that Tk bug...

> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 8157184..1f3ee05 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -2126,6 +2126,7 @@ proc do_create_branch {} {
>  		-font font_ui
>  	set lbranchm [eval tk_optionMenu $w.from.head_m create_branch_head \
>  		$all_heads]
> +	bind $lbranchm <Visibility> "grab $lbranchm"
>  	$lbranchm configure -font font_ui
>  	$w.from.head_m configure -font font_ui
>  	grid $w.from.head_r $w.from.head_m -sticky w

-- 
Shawn.
