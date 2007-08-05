From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-diff new files (without using index)
Date: Sat, 4 Aug 2007 23:52:45 -0400
Message-ID: <20070805035245.GE9527@spearce.org>
References: <87wswalkad.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 05:52:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXAh-0004Hh-9j
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 05:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760583AbXHEDwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 23:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757631AbXHEDwt
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 23:52:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45147 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbXHEDws (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 23:52:48 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHXAP-00048K-9E; Sat, 04 Aug 2007 23:52:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4461A20FBAE; Sat,  4 Aug 2007 23:52:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87wswalkad.fsf@catnip.gol.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54929>

Miles Bader <miles@gnu.org> wrote:
> One thing I often want to do is generate a complete diff of all changes,
> including new/removed files.
> 
> If I add things to the index, I can use "git-diff --cached" to do it;
> however I'd actually like to be able to do this _without_ updating the
> index; in other words, any un-added new file as a change.  As it is, the
> "non-indexed" state seems kind of a second-class citizen, as you can
> never have new files there (or rather, git will never really see them).
 
Use a temporary index:

  (export GIT_INDEX_FILE=.git/tempindex;
   cp .git/index $GIT_INDEX_FILE;
   git add new-file;
   git add other-new-file;
   git diff --cached)

We pull this trick sometimes in internal tools, when we want to
produce some result but aren't sure we want to keep the resulting
index, or really know we don't want to keep the resulting index.

Another option is to just add everything, then reset the index:

  git add new-file
  git add other-new-file
  git diff --cached
  git reset

Granted if you had other files staged they just became unstaged
and will need to be restaged...  the temporary index trick above
avoids that.

-- 
Shawn.
