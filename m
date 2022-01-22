Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F895C433FE
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiAVV4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiAVV4M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35361C06173D
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so25028373wmb.5
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QB6vdjI5ZUXzQx8gj3AD9+ysUH3Y1x0L49EQ6xQ/MqY=;
        b=LrcyVMjKhgEg+XRDpzaY76ymPPW92/5UYHgtLamAAIt93a3NwyyZxhOtj6VwipEvIz
         Hv0XMI+MfhKZGiyEKzI7wlaf4+wDqWa9sLPtMKG94inZv/cLanI5YbeXR5PrV8xpzvlQ
         qOdsnmmTXXFGLMBSH7Zx+rVVmkcpGd+QUElvxFJwH3fvKzctzshWzvpdFES3Y1uiwXNH
         DCHoJKxMEee9MccLgTd0aveZj3I0OhjJbyT/wSOsHLKtALji7agDhuxDI59HXmkuuret
         Kr0E7PgUEA2yRvU4r93nfJ0xiiokTT1sj26m0KAgR6sluJyCGiw+xtASmwquLnlGOFiA
         V3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QB6vdjI5ZUXzQx8gj3AD9+ysUH3Y1x0L49EQ6xQ/MqY=;
        b=MucT8J0qNp3iulSTR2wiSBn4/RCVq7gBRON7uenwbB23j9SHDm49Mz8rpZBNpKvFqN
         DTPIPbx8I+5V2Qk/An4Dq/lYTnl5d9iIzGcuS+I+qVWxxXZG5rz3DY657PGIg3M5oMQD
         9WtlC430oDfml65iIrHFC6eNmAWTFHf5jlCeaYw50OdA2ltaZ5aZbcH+5tixjj9RiLtb
         e+U7wAM7sMH5j86qEhSoRXEe7qSmvIuggrG29PG1tgTTHqULd1K/WAh110NlMdOdq51N
         PE9zbrvXVHh1zZ5OorPmIJgpiz3qMBhRgh+bOsLYeuxodkK4sd/WGNoVXrKm4vryTXZ5
         3rng==
X-Gm-Message-State: AOAM530TTAwn4xj8neeCUChW7bfVZiWY6OocFJO86+Uh1wEVLxl1PV5P
        X3TkPa8blVV8iwBPvNgKhkubNSu8J2o=
X-Google-Smtp-Source: ABdhPJwFIX23ul+0qTtzaGlIv8IJnRrf8TTjC6OA00BplKrJ3TzcTooTqXXKdVkXX+whSCTwaUfCxA==
X-Received: by 2002:a05:600c:1f10:: with SMTP id bd16mr5792353wmb.111.1642888570523;
        Sat, 22 Jan 2022 13:56:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm2126736wmx.5.2022.01.22.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:09 -0800 (PST)
Message-Id: <2f296aeeefbf8340cfb8b7fa4fef5ad49c8b4aa1.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:55:57 +0000
Subject: [PATCH 07/12] merge-tree: support including merge messages in output
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

