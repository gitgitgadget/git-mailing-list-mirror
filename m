Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDCCC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AC061159
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbhITXiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhITXgx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:36:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD686C0EFE40
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d21so31976262wra.12
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Lk/tCvJ2GLavDDUgLiOQCJkKvagb00pcWxmfnFgwgQ=;
        b=lv0NqZqGYk0FN07uPhaqY5UtMMdiYPDZaE88Ci7WIyOdij/DPbLpglVHzOLAcWB9Wt
         0qhWMVeD7CvNVMySiCEpN4Sg9gYAz33Gp9WeQKJEUi4jl0dNV3bjryFy6W29p3ZSjtBL
         AYqlyhNbT7B0wplDL2a/UOemMqmG05wFWvEEf5eF99brCucu6nF2f46RCgpZWQCDUmOj
         LmuTxvt44sbBgxmAtAhdU8UxnuhbcPEkaUdbJ1o8EEkSozhHgsWnOMdKPcaqtfwJLfwX
         ccfeKF6XGdE3u30YkuWzg4gT53Ra7clQxpNsGAOGJ29ydLX4XLwoW03Gz8bAC2UiYAtv
         F56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Lk/tCvJ2GLavDDUgLiOQCJkKvagb00pcWxmfnFgwgQ=;
        b=hcARsqggZwFIDs4LAROsePTQlEMxvV0SJu2xOamBMqmWLjR9dE88kSYQIgZv+dZNrk
         sTwxPRhIZlSl4wXSpeqFIOdSjgpyw+arXkbLQZQT15EDjKTcC6gKnvRXsC5eLNEWKzon
         rXq/5J1kp29zzjXO7I1QhUVSV8vCytQSspJisX01wkmBqvQAdAU165XHHmvN5BXKUlzg
         f7lmSv4aZEG9zf51MmkAev6rFtAzgk/cRWSQ/IRl2+Bt8ZaGRySXTzEUsneRDE3kmGha
         6gMTj7rK2dXbTwYgMXKTHvllm0kS4z/cIgHWGu1w9g21jHWd1iXJGDUFrNmq+KJ1dxrO
         KQ3w==
X-Gm-Message-State: AOAM533xnv7d44+qiNK7OppYaXH10znVUy23eq1MZlvFbYAicRJMEXtQ
        oTNvUvYlq5Vvs6UmIiXBZrrt97O/jWE=
X-Google-Smtp-Source: ABdhPJwAaQXx+/yXuEnwg/osdUFeGt85q0csvAVmO3KAZfFzGNKjpyjijWHi/ELlNc71WaKu+KpcgQ==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr258990wmc.19.1632159945530;
        Mon, 20 Sep 2021 10:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm196460wmp.26.2021.09.20.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:45 -0700 (PDT)
Message-Id: <131beda1bc32d61b1063a51210048feb26755bb2.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:33 +0000
Subject: [PATCH v3 10/14] add: update --renormalize to skip sparse paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We added checks for path_in_sparse_checkout() to portions of 'git add'
that add warnings and prevent stagins a modification, but we skipped the
--renormalize mode. Update renormalize_tracked_files() to ignore cache
entries whose path is outside of the sparse-checkout cone (unless
--sparse is provided). Add a test in t3705.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                  |  4 +++-
 t/t3705-add-sparse-checkout.sh | 12 +++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f87b8134b67..f8f0dfa4046 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -154,7 +154,9 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
-		if (ce_skip_worktree(ce))
+		if (!include_sparse &&
+		    (ce_skip_worktree(ce) ||
+		     !path_in_sparse_checkout(ce->name, &the_index)))
 			continue;
 		if (ce_stage(ce))
 			continue; /* do not touch unmerged paths */
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 9347705ad1c..10969efc23e 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -172,6 +172,9 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	test_must_fail git add --chmod=+x sparse_entry &&
 	test_sparse_entry_unstaged &&
 
+	test_must_fail git add --renormalize sparse_entry &&
+	test_sparse_entry_unstaged &&
+
 	# Avoid munging CRLFs to avoid an error message
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
@@ -181,7 +184,14 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	git add --sparse --chmod=+x sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	test-tool read-cache --table >actual &&
-	grep "^100755 blob.*sparse_entry\$" actual
+	grep "^100755 blob.*sparse_entry\$" actual &&
+
+	git reset &&
+
+	# This will print a message over stderr on Windows.
+	git add --sparse --renormalize sparse_entry &&
+	git status --porcelain >actual &&
+	grep "^M  sparse_entry\$" actual
 '
 
 test_expect_success 'add obeys advice.updateSparsePath' '
-- 
gitgitgadget

