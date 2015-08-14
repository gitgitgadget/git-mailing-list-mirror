From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v7 2/4] notes: add tests for --commit/--abort/--strategy exclusivity
Date: Fri, 14 Aug 2015 14:13:53 -0700
Message-ID: <1439586835-15712-3-git-send-email-jacob.e.keller@intel.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 23:14:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQMJ5-00065D-8t
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbbHNVOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:14:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:13370 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbbHNVOS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:14:18 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 14 Aug 2015 14:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,680,1432623600"; 
   d="scan'208";a="784359583"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2015 14:13:57 -0700
X-Mailer: git-send-email 2.5.0.280.g4aaba03
In-Reply-To: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275960>

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
