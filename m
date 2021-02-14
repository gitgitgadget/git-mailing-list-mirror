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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C93EC433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8B164E26
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhBNIBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 03:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBNIAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 03:00:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A054C061797
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v1so4885603wrd.6
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=l/z2OvLd3svp846r/v6fGN490jMZ+a4VTznQAsWEl60=;
        b=tNLxzPaAbv464yhBh0BhMjWC8DCHXQCnjd/7tpM0DfVsePduCkQ2Y3lqAADSv6b7vZ
         xK3bDmqZ5TD9MYTgfmLPBs73Wqo8ndjlnPBtuWjTzK1AHcwQIoCkkJ+42A+aZvWNYgah
         ceVlXkeHvLWmNJ7L3fu4LiLUfTWeaEg2q1krm7BP+5pDVwPJkR2d4Jdai9CPVDM/0IsW
         nVSnDfRN0Yv+yrIeYvkW0fSkx45PDOh9gsAF1ZtK61QaC0yqbh1ok6PPGsPqG5OOJSgr
         aBCurQVndbeJ01XuKxqLHWmJnhDa439a741g9Yi682cjQsLDFsfMA9/uTdaAdMzII8j0
         M0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=l/z2OvLd3svp846r/v6fGN490jMZ+a4VTznQAsWEl60=;
        b=sjcEVbGjLMCdbFTO4kPD61tiIKVvKo3dB0ySxTO/Ua0xBoloh8l9gIWwTZ2TRhn3w/
         TRIYzGKzVnNHPTmiN37cBDrbr1LqtFJsZabCDvlfyCRk4Mz/RBQzzlxCuXnSnBo2fc0k
         b8uDs+x9ifKJI6xKczcZJaz/CS3AhXa21+d+l6K/nhxfIxC4QTizNwohlyXxYAs2CFPj
         xMBLGTlm4OUp+e4Ce4JPJUdwyPTaWaRMStGJWS3QZx+ErZ1tfiJmXLJrKWv82bHOoFjG
         lxcyiDs/sSN4bJbT0y6f61OZGOvHiTqS4wGOE620DuqiWD8+TzFznw6sXCMuRORevDBQ
         eAGw==
X-Gm-Message-State: AOAM532vDnmim5toCbE+EFJtIyNlLCSz6KLOxMElcJzByTNJuQ0mMS5C
        uzthMUsuBvwIk5mC/jL3Nr2Tbg0ZJ0Y=
X-Google-Smtp-Source: ABdhPJyVKn0RcF91G23Tc/KaZVW8gXqq7Gxc/lh90Xyg2bifA5Ae2LL3LAn7kMay/++69fzUZc+gFA==
X-Received: by 2002:a5d:680e:: with SMTP id w14mr9906762wru.322.1613289550956;
        Sat, 13 Feb 2021 23:59:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z66sm1759839wmg.39.2021.02.13.23.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:59:10 -0800 (PST)
Message-Id: <1df498b3a2f00cdcbe93acda1dc637e3fca0ee0b.1613289544.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.git.1613289544.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:59:03 +0000
Subject: [PATCH 10/10] diffcore-rename: use directory rename guided basename
 comparisons
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Hook the work from the last several patches together so that when
basenames in the sets of possible remaining rename sources or
destinations aren't unique, we can guess which directory source files
were renamed into.  When that guess gives us a pairing of files, and
those files are sufficiently similar, we record the two files as a
rename and remove them from the large matrix of comparisons for inexact
rename detection.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       12.775 s ±  0.062 s    12.596 s ±  0.061 s
    mega-renames:    188.754 s ±  0.284 s   130.465 s ±  0.259 s
    just-one-mega:     5.599 s ±  0.019 s     3.958 s ±  0.010 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/gitdiffcore.txt |  2 +-
 diffcore-rename.c             | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 80fcf9542441..8673a5c5b2f2 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -186,7 +186,7 @@ mark a file pair as a rename and stop considering other candidates for
 better matches.  At most, one comparison is done per file in this
 preliminary pass; so if there are several remaining ext.txt files
 throughout the directory hierarchy after exact rename detection, this
-preliminary step will be skipped for those files.
+preliminary step may be skipped for those files.
 
 Note.  When the "-C" option is used with `--find-copies-harder`
 option, 'git diff-{asterisk}' commands feed unmodified filepairs to
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 5de4497e04fa..70a484b9b63e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -667,7 +667,6 @@ static const char *get_basename(const char *filename)
 	return base ? base + 1 : filename;
 }
 
-MAYBE_UNUSED
 static int idx_possible_rename(char *filename, struct dir_rename_info *info)
 {
 	/*
@@ -780,8 +779,6 @@ static int find_basename_matches(struct diff_options *options,
 	int i, renames = 0;
 	struct strintmap sources;
 	struct strintmap dests;
-	struct hashmap_iter iter;
-	struct strmap_entry *entry;
 
 	/*
 	 * The prefeteching stuff wants to know if it can skip prefetching
@@ -831,17 +828,34 @@ static int find_basename_matches(struct diff_options *options,
 	}
 
 	/* Now look for basename matchups and do similarity estimation */
-	strintmap_for_each_entry(&sources, &iter, entry) {
-		const char *base = entry->key;
-		intptr_t src_index = (intptr_t)entry->value;
+	for (i = 0; i < rename_src_nr; ++i) {
+		char *filename = rename_src[i].p->one->path;
+		const char *base = NULL;
+		intptr_t src_index;
 		intptr_t dst_index;
-		if (src_index == -1)
-			continue;
 
-		if (0 <= (dst_index = strintmap_get(&dests, base))) {
+		/* Is this basename unique among remaining sources? */
+		base = get_basename(filename);
+		src_index = strintmap_get(&sources, base);
+		assert(src_index == -1 || src_index == i);
+
+		if (strintmap_contains(&dests, base)) {
 			struct diff_filespec *one, *two;
 			int score;
 
+			/* Find a matching destination, if possible */
+			dst_index = strintmap_get(&dests, base);
+			if (src_index == -1 || dst_index == -1) {
+				src_index = i;
+				dst_index = idx_possible_rename(filename, info);
+			}
+			if (dst_index == -1)
+				continue;
+
+			/* Ignore this dest if already used in a rename */
+			if (rename_dst[dst_index].is_rename)
+				continue; /* already used previously */
+
 			/* Estimate the similarity */
 			one = rename_src[src_index].p->one;
 			two = rename_dst[dst_index].p->two;
-- 
gitgitgadget
