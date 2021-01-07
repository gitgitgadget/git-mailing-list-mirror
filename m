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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E0AC4332B
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17DB23718
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbhAGVhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbhAGVhM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:12 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06EEC0612FE
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q18so7062528wrn.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b2Tke+PYbrPjdh/VepLSu52qSdEUam57Tg136FE7V/g=;
        b=A//8T4IUJtSAYCTRVKMBNp1Dzq9b6PLivsC3MR+1c7T7QAOz8Xp0qe8pB4jGQQqcbM
         YlKFN99EWsmn3Oimvsnr6HJQ64rdlNTZBq/3bkcViiLusUpxqiANYSO9fodEHLcKE4R0
         Sr8uWFRBSNXYpa8N0x4fC9HwJ9UF/HKTMVvhJa+JwFX9ggwSKRB7/4nau0VkfyRpHlKs
         4kl85Ur16tQt6LyIzFgRVtSN2/gBFOAcdJ5wzm8C9KB+fhBlY6sNdiQlFCje+IGe10SZ
         tZygoXpiTrSxsLowrW+HSGdXIMp0gT+n/Q+z59qCtbzpagnsfx7IhJL8sYGVQ85qgNjU
         3jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b2Tke+PYbrPjdh/VepLSu52qSdEUam57Tg136FE7V/g=;
        b=eY+MbOvK42KCU18UGzYmFhkQzaemb38rzy6jaLo1gAMQREGYfQNER4o0VKkmCYLzG9
         42FE3pOk2Y6YNHrNiWKAHFhT9ZFwsrq79ogjoeO4sgkYf8t/wBVDDBexfz2tZO9O8flY
         XmuW1w463hvy/fG/hhCtU+Fg4FhwWYS2kKxMO+i9z3vehT7bhRqN7gG4DSEwjShTXS05
         FGdo0uesCW5v/k42Pa+MHqbCw6IndbuEkOUFcdPJ7sNJ2Lzr4mm7ZeMvaO89O9O/+pWe
         NVpJMVR9VwZHxIHdYaCwaLqKvmSMM69M+yB9e3aFaeOjpz4RvfCqJOfWMSBp0SJ/I/2v
         wmBA==
X-Gm-Message-State: AOAM531T/xw25uFM+y6fBxEsgoA0J2FDAwrmhs/2AmAgT+d1H+HOViCh
        Qn8IubRbjfONXRVxQuC2f3HO06fIQug=
X-Google-Smtp-Source: ABdhPJycHXQoNrYlGTsZFixYXW4q8kQL47T3GEEaTb7gy2dEWhxs+3nPnX54wRrqx2dJdkf/1qMkzA==
X-Received: by 2002:adf:dd11:: with SMTP id a17mr545044wrm.360.1610055373320;
        Thu, 07 Jan 2021 13:36:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1sm9785101wrr.48.2021.01.07.13.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:12 -0800 (PST)
Message-Id: <bb4285250cdef2fcd16a22f8540968c871302c9f.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:35:53 +0000
Subject: [PATCH v2 05/17] merge-ort: add outline of
 get_provisional_directory_renames()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This function is based on merge-recursive.c's get_directory_renames(),
except that the first half has been split out into a not-yet-implemented
compute_rename_counts().  The primary difference here is our lack of the
non_unique_new_dir boolean in our strmap.  The lack of that field will
at first cause us to fail testcase 2b of t6423; however, future
optimizations will obviate the need for that ugly field so we have just
left it out.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 378ac495d09..73d3ff97f52 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -721,11 +721,69 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to directory rename detection ***/
 
+static void compute_rename_counts(struct diff_queue_struct *pairs,
+				  struct strmap *dir_rename_count,
+				  struct strset *dirs_removed)
+{
+	die("Not yet implemented!");
+}
+
 static void get_provisional_directory_renames(struct merge_options *opt,
 					      unsigned side,
 					      int *clean)
 {
-	die("Not yet implemented!");
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	struct rename_info *renames = &opt->priv->renames;
+
+	compute_rename_counts(&renames->pairs[side],
+			      &renames->dir_rename_count[side],
+			      &renames->dirs_removed[side]);
+	/*
+	 * Collapse
+	 *    dir_rename_count: old_directory -> {new_directory -> count}
+	 * down to
+	 *    dir_renames: old_directory -> best_new_directory
+	 * where best_new_directory is the one with the unique highest count.
+	 */
+	strmap_for_each_entry(&renames->dir_rename_count[side], &iter, entry) {
+		const char *source_dir = entry->key;
+		struct strintmap *counts = entry->value;
+		struct hashmap_iter count_iter;
+		struct strmap_entry *count_entry;
+		int max = 0;
+		int bad_max = 0;
+		const char *best = NULL;
+
+		strintmap_for_each_entry(counts, &count_iter, count_entry) {
+			const char *target_dir = count_entry->key;
+			intptr_t count = (intptr_t)count_entry->value;
+
+			if (count == max)
+				bad_max = max;
+			else if (count > max) {
+				max = count;
+				best = target_dir;
+			}
+		}
+
+		if (max == 0)
+			continue;
+
+		if (bad_max == max) {
+			path_msg(opt, source_dir, 0,
+			       _("CONFLICT (directory rename split): "
+				 "Unclear where to rename %s to; it was "
+				 "renamed to multiple other directories, with "
+				 "no destination getting a majority of the "
+				 "files."),
+			       source_dir);
+			*clean &= 0;
+		} else {
+			strmap_put(&renames->dir_renames[side],
+				   source_dir, (void*)best);
+		}
+	}
 }
 
 static void handle_directory_level_conflicts(struct merge_options *opt)
-- 
gitgitgadget

