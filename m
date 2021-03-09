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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C4AC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3794A652A4
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 06:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCIGZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhCIGYu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 01:24:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C15C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 22:24:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e10so13889808wro.12
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 22:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+SeWPFdImdnYO4XXes7FXQjYB3PNMLwsm8j9cD3i6nw=;
        b=kFBE+EYiUY4VzQ6N6I94orTrlv5pRRT6ToMLjUE1ASyTdogK1JEdzz9MHg6jDrgCH2
         TFAg2qSsYjoBj6HLNY5TAoOvBchUifCxyYqIUSgpEVxewdSLeHKm1HnezY3GEUMisrnQ
         RPI6pCMfbfaq3m8UncWDe1H3Umdw2QrwPErMNmPbV+lh812t4HAU0D9Zw2+0aoumKNnG
         PNe7dF/xV87a7n9cp/M6QgFnA7MG0nCxCPs2kdp/HiJUmPudRmWo0LUNka/BC1b8ScU4
         +OvZsFoYDnMJ3x95RpWijmu4SWct7Migaa2TJsbKJCtAzkfxuFYDheCmGO6Xd1spIJBm
         /ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+SeWPFdImdnYO4XXes7FXQjYB3PNMLwsm8j9cD3i6nw=;
        b=P6M4dQ0NTHlF2vvBog20FKIvF5Vm/h62dPexSBQt6MC29CWkTgIoIEuUTKMxnUlgCZ
         r0gGN+V/hLq6xbpozI7LT0DfxSuJM49H19S8oU1RUDQ7Y/Ih6Hg7QF/871nVqpYySrCQ
         1TY9lCMBzdFQxRC5okbcFGZoBh5AFBEudGLSzdWGt5nBOlO3pb/r/8tgTcaPqYWtA9wz
         dCTvyp7vmpBHTKRcD+kbwI6moiv3OawDINNEn3sAXBiXqytZeYct5RI5oqX/YJexBX/M
         dYKTwFxN8FmK3zHbgqokDaE0SpJbVVlSyvCEpFcoeatKhDQIDFUhkwOPxoN4FTRaq4y7
         0fNw==
X-Gm-Message-State: AOAM532k94uMZHVHoct2tvTGCdcZCDFFMg+nXIZWO2/FrOiObIAtiKjb
        Q5iuiQOb7iZ3371jBfNvOhsBtra7cpk=
X-Google-Smtp-Source: ABdhPJyhBXJyZWQEzxwaPX4H8LsMiWx99QA6ReAPxFU+9wE60uNBS+JAWyBBd9I9jdYk4F63o8pElQ==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr26097516wre.386.1615271089027;
        Mon, 08 Mar 2021 22:24:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11sm23662906wrq.74.2021.03.08.22.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:24:48 -0800 (PST)
Message-Id: <24454e67b186992b9ef7a8ac6f220cbb4aaafd6b.1615271086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
        <pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 06:24:37 +0000
Subject: [PATCH v2 02/10] merge-ort: add a special minimal index just for
 renormalization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

renormalize_buffer() requires an index_state, which is something that
merge-ort does not operate with.  However, all the renormalization code
needs is an index with a .gitattributes file...plus a little bit of
setup.  Create such an index, along with the deallocation and
attr_direction handling.

A subsequent commit will add a function to finish the initialization
of this index.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 5309488fd9d8..d91b66a052b6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -18,6 +18,7 @@
 #include "merge-ort.h"
 
 #include "alloc.h"
+#include "attr.h"
 #include "blob.h"
 #include "cache-tree.h"
 #include "commit.h"
@@ -170,6 +171,16 @@ struct merge_options_internal {
 	 */
 	struct rename_info renames;
 
+	/*
+	 * attr_index: hacky minimal index used for renormalization
+	 *
+	 * renormalization code _requires_ an index, though it only needs to
+	 * find a .gitattributes file within the index.  So, when
+	 * renormalization is important, we create a special index with just
+	 * that one file.
+	 */
+	struct index_state attr_index;
+
 	/*
 	 * current_dir_name, toplevel_dir: temporary vars
 	 *
@@ -349,6 +360,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	string_list_clear(&opti->paths_to_free, 0);
 	opti->paths_to_free.strdup_strings = 0;
 
+	if (opti->attr_index.cache_nr)
+		discard_index(&opti->attr_index);
+
 	/* Free memory used by various renames maps */
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
 		struct hashmap_iter iter;
@@ -3272,6 +3286,8 @@ void merge_finalize(struct merge_options *opt,
 {
 	struct merge_options_internal *opti = result->priv;
 
+	if (opt->renormalize)
+		git_attr_set_direction(GIT_ATTR_CHECKIN);
 	assert(opt->priv == NULL);
 
 	clear_or_reinit_internal_opts(opti, 0);
@@ -3347,6 +3363,10 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	/* Default to histogram diff.  Actually, just hardcode it...for now. */
 	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
 
+	/* Handle attr direction stuff for renormalization */
+	if (opt->renormalize)
+		git_attr_set_direction(GIT_ATTR_CHECKOUT);
+
 	/* Initialization of opt->priv, our internal merge data */
 	trace2_region_enter("merge", "allocate/init", opt->repo);
 	if (opt->priv) {
-- 
gitgitgadget

