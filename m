From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: exception in git-gui when saving options
Date: Sun, 18 Feb 2007 02:14:58 -0500
Message-ID: <20070218071457.GC31350@spearce.org>
References: <20070217194033.GH21842@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sun Feb 18 08:15:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIgGY-0001Xp-W6
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 08:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbXBRHPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 02:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbXBRHPE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 02:15:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39579 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030385AbXBRHPD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 02:15:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HIgGC-0002WD-3d; Sun, 18 Feb 2007 02:15:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8DDFF20FBAE; Sun, 18 Feb 2007 02:14:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070217194033.GH21842@admingilde.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40059>

Martin Waitz <tali@admingilde.org> wrote:
> I get the following backtrace when I want to save options in a
> git-gui which is started in blame mode:
> 
> The options seem to be saved correctly.

Whoops.  :-)  Its fixed with the following commit in git-gui:

commit 372ef954a15c321a1065bf7e764449ce7767277f
Author: Shawn O. Pearce <spearce@spearce.org>
Date:   Sun Feb 18 02:12:32 2007 -0500

    git-gui: Correct crash when saving options in blame mode.
    
    Martin Waitz noticed that git-gui crashed while saving the user's
    options out if the application was started in blame mode.  This
    was caused by the do_save_config procedure invoking reshow_diff
    incase the number of context lines was modified by the user.
    Because we bypassed main window UI setup to enter blame mode we
    did not set many of the globals which were accessed by reshow_diff,
    and reading unset variables is an error in Tcl.
    
    Aside from moving the globals to be set earlier, I also modified
    reshow_diff to not invoke clear_diff if there is no path currently
    in the diff viewer.  This way reshow_diff does not crash when in
    blame mode due to the $ui_diff command not being defined.
    
    Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
