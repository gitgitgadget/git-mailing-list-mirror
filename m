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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C117FC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 02:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E62A64EDB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 02:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBZCAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 21:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhBZB7r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 20:59:47 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9490CC061797
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i9so5867917wml.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=hlYiiGu5GzvWyZmoOfVERsxxquNlU1jD6lle8NKwgrs=;
        b=lyO4esKcarT+TIpjQRAhVY0q0H3jUYBOvnyq4PRfr0qvZQ8r7ApHjEFwa5+5l7Zmd2
         18YQQYLjbCSUqrwAB15fgqVCEmwmWSTSppc4lP6HvqHgSg44iCS22QQ+jJc4ZfHMrItz
         i8CuTexsVW6oYA2A7a/MhOyaDVcXDJqDGOaDZi4LeTOer7U+OSvqTB7qLKmfP0OtgplQ
         ffIZRGBxyr3ntCeKs2MgvY+wI7gX9Bd0UzDG/wmfk1jz/L0k988nq+sg/wOk3cA83Ie9
         MoyA6XCaDF1hh/uci/X/R48QNGWx0La8zdI47ThEqALZOYAXroirFL7HgMANz8QP7+UI
         PCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=hlYiiGu5GzvWyZmoOfVERsxxquNlU1jD6lle8NKwgrs=;
        b=YaZMUozFaskHjfo0ptz25MfYqtt3Xnu3V6uymK4gTN0d1cHMadqKm56fVkRAg98B/d
         UbxQGs1TDtUv4ZgAeWktCHZlQ4k79DtduOwHrmwakUhbH0iXLWE8YLbWiUPes+VYmdzM
         dane8SqFyLJsk9/3HWqw06jPK0NhvbquITu5dVg1Ilbc8BYvtoIwsFdWvH9fhx9oiGPd
         3sCadx1n2fboW5L1fzF6/SF1HfmP0RhFKMP2wG/7DA7R1EtVugdNHhIATU8jfgt9g3C4
         tG6OiK09pSUHHUNpc+Dy9BciWAS1on9OuSY+AC9E7D9DKdoR8SDtfEw6Ji8xG5g3gNSd
         y/nQ==
X-Gm-Message-State: AOAM531pHYojdS9plgqSJxgeozNqckWbc7AR9d4JGCWsn9d7eRGTT2Gu
        OGVwgUWpPnwSCcF3tuGWauEZ7R2iet8=
X-Google-Smtp-Source: ABdhPJyJk60x8z2Fzn5bA354QG3J+Z/6AvhxLAv5LuLV+oukBD7h2ErLKAvedug/8WTwPExevNvoSw==
X-Received: by 2002:a1c:c903:: with SMTP id f3mr396617wmb.69.1614304709385;
        Thu, 25 Feb 2021 17:58:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2sm9361173wml.34.2021.02.25.17.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:58:29 -0800 (PST)
Message-Id: <65f7bfb735f21ff774938b49ba500bf81265db94.1614304700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 01:58:19 +0000
Subject: [PATCH v3 10/10] diffcore-rename: compute dir_rename_guess from
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
