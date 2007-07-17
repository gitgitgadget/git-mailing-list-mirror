From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Another question about importing SVN with fast-import
Date: Mon, 16 Jul 2007 23:38:40 -0400
Message-ID: <20070717033840.GK32566@spearce.org>
References: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 17 05:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAdtp-0004Q5-Ut
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 05:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbXGQDip (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 23:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754443AbXGQDip
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 23:38:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60711 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbXGQDio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 23:38:44 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAdtO-000675-HW; Mon, 16 Jul 2007 23:38:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 28DF520FBAE; Mon, 16 Jul 2007 23:38:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52737>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> First off, I would just like to say fast-import rocks.  It's well named 
> too ...

I'm glad you like it.  ;-)
 
> Now the question.  Shawn recently added C and R operations - almost as 
> soon as they were asked for too.

Sometimes I'm responsive...

> However, how do you copy a file from a 
> particular revision?

and sometimes not so much.  You can't do that right now.  I've wanted
to open up the data subcommand to allow another form that lets you
specify data from a branch and file path (thus selecting a blob
from another revision) but I haven't gotten around to it.  I also
don't have time to do it during the earlier part of this week.
Maybe I'll get to it later near the end of the week.

It shouldn't be too difficult now with the tree_content_get()
function that I recently defined for the C/R commands.  The SHA-1
comes back in the tree_entry leaf, but that codepath is only valid
for the tip of a branch that fast-import knows about in memory.
If it doesn't then you probably need to fallback into raw tree
parsing.  Ugh.

The way prior frontends have handled this is they assigned marks
to every blob, and then had a translation table within the frontend
of revision->mark, so that anytime it needed a given revision of a
file it knew what mark to send to fast-import.  This does require
that the frontend maintain basically everything...

> I have just hit a point where someone deleted a 
> directory, and then copied one of the files from that directory back from 
> an old revision (as two separate commits).  Since I'm not tracking any 
> branch contents in my front-end, and the copy operation only works from 
> the current branch head I seem to be stuck ... or have I missed something?

Yea, I got nothing.  I can't think of any method to make that work
aside from using marks.  Or teaching fast-import how to do tree
lookup, like I described above.

-- 
Shawn.
