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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C34C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D5222CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgLDUtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbgLDUtm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:42 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE98C08E862
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:27 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so8172922wmb.5
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XJPfvf2mmPYAO+WF6XjbOW5AJ00Zwdiy5fArUe9FNv8=;
        b=JRET0NH4e+TBKL0BjMQCpoKiS92AwMtIFdax0pXYYHvizO9+uMANEPG9odM/rN8BRZ
         J/LinS4bc3a98kkQu7FkfZLh/kX2wMnODldiol4pEzrBt3Sqgc9bzszGSDvpRKm/QJmh
         fnH4yWrBC4v3ygHgDqy5XsYlQh4CqTWuh2Tn4PK9gcue63UqQsDaiyYeYSnBXkusv3Ir
         lOhnDJFkAewmjPE37hqbh27Zel30djdl1hB0pcD4scl5OXYVhwErnabQy3NO9ZwvZNl8
         KQ26UBDzVRr2eLc5Gl9Fs6ukdzOIT8xcAR2tUPRm7vVdNnuFMgvx+CJ62LCM6S7h2kA9
         yYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XJPfvf2mmPYAO+WF6XjbOW5AJ00Zwdiy5fArUe9FNv8=;
        b=VkQDU5TRqplX/wV9YvR3R7LPXklhIuPFonCftZMYfsa7bB681GNqs6h/8Kx/ew7KNV
         T5sKuL0U7BuC5kcc8cEKE+N7niZQ9Yc/57xJNXhTcLImmFIbeg0b9zMxl3HeioUnvZTo
         HJYHn83+EFx04EBtlQK2iqrlza/xYpiYxaPxvqrp6mPkAyd6a61XXhKHPWPuP6/EJMaV
         hXwSbXXkCh17U0N+6BmoFwyRmcJ0Xy5ciHvHZRPiY9q1+8vJRVIkaxedB3NI9z2WIaCg
         H0QzmwLaFri/lt8EK+ZWVT0eo9QATvAAlbEOiM/oO5vyhH+Awz4Al+FAmIqbMQ4njFRK
         3Uug==
X-Gm-Message-State: AOAM5300tp1mAFBY2DGovBy2PFegbrxqJkJExAqAQed5eh8+XrKsBhXz
        wz2Q0g1Hv0vCUIxfhQvOIpvdUaQSAjo=
X-Google-Smtp-Source: ABdhPJy6SEgGp+tTx9RlrmsWmcE5j2WmwHe20q2mhOzAghmJYjWvhdNVMsxKgAzS6avthoInU8OZzQ==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr6281656wmh.85.1607114906426;
        Fri, 04 Dec 2020 12:48:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y68sm3563239wmc.0.2020.12.04.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:25 -0800 (PST)
Message-Id: <8ee8561d7a3b4cb76ccffbd6061f3a874f386675.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:48:03 +0000
Subject: [PATCH v2 13/20] merge-ort: step 1 of tree writing -- record
 basenames, modes, and oids
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

As a step towards transforming the processed path->conflict_info entries
into an actual tree object, start recording basenames, modes, and oids
in a dir_metadata structure.  Subsequent commits will make use of this
to actually write a tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index c54837999f..60cd73416e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -492,10 +492,31 @@ static int string_list_df_name_compare(const char *one, const char *two)
 	return onelen - twolen;
 }
 
+struct directory_versions {
+	struct string_list versions;
+};
+
+static void record_entry_for_tree(struct directory_versions *dir_metadata,
+				  const char *path,
+				  struct merged_info *mi)
+{
+	const char *basename;
+
+	if (mi->is_null)
+		/* nothing to record */
+		return;
+
+	basename = path + mi->basename_offset;
+	assert(strchr(basename, '/') == NULL);
+	string_list_append(&dir_metadata->versions,
+			   basename)->util = &mi->result;
+}
+
 /* Per entry merge function */
 static void process_entry(struct merge_options *opt,
 			  const char *path,
-			  struct conflict_info *ci)
+			  struct conflict_info *ci,
+			  struct directory_versions *dir_metadata)
 {
 	VERIFY_CI(ci);
 	assert(ci->filemask >= 0 && ci->filemask <= 7);
@@ -503,6 +524,14 @@ static void process_entry(struct merge_options *opt,
 	assert(ci->match_mask == 0 || ci->match_mask == 3 ||
 	       ci->match_mask == 5 || ci->match_mask == 6);
 
+	if (ci->dirmask) {
+		record_entry_for_tree(dir_metadata, path, &ci->merged);
+		if (ci->filemask == 0)
+			/* nothing else to handle */
+			return;
+		assert(ci->df_conflict);
+	}
+
 	if (ci->df_conflict) {
 		die("Not yet implemented.");
 	}
@@ -571,6 +600,7 @@ static void process_entry(struct merge_options *opt,
 	 */
 	if (!ci->merged.clean)
 		strmap_put(&opt->priv->conflicted, path, ci);
+	record_entry_for_tree(dir_metadata, path, &ci->merged);
 }
 
 static void process_entries(struct merge_options *opt,
@@ -580,6 +610,7 @@ static void process_entries(struct merge_options *opt,
 	struct strmap_entry *e;
 	struct string_list plist = STRING_LIST_INIT_NODUP;
 	struct string_list_item *entry;
+	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP };
 
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
@@ -609,13 +640,16 @@ static void process_entries(struct merge_options *opt,
 		 */
 		struct merged_info *mi = entry->util;
 
-		if (!mi->clean) {
+		if (mi->clean)
+			record_entry_for_tree(&dir_metadata, path, mi);
+		else {
 			struct conflict_info *ci = (struct conflict_info *)mi;
-			process_entry(opt, path, ci);
+			process_entry(opt, path, ci, &dir_metadata);
 		}
 	}
 
 	string_list_clear(&plist, 0);
+	string_list_clear(&dir_metadata.versions, 0);
 	die("Tree creation not yet implemented");
 }
 
-- 
gitgitgadget

