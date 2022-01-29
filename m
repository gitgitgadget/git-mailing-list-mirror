Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25D1C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353035AbiA2SHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352974AbiA2SHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB6FC061749
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:23 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m14so16918466wrg.12
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PlInyUqRBx0ASPfJ5p3RLGlX6fpaPltpQjbFbwbFWcs=;
        b=UN4TpkgSIoh0btUwKqExlcSQoyaggFa2Te8RyObAnVbO3zxEeYiaN47yGSKdseE6M3
         pjhx96IDUHIF4+Bg8+9U47oZwm/wPvl2P1Hav+lj6d6QFW+AqW/Kl8CSXZkaaOq9Wzfi
         p2fHvvJkrrRePS8tr9gbjK4KUg7ujAkdziCHahu4HkP1N0Ogof5SV2IfbSQVXM4fA/ZB
         RcLvs3VcSM7uhqari1Tgsyk4qAauayBL+qzh7IYyY5yDnKgR++jHTODkYGL01XP171hf
         LokKCX3qAxN7VYH4OrkJr/VZtfyodxaTgnhYMdFFFkjlMaptJBIWYczr0R+admzXID1x
         6TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PlInyUqRBx0ASPfJ5p3RLGlX6fpaPltpQjbFbwbFWcs=;
        b=nlHjOHEYckpnjX5VRl46DekSYX/6wwjUa2sqMO5arwRALl2GjrBVvve3lipiD6HMlH
         6O79ARS4gb9TbNBMnsM7sVAUXtfv7oLXL47SBv4WBCncv9FRGndDCvAPeHBjMUzLvWl4
         +RFXE4ZdYL2jb3WqrD3gNY01cT3Ydvv5klEguO2QpCseD6D3GYR8PHCKxa3L3nOFVYqr
         vTjGUugItAtnRMplcx2tfkNiROcT22dvwDsyWQujIBc/1qSabpIU0aS0Ghbs398hI92L
         GxJtKIOrIt1yarv3lXVlBGPl/r+Cg9adv1b8TY7lNOqNOyGg2FyKDLIDUEZCC8UXBdQW
         O9AA==
X-Gm-Message-State: AOAM530c4qOCO0gdTNI5cXIlcrAnyPEmu6HrtemXWUIPDmQzOBqWzYdk
        s28nTlfB0KZWhT6ellUPPdfaw7fYVF0=
X-Google-Smtp-Source: ABdhPJwZxMzpe6iYI4JA8KeR0RZCQJJcx1y9MlEz9gzgumBTzxHvWhCun8BbKr+j/M5isBgrkao/mg==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr11621370wrt.187.1643479642255;
        Sat, 29 Jan 2022 10:07:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm8606362wrm.90.2022.01.29.10.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:21 -0800 (PST)
Message-Id: <9c2334ae9f294b92c0c34b3d13efc2b16eefecb4.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:09 +0000
Subject: [PATCH v2 09/13] merge-ort: provide a merge_get_conflicted_files()
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

