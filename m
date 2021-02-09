Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BCEC43381
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911B064E40
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhBIW6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbhBIWWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:22:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DB3C03C045
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:16 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i9so79039wmq.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=63NYMlpFB88hApbscTOoL2kMlxFQErJFXFDT05KQW4s=;
        b=JjkDi76MSO2tUzZrpGSZelS5heiL4wKh7pS5efy3xxNcJDuUvSO3ZYN0a5JNNgBfFQ
         9Fq2bg0zUDTL/OZDHsmQvpA8WWLjlpj9lVO+Zk6PekuYvNl5yH66JJfKrxJgjXQ/aDKd
         CcyFdSG7gFuMimESV3aWwX0Wppogb631KwdqjEvSZ/e7HBnWBeSWx4/hvNzRm8BmfAYd
         KYx/LzvpJnhztywFHhXRggCOL9AYj73zBbTpSyI2Ptx2NRVG8IX9aK93Vf7U/dg0KTmc
         3ltz1joPqgcjmGp3s1tnNoqUiXDnC7JYtHUJNp5jLMbqKBChNvNr21H35xWHKQfT28M+
         kJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63NYMlpFB88hApbscTOoL2kMlxFQErJFXFDT05KQW4s=;
        b=GLJXWjqlOMV4SrqbbEL69OKav/p6h2M9ULhs2PMiN0dPy3L5qDtXq53E2Mx8h26f+c
         BePu2R0LAE+1ZsFF9sRMxT8KCR8uQEyPHmD1dVpwJkeLrEGE/cBY2vAIkltbTGFVbgsI
         Dqj0toM4yw/RUXAUqmhYtsQ2rnn7FBwEklGZ8HW9mnvf9i//1cLXkZt6kFtExCGfxI5a
         VtFpAWRUgGjsK2BrDlEZOTuLq6uqE9i4vjEykJILGLXIscJ4oYQlYiySEnGE6fhwUC+y
         JrOH8JgwyyEd00FDVvyuSaGCem44mnW843DDkgtyNVMUbe/tqMRe3Ffl/O0MV4fZFor3
         oa+A==
X-Gm-Message-State: AOAM530asVsiiqaJzleJStBcxjByT/tlyLSHyGWARR2xDd47xn0QNdNk
        /zg9F1q3F/aKFNkFMpCnWy2SvozLbaD7xg==
X-Google-Smtp-Source: ABdhPJytrGJCTmtKIft6g9f4fpWO38kY2EFLUO9qp6BH+bw9iwVPjneDgTdsW3UdoctgniTZqtJzlg==
X-Received: by 2002:a1c:67c4:: with SMTP id b187mr104585wmc.17.1612906935268;
        Tue, 09 Feb 2021 13:42:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/12] test-lib-functions: move test_set_index_version() to its user
Date:   Tue,  9 Feb 2021 22:41:50 +0100
Message-Id: <20210209214159.22815-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the test_set_index_version() function to its only user. This
function has only been used in one place since its addition in
5d9fc888b48 (test-lib: allow setting the index format version,
2014-02-23). Let's have that test script define it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2104-update-index-skip-worktree.sh | 5 +++++
 t/test-lib-functions.sh               | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 7e2e7dd4ae5..30666fc70d2 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -9,6 +9,11 @@ test_description='skip-worktree bit test'
 
 sane_unset GIT_TEST_SPLIT_INDEX
 
+test_set_index_version () {
+    GIT_INDEX_VERSION="$1"
+    export GIT_INDEX_VERSION
+}
+
 test_set_index_version 3
 
 cat >expect.full <<EOF
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0d40f8a598e..728bdf94684 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -32,11 +32,6 @@ test_set_editor () {
 	export EDITOR
 }
 
-test_set_index_version () {
-    GIT_INDEX_VERSION="$1"
-    export GIT_INDEX_VERSION
-}
-
 test_decode_color () {
 	awk '
 		function name(n) {
-- 
2.30.0.284.gd98b1dd5eaa7

