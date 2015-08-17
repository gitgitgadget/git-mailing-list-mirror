From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v9 2/6] notes: extract enum notes_merge_strategy to notes-utils.h
Date: Mon, 17 Aug 2015 14:33:30 -0700
Message-ID: <1439847214-2980-3-git-send-email-jacob.e.keller@intel.com>
References: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 23:33:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRS2J-0003SX-Hu
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 23:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbbHQVdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 17:33:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:12036 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960AbbHQVdh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 17:33:37 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,697,1432623600"; 
   d="scan'208";a="785910988"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276092>

From: Jacob Keller <jacob.keller@gmail.com>

A future patch will extract parsing of the --strategy string into a
helper function in notes.c and will require the enumeration definition.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 notes-merge.h | 10 +++-------
 notes-utils.h |  8 ++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/notes-merge.h b/notes-merge.h
index 1d01f6aacf54..0d890563b5f4 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -1,6 +1,8 @@
 #ifndef NOTES_MERGE_H
 #define NOTES_MERGE_H
 
+#include "notes-utils.h"
+
 #define NOTES_MERGE_WORKTREE "NOTES_MERGE_WORKTREE"
 
 enum notes_merge_verbosity {
@@ -13,13 +15,7 @@ struct notes_merge_options {
 	const char *remote_ref;
 	struct strbuf commit_msg;
 	int verbosity;
-	enum {
-		NOTES_MERGE_RESOLVE_MANUAL = 0,
-		NOTES_MERGE_RESOLVE_OURS,
-		NOTES_MERGE_RESOLVE_THEIRS,
-		NOTES_MERGE_RESOLVE_UNION,
-		NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ
-	} strategy;
+	enum notes_merge_strategy strategy;
 	unsigned has_worktree:1;
 };
 
diff --git a/notes-utils.h b/notes-utils.h
index 890ddb33e13a..db5811e3f718 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -19,6 +19,14 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 
 void commit_notes(struct notes_tree *t, const char *msg);
 
+enum notes_merge_strategy {
+		NOTES_MERGE_RESOLVE_MANUAL = 0,
+		NOTES_MERGE_RESOLVE_OURS,
+		NOTES_MERGE_RESOLVE_THEIRS,
+		NOTES_MERGE_RESOLVE_UNION,
+		NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ
+};
+
 struct notes_rewrite_cfg {
 	struct notes_tree **trees;
 	const char *cmd;
-- 
2.5.0.280.g4aaba03
