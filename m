From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 05:43:36 -0500
Message-ID: <20070115104336.GD12257@spearce.org>
References: <200701151000.58609.andyparkins@gmail.com> <20070115101529.GB12257@spearce.org> <Pine.LNX.4.63.0701151126540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 18:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vi4-0006dA-OS
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:28 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9d-0003eK-U6
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbXAOKnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbXAOKnl
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:43:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47335 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206AbXAOKnk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:43:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6PJP-0005Ql-6y; Mon, 15 Jan 2007 05:43:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A11C920FBAE; Mon, 15 Jan 2007 05:43:36 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701151126540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36807>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 15 Jan 2007, Shawn O. Pearce wrote:
> > A commit-msg hook could probably implement the signing.
> 
> But it would only sign the _message_. You would have to sign the whole 
> _raw_ commit message, to include also the ancestry. But there is no hook 
> _between_ constructing that _raw_ commit message and actually writing the 
> commit object (this would have to be in builtin-commit-tree.c:151).

Sorry, I was assuming people knew what was in the grey matter
upstairs.  :-)

I meant to say something along the lines of:

  A commit-msg hook could probably implement the signing.  However
  doing that would require generating the raw commit data using the
  current timestamp, and that would require having git-commit.sh set
  the timestamp into GIT_COMMITTER_DATE and GIT_AUTHOR_DATE before
  it runs the hook, or before git-commit-tree.  Clearly an ugly mess.

Johannes is right.  A proper signing would probably need to be done
in commit-tree itself.  Or commit-tree would need to be invoked to
create a dummy commit, fetch it back out with cat-file, sign that,
then regenerate the commit with the same prior timestamps.  Ugly.

But I don't really see a need for commit signing in Git.  The best
way to shuttle commits around in Git-space is through published
repositories.  You probably want to grab whatever is on that
repository, and you either trust the repository owner or you don't.
If you don't trust the owner, but you trust the pusher, than using
1 annotated tag per push is reasonable and gives you something
to verify the repository owner isn't playing games.  If you don't
trust the pusher than you should be reviewing the changes before
deciding to keep them in your project.

But even then annotated tags are overkill.  You could just
receive the commit SHA1 out-of-band from the pusher (e.g. email,
like Junio's hidden X-master-at header) and verify that by hand.
8 digits is probably more than enough to hand-verify the entire
commit chain you are receiving.

-- 
Shawn.
