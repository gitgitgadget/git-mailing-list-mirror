From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] bash: Support git-rebase -m continuation completion.
Date: Sun, 4 Feb 2007 23:52:02 -0500
Message-ID: <20070205045202.GA13398@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 05:52:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDvpr-0007a5-Pi
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 05:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbXBEEwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 23:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbXBEEwH
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 23:52:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60773 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbXBEEwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 23:52:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDvpY-0002az-La; Sun, 04 Feb 2007 23:51:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 627C020FBAE; Sun,  4 Feb 2007 23:52:03 -0500 (EST)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38725>

Apparently `git-rebase -m` uses a metadata directory within .git
(.git/.dotest-merge) rather than .dotest used by git-am (and
git-rebase without the -m option).  This caused the completion code
to not offer --continue, --skip or --abort when working within a
`git-rebase -m` session.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 466cc32..5f9a34b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -627,7 +627,7 @@ _git_push ()
 _git_rebase ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	if [ -d .dotest ]; then
+	if [ -d .dotest ] || [ -d .git/.dotest-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
-- 
1.5.0.rc3.39.gec804
