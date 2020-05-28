Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A387FC433E2
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA36207F5
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405742AbgE1SLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:11:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:20269 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405706AbgE1SLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:11:15 -0400
IronPort-SDR: omnyKFSyFmBmEYQHL3nKD8FcEmdBfylrfd4vAWK4K4UTxlwHTilm8Xk/KYu7d6lKn8gtg9MNZC
 6aIVdJ7F+ytA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:10:51 -0700
IronPort-SDR: rC+QrZiEhfSZhWMApwOPBzHqhHcfnb6fbL/+6Gl4u77NLN2jTDlWFceygYI/b0nZNBGXmAHMm2
 Trkelzunww/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267301349"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 11:10:50 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 05/16] completion: add tests showing subpar -c/-C startpoint completion
Date:   Thu, 28 May 2020 11:10:37 -0700
Message-Id: <20200528181048.3509470-6-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200528181048.3509470-1-jacob.e.keller@intel.com>
References: <20200528181048.3509470-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

When using the branch creation argument for git switch or git checkout,
-c/-C or -b/-B, the commands operate in a different mode: `git switch -c
<branch> <some-reference>` means to create a branch named <branch> at
the commit referred to by <some-reference>.

When completing the start-point, we ought to always complete all valid
references.

Add tests for the completion of the start-point to -c/-C and -b/-B.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9902-completion.sh | 140 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8a3995f82f38..609981244e9b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1448,6 +1448,146 @@ test_expect_success 'git checkout - with --no-track, complete only local referen
 	EOF
 '
 
+#TODO: completing the start point of -c/-C should not include DWIM references
+test_expect_failure 'git switch - with -c, complete all references' '
+	test_completion "git switch -c new-branch " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: completing the start point of -c/-C should not include DWIM references
+test_expect_failure 'git switch - with -C, complete all references' '
+	test_completion "git switch -C new-branch " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: completing the start point of -c/-C should include all references, not just local branches
+test_expect_failure 'git switch - with -c and --track, complete all references' '
+	test_completion "git switch -c new-branch --track " <<-EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: completing the start point of -c/-C should include all references, not just local branches
+test_expect_failure 'git switch - with -C and --track, complete all references' '
+	test_completion "git switch -C new-branch --track " <<-EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: completing the start point of -c/-C should include all references, not just local branches
+test_expect_failure 'git switch - with -c and --no-track, complete all references' '
+	test_completion "git switch -c new-branch --no-track " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: completing the start point of -c/-C should include all references, not just local branches
+test_expect_failure 'git switch - with -C and --no-track, complete all references' '
+	test_completion "git switch -C new-branch --no-track " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: completing the start point of -b/-B should not include DWIM references
+test_expect_failure 'git checkout - with -b, complete all references' '
+	test_completion "git checkout -b new-branch " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+#TODO: completing the start point of -b/-B should not include DWIM references
+test_expect_failure 'git checkout - with -B, complete all references' '
+	test_completion "git checkout -B new-branch " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -b and --track, complete all references' '
+	test_completion "git checkout -b new-branch --track " <<-EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -B and --track, complete all references' '
+	test_completion "git checkout -B new-branch --track " <<-EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -b and --no-track, complete all references' '
+	test_completion "git checkout -b new-branch --no-track " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with -B and --no-track, complete all references' '
+	test_completion "git checkout -B new-branch --no-track " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.25.2

