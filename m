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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9222EC433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8EE64FF0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhCEAzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhCEAzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0636C061756
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:55:41 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j2so225738wrx.9
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+SeWPFdImdnYO4XXes7FXQjYB3PNMLwsm8j9cD3i6nw=;
        b=uNgaBIInflwpCCr/7T01AySb45Sect38QsxI4WAQC9rFsif29/IF4IE9WLtNhvlPZU
         u7W3gHfzYhVi6FmMdVdC4gh2CHyfX0FpaDl7uxqfMr0VG66Da6yb+qgTy3uTW0knboii
         E/9KASk+Yz9b9HxnbES8yBWin49PCmdw2SnNmw7B4HYAUldZUUMafh1jz6QxFvFhryk0
         Rhm2ILe8Ksx7K47v94ihSGxQvg5v3UVgc4WvUjuhHvZeirBNJ6QcZMFTBBYrKHwyll7w
         XBwQ3mNcIa5QOuhMaG1EVZV2ulLxZZl8ZsejjE3Q77AN3D1Nrt8IvS2z4Zej4fcRheFu
         bEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+SeWPFdImdnYO4XXes7FXQjYB3PNMLwsm8j9cD3i6nw=;
        b=IwRQOlwNPBIQf0999zDmt1cCwRBcb/cgUolX/XjsFaDDu0Zrw38J8qJvQ7UZxkUMC7
         BMec6tPxKw1Zfoll+Y92aKCdQxBj8+cEwgaLUu5UbYPglAfp7qaT5Sf44Wo/YZot8HD9
         NKlEeQNdZ8ixAheezfFy/ky0g7Vjf/WjX4y5Qw567aDaf4A6XdGxFUEVB2Nawnul+Ivn
         D7ojdhPJL5DhAObVscJzZyWBYYpw1u6MC+BcpwGDBukvsoJxYLPN3eluErbFPx6zWnOL
         rnacSVqWFGDL6zYvTW6kk6qts8HTrVhBgZQ01EgckOUSwjaEF8EqHhbzUq8Wvgnxl3al
         0XHA==
X-Gm-Message-State: AOAM532dGaHORMy5Y+EeqDonR79t9K4S8a1fRxYGpaCGHPpBe3Pzs7QH
        SQ5IFV4V0wMhTYycBH7cCC2OD8E4ew0=
X-Google-Smtp-Source: ABdhPJy+sNw7y4on1fRqq5BdPncpL4hg/oYezjmqbbJgm4DkqBdY1bk7E/9tfkuxju47o8d2lLl22g==
X-Received: by 2002:a5d:5411:: with SMTP id g17mr6702996wrv.194.1614905740466;
        Thu, 04 Mar 2021 16:55:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u137sm1646117wmu.20.2021.03.04.16.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:55:40 -0800 (PST)
Message-Id: <24454e67b186992b9ef7a8ac6f220cbb4aaafd6b.1614905738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Mar 2021 00:55:28 +0000
Subject: [PATCH 02/11] merge-ort: add a special minimal index just for
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

