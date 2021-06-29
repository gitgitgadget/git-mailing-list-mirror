Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A616C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7574861CA3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhF2Byz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhF2ByX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663EFC0613A2
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j1so23628028wrn.9
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2NnBKce/32GyuSe6kI1cYosfQIE9q6lvos67gcH5Bfo=;
        b=PtBx5Xr1eLxbfo0U4+MOyKiq/NTWXgF/J9xjMD87wZTgJLYHoeIfEfjXRY6fv0xdzw
         WZvYGyCg+fgqsb2RRFkJAtrpluwWjDD/uXrICZX9+nKbGH0ZFjlwJNbqRWqDUMXfQUOp
         3b+HyF9vlVIEbloGzb/PvmlE617JKkDLfT5ajI52V8UfiLHJ7ZnFa9dUPGdndIrg88vu
         C13qa8ajHyYn3lAJj9V8/nr2cPbhd0w+Yop1zgnwt5B7d6rNl3bKEgOjs+RFDQbsTue8
         U0qlrW3OhQpCFRf3sj2Pi7IpR5TfQqu2JDzuWvKOvdOmtq97byIEsNXN8Rbz/0D8GfMj
         JL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2NnBKce/32GyuSe6kI1cYosfQIE9q6lvos67gcH5Bfo=;
        b=dhBxTCxPnfnSTjRs64q2vKWrieaopsb1pYjaL3tfVO5Ek+h8nxYwIJ2K8/Kl0RWcEf
         qhF5lS2ZYn0QNipSmKQTXz5wJynmoKv6SAJ9SVjl2PcYOZOunFjtQJHD3bFijgKfx39Y
         piGx5BEiPiX6dF7lm/5D/Pv+rHp6LA/vDkQGmxkOkDftglqnTegGaIIHQIM60MnMe3GA
         B/TL8+ahav749alj/IDYVuqxDBKNBeB4zmggg0RV9BrPOx3OJOGoZ4PJnriKCgH0xyoU
         YkRIJuqJrZ61rIwQR7GVeZCb2/RyoHMU63L6sSLn8wYOXTpXMLpKzhWRt+NyWfSGtoxy
         MFLQ==
X-Gm-Message-State: AOAM533UisG+k1W1E+H+eBnucjCrGFRRr4XZc8b7sjm+P1x10G2kW5RW
        iDgwchyA3v6mMMDChrl/RbIZlPgPC6g=
X-Google-Smtp-Source: ABdhPJylLzM5bxSiFBVC5LaV8Z9BgGhIFAZ5WFckn9OOfhkESSwMudj7UHsqXJJ64zR1ZvBslViiyA==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr31097172wrw.302.1624931512064;
        Mon, 28 Jun 2021 18:51:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm16613293wrv.82.2021.06.28.18.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:51 -0700 (PDT)
Message-Id: <711e403a63a7815d0581b469a9f0d52d0c8054ca.1624931503.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:42 +0000
Subject: [PATCH v6 14/14] fsmonitor: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c              |  7 ++++++
 t/t7519-status-fsmonitor.sh | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

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
index 637391c6ce4..8f9240b9b1a 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -73,6 +73,7 @@ test_expect_success 'setup' '
 	expect*
 	actual*
 	marker*
+	trace2*
 	EOF
 '
 
@@ -383,4 +384,51 @@ test_expect_success 'status succeeds after staging/unstaging' '
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
