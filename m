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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7A5C4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595EC22D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394114AbgLMIGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393200AbgLMIFx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:53 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55701C06138C
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:38 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so13280370wrt.2
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Og3aZK8VK2Qt2KGO3ya3FSuqQqSkXKu+yAFkJenXSh8=;
        b=FXCDGO3upBI1ZPg7ZMDEy33ZTDxa3f2EN9CCuCS8alQkrnXST7t7Cctr1/sGf4Z5Ra
         9O/zqJ3qW2KRvDDXN71yLH60+HKa6NOU6zmldKzTT4P2TVO+HKWLhTdT5GXXaHZfBXsF
         LUc2FJGyBRZj9NGAM14Fk80i6Vq7eJP8wWY+Ac9LSrcBHK6crclI94hpqg3LXGYwBsWu
         aWM0zJ1qxOug0j8v3DeCKUxm2QfzWy1mfaRt3+A93DAOtc9NhdAMOUbWp0dLpRXUpZls
         +2KiABYLLURYbxVaWQUScbPq+cNOzixHVfDpuQB4sTK8S77Red4HyPuZp2j6T1OXJ/4k
         bbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Og3aZK8VK2Qt2KGO3ya3FSuqQqSkXKu+yAFkJenXSh8=;
        b=tL5T0O1U4V7ZZoE2OmrdJGcpTzK2Gl0Pqlgd4fc8m984OgMS4gm0sE0E8InwmHMdb3
         kPDdk55mjAc7KBxIBET4u79x+KyNOQMuC9KgdNecVd3geTpKB3bSyYXkF0lxG/hmnvJQ
         SaieQsWrmRf2xORITI5maeC/dOPW452nikYOnf2/JHV9FmXt8fiEygj01T8ZaVIvzptj
         neOwnh5xacVB7Ou89VOCIRK60RdZKTrXsMBfQNTOTITJPxn+HNAUawT9bSdjmsrqHzx0
         Fg43ppAZ/n9pgjh5GCW7FqyH80f7JS5CDDoOSnZVmQksHTvtIiC4xfHiIWGXwJjlzd/h
         zgZg==
X-Gm-Message-State: AOAM5318HrxYC28cLIpvWW9ASBk24uK6tHMBdW7jJjCtF6VdgDfAlRUf
        py+DuRNG2K1EcKX3TRQSSp9rxsMqHY8=
X-Google-Smtp-Source: ABdhPJzYTCTY28KSp/jUuVA4tqd9+pO/9Xbpa2VXpogV53nsg3u1LxNio6TVhQTT9eKt249xMHGD/A==
X-Received: by 2002:adf:e990:: with SMTP id h16mr23313138wrm.307.1607846676909;
        Sun, 13 Dec 2020 00:04:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm7851855wrs.65.2020.12.13.00.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:36 -0800 (PST)
Message-Id: <be4bdfac876d6052b845afcf77a5330fe8c6d243.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:16 +0000
Subject: [PATCH v3 09/20] merge-ort: record stage and auxiliary info for every
 path
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

Create a helper function, setup_path_info(), which can be used to record
all the information we want in a merged_info or conflict_info.  While
there is currently only one caller of this new function, and some of its
particular parameters are fixed, future callers of this function will be
added later.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 7 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index a6876191c02..bbfc056300b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -185,6 +185,26 @@ struct conflict_info {
 	unsigned match_mask:3;
 };
 
+/*
+ * For the next three macros, see warning for conflict_info.merged.
+ *
+ * In each of the below, mi is a struct merged_info*, and ci was defined
+ * as a struct conflict_info* (but we need to verify ci isn't actually
+ * pointed at a struct merged_info*).
+ *
+ * INITIALIZE_CI: Assign ci to mi but only if it's safe; set to NULL otherwise.
+ * VERIFY_CI: Ensure that something we assigned to a conflict_info* is one.
+ * ASSIGN_AND_VERIFY_CI: Similar to VERIFY_CI but do assignment first.
+ */
+#define INITIALIZE_CI(ci, mi) do {                                           \
+	(ci) = (!(mi) || (mi)->clean) ? NULL : (struct conflict_info *)(mi); \
+} while (0)
+#define VERIFY_CI(ci) assert(ci && !ci->merged.clean);
+#define ASSIGN_AND_VERIFY_CI(ci, mi) do {    \
+	(ci) = (struct conflict_info *)(mi);  \
+	assert((ci) && !(mi)->clean);        \
+} while (0)
+
 static int err(struct merge_options *opt, const char *err, ...)
 {
 	va_list params;
@@ -201,6 +221,65 @@ static int err(struct merge_options *opt, const char *err, ...)
 	return -1;
 }
 
