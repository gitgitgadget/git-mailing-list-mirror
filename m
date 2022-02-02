Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE3EC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiBBHfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbiBBHez (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:34:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D16EC061401
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s18so36535861wrv.7
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ic5JyJUYhqiS8qLrTIu1x3UTrzMNVC/cJm9nrqcJlvg=;
        b=EVQARIicZB72pB6IV9Fgw/kfxELpVcCrqrJ76anbKn1m3eNkF7HFilaac1DAR4xsnz
         sE06F9E49xooRlU/yCaVbwyH+w2mAQ4PX3xpdYPFDxWvqprpUP+whbfGI+5wuEyLCWOg
         +/NUFVyaQXVBlA3KHLmoO5jCF9be0WMXHldy1TsnrP592BZLvtXaDrhpCTktDMrXDuql
         2nnCYDa4WfZtAB4UAMMy8WQYJG55Gi7siXpR+Seyvxb2WNl7sLr3HxnpgFCdykI8o/k0
         CzK+SLBiObNz3ijGX6ZdQyraKSA6Re1KWrvv20kjM0Xug2Bz0CTZXZFeofuS3wNIBTXl
         76rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ic5JyJUYhqiS8qLrTIu1x3UTrzMNVC/cJm9nrqcJlvg=;
        b=1G1cJzBmbCH+V8anCvqdx9nUusrZAcP9DsHyXXUA9EcZ6f+eAoj3TX+hjPsjv7OncZ
         HdfpPQGHkO9FJFtJ3Vzwq4pWI4BAPccvoN68DPWwXoZy27V4voeaePorxsIB6AK8jwUE
         6PP/UKa8IP09EyooEMqSZlePAmsNQi10BgnBmTWU4FT8ar4BUjsAPZGFRIRHYAqbP0+I
         z7edbkYBgoJDD1S3r8X/2LAsQs8zXYdJt1sRkLxlaDPIaw6KLi2Ztbm4vHqkI4YQ5w+2
         qV1WYRgrnNSV2suekKri/zJ2097v+RmDq08vIvBm1Vj2BiFoMctgcD9BeAKIZXI3INhG
         oZvQ==
X-Gm-Message-State: AOAM531CFWBql8Pl3BAmpNtxmDZAp2AyabJHsntO0d3i8ky61oSC/yN0
        SUtX51jzw5WKx9CkYHqFWmV7j73nwuA=
X-Google-Smtp-Source: ABdhPJzzH3FR/WYFhCgLOuvB19BTepQhtuxTxsVKG3y33sIsjLMzVWOuJer2AVlYo89VYkU2mNDK1g==
X-Received: by 2002:a5d:5343:: with SMTP id t3mr24949231wrv.521.1643787290780;
        Tue, 01 Feb 2022 23:34:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6sm16038755wrq.97.2022.02.01.23.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:50 -0800 (PST)
Message-Id: <c8ed002408d82dc0f1a059a117cd4fd7113d8b07.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:35 +0000
Subject: [PATCH v3 09/15] merge-tree: support including merge messages in
 output
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When running `git merge-tree --write-tree`, we previously would only
return an exit status reflecting the cleanness of a merge, and print out
the toplevel tree of the resulting merge.  Merges also have
informational messages, such as:
  * "Auto-merging <PATH>"
  * "CONFLICT (content): ..."
  * "CONFLICT (file/directory)"
  * etc.
In fact, when non-content conflicts occur (such as file/directory,
modify/delete, add/add with differing modes, rename/rename (1to2),
etc.), these informational messages may be the only notification the
user gets since these conflicts are not representable in the contents
of the file.

Add a --[no-]messages option so that callers can request these messages
be included at the end of the output.  Include such messages by default
when there are conflicts, and omit them by default when the merge is
clean.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 45 +++++++++++++++++++++++++++-----
 builtin/merge-tree.c             | 19 ++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 21 +++++++++++++++
 3 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 569485815a0..42e0f8f6183 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -9,7 +9,7 @@ git-merge-tree - Perform merge without touching index or working tree
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' [--write-tree] <branch1> <branch2>
+'git merge-tree' [--write-tree] [<options>] <branch1> <branch2>
 'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
 
 DESCRIPTION
@@ -35,17 +35,47 @@ merge is distinguished from a trivial merge in that it includes:
 After the merge completes, it will create a new toplevel tree object.
 See `OUTPUT` below for details.
 
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
@@ -69,7 +99,8 @@ be used as a part of a series of steps such as
 
 However, it does not quite fit into the same category of low-level
 plumbing commands since the possibility of merge conflicts give it a
-much higher chance of the command not succeeding.
+much higher chance of the command not succeeding (and NEWTREE containing
+a bunch of stuff other than just a toplevel tree).
 
 GIT
 ---
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index d14c9f6e44e..6a556ab1c9c 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -390,6 +390,7 @@ static int trivial_merge(const char *base,
 
 struct merge_tree_options {
 	int mode;
+	int show_messages;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -432,18 +433,27 @@ static int real_merge(struct merge_tree_options *o,
 	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
 	if (result.clean < 0)
 		die(_("failure to merge"));
+
+	if (o->show_messages == -1)
+		o->show_messages = !result.clean;
+
 	puts(oid_to_hex(&result.tree->object.oid));
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
@@ -453,10 +463,13 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			    'w'),
 		OPT_CMDMODE(0, "trivial-merge", &o.mode,
 			    N_("do a trivial merge only"), 't'),
+		OPT_BOOL(0, "messages", &o.show_messages,
+			 N_("also show informational/conflict messages")),
 		OPT_END()
 	};
 
 	/* Parse arguments */
+	original_argc = argc;
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 	if (o.mode) {
@@ -468,6 +481,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			usage_with_options(merge_tree_usage, mt_options);
 		o.mode = (argc == 2 ? 'w' : 't');
 	}
+	if (o.mode == 't' && original_argc < argc)
+		die(_("--trivial-merge is incompatible with all other options"));
 
 	/* Do the relevant type of merge */
 	if (o.mode == 'w')
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 66c3eaf2021..e2255711f9c 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -85,4 +85,25 @@ test_expect_success 'Barf on too many arguments' '
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

