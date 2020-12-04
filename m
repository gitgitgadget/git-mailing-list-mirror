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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D8C4167B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC4F22CE3
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgLDUtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbgLDUtm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:42 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA00FC08E861
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:26 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g185so8193734wmf.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ajsah9vP6m5FStxN4iJIKQQYqeKlqqcbNP8dSaxtu+0=;
        b=LrNxzJKzV+J2YoYYyS+60OHSQ7x3C7uIqTd1OD10x9304efG1sthMiLqPf65LQCOis
         CT7XObcbeXxpsCxHdjwHs1IEAJnGXKBbq+L8dQjiVmypX8YiG5V9O0dDFV2144oY0afS
         W/SmFLGSejpoI2dSdnGEfSSyyf7adI1tdE5f8PaNZ7Mxj6LDFc8Sa8NqqTB/Amipw6ir
         PidIDKAq60LAS7vIxmhHUbRFoRx37b83soutRxGIc+W/9N3u69gIFfSJFaGO2LFvF0D+
         IcUIkx0TFzt0np8Z9hMrOVZUoZnYI1XZPtLzysyJrRGtlvsStfPlP69iWr2IdOYH4zk9
         JDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ajsah9vP6m5FStxN4iJIKQQYqeKlqqcbNP8dSaxtu+0=;
        b=LIIHwZJuo7jwi90ekFEkmZf4fAi1GifzlAOhYB6/WUiY+KlxMq660zeckSVlNQfgQ7
         thhOjGQopMhbtcg1kxBNf4AMsnMJIFNThWjL9N4v3BQKK9MfSl6IUz+4Jw4lhliCvDcz
         23eAodIGIQtSqvU/1/mVKFwaAmQcCZks5XlFddZpj1mlQQsmTx8fTwRFZ3Wulmg1uPfA
         FsIYGBLvl6dOT9WA3fA9tEzezITVqdF4SpOc2cWy58lnAjAjgtQG9c562E5s6dIEiGjk
         AJVoP2mVWc+7lzH6jvyIwaJBY+fdpbTVmhUZQ4oGnSp5cVxlKpXBIVLVab3w8xP5KfG3
         28AA==
X-Gm-Message-State: AOAM533idH5tIeSC4gfQfvO9sFEk2HglBMRq9Eaul6sD3h2Kxdk00LUU
        px/fhsWsKiyIeP35s6m8EUq6o9/Ff+E=
X-Google-Smtp-Source: ABdhPJyvJ8my+CpvPd9vTNNBMF3hKbU7bkaIr6Q5HVH/6RwwEoncAkd5G1iXLhOT6FSvfx4/YehGZA==
X-Received: by 2002:a1c:17:: with SMTP id 23mr6034021wma.35.1607114905413;
        Fri, 04 Dec 2020 12:48:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm4854142wrp.3.2020.12.04.12.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:24 -0800 (PST)
Message-Id: <b54306fd0e6663b78a061f4660b4f76f4d1fd820.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:48:02 +0000
Subject: [PATCH v2 12/20] merge-ort: have process_entries operate in a defined
 order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want to handle paths below a directory before needing to handle the
directory itself.  Also, we want to handle the directory immediately
after the paths below it, so we can't use simple lexicographic ordering
from strcmp (which would insert foo.txt between foo and foo/file.c).
Copy string_list_df_name_compare() from merge-recursive.c, and set up a
string list of paths sorted by that function so that we can iterate in
the desired order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index fbbbde1c3f..c54837999f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -465,6 +465,33 @@ static int detect_and_process_renames(struct merge_options *opt,
 	return clean;
 }
 
+static int string_list_df_name_compare(const char *one, const char *two)
+{
+	int onelen = strlen(one);
+	int twolen = strlen(two);
+	/*
+	 * Here we only care that entries for D/F conflicts are
+	 * adjacent, in particular with the file of the D/F conflict
+	 * appearing before files below the corresponding directory.
+	 * The order of the rest of the list is irrelevant for us.
+	 *
+	 * To achieve this, we sort with df_name_compare and provide
+	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
+	 * We use the mode S_IFDIR for everything else for simplicity,
+	 * since in other cases any changes in their order due to
+	 * sorting cause no problems for us.
+	 */
+	int cmp = df_name_compare(one, onelen, S_IFDIR,
+				  two, twolen, S_IFDIR);
+	/*
+	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
+	 * that 'foo' comes before 'foo/bar'.
+	 */
+	if (cmp)
+		return cmp;
+	return onelen - twolen;
+}
+
 /* Per entry merge function */
 static void process_entry(struct merge_options *opt,
 			  const char *path,
@@ -551,24 +578,44 @@ static void process_entries(struct merge_options *opt,
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
+	struct string_list plist = STRING_LIST_INIT_NODUP;
+	struct string_list_item *entry;
 
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
 		return;
 	}
 
+	/* Hack to pre-allocate plist to the desired size */
+	ALLOC_GROW(plist.items, strmap_get_size(&opt->priv->paths), plist.alloc);
+
+	/* Put every entry from paths into plist, then sort */
 	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
+		string_list_append(&plist, e->key)->util = e->value;
+	}
+	plist.cmp = string_list_df_name_compare;
+	string_list_sort(&plist);
+
+	/*
+	 * Iterate over the items in reverse order, so we can handle paths
+	 * below a directory before needing to handle the directory itself.
+	 */
+	for (entry = &plist.items[plist.nr-1]; entry >= plist.items; --entry) {
+		char *path = entry->string;
 		/*
 		 * NOTE: mi may actually be a pointer to a conflict_info, but
 		 * we have to check mi->clean first to see if it's safe to
 		 * reassign to such a pointer type.
 		 */
-		struct merged_info *mi = e->value;
+		struct merged_info *mi = entry->util;
 
-		if (!mi->clean)
-			process_entry(opt, e->key, e->value);
+		if (!mi->clean) {
+			struct conflict_info *ci = (struct conflict_info *)mi;
+			process_entry(opt, path, ci);
+		}
 	}
 
+	string_list_clear(&plist, 0);
 	die("Tree creation not yet implemented");
 }
 
-- 
gitgitgadget

