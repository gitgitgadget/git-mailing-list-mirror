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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E52C433E9
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C05964E4B
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 03:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhB1D72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 22:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhB1D7L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 22:59:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0342EC061788
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id u125so11212778wmg.4
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 19:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fcQkjCw6zC06N7gSUFzG0EzW9qGvc97YSBo5+h04zSE=;
        b=NLK1AJX8DsDdfcFMBPF2w8upNoZ2p/u9Ax0ytw1MR8LoS0K5Chrb3TgdZp68KbS6Xf
         afwl1H9o0Uaao1/+pYYp9KsbW+C+SKWzPtDyHGES0Sa8ACppPlI5lFv0uvCO6/Naq7pl
         iJaaHsIci3cmKlLwFNsBshTL1KrTaK6OGiEi+8eFhLabga4seh8VpBtExNn3FKu/0FcJ
         BtsGexJH5iYY/dhswWeokLi/BVH4Sr59UB6gniYrIvMX0X/i/az/+SsFavt9uUGP0dEd
         41M5350bGxZuB2/pn0j5HzE4ztOhEVy1qaNW6BDo+2rZ/IPoETja2CJOoJ0S/eJHm4lr
         uugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fcQkjCw6zC06N7gSUFzG0EzW9qGvc97YSBo5+h04zSE=;
        b=Cw4Tzn8yuf2F5fxKrfj5HqACZj44hfCMhHfzujXUnOqjUtlnk+6HNWwWBAMAXmVi71
         QrwUKoRiKrBmxK2ig/wAXTmksGAE5Owg/c+pEnzClHzm6lkzuBT8fgOxx0I2vNLUJrgm
         A/DakdZ4rssmi8qrBnMf08na0/coIFVHy+4VkM5fPF+V4Zhum7wLunkrL04mjdD37D1W
         9Ghdq6O+zseRvnYGpH8AtdcTYn3cBLqBBXD5uswruVY4Ec05dimU12sTORljcYphq/h6
         sKZjwO9VXZfqfnxtXmjsDQsd14NEnvtTSDeGYgmDqVLKAlmbc1e62rHf0eAI8bkWUlcq
         I5kg==
X-Gm-Message-State: AOAM533xjfTLa1E4l4lpXNaRWLqjdanFepJHGhyrX2pZjRrUyiZLF0NU
        gLwg8vXOHLoIyzlP3vzwnuVI7NLiGlE=
X-Google-Smtp-Source: ABdhPJxpsnJJagCFkl7o5yoIZLdJOEnGOKbYUqYlfcA3cD7YaMDQPjeoW8lSep3U1zqryICvmEWKrA==
X-Received: by 2002:a05:600c:358d:: with SMTP id p13mr9867213wmq.152.1614484709853;
        Sat, 27 Feb 2021 19:58:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a198sm9913388wmd.11.2021.02.27.19.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 19:58:29 -0800 (PST)
Message-Id: <042ce66011efabcf15be697816d9a97b76877fbf.1614484707.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.git.1614484707.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Feb 2021 03:58:21 +0000
Subject: [PATCH 3/8] merge-ort: add data structures for an alternate tree
 traversal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to determine whether directory rename detection is needed, we
as a pre-requisite need a way to traverse through all the files in a
given tree before visiting any directories within that tree.
traverse_trees() only iterates through the entries in the order they
appear, so add some data structures that will store all the entries as
we iterate through them in traverse_trees(), which will allow us to
re-traverse them in our desired order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 83aa4c08121f..d49cfa8b030b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -51,6 +51,12 @@ enum merge_side {
 	MERGE_SIDE2 = 2
 };
 
+struct traversal_callback_data {
+	unsigned long mask;
+	unsigned long dirmask;
+	struct name_entry names[3];
+};
+
 struct rename_info {
 	/*
 	 * All variables that are arrays of size 3 correspond to data tracked
@@ -102,6 +108,22 @@ struct rename_info {
 	 */
 	struct strset relevant_sources[3];
 
+	/*
+	 * callback_data_*: supporting data structures for alternate traversal
+	 *
+	 * We sometimes need to be able to traverse through all the files
+	 * in a given tree before all immediate subdirectories within that
+	 * tree.  Since traverse_trees() doesn't do that naturally, we have
+	 * a traverse_trees_wrapper() that stores any immediate
+	 * subdirectories while traversing files, then traverses the
+	 * immediate subdirectories later.  These callback_data* variables
+	 * store the information for the subdirectories so that we can do
+	 * that traversal order.
+	 */
+	struct traversal_callback_data *callback_data;
+	int callback_data_nr, callback_data_alloc;
+	char *callback_data_traverse_path;
+
 	/*
 	 * needed_limit: value needed for inexact rename detection to run
 	 *
@@ -396,6 +418,10 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		}
 		strmap_clear(&opti->output, 0);
 	}
+
+	/* Clean out callback_data as well. */
+	FREE_AND_NULL(renames->callback_data);
+	renames->callback_data_nr = renames->callback_data_alloc = 0;
 }
 
 static int err(struct merge_options *opt, const char *err, ...)
-- 
gitgitgadget