When running `git merge-tree --write-tree`, we previously would only
return an exit status reflecting the cleanness of a merge, and print out
the toplevel tree of the resulting merge.  Merges also have
informational messages, ("Auto-merging <PATH>", "CONFLICT (content):
...", "CONFLICT (file/directory)", etc.)  In fact, when non-content
conflicts occur (such as file/directory, modify/delete, add/add with
differing modes, rename/rename (1to2), etc.), these informational
messages are often the only notification since these conflicts are not
representable in the contents of the file.

Add a --[no-]messages option so that callers can request these messages
be included at the end of the output.  Include such messages by default
when there are conflicts, and omit them by default when the merge is
clean.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 45 +++++++++++++++++++++++++++-----
 builtin/merge-tree.c             | 24 +++++++++++++----
 t/t4301-merge-tree-real.sh       | 21 +++++++++++++++
 3 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index b900bc1362c..fd7a867de60 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -9,7 +9,7 @@ git-merge-tree - Perform merge without touching index or working tree
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' [--write-tree] <branch1> <branch2>
+'git merge-tree' [--write-tree] [<options>] <branch1> <branch2>
 'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2>
 
 DESCRIPTION
@@ -38,17 +38,47 @@ than the first form even on successful merges (especially if working
 in large repositories).  The remainder of this manual will only
 discuss the first form.
 
+OPTIONS
+-------
+
+--[no-]messages::
+	Write any informational messages such as "Auto-merging <path>"
+	or CONFLICT notices to the end of stdout.  If unspecified, the
+	default is to include these messages if there are merge
+	conflicts, and to omit them otherwise.
+
 OUTPUT
 ------
 
-For either a successful or conflicted merge, the output from
-git-merge-tree is simply one line:
+By default, for a successful merge, the output from git-merge-tree is
+simply one line:
+
+	<OID of toplevel tree>
+
+Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
+	<Informational messages>
+
+These are discussed individually below.
+
+OID of toplevel tree
+~~~~~~~~~~~~~~~~~~~~
+
+This is a tree object that represents what would be checked out in the
+working tree at the end of `git merge`.  If there were conflicts, then
+files within this tree may have embedded conflict markers.
+
+Informational messages
+~~~~~~~~~~~~~~~~~~~~~~
+
+This always starts with a blank line to separate it from the previous
+section, and then has free-form messages about the merge, such as:
 
-The printed tree object corresponds to what would be checked out in
-the working tree at the end of `git merge`, and thus may have files
-with conflict markers in them.
+  * "Auto-merging <file>"
+  * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
+  * "Failed to merge submodule <submodule> (<reason>)"
+  * "Warning: cannot merge binary files: <filename>"
 
 EXIT STATUS
 -----------
@@ -72,7 +102,8 @@ be used as a part of a series of steps such as
 
 However, it does not quite fit into the same category of low-level
 plumbing commands since the possibility of merge conflicts give it a
-much higher chance of the command not succeeding.
+much higher chance of the command not succeeding (and NEWTREE containing
+a bunch of stuff other than just a toplevel tree).
 
 GIT
 ---
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 0c19639594d..560640ad911 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -391,6 +391,7 @@ static int trivial_merge(const char *base,
 struct merge_tree_options {
 	int real;
 	int trivial;
+	int show_messages;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -440,22 +441,30 @@ static int real_merge(struct merge_tree_options *o,
 		commit_list_insert(j->item, &merge_bases);
 
 	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
-	printf("%s\n", oid_to_hex(&result.tree->object.oid));
+
 	if (result.clean < 0)
 		die(_("failure to merge"));
-	else if (!result.clean)
-		printf(_("Conflicts!\n"));
+
+	if (o->show_messages == -1)
+		o->show_messages = !result.clean;
+
+	printf("%s\n", oid_to_hex(&result.tree->object.oid));
+	if (o->show_messages) {
+		printf("\n");
+		merge_display_update_messages(&opt, &result, stdout);
+	}
 	merge_finalize(&opt, &result);
 	return !result.clean; /* result.clean < 0 handled above */
 }
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
-	struct merge_tree_options o = { 0 };
+	struct merge_tree_options o = { .show_messages = -1 };
 	int expected_remaining_argc;
+	int original_argc;
 
 	const char * const merge_tree_usage[] = {
-		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
+		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
 		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
 		NULL
 	};
@@ -464,6 +473,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			 N_("do a real merge instead of a trivial merge")),
 		OPT_BOOL(0, "trivial-merge", &o.trivial,
 			 N_("do a trivial merge only")),
+		OPT_BOOL(0, "messages", &o.show_messages,
+			 N_("also show informational/conflict messages")),
 		OPT_END()
 	};
 
@@ -472,10 +483,13 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 		usage_with_options(merge_tree_usage, mt_options);
 
 	/* Parse arguments */
+	original_argc = argc;
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, 0);
 	if (o.real && o.trivial)
 		die(_("--write-tree and --trivial-merge are incompatible"));
+	if (!o.real && original_argc < argc)
+		die(_("--write-tree must be specified if any other options are"));
 	if (o.real || o.trivial) {
 		expected_remaining_argc = (o.real ? 2 : 3);
 		if (argc != expected_remaining_argc)
diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
index e03688515c5..c34f8e6c1ed 100755
--- a/t/t4301-merge-tree-real.sh
+++ b/t/t4301-merge-tree-real.sh
@@ -84,4 +84,25 @@ test_expect_success 'Barf on too many arguments' '
 	grep "^usage: git merge-tree" expect
 '
 
+test_expect_success 'test conflict notices and such' '
+	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
+
+	# Expected results:
+	#   "greeting" should merge with conflicts
+	#   "numbers" should merge cleanly
+	#   "whatever" has *both* a modify/delete and a file/directory conflict
+	cat <<-EOF >expect &&
+	HASH
+
+	Auto-merging greeting
+	CONFLICT (content): Merge conflict in greeting
+	Auto-merging numbers
+	CONFLICT (file/directory): directory in the way of whatever from side1; moving it to whatever~side1 instead.
+	CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in side1.  Version side1 of whatever~side1 left in tree.
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

