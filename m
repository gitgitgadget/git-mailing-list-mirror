Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875FEC433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiAVV40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiAVV4N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DF2C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so25028382wmb.5
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=miSP13fT2WRghhWNZAPyivn3ZVoYRAB2zZZ4g5L4sZA=;
        b=XP330X3Fl14M8pNhLvuRPVdxbsQPFy1PwxA/Mw1OiwPexCnJprriTHSm5vHeUks4jo
         MYMnrJ5IVRxqwd/tG1dOqNk3TrhIvAGheoybDQZBAzvs2UwpNqAILT5nm2z9ZocWRoCA
         C6LnY6DjKEy9+hm/fiLJ4QgK6Z9O8x+RZJDnIjUgx1Ta9TLJUyMlp/UQi0hIzbV2sTM8
         k3CtWdZI39ccbHtJ4XACWQ9vndOusCTRrEanc3WJVaeT0bD+6+HeV+b7ionaVtF1phKm
         IDOSmk5pwX5pY7YWXiEemmyTb8+CEQb5XijEjeCrhILUPMaQpvLp3qd+CWJo4WR1xObg
         Vpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=miSP13fT2WRghhWNZAPyivn3ZVoYRAB2zZZ4g5L4sZA=;
        b=MwS6sWmSPIHrMjZKZ1SaBY1lVnF7U1T5B1FADadpcEGQW9OJbgBEN3xWh0Jsnf49qw
         1gzLKadNmlGlf0zuAbE1KeLHZ65etk9PDGnaU/Hbe/p1Zi2JxjcJpc3Llz6LH9DLWyhf
         am2JNW6JF7Fa5EYj/L06mckaVJwD6x6vq9rU8dqicRq9/uIXFbMT36PITX1z5ueQFstO
         p0lMhTkXoSDezUy5v9VnIDNXGyh1sLLZL31dgO4twYR7ApWx/S2bLNMYMfECUQUWxWIM
         AnrdebFtfYHnL8XpD1gRg66l4vvPtffL4/es81v+davCROkwtPGblhXkonGFGH3Lsmdu
         e7iw==
X-Gm-Message-State: AOAM531LNmK0SFaibE6bi95qFQpmavC2Tsp1p92gET5w+uw6jZpdMikC
        +qhVfKOqJH4yZLkFUCc8Th8pGvGAZAE=
X-Google-Smtp-Source: ABdhPJzDYA2E64I98NNsPu0vLMOzQkjfIKBfSaqEUjLFFC6EESKFhm0lIaWcpCSV6YfYTuJd/2LRMQ==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr5817632wmc.70.1642888571465;
        Sat, 22 Jan 2022 13:56:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm9764100wrm.58.2022.01.22.13.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:11 -0800 (PST)
Message-Id: <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:55:58 +0000
Subject: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
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
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

After a merge, this function allows the user to extract the same
information that would be printed by `ls-files -u` -- conflicted
files with their mode, oid, and stage.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 31 +++++++++++++++++++++++++++++++
 merge-ort.h | 21 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index b78dde55ad9..5e7cea6cc8f 100644
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

