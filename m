Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F42C43460
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8850D613B1
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbhDMOCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbhDMOCG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A736C06138E
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p6so9871880wrn.9
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WvaZ3YS8coAgjJkm1yddD68D6kGxSzaGXo2N92oNDOY=;
        b=AtYenlkFZ64WD6VI9zw6lN7KlF6Fy1V02qLbEGdjejqywQCxrnrstt+2owJlfZ+PiB
         fpOBqDFDrLunFFxGAttoYgHt0LVkuwXuY3JIhNOo3ffwnPmI8MWsRd6zZboKwu8oKwfS
         cdQ+eNEXABhS2d1Qj1ZeABqstnSDUvkHLbg2+gXEhlUJao5sGCtI5n7tSuwcdX+j2WCQ
         hTvs8WU2T7pDmNuxQZkrd4Dj+5BzmDgz1EaUk5QVjqATcWNmGSnFZ1b4m1P8Wjg8IJlz
         AjMhKv1VkT4qVxDWE3X+rqE5WPayNClWyfCU7G13eAHf9j7t4FesDJc8xqALUbxg9leq
         eE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WvaZ3YS8coAgjJkm1yddD68D6kGxSzaGXo2N92oNDOY=;
        b=hPWViBzxJF1fkXS7+PHgGfwEQbgzQk2ubc8qXHAzQQT4sWH0FjXvpCa7RTIIFMRRoW
         +SJQVpN0e/R/qFof86O2j+DgVI/wbnWLbcfvC1Co/q9OLqO09ecxokciyUwDxjFhD2he
         U2ZaWHnkvPRZr7eSNyFQa5bgBPZZuU0qcq289ahCZCcYS+P3RVKjhi/dChHd8A6i2qVy
         /woi2IYf0vW2J6gfbxddm7lGXx5Zi6z1an1CLUPrLEOm+qnWGDTq0242nI76W9KX7Quv
         JJCMeEn2wWZPa87RFaqPOOiRvGOKNzJWHlNYdTBQYunUQUBC7XzNAXJDza2PSTdAjF0+
         /y8Q==
X-Gm-Message-State: AOAM532y2oqSIw+Y9g4t6ajymSZhO88Ap4RQ4Wl8u8jI0xKsYiAFi8XU
        aWrDF+ExzaRqA3zfH3xk10y69wXelhc=
X-Google-Smtp-Source: ABdhPJxoqu9REEFmafm5nIHUXz0TW6ApF6i245TF6ypsztT6qLzyDJ//gb1zkSlNfh6kqil6Oc1pMQ==
X-Received: by 2002:adf:fa07:: with SMTP id m7mr34492488wrr.42.1618322504076;
        Tue, 13 Apr 2021 07:01:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y31sm2686739wmp.46.2021.04.13.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:43 -0700 (PDT)
Message-Id: <f1a9ce4ef0e56a9be7adbdd81b4eeb6404906eb3.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:34 +0000
Subject: [PATCH 07/10] add: allow operating on a sparse-only index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Disable command_requires_full_index for 'git add'. This does not require
any additional removals of ensure_full_index(). The main reason is that
'git add' discovers changes based on the pathspec and the worktree
itself. These are then inserted into the index directly, and calls to
index_name_pos() or index_file_exists() already call expand_to_path() at
the appropriate time to support a sparse-index.

Add a test to check that 'git add -A' and 'git add <file>' does not
expand the index at all, as long as <file> is not within a sparse
directory. This does not help the global 'git add .' case.

We can measure the improvement using p2000-sparse-operations.sh with
these results:

Test                                  HEAD~1           HEAD
------------------------------------------------------------------------------
2000.6: git add -A (full-index-v3)    1.35(1.00+0.20)  1.33(0.98+0.19) -1.5%
2000.7: git add -A (full-index-v4)    1.25(0.97+0.17)  1.23(0.96+0.16) -1.6%
2000.8: git add -A (sparse-index-v3)  2.38(2.28+0.13)  0.06(0.04+0.08) -97.5%
2000.9: git add -A (sparse-index-v4)  2.39(2.25+0.18)  0.06(0.04+0.07) -97.5%

While the 97% improvement seems impressive, it's important to recognize
that previously we had significant overhead for expanding the
sparse-index. Comparing to the full index case, 'git add -A' goes from
1.33s to 0.06s, which is "only" a 95% improvement.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                            |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 58ee3f954ef7..0572d0344065 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -526,6 +526,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
 	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	/*
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index b937d7096afd..c210dba78067 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -459,6 +459,18 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/untracked.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index status &&
+	test_region ! index ensure_full_index trace2.txt &&
+
+	rm trace2.txt &&
+	echo >>sparse-index/README.md &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index add -A &&
+	test_region ! index ensure_full_index trace2.txt &&
+
+	rm trace2.txt &&
+	echo >>sparse-index/extra.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index add extra.txt &&
 	test_region ! index ensure_full_index trace2.txt
 '
 
-- 
gitgitgadget

