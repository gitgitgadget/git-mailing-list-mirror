Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA15C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbiAER1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242214AbiAER1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:27:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8CEC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:27:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso2342029wmc.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U3xsy67lIPsyRvBAK8igBO4UNzdFYTUMmcc1kQCaIE0=;
        b=Eb22douKMj6AglSgGHhdeab81qSfO2XuYft9h/dnnxempGBE6fIY+s4Tkw7XQ1UTrv
         RgqZYtuUI+p6QtugbLwkKoGlzmvB3OzGyWwDEV8U3i6pnJYOQT/HTxDdWQSy2POWeOb/
         PidTATKuEQFVt1ok9VV9qMW3L1+jMcgl6G8FbZI7CSwREwd2kVAjnUsSzPDfUECeDFu6
         1ILOoRZ58B53l4ixIpJqtzLEydla919MR4xzxIb0EFvila9ATZnVVBJxt7JjFRYMFtTg
         rF/OKv/1JI2GR+bI15HSH0XPZIxVHeWA2FgL58GMKiPk0MpR+afeCO1Y8Clj54mREQE9
         AMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U3xsy67lIPsyRvBAK8igBO4UNzdFYTUMmcc1kQCaIE0=;
        b=A42gsBhUuvjB6mPnd2CHXUl7AjNxVoQUQwzMKLei0oFFdASNx1vt9k1/3ikicpDHfy
         2oZ+PicMQeOEBaqbarfH9PLfhHjVRG0XIsKkumMMoKjcYYwojz6YIXQ5nlUAVayt2RSO
         mXQG8Oc0krnIuS6SovyfJ3k/g5G2Lunl3Evcwh16BTQeBfOyLROln7dty4hXp8ck14jL
         mJ3weQIduCcTr5NX6R0TOBT+KRB9wkzLz7M8DcDM5WrAQUmZfGbJAPxtR0lj1UlFKlsL
         6Q0sfui8+WODPe99PPlrLwoic8TU34Mz5zBRw/p6XL+hDXNbeiBqtHOZ1lVO2vowK/Mg
         Ny7Q==
X-Gm-Message-State: AOAM533MA/OgtWZmlDaamaCS6AYiwHapAChf+xQ7M553vSH2Zwpa9ZID
        u0m5LH0kTrpjUXRzj8NyhEKcHUd2M78=
X-Google-Smtp-Source: ABdhPJwx5i7kY8UYq2mn3mFBycXzXNpXU5TGh05vjYks9Oq024586QQ7X4udz2qRtl1sxFIQ2dxc6Q==
X-Received: by 2002:a1c:f706:: with SMTP id v6mr3714290wmh.140.1641403661623;
        Wed, 05 Jan 2022 09:27:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18sm3020352wrn.81.2022.01.05.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:27:41 -0800 (PST)
Message-Id: <4b513a6d696b8e6ff2c1b669059fcd8747bfa10d.1641403655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 17:27:34 +0000
Subject: [PATCH v2 7/8] merge-tree: support saving merge messages to a
 separate file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When running `git merge-tree --real`, we previously would only return an
