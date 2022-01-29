Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0EBC433FE
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353083AbiA2SHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346206AbiA2SHX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173C5C06173B
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c2so7054198wml.1
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ic5JyJUYhqiS8qLrTIu1x3UTrzMNVC/cJm9nrqcJlvg=;
        b=V8TbBpjjDBVHB7lFqGTeGR1Ua1B1k+FwqH7PzxBPo0hMjlfRLWcLTq5WlgvDUrdkMt
         Ag2k+QkoGAbgmTEo5OvqwxwE2teyQ7KHGbTRXmaPS0bKTo1Vgrr4PSjE9IvFxMe1kMHt
         jw8p4ISMLoCbyOBlzj7zcP5Gmq4y37WTCdkitqVa9Zj9/ID8Wtbc6/1C+Pe6kHKcNOvl
         mCLTrSueg47h3MdwCfwp6nPSlNhrWzqV3OYFEh6SzNPbQiYfaiu3ort35uuY9zasKgcj
         IAZzfMw/zFTfWKwGH+01JPtZGcC8u9maojLh/5wKGUXL0WuWVx4EaZAtnOlTIpCHULMt
         IDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ic5JyJUYhqiS8qLrTIu1x3UTrzMNVC/cJm9nrqcJlvg=;
        b=4v8eiU/Pmx4GuShtK8PtAYsnJmzVWXUEk//TaMxQYLpCwXgNQTSMR+gVls6rKFI7uO
         hCPt5v8OOezADmFppj8fm8EjkGCQndZMoUeMGDytbFwjcxaO/5Chy3czP+iaUXMrS/xn
         fIkuTy/iJ6niy975thvHuoNVFdBEbsXnJcZQvnPMBtil5/WbBTjVUO6cMKkltxmDNhKC
         i/R2Z/fdw8MNXRVePJmKTkOjC43N1WOTWZejXpV4r9616VeJ20aR7YJhAp0pp/JlDNSU
         8OMcoER7bwALVS06HVIm0L827mVb0B/PjEnOivwApt3KL97CEKaXbcZYC1KqRGn76y1R
         EUWg==
X-Gm-Message-State: AOAM532ByXEP3Ytc978GEfjs0vR1MG4lyT6rw2okHOIkveKKDi872cMh
        h1aFzgRT/o2pdkMSrrDI84aQqsP1+AQ=
X-Google-Smtp-Source: ABdhPJynujEedEJXCMEOf/CKAi24kiJd7KuAAj6iFDFVMcsXL1k3lnlZn65DyAuv8GudKKe7ptMeAQ==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr20190321wmk.100.1643479641475;
        Sat, 29 Jan 2022 10:07:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm7288870wrq.66.2022.01.29.10.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:21 -0800 (PST)
Message-Id: <d0d30e92ecd9dff6174a39a94a9e7d7e29896fd4.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:08 +0000
Subject: [PATCH v2 08/13] merge-tree: support including merge messages in
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

