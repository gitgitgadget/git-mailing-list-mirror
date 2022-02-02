Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84525C433FE
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbiBBHfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiBBHfG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:35:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AF8C061755
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s9so36528893wrb.6
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PlInyUqRBx0ASPfJ5p3RLGlX6fpaPltpQjbFbwbFWcs=;
        b=hHijD8mFatRRSzvkW76yjJRTSUcUNNqh98UN2FBZl0fl8Ch2ytDGd5IVC/aZqWv1DE
         AQs19QQS6VWjXbtRDdvDGG7vHG2835LCOLoFLQU5b7/eBNfvQaJlC1HcDZEYJShFt9jJ
         CGBNI5rliBhnsN4G6faooFcSIsFP46aX/LRx7JKoXzRjVepa+fvLqr7UGi/g7pv395UN
         h2I+Id1HJOmAXq5BEN2IHDUFealCSkaPTrkxbxdBtdvv+8+ugwOEaK0UMyz1rVLLg6GT
         JLanSkRW3lMsv6U6vyODsvaYKcsj9Mx3VAcKyJIF3tZY1M/cyyLB7TLsoc7R8zFRMqb9
         zSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PlInyUqRBx0ASPfJ5p3RLGlX6fpaPltpQjbFbwbFWcs=;
        b=L08bfQOjaFLTr9M0HphZQjCAQzOvA2rPkEVB6HObflUrlRFn9wxGk0GA8wLfG30IGA
         voXySCIETtSi7mPf/5cCQ6q2Xk0q86Biw7LqyjF9x/r9ojjwkqU0TFP7e7m1ro/I31oD
         1DHU587T3kheSgAuZBrZFZnjHqhiCighsKVOWB0c17YL/M2flj/0WeabWCa/sPuEqz5C
         RWpmoLTOXFUji0e61qniG+G3rbq0ZLyI0Ac8lezpMjyxevJ+37lO8WcvAoFYOesJVVWR
         A2OCMPehnlLk9qM4VjyiHNYYEV1HgYWxdIKaNMg8bc3awauLqvAip7QNbJd56AEpaHXx
         8B2g==
X-Gm-Message-State: AOAM532yfbf03HwhiWt/Qc0wN409DOS0ceVg4V9pyZFnkFEc5NtTIy5o
        1Jy7ydj2O9PWRvr0R0DEsKyOqlKUt58=
X-Google-Smtp-Source: ABdhPJySzK4rxhT9r+C9b7LxwtecuENaMTIBoEfy5b2jfja8DEDNkHfi+Ft+5pOr7Bz1KFyBjhU6cw==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr24486530wrv.44.1643787291783;
        Tue, 01 Feb 2022 23:34:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3sm16184981wru.33.2022.02.01.23.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:51 -0800 (PST)
Message-Id: <1c2a3f5ef63cbc8ac5a61c97e42cc4cce55ee663.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:36 +0000
Subject: [PATCH v3 10/15] merge-ort: provide a merge_get_conflicted_files()
 helper function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

After a merge, this function allows the user to extract the same
information that would be printed by `ls-files -u`, which means
files with their mode, oid, and stage.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 31 +++++++++++++++++++++++++++++++
 merge-ort.h | 21 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index d28d1721d14..c4ce6027dc4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4275,6 +4275,37 @@ void merge_display_update_messages(struct merge_options *opt,
 	trace2_region_leave("merge", "display messages", opt->repo);
 }
 
+void merge_get_conflicted_files(struct merge_result *result,
+				struct string_list *conflicted_files)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	struct merge_options_internal *opti = result->priv;
+
+	strmap_for_each_entry(&opti->conflicted, &iter, e) {
+		const char *path = e->key;
+		struct conflict_info *ci = e->value;
+		int i;
+
+		VERIFY_CI(ci);
+
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+			struct stage_info *si;
+
+			if (!(ci->filemask & (1ul << i)))
+				continue;
+
+			si = xmalloc(sizeof(*si));
+			si->stage = i+1;
+			si->mode = ci->stages[i].mode;
+			oidcpy(&si->oid, &ci->stages[i].oid);
+			string_list_append(conflicted_files, path)->util = si;
+		}
+	}
+	/* string_list_sort() uses a stable sort, so we're good */
+	string_list_sort(conflicted_files);
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
diff --git a/merge-ort.h b/merge-ort.h
index d643b47cb7c..e635a294ea8 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -2,6 +2,7 @@
 #define MERGE_ORT_H
 
 #include "merge-recursive.h"
+#include "hash.h"
 
 struct commit;
 struct tree;
@@ -89,6 +90,26 @@ void merge_display_update_messages(struct merge_options *opt,
 				   struct merge_result *result,
 				   FILE *stream);
 
+struct stage_info {
+	struct object_id oid;
+	int mode;
+	int stage;
+};
+
+/*
+ * Provide a list of path -> {struct stage_info*} mappings for
+ * all conflicted files.  Note that each path could appear up to three
+ * times in the list, corresponding to 3 different stage entries.  In short,
+ * this basically provides the info that would be printed by `ls-files -u`.
+ *
+ * result should have been populated by a call to
+ * one of the merge_incore_[non]recursive() functions.
+ *
+ * conflicted_files should be empty before calling this function.
+ */
+void merge_get_conflicted_files(struct merge_result *result,
+				struct string_list *conflicted_files);
+
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result);
-- 
gitgitgadget

