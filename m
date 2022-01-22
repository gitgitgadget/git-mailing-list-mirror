Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6EAC43219
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiAVV4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiAVV4J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E24C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so25215730wme.0
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TL9IIOJWkeHV3aADLJVy6RlNpZUpHjdBaktqfMu4Usk=;
        b=qRlBtpbQgqjSHVlP1QXpfZouN4/IrLwq/kjzW2rHZpWw31maWQ/3Hy7eKnz/+41tR7
         hDyun9ffxFVnneT3PWztsM/vwGnwI9siHyf7AvurIkoKWC+W1fFs1/C5PxkCpmde3YZm
         SAp2OKjY9SM8K++OruvyggftLLWUcNF14n0eXltB2xB67OegLZNscuPW3ufsUb5ENPeC
         14OpdIGzKlWf98wIJHALoh8FMj6bKvrBvz3UMY8dBSErpGawy79reCYwWsJVmbvgji6e
         lAlBeLTUptbwV/Mr1tS+7VzFK11QdEs21DGH7FD9KwQIFeOGDkA4btc10OcKR2kSDP1g
         Kg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TL9IIOJWkeHV3aADLJVy6RlNpZUpHjdBaktqfMu4Usk=;
        b=X81xYuSVL+FueGMVqhxUEHHdSLuh1gC8sZRyosf81CYij9P9ROwHv3dvi8aXAByJeA
         TIYQqDnl+hmpcptuHZ9k1WVoHO/mnhyR1N1yt9uuk2onxRN5WsZ/bsxoWUBGWNFYCW0E
         YjnPI18Z/l2m+WsFOxSYe2COZIOJvS8cg2zG80fJ9DCXqSYkNzKpcX4upS1GLyrFJdFE
         WaJjkTAKakTDD4eHNTX5zpKN4dnNOjqoZmffKr9YbwvFAmOI20CVzD/91C2gW9ptICpX
         3YEnixASSIH+B//JjXBptABA7oEGi0K+zM6zqJq2bKYbMGMLl5M3ciGHBPdQtbwQv3bd
         mI3A==
X-Gm-Message-State: AOAM533cRVvS+TIRIWg3EtYN+ONjvz3rcHN0ookt30cCEU+4QbLNWcdQ
        MRt73TZevogx9ureV/aYlvYrL1D6s4w=
X-Google-Smtp-Source: ABdhPJw10IIF4gTyl/zd0uzGGoIDXEwRETdyUYHcjNpPQemZ/wDBjvs0ND26fZFp7yEK3vM0i7gQIw==
X-Received: by 2002:a05:600c:3d9b:: with SMTP id bi27mr5855982wmb.36.1642888567017;
        Sat, 22 Jan 2022 13:56:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm9940544wrf.111.2022.01.22.13.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:06 -0800 (PST)
Message-Id: <65fdae9ddba7c7065ce27acbf4e80a1a74842aa7.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:55:53 +0000
Subject: [PATCH 03/12] merge-tree: add option parsing and initial shell for
 real merge function
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

Let merge-tree accept a `--write-tree` parameter for choosing real
merges instead of trivial merges, and accept an optional
`--trivial-merge` option to get the traditional behavior.  Note that
these accept different numbers of arguments, though, so these names
need not actually be used.

Note that real merges differ from trivial merges in that they handle:
  - three way content merges
  - recursive ancestor consolidation
  - renames
  - proper directory/file conflict handling
  - etc.
Basically all the stuff you'd expect from `git merge`, just without
updating the index and working tree.  The initial shell added here does
nothing more than die with "real merges are not yet implemented", but
that will be fixed in subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 67 ++++++++++++++++++++++++++++++++++++++------
 git.c                |  2 +-
 2 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 914ec960b7e..33e47cc1534 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,13 +3,12 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "object-store.h"
+#include "parse-options.h"
 #include "repository.h"
 #include "blob.h"
 #include "exec-cmd.h"
 #include "merge-blobs.h"
 
-static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
-
 struct merge_list {
 	struct merge_list *next;
 	struct merge_list *link;	/* other stages for this object */
@@ -366,15 +365,17 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-static int trivial_merge(int argc, const char **argv)
+static int trivial_merge(const char *base,
+			 const char *branch1,
+			 const char *branch2)
 {
 	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	buf1 = get_tree_descriptor(r, t+0, argv[1]);
-	buf2 = get_tree_descriptor(r, t+1, argv[2]);
-	buf3 = get_tree_descriptor(r, t+2, argv[3]);
+	buf1 = get_tree_descriptor(r, t+0, base);
+	buf2 = get_tree_descriptor(r, t+1, branch1);
+	buf3 = get_tree_descriptor(r, t+2, branch2);
 	trivial_merge_trees(t, "");
 	free(buf1);
 	free(buf2);
@@ -384,9 +385,57 @@ static int trivial_merge(int argc, const char **argv)
 	return 0;
 }
 
+struct merge_tree_options {
+	int real;
+	int trivial;
+};
+
+static int real_merge(struct merge_tree_options *o,
+		      const char *branch1, const char *branch2)
+{
+	die(_("real merges are not yet implemented"));
+}
+
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
-	if (argc != 4)
-		usage(merge_tree_usage);
-	return trivial_merge(argc, argv);
+	struct merge_tree_options o = { 0 };
+	int expected_remaining_argc;
+
+	const char * const merge_tree_usage[] = {
+		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
+		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
+		NULL
+	};
+	struct option mt_options[] = {
+		OPT_BOOL(0, "write-tree", &o.real,
+			 N_("do a real merge instead of a trivial merge")),
+		OPT_BOOL(0, "trivial-merge", &o.trivial,
+			 N_("do a trivial merge only")),
+		OPT_END()
+	};
+
+	/* Check for a request for basic help */
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(merge_tree_usage, mt_options);
+
+	/* Parse arguments */
+	argc = parse_options(argc, argv, prefix, mt_options,
+			     merge_tree_usage, 0);
+	if (o.real && o.trivial)
+		die(_("--write-tree and --trivial-merge are incompatible"));
+	if (o.real || o.trivial) {
+		expected_remaining_argc = (o.real ? 2 : 3);
+		if (argc != expected_remaining_argc)
+			usage_with_options(merge_tree_usage, mt_options);
+	} else {
+		if (argc < 2 || argc > 3)
+			usage_with_options(merge_tree_usage, mt_options);
+		o.real = (argc == 2);
+	}
+
+	/* Do the relevant type of merge */
+	if (o.real)
+		return real_merge(&o, argv[0], argv[1]);
+	else
+		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/git.c b/git.c
index 5ff21be21f3..6090a1289db 100644
--- a/git.c
+++ b/git.c
@@ -558,7 +558,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
 	{ "mktree", cmd_mktree, RUN_SETUP },
 	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
-- 
gitgitgadget