+static void setup_path_info(struct merge_options *opt,
+			    struct string_list_item *result,
+			    const char *current_dir_name,
+			    int current_dir_name_len,
+			    char *fullpath, /* we'll take over ownership */
+			    struct name_entry *names,
+			    struct name_entry *merged_version,
+			    unsigned is_null,     /* boolean */
+			    unsigned df_conflict, /* boolean */
+			    unsigned filemask,
+			    unsigned dirmask,
+			    int resolved          /* boolean */)
+{
+	/* result->util is void*, so mi is a convenience typed variable */
+	struct merged_info *mi;
+
+	assert(!is_null || resolved);
+	assert(!df_conflict || !resolved); /* df_conflict implies !resolved */
+	assert(resolved == (merged_version != NULL));
+
+	mi = xcalloc(1, resolved ? sizeof(struct merged_info) :
+				   sizeof(struct conflict_info));
+	mi->directory_name = current_dir_name;
+	mi->basename_offset = current_dir_name_len;
+	mi->clean = !!resolved;
+	if (resolved) {
+		mi->result.mode = merged_version->mode;
+		oidcpy(&mi->result.oid, &merged_version->oid);
+		mi->is_null = !!is_null;
+	} else {
+		int i;
+		struct conflict_info *ci;
+
+		ASSIGN_AND_VERIFY_CI(ci, mi);
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+			ci->pathnames[i] = fullpath;
+			ci->stages[i].mode = names[i].mode;
+			oidcpy(&ci->stages[i].oid, &names[i].oid);
+		}
+		ci->filemask = filemask;
+		ci->dirmask = dirmask;
+		ci->df_conflict = !!df_conflict;
+		if (dirmask)
+			/*
+			 * Assume is_null for now, but if we have entries
+			 * under the directory then when it is complete in
+			 * write_completed_directory() it'll update this.
+			 * Also, for D/F conflicts, we have to handle the
+			 * directory first, then clear this bit and process
+			 * the file to see how it is handled -- that occurs
+			 * near the top of process_entry().
+			 */
+			mi->is_null = 1;
+	}
+	strmap_put(&opt->priv->paths, fullpath, mi);
+	result->string = fullpath;
+	result->util = mi;
+}
+
 static int collect_merge_info_callback(int n,
 				       unsigned long mask,
 				       unsigned long dirmask,
@@ -215,10 +294,12 @@ static int collect_merge_info_callback(int n,
 	 */
 	struct merge_options *opt = info->data;
 	struct merge_options_internal *opti = opt->priv;
-	struct conflict_info *ci;
+	struct string_list_item pi;  /* Path Info */
+	struct conflict_info *ci; /* typed alias to pi.util (which is void*) */
 	struct name_entry *p;
 	size_t len;
 	char *fullpath;
+	const char *dirname = opti->current_dir_name;
 	unsigned filemask = mask & ~dirmask;
 	unsigned match_mask = 0; /* will be updated below */
 	unsigned mbase_null = !(mask & 1);
@@ -287,13 +368,15 @@ static int collect_merge_info_callback(int n,
 	make_traverse_path(fullpath, len + 1, info, p->path, p->pathlen);
 
 	/*
-	 * TODO: record information about the path other than all zeros,
-	 * so we can resolve later in process_entries.
+	 * Record information about the path so we can resolve later in
+	 * process_entries.
 	 */
-	ci = xcalloc(1, sizeof(struct conflict_info));
-	ci->df_conflict = df_conflict;
+	setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+			names, NULL, 0, df_conflict, filemask, dirmask, 0);
+
+	ci = pi.util;
+	VERIFY_CI(ci);
 	ci->match_mask = match_mask;
-	strmap_put(&opti->paths, fullpath, ci);
 
 	/* If dirmask, recurse into subdirectories */
 	if (dirmask) {
@@ -337,7 +420,7 @@ static int collect_merge_info_callback(int n,
 		}
 
 		original_dir_name = opti->current_dir_name;
-		opti->current_dir_name = fullpath;
+		opti->current_dir_name = pi.string;
 		ret = traverse_trees(NULL, 3, t, &newinfo);
 		opti->current_dir_name = original_dir_name;
 
-- 
gitgitgadget

