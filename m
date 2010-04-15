From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/2] (resend) stash: Don't overwrite files that have gone from the index
Date: Thu, 15 Apr 2010 01:24:22 +0100
Message-ID: <1271291062-32154-2-git-send-email-charles@hashpling.org>
References: <1271291062-32154-1-git-send-email-charles@hashpling.org>
Cc: Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 02:24:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Ct0-0003aL-AG
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 02:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521Ab0DOAYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 20:24:42 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:57420 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755426Ab0DOAYl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 20:24:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAPf5xUvUnw4U/2dsb2JhbACbW3G9cYUNBA
Received: from pih-relay08.plus.net ([212.159.14.20])
  by relay.pcl-ipout02.plus.net with ESMTP; 15 Apr 2010 01:24:40 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1O2Csq-0004Qs-9q; Thu, 15 Apr 2010 01:24:40 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O2Csp-0008OK-O9; Thu, 15 Apr 2010 01:24:39 +0100
X-Mailer: git-send-email 1.7.1.rc1.241.g4e72f
In-Reply-To: <1271291062-32154-1-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: 35fc0a7d3ae5ce9dfff2242c8ef7c129
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144930>

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
1.7.1.rc1.241.g4e72f
