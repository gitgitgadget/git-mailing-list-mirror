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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC1BC433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F025164ECD
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhCMWWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 17:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhCMWWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 17:22:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B128C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:14 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l11so6740379wrp.7
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5/yJVBADopBvaw7H3HUHOXZEwnTiSSJ1BMR3ZZdBgxk=;
        b=ENbu1QkuW4NRilxsZ9o1eqHy0eZa8jtzkyApaNP0pFpXxskWa23C5LnZX7Ienu4T6e
         XGdRzXQ8hoGXd+J/2Sp7VdIYzJQwKEWF9rSeZwhdZcpICIgGpY4qSiHifDtx+fPTVC9Y
         nKe6yUU7ind9PfsBGlT04YhpGJUg0h4hXvguKeY9qsuwTR69tNmRWqfyD9QqDGs8nw0T
         iZ1040LneQr1tkD/7/tdNKmK94e8rdydIrQpklT1o8kn7ziqt3z5pN8YNVWXm3FtF4U/
         TVR42E0oX/ppXO1aSNoeRufbw9z3xYwBK+33XswQWUZwfFFG9jTX3M8/lt+RIk/L1roQ
         GMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5/yJVBADopBvaw7H3HUHOXZEwnTiSSJ1BMR3ZZdBgxk=;
        b=SfTgfpjel+mRImJA5oFeLQxrJdhWUHtAxXWemLARFMKhTHW6eYs7GOCbxA1M5KVIpv
         3fcCmCB4r97qBO+reUPFeWZTpjmtb1ISAU0seCU/yzzeCtmuzTFZd/9bZgJRZyta35e/
         RRKcK482SL9aYRfCrE4agyCT4E1J63wxe5C2mbKp8HvAo1ZwHnYD7Sj1M19I0Uy1aCq5
         PjHLz4wI4mZp1wyEjF4iSh0S8gO5oweUQRgBYJXHk4HsZbNiHgdGpwc8UMlKyWtA9Zz3
         0pGfRB1w5TX1Z7GRNk/QGumySQskfn6KKQyorv2L89bmTEBBfXKrgTBKCIcazbG+KhYh
         trMg==
X-Gm-Message-State: AOAM530bTbEj2mMHaCcaftVnzJFu6DCLxPp1Qs1OyDUx1g1G54NjLtk9
        9WzO1Ioj8u3zSwk7fEnvYbZgUBS/hgc=
X-Google-Smtp-Source: ABdhPJztsd0mmxkTrffWmRwEnPVhzPy8xh3g/+QDvJRvCpi1Ivv/gsrwladyKFwGNEnwXU8xu93Dpg==
X-Received: by 2002:a05:6000:1ca:: with SMTP id t10mr20671892wrx.45.1615674133101;
        Sat, 13 Mar 2021 14:22:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm14126990wrn.97.2021.03.13.14.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 14:22:12 -0800 (PST)
Message-Id: <b62e26fb1213b69a2008d4ec2c2cb862329ee0b9.1615674128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.853.git.1615674128.gitgitgadget@gmail.com>
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Mar 2021 22:22:06 +0000
Subject: [PATCH 6/8] diffcore-rename: add computation of number of unknown
 renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The previous commit can only be effective if we have a computation of
the number of paths under a given directory which are still have pending
renames, and expected this number to be recorded in the dir_rename_count
map under the key UNKNOWN_DIR.  Add the code necessary to compute these
values.

Note that this change means dir_rename_count might have a directory
whose only entry (for UNKNOWN_DIR) was removed by the time merge-ort
goes to check it.  To account for this, merge-ort needs to check for the
case where the max count is 0.

With this change we are now computing the necessary value for each
directory in dirs_removed, but are not using that value anywhere.  The
next two commits will make use of the values stored in dirs_removed in
order to compute whether each relevant_source (that is needed only for
directory rename detection) has become unnecessary.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 41 +++++++++++++++++++++++++++++++++++++----
 merge-ort.c       |  3 +++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8fa29076e0aa..9844cd48788e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -699,7 +699,8 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 	/*
 	 * Although dir_rename_count was passed in
 	 * diffcore_rename_extended() and we want to keep it around and
-	 * return it to that caller, we first want to remove any data
+	 * return it to that caller, we first want to remove any counts in
+	 * the maps associated with UNKNOWN_DIR entries and any data
 	 * associated with directories that weren't renamed.
 	 */
 	strmap_for_each_entry(info->dir_rename_count, &iter, entry) {
@@ -711,6 +712,9 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 			strintmap_clear(counts);
 			continue;
 		}
+
+		if (strintmap_contains(counts, UNKNOWN_DIR))
+			strintmap_remove(counts, UNKNOWN_DIR);
 	}
 	for (i = 0; i < to_remove.nr; ++i)
 		strmap_remove(info->dir_rename_count,
@@ -1125,6 +1129,7 @@ static void handle_early_known_dir_renames(struct dir_rename_info *info,
 	 * a majority.
 	 */
 
+	int i;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 
@@ -1134,10 +1139,38 @@ static void handle_early_known_dir_renames(struct dir_rename_info *info,
 		return; /* culling incompatbile with break detection */
 
 	/*
-	 * FIXME: Supplement dir_rename_count with number of potential
-	 * renames, marking all potential rename sources as mapping to
-	 * UNKNOWN_DIR.
+	 * Supplement dir_rename_count with number of potential renames,
+	 * marking all potential rename sources as mapping to UNKNOWN_DIR.
 	 */
+	for (i = 0; i < rename_src_nr; i++) {
+		char *old_dir;
+		struct diff_filespec *one = rename_src[i].p->one;
+
+		/*
+		 * sources that are part of a rename will have already been
+		 * removed by a prior call to remove_unneeded_paths_from_src()
+		 */
+		assert(!one->rename_used);
+
+		old_dir = get_dirname(one->path);
+		while (*old_dir != '\0' &&
+		       NOT_RELEVANT != strintmap_get(dirs_removed, old_dir)) {
+			char *freeme = old_dir;
+
+			increment_count(info, old_dir, UNKNOWN_DIR);
+			old_dir = get_dirname(old_dir);
+
+			/* Free resources we don't need anymore */
+			free(freeme);
+		}
+		/*
+		 * old_dir and new_dir free'd in increment_count, but
+		 * get_dirname() gives us a new pointer we need to free for
+		 * old_dir.  Also, if the loop runs 0 times we need old_dir
+		 * to be freed.
+		 */
+		free(old_dir);
+	}
 
 	/*
 	 * For any directory which we need a potential rename detected for
diff --git a/merge-ort.c b/merge-ort.c
index e2606c73ad88..f2b259986e22 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1546,6 +1546,9 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 			}
 		}
 
+		if (max == 0)
+			continue;
+
 		if (bad_max == max) {
 			path_msg(opt, source_dir, 0,
 			       _("CONFLICT (directory rename split): "
-- 
gitgitgadget

