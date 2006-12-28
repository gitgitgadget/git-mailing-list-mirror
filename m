From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/11] Ensure `git-pull` fails if `git-merge` fails.
Date: Thu, 28 Dec 2006 02:35:01 -0500
Message-ID: <20061228073501.GD17867@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzpnH-0000v9-5t
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWL1HfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWL1HfI
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:35:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45808 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964968AbWL1HfG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:35:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzpme-0007wK-Gw; Thu, 28 Dec 2006 02:34:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D4ADB20FB65; Thu, 28 Dec 2006 02:35:01 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35526>

If git-merge exits with a non-zero exit status so should git-pull.
This way the caller of git-pull knows the task did not complete
successfully simply by checking the process exit status.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index fd4ffb8..2725946 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -119,5 +119,5 @@ case "$strategy_args" in
 esac
 
 merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
-git-merge $no_summary $no_commit $squash $strategy_args \
+exec git-merge $no_summary $no_commit $squash $strategy_args \
 	"$merge_name" HEAD $merge_head
-- 
1.4.4.3.gd2e4
