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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92232C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCA764F14
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBZB7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBZB7F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 20:59:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F97C06174A
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so7084843wry.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UWz059XO4uQI0ZR7ZOjx2U0JfmepuJIpi35pcbhyZUo=;
        b=jm/4i2YjJjfi6gKiQrBa/ceNM1XshQaPC5kwN2vgRbiLS2jEiRq92s4ZLTz5uBTZ5w
         RrNVk95SGYa63twmarTC9Tq10jt+DpUSExbfrftpn853s0fs4giiZWBBSW151zCebssv
         bXeMmf7wAzSs9qkjUyUydnHXDEZsEtrPO31bFHxIpB51Vvhxm04DHI44xZPe/3rTivl4
         MEkHX+xv/oFQ3WDMAuBopd9Tz1yUwyj4Ho33IG0zFDAAtSqgAcHFSuTjj+9KgsMlQnT1
         BdzxlkSa8wnC9Clw3mfGWgKn5kYNj1lE7Qn8mh4Y/OVhin7Q/VFZqRl+Vgj74EkNdJHG
         Qp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UWz059XO4uQI0ZR7ZOjx2U0JfmepuJIpi35pcbhyZUo=;
        b=flfLPXVhd/0qcyKv5jjKjaQCqsCnvwtLZ4yKhMo1ZntQn/8sMWmlfh+loao3pyPln8
         +L+imi8QJE7U9q5pM/R7P6xnUWsAjQNqMgqeedLR2rA6CsI/TOOzahyOjUGIzp2oLjvZ
         54oIaPCKXnwr3BGza/8AzkzdIDpzB5MZblQwf+a0hjOt2H/QOkxS3gN43hihVIDUFQbl
         NqutBp0JqlPNDK1T2toMKwFQFpAZkkG/SJ5GqRKHehZx5bhLdqvOg3+d1nYWaucuJXJD
         AlQuL4/YFxFrpIySPPKes0rvQ2G/Uk/sQomIYIEWutiIlejqqZDgRSPhDRasE3zJTXEr
         c11A==
X-Gm-Message-State: AOAM531zdXtj1q4T+VFWP3AcvjejzjQUQgnyIwILTDi1WUk57huLeSjw
        eewRkPsyPapblFIRRUFUtFx/UdainIw=
X-Google-Smtp-Source: ABdhPJxUNOt+RCkVaNZQJS3Fip9QA8FHxaUnXbTGxkSXnEN6fRBfph/qg4h+bIAtWGHPFlvwvScgAA==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr712105wrw.148.1614304703313;
        Thu, 25 Feb 2021 17:58:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 75sm10393974wma.23.2021.02.25.17.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:58:22 -0800 (PST)
Message-Id: <6afa9add40b9cc75c284c480d3048b0e32e8198a.1614304700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 01:58:10 +0000
Subject: [PATCH v3 01/10] diffcore-rename: use directory rename guided
 basename comparisons
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

A previous commit noted that it is very common for people to move files
across directories while keeping their filename the same.  The last few
commits took advantage of this and showed that we can accelerate rename
detection significantly using basenames; since files with the same
basename serve as likely rename candidates, we can check those first and
remove them from the rename candidate pool if they are sufficiently
similar.

Unfortunately, the previous optimization was limited by the fact that
the remaining basenames after exact rename detection are not always
unique.  Many repositories have hundreds of build files with the same
name (e.g. Makefile, .gitignore, build.gradle, etc.), and may even have
hundreds of source files with the same name.  (For example, the linux
kernel has 100 setup.c, 87 irq.c, and 112 core.c files.  A repository at
$DAYJOB has a lot of ObjectFactory.java and Plugin.java files).

For these files with non-unique basenames, we are faced with the task of
attempting to determine or guess which directory they may have been
relocated to.  Such a task is precisely the job of directory rename
detection.  However, there are two catches: (1) the directory rename
detection code has traditionally been part of the merge machinery rather
than diffcore-rename.c, and (2) directory rename detection currently
runs after regular rename detection is complete.  The 1st catch is just
an implementation issue that can be overcome by some code shuffling.
The 2nd requires us to add a further approximation: we only have access
to exact renames at this point, so we need to do directory rename
detection based on just exact renames.  In some cases we won't have
exact renames, in which case this extra optimization won't apply.  We
also choose to not apply the optimization unless we know that the
underlying directory was removed, which will require extra data to be
passed in to diffcore_rename_extended().  Also, even if we get a
prediction about which directory a file may have relocated to, we will
still need to check to see if there is a file in the predicted
directory, and then compare the two files to see if they meet the higher
min_basename_score threshold required for marking the two files as
renames.

This commit introduces an idx_possible_rename() function which will give
do this directory rename detection for us and give us the index within
rename_dst of the resulting filename.  For now, this function is
hardcoded to return -1 (not found) and just hooks up how its results
would be used once we have a more complete implementation in place.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/gitdiffcore.txt |  2 +-
 diffcore-rename.c             | 42 ++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 9 deletions(-)

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
index 41558185ae1d..b3055683bac2 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -379,6 +379,12 @@ static const char *get_basename(const char *filename)
 	return base ? base + 1 : filename;
 }
 
+static int idx_possible_rename(char *filename)
+{
+	/* Unconditionally return -1, "not found", for now */
+	return -1;
+}
+
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score)
 {
@@ -415,8 +421,6 @@ static int find_basename_matches(struct diff_options *options,
 	int i, renames = 0;
 	struct strintmap sources;
 	struct strintmap dests;
-	struct hashmap_iter iter;
-	struct strmap_entry *entry;
 
 	/*
 	 * The prefeteching stuff wants to know if it can skip prefetching
@@ -466,17 +470,39 @@ static int find_basename_matches(struct diff_options *options,
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
+		/*
+		 * If the basename is unique among remaining sources, then
+		 * src_index will equal 'i' and we can attempt to match it
+		 * to a unique basename in the destinations.  Otherwise,
+		 * use directory rename heuristics, if possible.
+		 */
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
+				dst_index = idx_possible_rename(filename);
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

