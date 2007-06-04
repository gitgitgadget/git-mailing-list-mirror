From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Improved git-gui blame viewer
Date: Mon, 4 Jun 2007 02:07:20 -0400
Message-ID: <20070604060720.GF4507@spearce.org>
References: <20070602041723.GD7044@spearce.org> <f3rhme$2h9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Melchior <mmelchior@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Jun 04 08:07:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv5j5-0001Bt-1O
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 08:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXFDGHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 02:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbXFDGHY
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 02:07:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44904 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXFDGHY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 02:07:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hv5ir-0003rs-QY; Mon, 04 Jun 2007 02:07:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8DE3920FBAE; Mon,  4 Jun 2007 02:07:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <f3rhme$2h9$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49066>

Matthijs Melchior <mmelchior@xs4all.nl> wrote:
> The colors look much better.

Thank Linus.  He's not a user inteface guy, but his idea was actually
pretty good.  ;-)
 
> The behavior has some rough edges. I don't like the following:
>   When clicking on a link in the left column, the file as present in
>   that commit is loaded, positioned at the top. I would like for the
>   line where I clicked is to stay at the same position on the screen,
>   so I do not have to find it again.

Me too.  Unfortunately I'm fighting with Tk to make this work.
Right now I've got the code written to do this, and I see it happen
internally, but then something causes Tk to reset the viewport back
to the top.  Arrrrrrgh.  I haven't pushed it out because it doesn't
work.
 
>   Also, when returning I would like most lines on the screen stay the
>   same.

Ditto.

>   When clicking on a light gray line to become a green line, then
>   adjacent areas are not correctly colored.  A few adjacent entries
>   become all same gray... [Look around git-gui.sh:340]

This (I think) is because of the way the color selections are
being done.  git-gui is being stupid and just alternating colors to
commits as they come in from `git blame --incremental`.  The thing
about the incremental blame is I can receive data for any part of
the file at any time.  So in general what happens is I get data for
one part of the file, give it color A, then data for another part,
give it color B, and then get data for part that is right next to the
first A and assign it A again.  So you see chunks where there is no
alternating...

>   Something I want for the normal window, in the Staged and Unstaged
>   file lists, high-lite the last entry selected so it becomes easy to
>   click on the next one and I can see more clearly what is displayed
>   in the bottom area.

I'm not sure I understand what you are looking for here.  Right now
git-gui should be inverting the foreground/background colors on
the file that is "selected" (shown in the lower diff view pane).
So the background should be black, and the foreground white.
Is this not happening?  Or are you looking for something else?

-- 
Shawn.
