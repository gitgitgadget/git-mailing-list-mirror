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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2AEC433E0
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345F161981
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhCTAEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCTAEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63777C061761
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k128so3864220wmk.4
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i7t+eJQcgwTX2+yM47HxJduHsS0+Js64QpdHJo4KdIQ=;
        b=lDuhNpjn3rNG8tKwnE/E93HYs2GUwOhp9ldDeg1vxFfKAmJOJVkxGc/k2lrkVbSEru
         BuaV426gpv3CGP1u9YLv7UppnvYaAmB2uzt2RlUjHsXP71GfPLFDmBrIKG1YqWBIml7K
         eumOUI1/TrTUhRlqb9HXjb1YLXpcvPS+RoPrWaQNBOcM3YNTIAn3VimHmqsynlhEZC1O
         fdDOpBrG7W0x2xoHcCuYrvb+W42Zoqp9ckModyDEWAJ0mLIj6IKLW/7zkZlRjDHlvI8K
         oOVvebFvxmdKGuWFaVIEbFo9iXpKGox6GuWAgyXoDs21cZOIgwhlKcGoiWaGkHDK29OI
         jDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i7t+eJQcgwTX2+yM47HxJduHsS0+Js64QpdHJo4KdIQ=;
        b=gy402s1lg3Tymj2Zw8IyqN0y0SElWYAZT5MK8JasGpwJajFa1DBspMCZ7/7GJr6bBF
         rzncC1LVSFzXGo8j0JZIH96yIXtBlr0vhG2bLbq4s1uw9cN3WceNJn+c+eIOKVmMS/h4
         UErj1BWYVtljxFxl3O5wVkbGWqoy+o7eewtWDLEGfyULA7jr8EmTDJ+MWTk4H4GGLNMY
         kpIBMvaoiLw+i3jLHPqllATIuIguw15CNALJGBD/4IomRL1CJ79Qm5/nF94c5il4etWv
         nQisU887p8tUA8IWtwtelK4L74/ctF41rp+eX/TG1ySEU81YlXqzrI5A9OIBrW6QHLzs
         GY8Q==
X-Gm-Message-State: AOAM5315hi9YXMHy5aRxstx67w0iddE1JNWtz4hWYm0P/pWA3U6FqkyB
        eg7FlyXHYyHIm4RElj4j/dapXWjBS9o=
X-Google-Smtp-Source: ABdhPJztutXWnwYqNduFebBFCK08Pg8GjHvSef2kovpYC0lRaQcEqPI3ZaQrunEUrx5Cq/p09oC5lg==
X-Received: by 2002:a1c:bb0b:: with SMTP id l11mr5854717wmf.150.1616198639081;
        Fri, 19 Mar 2021 17:03:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h25sm9473937wml.32.2021.03.19.17.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:03:58 -0700 (PDT)
Message-Id: <6d34cc466bd53e074c690b58ef03391eac10e5d9.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:45 +0000
Subject: [PATCH v3 02/13] merge-ort: add a special minimal index just for
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

