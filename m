Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6128C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 12:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjHGMtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjHGMtW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 08:49:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085AA170B
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 05:49:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so27921855e9.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 05:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691412559; x=1692017359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hlGNCuB4d2Ai2xnzHTtlkprqwV6phjwV9Y84kPKJ/SI=;
        b=HQ/0Qnph4LVynQ/pGmex7LC0BzSOoZ8bSGBfHSY+9s+Def7Kxt9cLcmEkNGZZSVUJf
         zNv78Aug/td+qAeWbrY+6J/uOqnXjYv8wCHhhuJM6cAyj7JQ8+kDKhlC6ZXCI25NRc7Y
         X5RuRG6zxIsngRYp9WmswFkq1OyI2bmaaccKf0ei3n28sgqFQkitjGto63uBpN04mNHS
         5oPp0OuKqNmu7H9H8aF9hZwt33jH81Yvu4lavMlMWgTy6oskyE+Sqx8/uOQrk+e5NCkg
         eTv7haQ+FUJjeoo3ifN6cwL1WjQuL1gYKxMDfJihAFYX8t+N1xKibD9aT2UFHpYAh27E
         MaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691412559; x=1692017359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlGNCuB4d2Ai2xnzHTtlkprqwV6phjwV9Y84kPKJ/SI=;
        b=QKCzn/G2WXTTwUxyNgZHb0aNNO07IfuC/Bbfo+dBJNQ1N2GkCtNTCrt4dPDdVT6MSf
         u+q4L89rbUIin/VFXuR8QaAwBedAX9VrkgZXFg+Ikbz8BNWQwaLGyCQcpkPzIWrozAa/
         blKqv1t48nJp8beiowJ9dJ74Lq6xUWSzFc0P0gwX+pGmUjJzYPyCFhCkhUe37SIejDxQ
         fqLDffspu8mgkmWSrsixWyEcMf+Hv+upNrnXvI5JgLKRYtt3jEVc2jAokM8NrQdO1tib
         i4rgc3ALK+HqAvcjBzkJPWZJiHx3fIcpHUPaC8mZaRdFyO8jcZIA/gTeDY5BH13CT+MO
         uHjw==
X-Gm-Message-State: AOJu0YyNa/DBauZbmfs+FoD9Nx99ZeOX1wV45QvgcBJad69yxU8sw2b3
        G0oRLrS9Zh/FL1HSYKgjyECQvDgBRmY=
X-Google-Smtp-Source: AGHT+IFKaVMDsdP7SPFkwUM11KOGsGwCr5TrBrRFUMBu88jYbuusSvcIIDByAqRRYd4MOyUS8bePvQ==
X-Received: by 2002:a7b:ca58:0:b0:3fe:20aa:ada0 with SMTP id m24-20020a7bca58000000b003fe20aaada0mr7192002wml.15.1691412559011;
        Mon, 07 Aug 2023 05:49:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003fe29f6b61bsm10495497wmi.46.2023.08.07.05.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:49:18 -0700 (PDT)
Message-ID: <pull.1566.git.1691412557518.gitgitgadget@gmail.com>
From:   "Ryan Williams via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 12:49:17 +0000
Subject: [PATCH] ls-tree: default <tree-ish> to HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ryan Williams <ryan@runsascoded.com>,
        Ryan Williams <ryan@runsascoded.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ryan Williams <ryan@runsascoded.com>

When no positional arguments are passed to `git ls-tree`, it currently
prints "usage" info to stderr and exits with code 129. A more intuitive
default would be to operate on the `HEAD` commit's tree (similarly to
`git show`, `git log`, and possibly others).

This patch updates `git ls-tree [options...]` to operate identically to
`git ls-tree [options...] HEAD`, updates the docs to reflect that
`<tree-ish>` is optional (and `[path...]` args can only be provided if a
`<tree-ish>` is explicitly provided first), and duplicates some existing
test cases to omit the `HEAD` argument to `ls-tree` (verifying that
`ls-tree` behaves identically whether `HEAD` is provided or not).

Signed-off-by: Ryan Williams <ryan@runsascoded.com>
---
    ls-tree: default to HEAD

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1566%2Frunsascoded%2Fls-tree-head-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1566/runsascoded/ls-tree-head-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1566

 Documentation/git-ls-tree.txt |  6 +++---
 builtin/ls-tree.c             | 11 ++++++++---
 t/t3105-ls-tree-output.sh     |  7 ++++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 6572095d8d6..6211d630974 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
 	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>]
-	    <tree-ish> [<path>...]
+	    [<tree-ish> [<path>...]]
 
 DESCRIPTION
 -----------
@@ -36,7 +36,7 @@ in the current working directory.  Note that:
 OPTIONS
 -------
 <tree-ish>::
-	Id of a tree-ish.
+	Id of a tree-ish. If omitted, defaults to "HEAD".
 
 -d::
 	Show only the named tree entry itself, not its children.
@@ -139,7 +139,7 @@ which is able to interpolate different fields using a `%(fieldname)` notation.
 For example, if you only care about the "objectname" and "path" fields, you
 can execute with a specific "--format" like
 
-	git ls-tree --format='%(objectname) %(path)' <tree-ish>
+	git ls-tree --format='%(objectname) %(path)' [<tree-ish>]
 
 FIELD NAMES
 -----------
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f558db5f3b8..b1e337ccde9 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -18,7 +18,7 @@
 #include "pathspec.h"
 
 static const char * const ls_tree_usage[] = {
-	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
+	N_("git ls-tree [<options>] [<tree-ish> [<path>...]]"),
 	NULL
 };
 
@@ -377,6 +377,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	};
 	struct ls_tree_cmdmode_to_fmt *m2f = ls_tree_cmdmode_format;
 	int ret;
+	/* If no positional args were passed, default <tree-ish> to HEAD. */
+	const char *fallback_args[] = { "HEAD", NULL };
 
 	git_config(git_default_config, NULL);
 
@@ -405,8 +407,11 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		usage_msg_opt(
 			_("--format can't be combined with other format-altering options"),
 			ls_tree_usage, ls_tree_options);
-	if (argc < 1)
-		usage_with_options(ls_tree_usage, ls_tree_options);
+	if (argc < 1) {
+		/* `git ls-tree [flags...]` -> `git ls-tree [flags...] HEAD`. */
+		argv = fallback_args;
+		argc = 1;
+	}
 	if (repo_get_oid(the_repository, argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
diff --git a/t/t3105-ls-tree-output.sh b/t/t3105-ls-tree-output.sh
index ce2391e28be..cb05529c0ad 100755
--- a/t/t3105-ls-tree-output.sh
+++ b/t/t3105-ls-tree-output.sh
@@ -26,11 +26,16 @@ test_ls_tree_format_mode_output () {
 		local mode="$1" &&
 		shift &&
 
-		test_expect_success "'ls-tree $opts${mode:+ $mode}' output" '
+		test_expect_success "'ls-tree ${mode:+$mode }$opts' output" '
 			git ls-tree ${mode:+$mode }$opts HEAD >actual &&
 			test_cmp expect actual
 		'
 
+		test_expect_success "'ls-tree ${mode:+$mode }$opts' (default HEAD) output" '
+			git ls-tree ${mode:+$mode }$opts >actual &&
+			test_cmp expect actual
+		'
+
 		case "$opts" in
 		--full-tree)
 			test_expect_success "'ls-tree $opts${mode:+ $mode}' output (via subdir, fails)" '

base-commit: ac83bc5054c2ac489166072334b4147ce6d0fccb
-- 
gitgitgadget