exit status reflecting the cleanness of a merge, and print out the
toplevel tree of the resulting merge.  Merges also have informational
messages, ("Auto-merging <PATH>", "CONFLICT (content): ...", "CONFLICT
(file/directory)", etc.)  In fact, when non-content conflicts occur
(such as file/directory, modify/delete, add/add with differing modes,
rename/rename (1to2), etc.), these informational messages are often the
only notification since these conflicts are not representable in the
contents of the file.

Add a --messages option which names a file so that callers can request
these messages be recorded somewhere.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  6 ++++--
 builtin/merge-tree.c             | 18 ++++++++++++++++--
 t/t4301-merge-tree-real.sh       | 18 ++++++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 5823938937f..4d5857b390b 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -9,7 +9,7 @@ git-merge-tree - Perform merge without touching index or working tree
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' --real <branch1> <branch2>
+'git merge-tree' --real [--messages=<file>] <branch1> <branch2>
 'git merge-tree' <base-tree> <branch1> <branch2>
 
 DESCRIPTION
@@ -21,7 +21,9 @@ The first form will merge the two branches, doing a full recursive
 merge with rename detection.  If the merge is clean, the exit status
 will be `0`, and if the merge has conflicts, the exit status will be
 `1`.  The output will consist solely of the resulting toplevel tree
-(which may have files including conflict markers).
+(which may have files including conflict markers).  With `--messages`,
+it will write any informational messages (such as "Auto-merging
+<path>" and conflict notices) to the given file.
 
 The second form is meant for backward compatibility and will only do a
 trival merge.  It reads three tree-ish, and outputs trivial merge
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ac50f3d108b..46b746b6b7c 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -390,6 +390,7 @@ static int trivial_merge(const char *base,
 
 struct merge_tree_options {
 	int real;
+	char *messages_file;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -443,8 +444,15 @@ static int real_merge(struct merge_tree_options *o,
 	 */
 
 	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
+
+	if (o->messages_file) {
+		FILE *fp = xfopen(o->messages_file, "w");
+		merge_display_update_messages(&opt, &result, fp);
+		fclose(fp);
+	}
 	printf("%s\n", oid_to_hex(&result.tree->object.oid));
-	merge_switch_to_result(&opt, NULL, &result, 0, 0);
+
+	merge_finalize(&opt, &result);
 	return result.clean ? 0 : 1;
 }
 
@@ -452,15 +460,18 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
 	struct merge_tree_options o = { 0 };
 	int expected_remaining_argc;
+	int original_argc;
 
 	const char * const merge_tree_usage[] = {
-		N_("git merge-tree --real <branch1> <branch2>"),
+		N_("git merge-tree --real [<options>] <branch1> <branch2>"),
 		N_("git merge-tree <base-tree> <branch1> <branch2>"),
 		NULL
 	};
 	struct option mt_options[] = {
 		OPT_BOOL(0, "real", &o.real,
 			 N_("do a real merge instead of a trivial merge")),
+		OPT_STRING(0, "messages", &o.messages_file, N_("file"),
+			   N_("filename to write informational/conflict messages to")),
 		OPT_END()
 	};
 
@@ -469,8 +480,11 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 		usage_with_options(merge_tree_usage, mt_options);
 
 	/* Parse arguments */
+	original_argc = argc;
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, 0);
+	if (!o.real && original_argc < argc)
+		die(_("--real must be specified if any other options are"));
 	expected_remaining_argc = (o.real ? 2 : 3);
 	if (argc != expected_remaining_argc)
 		usage_with_options(merge_tree_usage, mt_options);
diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
index f7aa310f8c1..5f3f27f504d 100755
--- a/t/t4301-merge-tree-real.sh
+++ b/t/t4301-merge-tree-real.sh
@@ -78,4 +78,22 @@ test_expect_success 'Barf on too many arguments' '
 	grep "^usage: git merge-tree" expect
 '
 
+test_expect_success '--messages gives us the conflict notices and such' '
+	test_must_fail git merge-tree --real --messages=MSG_FILE side1 side2 &&
+
+	# Expected results:
+	#   "greeting" should merge with conflicts
+	#   "numbers" should merge cleanly
+	#   "whatever" has *both* a modify/delete and a file/directory conflict
+	cat <<-EOF >expect &&
+	Auto-merging greeting
+	CONFLICT (content): Merge conflict in greeting
+	Auto-merging numbers
+	CONFLICT (file/directory): directory in the way of whatever from side1; moving it to whatever~side1 instead.
+	CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in side1.  Version side1 of whatever~side1 left in tree.
+	EOF
+
+	test_cmp expect MSG_FILE
+'
+
 test_done
-- 
gitgitgadget

