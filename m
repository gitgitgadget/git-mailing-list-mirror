Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C6EC55191
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353B320857
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 02:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDYCUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 22:20:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:47707 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgDYCUx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 22:20:53 -0400
IronPort-SDR: hMuJH0UCOLml9ZVhlPvXSmUtUQK1VwdRp83+A+fAQo6IQk5WiXsJXz0VSThVlXWiiRAGQl5gvS
 APUodEbUuZjg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 19:20:52 -0700
IronPort-SDR: /FzbEKvcbnzFO0sWcLc1bHzMxWvFg5X+u0grwwzq/uoNY0EW41S5f/Nz+vGCzILvmiPOzJKDIP
 UhoNxnx6p55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,314,1583222400"; 
   d="scan'208";a="281056776"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2020 19:20:52 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 01/11] completion: add some simple test cases for git switch completion
Date:   Fri, 24 Apr 2020 19:20:34 -0700
Message-Id: <20200425022045.1089291-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200425022045.1089291-1-jacob.e.keller@intel.com>
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Future work is going to refactor the completion support for git switch,
so add some new test cases in order to help prevent regressions.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9902-completion.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5505e5aa249e..03e8188f023d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1240,6 +1240,31 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	test_cmp expected out
 '
 
+test_expect_success 'git switch - with --no-guess, complete only local branches' '
+	test_completion "git switch --no-guess " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
+test_expect_success 'git switch - with --detach, complete all references' '
+	test_completion "git switch --detach " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git switch - with --no-track, complete only local branch names' '
+	test_completion "git switch --no-track " <<-\EOF
+	master Z
+	matching-branch Z
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.25.2

