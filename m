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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13D0C433E9
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B310C64E33
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhB0Abz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhB0Abf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:31:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F0C061756
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h98so10193119wrh.11
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fbn6j9yecRzpkAPOum5e+vLczqyAc3Qa+nyqyPts5zY=;
        b=cCHhYDInrTUVuEeTVqeiRO91lfeVsRqHy+bmYjrZuxaEAloIG7hjKvi98ug6sCyBch
         6ef28+tAj5z50AO87EJAEITI9fxO+jqHrAC4a5QmT8ds1GRdfvVZjvZJLN3hykL3eSLy
         nVFT3IoJk+fIl6YjICqZsSLAY9e70ap/tCr5Sxp2K/NBmNCOkAiPZse+KWo6EQXEw8C+
         BZj9IzsOLr0ekF+OeTGYgSrl9IJtUIJGvF5Ix+Ms/SzvAeTBBbvQSkLcoHb9Fe6cLgbw
         R45dAS69kOJutyrFI2Y9b3IQKfl4iQLrSG0NPvGn1D2ZmAqs2DfbzzlF6JdE+uNGJYVP
         HQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fbn6j9yecRzpkAPOum5e+vLczqyAc3Qa+nyqyPts5zY=;
        b=Dc67ZrOjt8B1ehKTMS0sxhT+vLXjJso/7dJVDSOc6JcfiVcHhZYYieTj02g1tANJVH
         qIiGp676JODhtmetXIl20ya9A/2Fll8ldB9D9iVxZ9zkjcP96Rr1Ry7IEwTHvKNy/hgM
         G0CyskyRZimbNeMoI1Q6BdVUzq4EYLdHuK6O7xubbGDDInuezFSo5/ESmFyGhj/0R159
         wTdrXZ+GlTMuBktDW40KL/Thk6kxz0bXF6UatJ1qAjpMeoicTh9G4svFQuoVVlA38R6a
         aqbnLdAYpxcGAfxk7/JmVAPCWym+d2fnxHest9G6SlaxDMHbZz81XKmw34Rt8q1xI7up
         HNjw==
X-Gm-Message-State: AOAM53209JptZQxWXh/n2XXekUeJ2Oi1V2tWF25RYh8R+g/7DaFxEzWR
        Pr/DcOozT0OMB44ghMLQigaXyxdXCws=
X-Google-Smtp-Source: ABdhPJwgKtDygdD3ZEUyrbxyNpEg7rjUmNBkcGLeStbz+URVDe3ukQNvIB8aIfTf25gHGjPQjU/5/g==
X-Received: by 2002:a5d:66c8:: with SMTP id k8mr5765571wrw.163.1614385851466;
        Fri, 26 Feb 2021 16:30:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1sm13202560wmh.9.2021.02.26.16.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:51 -0800 (PST)
Message-Id: <823d07532e0077b24de0a4f2e145cc47f59d1b36.1614385849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
        <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:39 +0000
Subject: [PATCH v4 01/10] diffcore-rename: use directory rename guided
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

This commit introduces an idx_possible_rename() function which will
do this directory rename detection for us and give us the index within
rename_dst of the resulting filename.  For now, this function is
hardcoded to return -1 (not found) and just hooks up how its results
would be used once we have a more complete implementation in place.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
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

