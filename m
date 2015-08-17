From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v9 4/6] notes: add tests for --commit/--abort/--strategy exclusivity
Date: Mon, 17 Aug 2015 14:33:32 -0700
Message-ID: <1439847214-2980-5-git-send-email-jacob.e.keller@intel.com>
References: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 23:33:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRS2W-0003aM-NX
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 23:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbbHQVdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 17:33:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:43514 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbbHQVdh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 17:33:37 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,697,1432623600"; 
   d="scan'208";a="785910990"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 14:33:36 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276096>

From: Jacob Keller <jacob.keller@gmail.com>

Add new tests to ensure that --commit, --abort, and --strategy are
mutually exclusive.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t3310-notes-merge-manual-resolve.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 195bb97f859d..d5572121da69 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -314,6 +314,18 @@ y and z notes on 1st commit
 
 EOF
 
+test_expect_success 'do not allow mixing --commit and --abort' '
+	test_must_fail git notes merge --commit --abort
+'
+
+test_expect_success 'do not allow mixing --commit and --strategy' '
+	test_must_fail git notes merge --commit --strategy theirs
+'
+
+test_expect_success 'do not allow mixing --abort and --strategy' '
+	test_must_fail git notes merge --abort --strategy theirs
+'
+
 test_expect_success 'finalize conflicting merge (z => m)' '
 	# Resolve conflicts and finalize merge
 	cat >.git/NOTES_MERGE_WORKTREE/$commit_sha1 <<EOF &&
-- 
2.5.0.280.g4aaba03
