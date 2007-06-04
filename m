From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Improved git-gui blame viewer
Date: Mon, 4 Jun 2007 04:21:56 -0400
Message-ID: <20070604082156.GI4507@spearce.org>
References: <20070602041723.GD7044@spearce.org> <f3rhme$2h9$1@sea.gmane.org> <20070604060720.GF4507@spearce.org> <20070604073827.GF16637@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Melchior <mmelchior@xs4all.nl>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 10:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv7pV-00062l-Sp
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 10:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbXFDIWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 04:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbXFDIWE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 04:22:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47269 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbXFDIWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 04:22:03 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hv7p7-0008Ev-94; Mon, 04 Jun 2007 04:21:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BDD6B20FBAE; Mon,  4 Jun 2007 04:21:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070604073827.GF16637@admingilde.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49082>

Martin Waitz <tali@admingilde.org> wrote:
> 
> On Mon, Jun 04, 2007 at 02:07:20AM -0400, Shawn O. Pearce wrote:
> > >   When clicking on a light gray line to become a green line, then
> > >   adjacent areas are not correctly colored.  A few adjacent entries
> > >   become all same gray... [Look around git-gui.sh:340]
> 
> If you use three colors you can always select one which is different
> to the hunk above and below.  But I don't know if that would be
> visually appealing...

That's actually not a bad idea.  But to make that work I have to
do the coloring by line chunks, not commits.  Given how bad the
current by-commit coloring is, the 3 coloring by line chunks is
probably the best bet.  It would resemble what gitweb does, but
we'd be using 3 colors in git-gui vs. the 2 in gitweb.  We could
do worse.
 
> Another nice thing would be a smooth gradient for each hunk.
> Then we could use the same colors for every hunk, but the top of each
> hunk would be a little bit lighter/darker than the bottom so that
> it is easy to see the border.  Is that doable in Tk?

I think so, but its ugly.  The viewer is actually 4 text widgets
crammed next to each other.  I can set the background color of a
line by giving it a tag, so to do a gradient I have to assign a
different background color to each line by giving each line its
own tag (ick).  Worse, in a 3 line chunk I can only do 3 colors.
That fails your "smooth" concept.  ;-)

> Perhaps a simple small line between hunks is enough, too?

That would be messy.  I can certainly cause a few pixels of spacing
to show up between chunks, but I'm reading the data "live" from the
blame engine and putting it on screen.  Adding space betwen chunks
as I get it will cause the data to "reflow" while you are trying to
read it.  I can probably account for it with the scrollbar and adjust
it accordingly, but at some point you will wind up seeing the text
in the viewer pane moving around and expanding as the padding gets
tossed in.


BTW, I just got the jump-to-original line and restore-view-on-back
features that Matthijs was asking about working properly.  Apparently
a call to Tk's "update" (basically just let Tk pump its event loop)
is needed after I've finished reading the file content, but before I
adjust the view.  Its in my pu branch now (gitgui-0.7.2-58-gf9e96fd).

-- 
Shawn.
