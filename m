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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54671C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365AF6128B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbhGNNPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbhGNNPs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337C5C061766
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d2so3242876wrn.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+zCswDbBE6VAPxz4AwOZEa5RZC32g05Cgk4luWVMlJQ=;
        b=c9Fo3XtTXi9lORPNrmVzhgMBXFBevSOn5r1mIT1eNGrGiqtGPS6iu/dPxK9KzzVj5Q
         eTZ2ADK+c3bBVZ5eKRT69Ib4UxSyq9qdwXBnYiYHqam+M1sXDltaPH/JEsVWj5KDrOOG
         QjiNrxhxJAe0EfZeIPEOmV4hy26nWRek0TloUpIkPeIIgY2O/vbmBMBeiLOlCUzKPqjE
         mckpBRCWT3BpcSAl+QbF2o4HNh5kdoatJy5ZXucSEC7wxeB/g89kUlbMQ9sU9mRLMlru
         3TNOxG+vXR1h4SCCDLFu0f5LwA6Uww0noiZ1jCiGUvkfdogrcuWjucrNk9ZX4Dj3jyYS
         RZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+zCswDbBE6VAPxz4AwOZEa5RZC32g05Cgk4luWVMlJQ=;
        b=I0+z9Y76nSfo5ditqDUIN4kIXzs2Qz8Kdqf+/wcqTRVGxD0uQ2iLQf1XmPTvtmfkfV
         dwjATDeUw/TPeSXcxH7q5GQ1TngSwq/LOU20J0nSg8M3KTMSTVDaBvqMfUiB7ITLP0rE
         BpYUu9E3M7M6Y+PoyYIDV9flxIvWX0tbigipYr1aW9URGjS1vxwxNflK7n1ZHA7A79PU
         Xhl/QIyqtEaazLaWDZ0GijCkA5ktP3dOJr2Rcq20F4GiyHtFDGlOUaK1BLPjzQWdgnd4
         7W+fLeugYawAy3JlDoYFnn/S5mN6jEJZlevwWFMNcZ+pkMre77iy3Sqz1FQv7QKak9P1
         7O1g==
X-Gm-Message-State: AOAM533z3QRDRxaptKNUk+6QKG2NgNl4TK4gihRHwPmKorLwLMgTPJvI
        woxUZ80rMBlXo1zken/5PBnplczaUIM=
X-Google-Smtp-Source: ABdhPJwzJvqwfuXVlLfBawhTPjS+9bXwuxqOS1HR9rfDns/B84y+zPG3O6WDfhFjV1xG5h2VtB/YXQ==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr13159471wrv.72.1626268374885;
        Wed, 14 Jul 2021 06:12:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a64sm2020413wme.8.2021.07.14.06.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:54 -0700 (PDT)
Message-Id: <1d4b1f8aea0183a00f8c20226cca5e9c387e4adc.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:39 +0000
Subject: [PATCH v9 15/16] fsmonitor: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If we need to expand a sparse-index into a full one, then the FS Monitor
bitmap is going to be incorrect. Ensure that we start fresh at such an
event.

While this is currently a performance drawback, the eventual hope of the
sparse-index feature is that these expansions will be rare and hence we
will be able to keep the FS Monitor data accurate across multiple Git
commands.

These tests are added to demonstrate that the behavior is the same
across a full index and a sparse index, but also that file modifications
to a tracked directory outside of the sparse cone will trigger
ensure_full_index().

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c              |  7 ++++++
 t/t7519-status-fsmonitor.sh | 49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index ef53bd2198b..53c8f711ccc 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -186,6 +186,10 @@ int convert_to_sparse(struct index_state *istate)
 	cache_tree_free(&istate->cache_tree);
 	cache_tree_update(istate, 0);
 
+	istate->fsmonitor_has_run_once = 0;
+	FREE_AND_NULL(istate->fsmonitor_dirty);
+	FREE_AND_NULL(istate->fsmonitor_last_update);
+
 	istate->sparse_index = 1;
 	trace2_region_leave("index", "convert_to_sparse", istate->repo);
 	return 0;
@@ -282,6 +286,9 @@ void ensure_full_index(struct index_state *istate)
 	istate->cache = full->cache;
 	istate->cache_nr = full->cache_nr;
 	istate->cache_alloc = full->cache_alloc;
+	istate->fsmonitor_has_run_once = 0;
+	FREE_AND_NULL(istate->fsmonitor_dirty);
+	FREE_AND_NULL(istate->fsmonitor_last_update);
 
 	strbuf_release(&base);
 	free(full);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 637391c6ce4..deea88d4431 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -73,6 +73,7 @@ test_expect_success 'setup' '
 	expect*
 	actual*
 	marker*
+	trace2*
 	EOF
 '
 
@@ -383,4 +384,52 @@ test_expect_success 'status succeeds after staging/unstaging' '
 	)
 '
 
+# Usage:
+# check_sparse_index_behavior [!]
+# If "!" is supplied, then we verify that we do not call ensure_full_index
+# during a call to 'git status'. Otherwise, we verify that we _do_ call it.
+check_sparse_index_behavior () {
+	git status --porcelain=v2 >expect &&
+	git sparse-checkout init --cone --sparse-index &&
+	git sparse-checkout set dir1 dir2 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git status --porcelain=v2 >actual &&
+	test_region $1 index ensure_full_index trace2.txt &&
+	test_region fsm_hook query trace2.txt &&
+	test_cmp expect actual &&
+	rm trace2.txt &&
+	git sparse-checkout disable
+}
+
+test_expect_success 'status succeeds with sparse index' '
+	git reset --hard &&
+
+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
+	check_sparse_index_behavior ! &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+	EOF
+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	check_sparse_index_behavior ! &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+		printf "dir1/modified\0"
+	EOF
+	check_sparse_index_behavior ! &&
+
+	cp -r dir1 dir1a &&
+	git add dir1a &&
+	git commit -m "add dir1a" &&
+
+	# This one modifies outside the sparse-checkout definition
+	# and hence we expect to expand the sparse-index.
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+		printf "dir1a/modified\0"
+	EOF
+	check_sparse_index_behavior
+'
+
 test_done
-- 
gitgitgadget

