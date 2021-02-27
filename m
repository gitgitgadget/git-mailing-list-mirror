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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E01C433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67F264E4E
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhB0Acx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhB0AcR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:32:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7C1C0617A7
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:58 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 7so10230833wrz.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=I83zAEQWb0N/xYVhJPMdPGessk611TnJHpITpVbcPHk=;
        b=EQN8RdWXzJIyYH9TJVcansbFINOpczugV5j0jt8MKLLcog+blKZn0Jts2NhC+bLeVY
         uVQSqZgOXxa9kyQWQw6CuN/McvN+kyg50s3ce0ntu9SJCE8kDqB3vgGETc1G8MllI1tb
         6oJdNyIKhnX7BwBt0eHMQd3JVsUwThmmzIsLWFfQMSv9zQcK8QdeqwENz6hRNu8MwZ6b
         jsaaokPR49moiUbvIuoCuLIxqcWT0aqTPtHBJPmDevJbMlp/ACv8e0onKmlLPMGX5s9Z
         y2gt34uf4Z9qtjP+HHluxulMGQVqnimCLyNhwmmY4QvI9Ie/N7HImS+tPupo8Dj7BGLj
         csYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=I83zAEQWb0N/xYVhJPMdPGessk611TnJHpITpVbcPHk=;
        b=iOQmIHJPj1kcth/17BQIGEzEyLIE3QxgjQuG3tUI+aJlDDzY6Eq56EOoQYfcd2sqs5
         pZJvYGcnA7xFALbN7LdKFgd6z9zaWBWdOnbyIomJ9Kw6XUUB8I2j91T22wQX/3hlPkLZ
         WOlkuefw4bmRoKlOS5/CIK1h4wsD0553TH4gks+R/FZvFdGRQTXUCpUqrdXiYgNPmf47
         4zla0SRa1XHbpZ50Bow8amy9vrdd3a7BGLKmLyUY3LUjRU6yROiXnx8ZFyeq+nCuODSc
         LhvC8eoshNUg0BsvVpXobVpgWCGQ2gsAcil1wvZvLGfK1qlY9HYF1TUb/vaq2WvAvDt5
         3Bxw==
X-Gm-Message-State: AOAM532KcpSPlddZ7KENjMupC+QuBcBsmT1N84Pxgbo17PlOcLdJod2Z
        ymhK5Xfcq6E3l9scxOlRENqtA26PngQ=
X-Google-Smtp-Source: ABdhPJxQA4pclA0hhoKC7ewatjbpcYiRhW99QFYqebbFlQG3frpkpuMpfcgXq1+p05mDHOT4jpba8w==
X-Received: by 2002:a5d:4e0e:: with SMTP id p14mr5580946wrt.130.1614385857135;
        Fri, 26 Feb 2021 16:30:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm14348825wrt.21.2021.02.26.16.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:56 -0800 (PST)
Message-Id: <4be565c472088d4144063b736308bf2a57331f45.1614385849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
        <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:48 +0000
Subject: [PATCH v4 10/10] diffcore-rename: compute dir_rename_guess from
 dir_rename_counts
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

dir_rename_counts has a mapping of a mapping, in particular, it has
   old_dir => { new_dir => count }
We want a simple mapping of
   old_dir => new_dir
based on which new_dir had the highest count for a given old_dir.
Compute this and store it in dir_rename_guess.

This is the final piece of the puzzle needed to make our guesses at
which directory files have been moved to when basenames aren't unique.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       12.775 s ±  0.062 s    12.596 s ±  0.061 s
    mega-renames:    188.754 s ±  0.284 s   130.465 s ±  0.259 s
    just-one-mega:     5.599 s ±  0.019 s     3.958 s ±  0.010 s

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index e5fa0cb555dd..1fe902ed2af0 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -389,6 +389,24 @@ static void dirname_munge(char *filename)
 	*slash = '\0';
 }
 
+static const char *get_highest_rename_path(struct strintmap *counts)
+{
+	int highest_count = 0;
+	const char *highest_destination_dir = NULL;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	strintmap_for_each_entry(counts, &iter, entry) {
+		const char *destination_dir = entry->key;
+		intptr_t count = (intptr_t)entry->value;
+		if (count > highest_count) {
+			highest_count = count;
+			highest_destination_dir = destination_dir;
+		}
+	}
+	return highest_destination_dir;
+}
+
 static void increment_count(struct dir_rename_info *info,
 			    char *old_dir,
 			    char *new_dir)
@@ -512,6 +530,8 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 				       struct strset *dirs_removed,
 				       struct strmap *dir_rename_count)
 {
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
 	int i;
 
 	if (!dirs_removed) {
@@ -558,6 +578,23 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 					 rename_dst[i].p->one->path,
 					 rename_dst[i].p->two->path);
 	}
+
+	/*
+	 * Now we collapse
+	 *    dir_rename_count: old_directory -> {new_directory -> count}
+	 * down to
+	 *    dir_rename_guess: old_directory -> best_new_directory
+	 * where best_new_directory is the one with the highest count.
+	 */
+	strmap_for_each_entry(info->dir_rename_count, &iter, entry) {
+		/* entry->key is source_dir */
+		struct strintmap *counts = entry->value;
+		char *best_newdir;
+
+		best_newdir = xstrdup(get_highest_rename_path(counts));
+		strmap_put(&info->dir_rename_guess, entry->key,
+			   best_newdir);
+	}
 }
 
 void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
@@ -682,10 +719,10 @@ static int idx_possible_rename(char *filename, struct dir_rename_info *info)
 	 *       rename.
 	 *
 	 * This function, idx_possible_rename(), is only responsible for (4).
-	 * The conditions/steps in (1)-(3) will be handled via setting up
-	 * dir_rename_count and dir_rename_guess in a future
-	 * initialize_dir_rename_info() function.  Steps (0) and (5) are
-	 * handled by the caller of this function.
+	 * The conditions/steps in (1)-(3) are handled via setting up
+	 * dir_rename_count and dir_rename_guess in
+	 * initialize_dir_rename_info().  Steps (0) and (5) are handled by
+	 * the caller of this function.
 	 */
 	char *old_dir, *new_dir;
 	struct strbuf new_path = STRBUF_INIT;
-- 
gitgitgadget
