From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: QGit: Shrink used memory with custom git log format
Date: Mon, 26 Nov 2007 20:52:48 -0500
Message-ID: <20071127015248.GK14735@spearce.org>
References: <e5bfff550711240014n78f24b46qf012957d92b1a8e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 02:53:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwpdO-0007IY-OQ
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 02:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbXK0Bwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 20:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbXK0Bww
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:52:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43546 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbXK0Bww (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 20:52:52 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iwpct-00043y-Q5; Mon, 26 Nov 2007 20:52:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E1DE620FBAE; Mon, 26 Nov 2007 20:52:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <e5bfff550711240014n78f24b46qf012957d92b1a8e1@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66156>

Marco Costalba <mcostalba@gmail.com> wrote:
> Now instead of --pretty=raw a custom made --pretty=format is given,
> this shrinks loaded data of 30% (17MB less on Linux tree) and gives a
> good speed up when you are low on memory (especially on big repos)
> 
> Next step _would_ be to load log message body on demand (another 50%
> reduction) but this has two drawbacks:
> 
> (1) Text search/filter on log message would be broken
> 
> (2) Slower to browse through revisions because for each revision an
> additional git-rev-list /git-log command should be executed to read
> the body
> 
> The second point is worsted by the fact that it is not possible to
> keep a command running and "open" like as example git-diff-tree
> --stdin and feed with additional revision's sha when needed. Avoiding
> the burden to startup a new process each time to read a new log
> message given an sha would let the answer much more quick especially
> on lesser OS's
> 
> Indeed there is a git-rev-list --stdin option but with different
> behaviour from git-diff-tree --stdin and not suitable for this.

There was a proposed patch for git-cat-file that would let you run
it in a --stdin mode; the git-svn folks wanted this to speed up
fetching raw objects from the repository.  That may help as you
could get commit bodies (in raw format - not reencoded format!)
quite efficiently.

Otherwise I think what you really want here is a libgit that you can
link into your process and that can efficiently inflate an object
on demand for you.  Like the work Luiz was working on this past
summer for GSOC.  Lots of downsides to that current tree though...
like die() kills the GUI...

-- 
Shawn.
