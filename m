From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/2] stash: Don't overwrite files that have gone from the index
Date: Sat, 10 Apr 2010 19:14:01 +0100
Message-ID: <1270923241-14383-2-git-send-email-charles@hashpling.org>
References: <v2w918f64e01004101104xd4f1b4eciec01d2e87691ee72@mail.gmail.com>
Cc: Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org, khellls@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 10 20:24:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fMR-0007O3-Rl
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab0DJSYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:24:31 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:52079 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752091Ab0DJSY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 14:24:27 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2010 14:24:26 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAD9dwEvUnw4T/2dsb2JhbACbRnG5ZoUMBA
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.pcl-ipout02.plus.net with ESMTP; 10 Apr 2010 19:14:33 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1O0fCT-0002S9-1D; Sat, 10 Apr 2010 19:14:33 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O0fCS-0003mY-FQ; Sat, 10 Apr 2010 19:14:32 +0100
X-Mailer: git-send-email 1.7.1.rc0.266.gf3d756
In-Reply-To: <v2w918f64e01004101104xd4f1b4eciec01d2e87691ee72@mail.gmail.com>
X-Plusnet-Relay: a41b6b7cef53b410e813a27583e21624
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144571>

---

This patch is deliberately not signed off. It feels kludgy and uses a
non-portable xargs invocation.

It is designed as a starting point for discussion, that is all.

 git-stash.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 908aab2..9efc544 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -87,6 +87,8 @@ create_stash () {
 			export GIT_INDEX_FILE &&
 			git read-tree -m $i_tree &&
 			git add -u &&
+			{ git diff --quiet --diff-filter=D --cached ||
+				git diff -z --name-only --diff-filter=D --cached | xargs -0 git add --ignore-errors; } &&
 			git write-tree &&
 			rm -f "$TMP-index"
 		) ) ||
-- 
1.7.1.rc0.266.gf3d756
