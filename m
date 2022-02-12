Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E4AC433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiBLUfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiBLUfG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:06 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B814606E8
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so6910243wrg.11
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ap4ZqYlnkgb+ZsEVT3Um4/EicxMnYbd2hGinYTe7EAw=;
        b=HkwDNONTQHTCmGfa92iYdZA6Dd9zV5cyXxSJBhmQSQTO6Ki9ntGvUu10qa3zmoifec
         skxJZlxMexnzOdcJxOuAPZPlNIeZunSwVH0c5/mkH60YrkteDBJXLzfzC7rtcoh1TWIw
         HPcujELjUQ/X2QZ++YTHDn8Wa9nMHN+Tbo5303uSjtYf31jKDX1q0TwGklzPoy2Nj9H5
         AAem9Om1HR5c7jBDYQDBOVY+sbleljYMLrwCuHGR2mgIJWhJuDFiLyZYrMqLZRliyu1/
         uYqdfC9zGCFlkIzgwXPjQr1rnoDyPskrqObq2HUXEgDdI5yRjWZft8q1epr8ttQ9/rX6
         7k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ap4ZqYlnkgb+ZsEVT3Um4/EicxMnYbd2hGinYTe7EAw=;
        b=JK+1+vCRkHnoFT+x2dTYQZNvoMvCWkAxl9iJp3Akd6CC/ypNNWyHrVMwHKTunABXE5
         0TwJ8AvVW3OV04zEWHc2LxXEmREd4PIX+2XgChlAdH40ZTj0mgLjf6EkqsqjdDObHAzL
         Xa4qXQomT1tt+tu5dn0ToldSpABzqiNryWSqfFJ99mSbL1cc9DGi1yut1tjEI2nI4zS6
         0bJHwBlSx5kF/py26xMC8fQUF6c4mfCO5GGZirfd/sf2FY9hq8/poX7/nImK2isljtWv
         kEpjolx5BfgdhvL3tVSjMCfikDocPARd+sKepVAiGPGbDCGdBbmmBoeuZccHvIGFr4fR
         mvJQ==
X-Gm-Message-State: AOAM532q1ECWVv7Iqs6mrcKt1SwVa4agS4dLD4oo+cwsngxrjEwg5BYj
        OJ+EmGNZy1CFd1Y+KSWrUcSYv3/NF1g=
X-Google-Smtp-Source: ABdhPJzGo34LPIGcNFWwTLQmRkv0T3/90GUJx7VQEq3nxGf2Fixg3a+jxL0Euu1O2TfWxZjTERf64Q==
X-Received: by 2002:a05:6000:2c8:: with SMTP id o8mr5917811wry.663.1644698100503;
        Sat, 12 Feb 2022 12:35:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14sm9507471wri.93.2022.02.12.12.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:35:00 -0800 (PST)
Message-Id: <f3ad7add5154d9d33291df997350b2b5db88260e.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:48 +0000
Subject: [PATCH v4 07/12] merge-ort: provide a merge_get_conflicted_files()
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
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
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
index ebaed98d53a..e1b647b0a40 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4274,6 +4274,37 @@ void merge_display_update_messages(struct merge_options *opt,
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
index e5aec45b18f..ddcc39d7270 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -2,6 +2,7 @@
 #define MERGE_ORT_H
 
 #include "merge-recursive.h"
+#include "hash.h"
 
 struct commit;
 struct tree;
@@ -88,6 +89,26 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_display_update_messages(struct merge_options *opt,
 				   struct merge_result *result);
 
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

