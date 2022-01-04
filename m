Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E4C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiADRhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiADRhG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:37:06 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71EAC061784
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:37:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q16so77677534wrg.7
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nYf5xAjH38pG53d5lWxnBkNiDBQQR8OOEeDq2g67RQA=;
        b=kaJRpEvOiJgLTRcVdOXZHwTbiveIulEF46Y/5cDX5nTbmVpxD9kKLYErp+Ly1XEmBk
         vCIS/DpSjMPtPlNTzqWNkllAnu/4iOUCPHGDLQhgl+eTIXhly23rtTSUkggeBd6Ff03p
         z4cekQHln9Ghc1H03CGO+QK8ugqj6DdbpQ6BKw2ilG68zfBac6lHucl2ZkEMZ+tmdr7q
         BW/GBHrgc+rq5KcWzMVZZLhS0pXxddUTUDr6n0uRYbbtQylAH1ZzMdP1aa5wN//cTgYM
         wHDAIYb5m0IUhSQConPoxaYxH+iiLVfjHy18RcEZ6kFVWFVKVroyhfDNuPNmp6/L5CWy
         9sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nYf5xAjH38pG53d5lWxnBkNiDBQQR8OOEeDq2g67RQA=;
        b=RtFbQaxQwA9uVFasqi2kepsVXFshdD7r5dQvtpGgzWX6HipYOpszpbR8u8v/zkKm7A
         3H39Hv90H7KEBksv0biis8db/kOoMItUaqNsCBBOaMfpLfiihJ12ef8iAzZzdSQ8qItv
         K0luFIar31o0Z1PsEYx8jGk4OIAqMwEqIN1brVPHn7bj61M5KhyGigofAhQilpdj/g9R
         oErc9lsy+/E7dN+RLt/Q0VibJSdzSGeH7vB02tDbBjqExAMDFne5uyX4pf/O7L8Bk1WF
         Tq2lplMpXIIA2KGaulxLGiqGXXOPmBAyPXOKw7TMMn+8iGgnqx1z/oNR+gm0sY9z4yPZ
         qyZA==
X-Gm-Message-State: AOAM5323fPXesUQMqysFq5yHWgPwjamXCG6XaSR/40GouWpTBJpjezlI
        3v0jxN//xv7jbN7A2To8entHQN6MNFw=
X-Google-Smtp-Source: ABdhPJyx5BC7f0gw0ce/l4vw0X7xOEPxOdMSn6HYWJDwpLDuI7nKbOcUyWo5XCB9vvSVhTuEH7DO0w==
X-Received: by 2002:a5d:456a:: with SMTP id a10mr44302515wrc.670.1641317824155;
        Tue, 04 Jan 2022 09:37:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm39957790wrn.111.2022.01.04.09.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:37:03 -0800 (PST)
Message-Id: <52aec13d18e339024e350733ee9d0b5c6b9008e6.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:36:54 +0000
Subject: [PATCH 3/9] clean: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Remove full index requirement for `git clean` and test to ensure the index
is not expanded in `git clean`. Add to existing test for `git clean` to
verify cleanup of untracked files in sparse directories is consistent
between sparse index and non-sparse index checkouts.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/clean.c                          |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 98a2860409b..5628fc7103e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -983,6 +983,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		dir.flags |= DIR_KEEP_UNTRACKED_CONTENTS;
 	}
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d5167e7ed69..05587361452 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -764,23 +764,42 @@ test_expect_success 'clean' '
 	test_all_match git commit -m "ignore bogus files" &&
 
 	run_on_sparse mkdir folder1 &&
+	run_on_all mkdir -p deep/untracked-deep &&
 	run_on_all touch folder1/bogus &&
+	run_on_all touch folder1/untracked &&
+	run_on_all touch deep/untracked-deep/bogus &&
+	run_on_all touch deep/untracked-deep/untracked &&
 
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git clean -f &&
 	test_all_match git status --porcelain=v2 &&
 	test_sparse_match ls &&
 	test_sparse_match ls folder1 &&
+	run_on_all test_path_exists folder1/bogus &&
+	run_on_all test_path_is_missing folder1/untracked &&
+	run_on_all test_path_exists deep/untracked-deep/bogus &&
+	run_on_all test_path_exists deep/untracked-deep/untracked &&
+
+	test_all_match git clean -fd &&
+	test_all_match git status --porcelain=v2 &&
+	test_sparse_match ls &&
+	test_sparse_match ls folder1 &&
+	run_on_all test_path_exists folder1/bogus &&
+	run_on_all test_path_exists deep/untracked-deep/bogus &&
+	run_on_all test_path_is_missing deep/untracked-deep/untracked &&
 
 	test_all_match git clean -xf &&
 	test_all_match git status --porcelain=v2 &&
 	test_sparse_match ls &&
 	test_sparse_match ls folder1 &&
+	run_on_all test_path_is_missing folder1/bogus &&
+	run_on_all test_path_exists deep/untracked-deep/bogus &&
 
 	test_all_match git clean -xdf &&
 	test_all_match git status --porcelain=v2 &&
 	test_sparse_match ls &&
 	test_sparse_match ls folder1 &&
+	run_on_all test_path_is_missing deep/untracked-deep/bogus &&
 
 	test_sparse_match test_path_is_dir folder1
 '
@@ -920,6 +939,8 @@ test_expect_success 'sparse-index is not expanded' '
 	# Wildcard identifies only full sparse directories, no index expansion
 	ensure_not_expanded reset deepest -- folder\* &&
 
+	ensure_not_expanded clean -fd &&
+
 	ensure_not_expanded checkout -f update-deep &&
 	test_config -C sparse-index pull.twohead ort &&
 	(
-- 
gitgitgadget

