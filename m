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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74565C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 00:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4014364EC9
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 00:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhBWX7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbhBWXro (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 18:47:44 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EBEC0617AB
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:16 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v15so130749wrx.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=l/z2OvLd3svp846r/v6fGN490jMZ+a4VTznQAsWEl60=;
        b=kFF9C2j5ITKsKvA6ZZOcbgQb+VYSUuG9zQzn3BQBxb+pWSjBmf0Y/FWpNRpILahEBc
         fMJdG4kOCdAIV3ts+8sImmnTOSDEF6TPEqknMHUd7BP4q2Lh6TRayC5mH3318m3zwIAz
         UJqYJQZJ5P6MB7D/7YsLQWqGEzyWUuJeEDr29M7r2G8xif8Vk57NZvAk9UgYUCu9/shP
         YIOaCAPjnurTMEfJFRozKvm+SaU3J1MNAGe15AU6VE71aJ3mekornicZRUOFzC14M/7M
         tCsyRIt4j1MbY11Vkl5WZMEgYNgFJwAl1p+bwaQkIHyhS8PUkaATyy7t3741XcSs4iRd
         Wc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=l/z2OvLd3svp846r/v6fGN490jMZ+a4VTznQAsWEl60=;
        b=ntfigzS2y4JHK52nlJw8iLWhwR2pPAnN6mKyxMbrccGmtD3Sj0lEPXB8klIDnGmPUe
         SEO3CgjDIbCySX9kaf4efdswcDPBsWn5vhQnOrm0p5y7ZqlFs5hrTbmlxqb3QgjLZk7w
         VVljJQ/My8eyGYOnwCG1zVWoWgQskvnEtI53qwlCzp8xW+xY97eReIgduFMhsm/+Qv4N
         d9tRT64bWESDdbxLjyS18HGgQbB54PaXFC8+t/5ccZAblCsrKzrGediAPYIM0ptjVaU2
         YzE3oaZam/RAzW6bkMwvcQgd8hBXUxg4WJt0qCkyolFXeCRtvI+EDrYaP5x0YoCXA07P
         LjRQ==
X-Gm-Message-State: AOAM530d4cnWmFMBm0wvNgSRV79EVurmbKm8T1Lvu0x2rBV8ckeK2vf/
        hIpB5Fpd6r94otBBNogZAquQJz2ULIQ=
X-Google-Smtp-Source: ABdhPJzoXCD6kKA7p0MMq8EqHfkyMqoTXve7HxkOwmWBDrVAyXpgJCF0taIQvEKBItOuE8xxQEfnXQ==
X-Received: by 2002:a05:6000:1542:: with SMTP id 2mr29045767wry.356.1614123855212;
        Tue, 23 Feb 2021 15:44:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10sm366749wrq.22.2021.02.23.15.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:44:14 -0800 (PST)
Message-Id: <805c101cfd849db3a5defb30775c7abbfec99f68.1614123848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
        <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 23:44:07 +0000
Subject: [PATCH v2 10/10] diffcore-rename: use directory rename guided
 basename comparisons
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
