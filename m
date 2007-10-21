From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to run git-gui always in English?
Date: Sun, 21 Oct 2007 03:15:43 -0400
Message-ID: <20071021071543.GF14735@spearce.org>
References: <CCAD0DE0-65D4-4FEC-B02F-658010FECD04@zib.de> <20071021065230.GE14735@spearce.org> <C65193EE-A45D-49ED-8831-1A006421A915@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 09:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjV2W-0001zK-9c
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 09:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbXJUHPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 03:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbXJUHPr
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 03:15:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35535 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbXJUHPq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 03:15:46 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjV2G-0001gH-19; Sun, 21 Oct 2007 03:15:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8C4ED20FBAE; Sun, 21 Oct 2007 03:15:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <C65193EE-A45D-49ED-8831-1A006421A915@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61886>

Steffen Prohaska <prohaska@zib.de> wrote:
> On Oct 21, 2007, at 8:52 AM, Shawn O. Pearce wrote:
> >
> >I think that if you set LANG=en before you start git-gui it will
> >take on English, and so will all of the standard dialogs that we
> >"borrow" from wish.
> 
> Do we have a chance before we source the real git-gui.tcl?
> Maybe we could "set env(LANG)" based on "git config gui.lang"?
> Or is it already too late because we needed to restart wish?

Hmm.  Really quick testing here shows that we just need to make sure
env(LANG) is set before we do the msgcat::mcload call in git-gui.sh
line 104.

If we're going to use a `git config gui.lang` thing then we can
probably just make a msgcat::mclocale call on line 103 just before we
load our message file.  Unfortunately this is before we have located
git so technically git-gui doesn't know how to run git-config and
thus cannot get to gui.lang.  :-|

Hmm.  Looking at this further we may be able to insert the mclocale
call at two locations; one at line 864 before we open the repository
wizard, and again at line 1802, just before we start to initialize
our UI.  This does mean that for really serious errors (e.g. "No
git in PATH") we'll be using your native OS language.

-- 
Shawn.
