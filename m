From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Mac OSX and gitk right-click
Date: Sat, 7 Jun 2008 03:20:07 -0400
Message-ID: <20080607072007.GB12896@spearce.org>
References: <3215D250-73A0-422C-B104-2BE306778271@trustbearer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Harning <thomas.harning@trustbearer.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 09:21:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4sjb-0000KK-Dr
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 09:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbYFGHUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 03:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbYFGHUN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 03:20:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39314 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbYFGHUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 03:20:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K4sid-0007he-KR; Sat, 07 Jun 2008 03:20:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C337220FBAE; Sat,  7 Jun 2008 03:20:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <3215D250-73A0-422C-B104-2BE306778271@trustbearer.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84181>

Thomas Harning <thomas.harning@trustbearer.com> wrote:
> gitk doesn't appear to have right-click support in OSX, but  
> gitgui-0.8.1 has it...

That's because git-gui has this procedure

proc bind_button3 {w cmd} {
    bind $w <Any-Button-3> $cmd
    if {[is_MacOSX]} {
        # Mac OS X sends Button-2 on right click through three-button mouse,
        # or through trackpad right-clicking (two-finger touch + click).
        bind $w <Any-Button-2> $cmd
        bind $w <Control-Button-1> $cmd
    }
}

and uses it to configure the binding for the "right-click" scripts
rather than calling "bind $w <Any-Button-3> ..." directly.  gitk
does the latter, and thus fails on Mac OS X.

I actually think its a bug in Tcl/Tk on Aqua that it doesn't treat
Control-Click as a right click action, or that right mouse click
is sent as button 2, but is 3 on ever other system.

-- 
Shawn.
