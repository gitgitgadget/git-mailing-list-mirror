From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/11] Honor GIT_REFLOG_ACTION in git-rebase.
Date: Thu, 28 Dec 2006 02:34:52 -0500
Message-ID: <20061228073452.GB17867@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzpn2-0000sg-5e
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWL1He4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWL1He4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:34:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45796 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964975AbWL1Hez (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:34:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzpmU-0007vu-TU; Thu, 28 Dec 2006 02:34:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 44EA820FB65; Thu, 28 Dec 2006 02:34:52 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35522>

To help correctly log actions caused by porcelain which invoke
git-reset directly we should honor the setting of GIT_REFLOG_ACTION
which we inherited from our caller.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-reset.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index 2379db0..a969370 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -5,6 +5,7 @@
 USAGE='[--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
+set_reflog_action "reset $*"
 
 update= reset_type=--mixed
 unset rev
@@ -81,7 +82,7 @@ then
 else
 	rm -f "$GIT_DIR/ORIG_HEAD"
 fi
-git-update-ref -m "reset $reset_type $*" HEAD "$rev"
+git-update-ref -m "$GIT_REFLOG_ACTION" HEAD "$rev"
 update_ref_status=$?
 
 case "$reset_type" in
-- 
1.4.4.3.gd2e4
