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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE208C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CBE64F04
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhCQV2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhCQV2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F460C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e18so3315227wrt.6
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i7t+eJQcgwTX2+yM47HxJduHsS0+Js64QpdHJo4KdIQ=;
        b=n6U1j726EJyICqPbUhs4W6qU6eR/0TtX87BSdeOftT3X8+pMz8WEHGKnFevJGiOUZZ
         IhmwwZFIxr2lNyJ8ncWPO43GIolosLqAsVBErqSLHE6mvu0GMkcLlsWPg3q6+NX+/DK0
         EZqXZwf7mk+tHMhGr0yuQGEb7yI9Mo1daH3AwyTVyKI8e5sd9/FmZDF9oPRFaQojIFtF
         vraf7fk23bpa7+rEt8KSBxWmvtvlGx6PNOY3s6vZg97Y/5oX6bb9z8Gtn7OsU1Tku/DE
         86pPX/2vuCS8+u3NI2PLrCpMoFUgntp16s3bYXsKKgJ8SY5I2X06I2mlEcDV1JImaash
         zjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i7t+eJQcgwTX2+yM47HxJduHsS0+Js64QpdHJo4KdIQ=;
        b=b7sA9QoBdvY20u4NeccQPNAyEV7FDPInTx5056FZ9EpxXtu9tAjld1UyLR0xdYpudc
         gvDXoQw6flBvb4UV8VSOqjGJ1t5y2UhHZQ0EyfAL64c+NzJG9X9XoMMShyVakIzEJnrH
         vOEk06MqXlGOX5uXzR2GUyO/dLsLw77ekvL686Ali5NYYcTwxQyYAzwu5OikBL7ASTDv
         SSDY8XybPCOQUwIk0698M41/cyCkrK7Yb1CAgfp5yAM4GuIHPtaJIpd/6L2Smov6W3Ma
         9iRlLmcJt/fw6cZMWTLtL0xSOQI6R5Dxpbupw/qX8Ru+ZvqLuvrLCce4WcT8lbagYCSJ
         EnQw==
X-Gm-Message-State: AOAM532SZgcOO/g6iSZwYVoJxvS57UzMHV9gmW+MX0kDpfOYLATTRbeJ
        LWrosUTO9dTE+i6d8WHyovcd03u4IIU=
X-Google-Smtp-Source: ABdhPJwd16UjFjq1hGdRxBrw99K7jw8KvGLaDnMHpxVX6FUUGfvp9l4WPCEO4VLQOkSGMzrQBp2Ddw==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr6130040wrw.415.1616016488162;
        Wed, 17 Mar 2021 14:28:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm173372wmm.5.2021.03.17.14.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:07 -0700 (PDT)
Message-Id: <6d34cc466bd53e074c690b58ef03391eac10e5d9.1616016485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
        <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:27:54 +0000
Subject: [PATCH v2 02/13] merge-ort: add a special minimal index just for
 renormalization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
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
index 34a91c435737..3c606fa7e4b3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -18,6 +18,7 @@
 #include "merge-ort.h"
 
 #include "alloc.h"
+#include "attr.h"
 #include "blob.h"
 #include "cache-tree.h"
 #include "commit.h"
@@ -220,6 +221,16 @@ struct merge_options_internal {
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
@@ -399,6 +410,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	string_list_clear(&opti->paths_to_free, 0);
 	opti->paths_to_free.strdup_strings = 0;
 
+	if (opti->attr_index.cache_nr)
+		discard_index(&opti->attr_index);
+
 	/* Free memory used by various renames maps */
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
 		strintmap_func(&renames->dirs_removed[i]);
@@ -3407,6 +3421,8 @@ void merge_finalize(struct merge_options *opt,
 {
 	struct merge_options_internal *opti = result->priv;
 
+	if (opt->renormalize)
+		git_attr_set_direction(GIT_ATTR_CHECKIN);
 	assert(opt->priv == NULL);
 
 	clear_or_reinit_internal_opts(opti, 0);
@@ -3482,6 +3498,10 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
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

