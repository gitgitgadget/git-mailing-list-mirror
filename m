Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F73C433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 05:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhLaFEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 00:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhLaFEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 00:04:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047FBC06173F
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so54185582wrw.10
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DszO2FzHw5/xsbjtFV/4rTM1OD3kFiH2P0bVpINlHwI=;
        b=Zn5dmLY3P02eAuv/5FSyijDiIpLMqzrxbJaqMsLxlqje4ieCno+oL4rPjSWRoEWhBk
         2mSKPmuHu0ROD9jMJpKQzyR3n1cV6h3x3hMZxZac1G3P98mvL81z9RhuYa1WwFNK/11q
         B9O4C7YjjBqkC55yeSNCU2245zyFd2arGt4kCtwzKK4xj/1r8c5CWvp1uhrE413ty7MS
         8fQ67LGYmZdxbIIeI+Z0Ob3qpFCSyh204/AEFwf+p67VpD3TrITt5xbjxk0A3w8rLR1A
         rnWCLDcYGV/a5KF18ngHXrtqwVfN8z2KjIjNl56+Cj7yqZSSwYgGVGUbpps7G59VBdh2
         +G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DszO2FzHw5/xsbjtFV/4rTM1OD3kFiH2P0bVpINlHwI=;
        b=6Vxpe3vUDxLNdL+rTJidsu2OPYAW7IYeC1UhL47esx1RDH9Wmifr41jDXwBPd3UbAK
         9xV69qsu7kPRXaRt0j/Q/O6rKv/PXTPqEY/fhsd2lKAOc6yHLj4N+iXH8CQtW4McUQYP
         wYdERYlMGuMfxAp3ncGOtU9P+aWKJsSFU1vUavMRgH9ZPlmtVScJs4dXPEp9yb0mQrOS
         gGgYbm8MID96GuVO8+5XzHk9OmWwHWVnjgut2a+Xc4KH+Go4+qLwpqeVxBSUPtRipXBL
         LJnw9d+8LCISB4wh8k4JfdGG0K3qR38cPtRH/bVVGLrOTFMnU8wJ01WOSMSczx2bJ0jh
         +V+Q==
X-Gm-Message-State: AOAM532rVubBqwGOb4aELSj8Zm+wuXCmb1qyjxYuQl1fmpEIl++1dP7p
        +vbD5pxC5ZEhevS0CuKckkeCz9aSkHo=
X-Google-Smtp-Source: ABdhPJx+E0qxt+YQ/ysIZbVadiGw8s4+falA2j9JsFweyhmyvKXxkdRHauFWMu4nkqLPIRogt/aMoQ==
X-Received: by 2002:a05:6000:1842:: with SMTP id c2mr28310483wri.525.1640927050471;
        Thu, 30 Dec 2021 21:04:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm18494439wrb.13.2021.12.30.21.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:04:10 -0800 (PST)
Message-Id: <777de92d9f166793cddbb383f497518a5dedb9f4.1640927044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 05:04:03 +0000
Subject: [PATCH 7/8] merge-tree: support saving merge messages to a separate
 file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
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
index c5757bed5bb..47deef0b199 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -389,6 +389,7 @@ static int trivial_merge(const char *base,
 
 struct merge_tree_options {
 	int real;
+	char *messages_file;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -442,8 +443,15 @@ static int real_merge(struct merge_tree_options *o,
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
 
@@ -451,15 +459,18 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
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
 
@@ -468,8 +479,11 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
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
index 9fb617ccc7f..42218cdc019 100755
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

