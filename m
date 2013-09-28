From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] rebase -i: respect to core.abbrev
Date: Sat, 28 Sep 2013 19:07:15 +0300
Message-ID: <1380384435-20846-1-git-send-email-kirill.shutemov@linux.intel.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 18:07:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPx3O-0007ea-EV
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 18:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab3I1QHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 12:07:24 -0400
Received: from mga03.intel.com ([143.182.124.21]:26606 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab3I1QHW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 12:07:22 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 28 Sep 2013 09:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1000,1371106800"; 
   d="scan'208";a="366893540"
Received: from blue.fi.intel.com ([10.237.72.156])
  by azsmga001.ch.intel.com with ESMTP; 28 Sep 2013 09:07:20 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
	id 589CCE0090; Sat, 28 Sep 2013 19:07:19 +0300 (EEST)
X-Mailer: git-send-email 1.8.4.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235504>

git rebase -i collapses ids on todo list to 7 hexdigits.
Let's use core.abbrev config option instead, if it's set.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 git-rebase--interactive.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 10bf318d0d..078c28ff1b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -713,7 +713,8 @@ expand_todo_ids() {
 }
 
 collapse_todo_ids() {
-	transform_todo_ids --short=7
+	abbrev="$(git config --get 'core.abbrev')"
+	transform_todo_ids --short="${abbrev:-7}"
 }
 
 # Rearrange the todo list that has both "pick sha1 msg" and
-- 
1.8.4.rc3
