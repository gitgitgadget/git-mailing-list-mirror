From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Mon, 24 Dec 2007 23:42:02 -0500
Message-ID: <20071225044202.GO14735@spearce.org>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca> <8763yof9lg.fsf@gollum.intra.norang.ca> <Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bernt Hansen <bernt@alumni.uwaterloo.ca>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 25 05:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J71ch-0000pm-TA
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 05:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbXLYEmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 23:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbXLYEmI
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 23:42:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44616 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbXLYEmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 23:42:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J71bz-0001CC-9v; Mon, 24 Dec 2007 23:41:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3911E20FBAE; Mon, 24 Dec 2007 23:42:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712241835210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69225>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 24 Dec 2007, Bernt Hansen wrote:
> 
> > git rebase --interactive formats the combined commit log message 
> > incorrectly when squashing 3 or more commits which have no newline on 
> > the last line of the commit message.
> 
> This is a patch for git-gui, so why not make that clear in the subject?  
> (And I have a hunch that Shawn would have liked the patch relative to 
> git-gui.git, not git.git...)

Indeed.

Most git-gui changes have a subject that starts with "git-gui:" so
its clear in both the email and in the commit log that the change is
a git-gui change.  Remember, git-gui's logs show up in the core Git
logs (as its merged with -s subtree) so having that git-gui: prefix
does help people to localize the change within the overall suite.

git-am -3 does a reasonable job at correcting patches that are like
this one is (that aren't relative to git-gui.git) so that's less
of an issue for me.  And what git-am -3 cannot correct git-apply
-p2 usually does.  If that can't fix the patch then I'll usually
throw it back as its then most likely a true conflict.
 
> Further, there are other tools than rebase -i that like commit messages 
> better when terminated by a newline, and _that_ is what I would like to 
> read in the commit message for this patch.

Hmmph.  For that reason alone I'm tempted to *not* apply Bernt's
patch.

There is nothing that requires that a commit object end with an LF.
So tools that make this assumption (that there is a trailing LF)
while processing the body of a commit message are quite simply
broken.

Its easy in fast-import to generate commits without a trailing LF.
Or in many text editors its possible to save a file with no trailing
LF on the last line.  My favorite VI clone does that; if the file
doesn't end with an LF when it opens its *damned* hard to get a
trailing LF onto that last line.  And yes, that's the editor I use
for commit messages when I'm not using git-gui.

IMHO git-gui is producing valid commit messages, and always does
so with no trailing LF, and any tool that is assuming a trailing
LF is always present is broken.

Keeping git-gui behavior like this actually highlights the other
tools that are broken (here Bernt found git-rebase--interactive).


I'd like to hear Junio's or Linus' two cents on the matter, but
if we really want to say that all commits must end with an LF then
maybe git-commit-tree, git-hash-object and git-fast-import should be
performing that sort of validation before creating such an object in
the ODB.  Which is probably a change that shouldn't be made before
1.6.0 as its somewhat likely to break people's existing scripts.

-- 
Shawn.
