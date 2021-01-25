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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1982DC433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06ED22242
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbhAYSDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731340AbhAYRzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:53 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C2C0611C2
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c127so49696wmf.5
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cMsFnS14xgniOaBIK70q63JnbTK9euVHtZQ1xBvUskA=;
        b=hxP5GXBMHTaji4s+R2ZOKnHgvnknWNbGC9UDV6HAG2/HCxvAfaVgmbhUGo9g6pI2Mr
         uuGYNSk63Z1perkOuuu0WTTW60UgTBg5KmgMXg89U9l5qHY3nVtDVVykElakgPzQY6mF
         s9sPmBDpkRfA0/8EeSXiQzHB7H/P5g7wM0IJeyZMjxGN6a53naGxX4LDComSCryu5zOl
         A+SWvaBuQcnZlHG46zERkLlqDBRSKCgxoL5P81NbNCpUhMGkjyBMgeL8IyyOOUuVEIun
         +frSfVN5X4wTKCD+W+NMKKxdQNFE5O6PdwyO1ZAyPTto0eKeeX6DqMHOXonn82mqX3Mg
         Ki5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cMsFnS14xgniOaBIK70q63JnbTK9euVHtZQ1xBvUskA=;
        b=gu5kvOIdtWzsH075a2oZMZHAjvgQ3bzn2hl4dZeiAfXc/NjEV56FdnTkptkUotdN1/
         7X3Mk29c5e3XB0b3KPwvh82bSRh0A3YmZUK4cp9UMHwLpqytdrwXO2O/KmJWsy0J1TgA
         I226tIoz6kL8RhdZwZzwZMBs43Uxr7FvPShercpeXtK0awD8+5kj+dnO7jRKGxFp4+KS
         Fc+mcAZ5G6oisFJTqXz8Nf5BfrvfhiwOW0ry9aZUWcmYd+Et7r6BlggraXdWEu2HCSzL
         SdsjTEODyMx5J5ZrAV8XDnnp8yGZyvPHn91/pKuIIWc9gJG3zF31LpW5dha1hk+dX/aP
         z9DA==
X-Gm-Message-State: AOAM530oH+rCeA4BovnYtKSS7LuofFGBaG1OMgpFr6It4f4jgxYEQqlc
        oLCb6xxyvPEWx+lC3K+PmxyAVKQtzek=
X-Google-Smtp-Source: ABdhPJxWw9pBj1gIM77iwYO7XdQvvPnyUM8VCleLZlgdTLJeiMIT/7n1OuyiZINP4XaBO4y5Ve6IOA==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr1148583wmc.39.1611596557433;
        Mon, 25 Jan 2021 09:42:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm16364178wrr.35.2021.01.25.09.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:37 -0800 (PST)
Message-Id: <e24570336485ee153ada3289231b707e937524a8.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:11 +0000
Subject: [PATCH 25/27] fsmonitor: disable if index is sparse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The FS Monitor feature uses a bitmap over the index entries. This
currently interacts poorly with a sparse index. We will revisit this
interaction in the future, but for now protect the index by refusing to
use the FS Monitor extension at all if the index is sparse.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 fsmonitor.c                              | 21 ++++++++++++++-------
 read-cache.c                             |  3 ++-
 t/t1092-sparse-checkout-compatibility.sh |  8 ++++----
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 7b8cd3975b9..99b26576baa 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -58,6 +58,9 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	uint64_t timestamp;
 	struct strbuf last_update = STRBUF_INIT;
 
+	if (istate->sparse_index)
+		return 0;
+
 	if (sz < sizeof(uint32_t) + 1 + sizeof(uint32_t))
 		return error("corrupt fsmonitor extension (too short)");
 
@@ -98,7 +101,8 @@ void fill_fsmonitor_bitmap(struct index_state *istate)
 {
 	unsigned int i, skipped = 0;
 
-	ensure_full_index(istate);
+	if (istate->sparse_index)
+		return;
 
 	istate->fsmonitor_dirty = ewah_new();
 	for (i = 0; i < istate->cache_nr; i++) {
@@ -161,11 +165,7 @@ static int query_fsmonitor(int version, const char *last_update, struct strbuf *
 
 static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
 {
-	int pos;
-
-	ensure_full_index(istate);
-
-	pos = index_name_pos(istate, name, strlen(name));
+	int pos = index_name_pos(istate, name, strlen(name));
 
 	if (pos >= 0) {
 		struct cache_entry *ce = istate->cache[pos];
@@ -190,7 +190,8 @@ void refresh_fsmonitor(struct index_state *istate)
 	char *buf;
 	unsigned int i;
 
-	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
+	if (!core_fsmonitor || istate->fsmonitor_has_run_once ||
+	    istate->sparse_index)
 		return;
 
 	hook_version = fsmonitor_hook_version();
@@ -300,6 +301,9 @@ void add_fsmonitor(struct index_state *istate)
 	unsigned int i;
 	struct strbuf last_update = STRBUF_INIT;
 
+	if (istate->sparse_index)
+		return;
+
 	if (!istate->fsmonitor_last_update) {
 		trace_printf_key(&trace_fsmonitor, "add fsmonitor");
 		istate->cache_changed |= FSMONITOR_CHANGED;
@@ -335,6 +339,9 @@ void tweak_fsmonitor(struct index_state *istate)
 	unsigned int i;
 	int fsmonitor_enabled = git_config_get_fsmonitor();
 
+	if (istate->sparse_index)
+		fsmonitor_enabled = 0;
+
 	if (istate->fsmonitor_dirty) {
 		if (fsmonitor_enabled) {
 			ensure_full_index(istate);
diff --git a/read-cache.c b/read-cache.c
index 8c974829497..96d9b95128a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3017,7 +3017,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-	if (!strip_extensions && istate->fsmonitor_last_update) {
+	if (!strip_extensions && istate->fsmonitor_last_update &&
+	    !istate->sparse_index) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_fsmonitor_extension(&sb, istate);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2e8efe6ab37..1cdf33a4025 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -388,7 +388,7 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	init_repos &&
 
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		git -C sparse-index reset --hard &&
 	test_region index convert_to_sparse trace2.txt &&
 	test_region index ensure_full_index trace2.txt
 '
@@ -398,19 +398,19 @@ test_expect_success 'sparse-index is not expanded' '
 
 	rm -f trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" status -uno &&
+		git -C sparse-index status -uno &&
 	test_region ! index ensure_full_index trace2.txt &&
 
 	rm trace2.txt &&
 	echo >>sparse-index/README.md &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" add -A &&
+		git -C sparse-index add -A &&
 	test_region ! index ensure_full_index trace2.txt &&
 
 	rm trace2.txt &&
 	echo >>sparse-index/extra.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" add extra.txt &&
+		git -C sparse-index add extra.txt &&
 	test_region ! index ensure_full_index trace2.txt
 '
 
-- 
gitgitgadget

