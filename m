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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC4DC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55A623110
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392234AbhASTzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392020AbhASTzD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:03 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E77C0613D3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w5so20899107wrm.11
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BvTRjOzh3Pg8M4PKYrxaJ5Hkk6dQATHE8vqGsjvL+C0=;
        b=ZnIumjkNkgeovotm8rkHC1FxtvFY7gW/uAd7cmIAcL9WKK4ombEOomEkontBjR96xP
         R8A7iglIMg3aT99uPBon/UxREpt32cPFIXOarUwOVP9RssFce1fDtKk7t7n3JGIqV8Eg
         9KXkyLS+IN/CLpZl20lhcgiR2sNuX2hzuigWMdB3fNz5W7LhROwQvYrKkxVuQt10grOI
         o+hMhYiYYw7F2SO7Pr1BceDgL+Hub4D0rr4nikPMmZUG0fOw2Q11+TA2CLim28nBNLXZ
         pZw1pBTE7GzWqgcyS6V8oTyxnT6wi61AxnvKagQrh7YkUXrcYZ6ISrFg3HJhjI5j8KnV
         YYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BvTRjOzh3Pg8M4PKYrxaJ5Hkk6dQATHE8vqGsjvL+C0=;
        b=CnBjNYgGGW/JAC/K5dS0ZbxS4iioPXJQPo4dmNikLunKB20F6EJXdoVNdp0STov4bY
         FqfkZrD+O1+ypHdzksK+S4pbHwqxdf5dvN+WbVJYeyrpDI2pA4DIFUJBoJaq+oMUyApU
         xQkgROXT+UoDW+kKHcdill7CGJ7nk85OMWKs3oezGk8EdCywXa3a2UsZf/gVqTL6AYa7
         hfYy8yguDrdhPG0xDEuD8V5SXv2CY4xnv4RLxFtdGdpqAqpzwaK3jDQR7iziLu1shHKz
         jWwdvknGTc30JLh0ALMlLQWJ2jcuoIyiKhp8igkqblhmuO/FtEa2XhzQsdBLMmYcQbRm
         W5Nw==
X-Gm-Message-State: AOAM532P9XKMXF+tc4NuhbkTYQK7bEzGEtKWQHmjEQyytwIULcADq7qI
        RPpW86ZJvfAaxzQL9Ry4No69tRgpfN4=
X-Google-Smtp-Source: ABdhPJwPuIE+wcdX3x/GeVKLg9UlI+OLQW8REHj5a/Z/m5vJNodz5sBF0BUdRncUrjdD5daYsAH1Ig==
X-Received: by 2002:a5d:6686:: with SMTP id l6mr5896630wru.236.1611086039187;
        Tue, 19 Jan 2021 11:53:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm37925955wrs.34.2021.01.19.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:53:58 -0800 (PST)
Message-Id: <b008ba357121638e27148eb833ed0da52bebf92c.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:41 +0000
Subject: [PATCH v3 05/17] merge-ort: add outline of
 get_provisional_directory_renames()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
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
 merge-ort.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index b4c1fe28a5c..2a1c62c533b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -721,11 +721,66 @@ static int handle_content_merge(struct merge_options *opt,
 
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
+		if (bad_max == max) {
+			path_msg(opt, source_dir, 0,
+			       _("CONFLICT (directory rename split): "
+				 "Unclear where to rename %s to; it was "
+				 "renamed to multiple other directories, with "
+				 "no destination getting a majority of the "
+				 "files."),
+			       source_dir);
+			*clean = 0;
+		} else {
+			strmap_put(&renames->dir_renames[side],
+				   source_dir, (void*)best);
+		}
+	}
 }
 
 static void handle_directory_level_conflicts(struct merge_options *opt)
-- 
gitgitgadget

