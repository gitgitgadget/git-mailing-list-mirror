Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E410DC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhK2WWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhK2WVE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:21:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30F6C091D01
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q3so16484763wru.5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrQXsFXPVGWxGlrmm1zL9Eztou8c+tDoQ0COaFDx7q0=;
        b=jsww0uQMJrKLWY8mhwe0NMtbDyeU3qb2jBicCcRwrJOZxcphgkCby2P5SpAPeuE1dF
         tLh+kBj+cPFgPmuzVlj4VxQdvvxuzu4WJ9oG+3W1FN/J+EugimGhZXU596z2Ev0s+nN3
         LxX+X476ysHm609xyN9Vzgtv+dJR6AGqmAWN09cO/rT3N/Zl24tWJj8lFY1208kdqPDn
         ePdVgmX/iSg239FtUKdxJwFEJ/iqpIToHWxO/TP3FPvfHj8t+w745wfpZWiGD1RWbwDc
         4mZhHIzkX1bnwyzTM9VRW95zWHcNhbhUMTiKw5fmnL8P2+F1XdJCrlbvhRAJ85gpzqTI
         ZaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrQXsFXPVGWxGlrmm1zL9Eztou8c+tDoQ0COaFDx7q0=;
        b=y7Yp8CLP9jC/Zvyj/60jp4sKFx/KFsAhn78VYZ62zg7biHs8+bz1SQ7XW8+8xCbUvL
         wMMMRlxAJCVwq0IvmALedHf9x+CHT5v5+OXfuq9f9HdVVZOIqzCQHlOmcBXuItXfD8kC
         fWXU2isP9wd0wvbOttgJxUR5KUefHK8lXM74N08VFVtG2SuWZIOouI4d43Oyf+J8TK9K
         a8A+o6Gg7un41uBEI4s2hQSC0UtfOmtQ14tdMb/sNWcZI4MswVJJZe8RYLyhjDTQ2Ho8
         UYwEGJb+CUl7AnbQhOcDpykt05B1RcHJoi3J94/0/AczZ9iqTszVUUjWx800r/9pOeRq
         7H6w==
X-Gm-Message-State: AOAM532cuItMK6S/oJbj2H4DLUv+uAVD0GKCcYzpK9kvHeB/y1b/HcrD
        Y7T2Z5oK0QUIXInuIn64qqZCm/xoRg83UQ==
X-Google-Smtp-Source: ABdhPJwIklpi/h51hvenBK3dPMW53W//Rgdu3BJuXTZf80PreyVmG8ghWr6L+lu+4Y6H77AbpmjW0g==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr35608997wro.187.1638215959324;
        Mon, 29 Nov 2021 11:59:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/10] cat-file: make --batch-all-objects a CMDMODE
Date:   Mon, 29 Nov 2021 20:57:46 +0100
Message-Id: <patch-v3-06.10-fcb8331f091-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usage of OPT_CMDMODE() in "cat-file"[1] was added in parallel with
the development of[3] the --batch-all-objects option[4], so we've
since grown[5] checks that it can't be combined with other command
modes, when it should just be made a top-level command-mode
instead. It doesn't combine with --filters, --textconv etc.

By giving parse_options() information about what options are mutually
exclusive with one another we can get the die() message being removed
here for free, we didn't even use that removed message in some cases,
e.g. for both of:

    --batch-all-objects --textconv
    --batch-all-objects --filters

We'd take the "goto usage" in the "if (opt)" branch, and never reach
the previous message. Now we'll emit e.g.:

    $ git cat-file --batch-all-objects --filters
    error: option `filters' is incompatible with --batch-all-objects

1. b48158ac94c (cat-file: make the options mutually exclusive, 2015-05-03)
2. https://lore.kernel.org/git/xmqqtwspgusf.fsf@gitster.dls.corp.google.com/
3. https://lore.kernel.org/git/20150622104559.GG14475@peff.net/
4. 6a951937ae1 (cat-file: add --batch-all-objects option, 2015-06-22)
5. 321459439e1 (cat-file: support --textconv/--filters in batch mode, 2016-09-09)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c  | 25 +++++++++++--------------
 t/t1006-cat-file.sh |  7 ++-----
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 6d0f645301b..87356208134 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -674,6 +674,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			    N_("for blob objects, run textconv on object's content"), 'c'),
 		OPT_CMDMODE(0, "filters", &opt,
 			    N_("for blob objects, run filters on object's content"), 'w'),
+		OPT_CMDMODE(0, "batch-all-objects", &opt,
+			    N_("show all objects with --batch or --batch-check"), 'b'),
 		OPT_STRING(0, "path", &force_path, N_("blob"),
 			   N_("use a specific path for --textconv/--filters")),
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
@@ -689,8 +691,6 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			batch_option_callback),
 		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
 			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
-		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
-			 N_("show all objects with --batch or --batch-check")),
 		OPT_BOOL(0, "unordered", &batch.unordered,
 			 N_("do not order --batch-all-objects output")),
 		OPT_END()
@@ -699,30 +699,27 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	git_config(git_cat_file_config, NULL);
 
 	batch.buffer_output = -1;
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	if (opt) {
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc && batch.enabled)
+		usage_with_options(usage, options);
+	if (opt == 'b') {
+		batch.all_objects = 1;
+	} else if (opt) {
 		if (batch.enabled && (opt == 'c' || opt == 'w'))
 			batch.cmdmode = opt;
 		else if (argc == 1)
 			obj_name = argv[0];
 		else
 			usage_with_options(usage, options);
-	}
-	if (!opt && !batch.enabled) {
+	} else if (!opt && !batch.enabled) {
 		if (argc == 2) {
 			exp_type = argv[0];
 			obj_name = argv[1];
 		} else
 			usage_with_options(usage, options);
-	}
-	if (batch.enabled) {
-		if (batch.cmdmode != opt || argc)
-			usage_with_options(usage, options);
-		if (batch.cmdmode && batch.all_objects)
-			die("--batch-all-objects cannot be combined with "
-			    "--textconv nor with --filters");
-	}
+	} else if (batch.enabled && batch.cmdmode != opt)
+		usage_with_options(usage, options);
 
 	if ((batch.follow_symlinks || batch.all_objects) && !batch.enabled) {
 		usage_with_options(usage, options);
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index fc9191c1b94..ebec2061d25 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -14,7 +14,8 @@ for switches in \
 	'-p -t' \
 	'-t -s' \
 	'-s --textconv' \
-	'--textconv --filters'
+	'--textconv --filters' \
+	'--batch-all-objects -e'
 do
 	test_expect_success "usage: cmdmode $switches" '
 		test_cmdmode_usage git cat-file $switches
@@ -41,10 +42,6 @@ do
 	test_expect_success "usage: $opt requires another option" '
 		test_expect_code 129 git cat-file $opt
 	'
-
-	test_expect_failure "usage: incompatible options: --batch-all-objects with $opt" '
-		test_incompatible_usage git cat-file --batch-all-objects $opt
-	'
 done
 
 for opt in $short_modes
-- 
2.34.1.841.gf15fb7e6f34

