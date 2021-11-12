Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E10C433FE
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A83B60ED4
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhKLWXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhKLWXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1775EC061767
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id n29so17954102wra.11
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+ZFXZfB7ZyUGp1+MHBX4KL8uf3x5jVnEb5hUqbRYss=;
        b=WyhudGwL83klL+9SahuiSqQ4wdYCOJJ0I4jEuboHQmbfpYXnotRWtQQl2DgUGYQRoe
         mlEKjaoeYX1jjRC7XIwwAPiOm/TEPbh6hp0Bg256jHGYhb1PuE6lbD7o58mdGdhNyK4J
         23MUkB2NZlXK787oKqJZhkvRL/kF597WvyWvOTJ1eYomX087XWPkzZe3mp0I8eGFnPnV
         0Zm6ExQ7LQhOg6hZ/e7kEGMklGP6JKy8pzCCiSZhY5dOouDY+9GN7fmFaR/vrMiOsVHr
         QvVoEaCsy5v/EsV0IgDLt76s9Fhc/aX4IzK0QtKDZVPZ2cq0YLSXoDjJ3vh2OOYUwzuo
         Adrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+ZFXZfB7ZyUGp1+MHBX4KL8uf3x5jVnEb5hUqbRYss=;
        b=rqMpPG9+2JPkchVXn19ucd+4k60ELQnQ+HAi4ROUU4DRTqMW9clQmQKYipHWfZId7e
         sexcOyigWCo9DwJtEMWB/eq8a2uNhQERBkIBTs4pITDlUIsV8oajmjJTtBlIBwRBHabG
         x9G36eG+Qy9JF4Gx9yEqribN6ydjJUdqN53DaqAPpdC8N4d5KtLD/lDRPkxvOzPvCt16
         N3AQeSWQ8+RoQV7HEVWgp5jnFXm0wEAjL2NNmcLuGsBXxhc1s0S6jgcsMHg6QjeHkJOm
         L+vF0mWo4jZDl8faAp3GAqVXYLxhcFi8n8llaqfirKWohCgncIWdSkOT2qLucqi7ije8
         K+Gg==
X-Gm-Message-State: AOAM533t554Du/hFyxnmGWj5sudHEuwKovU5sW/+vJHwDTLtx17DlYQE
        wLrduTTJ4hOGuBlmboYKNsM2qwcnoNvb5w==
X-Google-Smtp-Source: ABdhPJzOjZgg++n8RTwWApTiVRZGlOILvaMjlUUkCA/a4QVoONyk7Sy7aeivmgFUcLkgUe9MEILK8Q==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr21283743wrv.212.1636755656402;
        Fri, 12 Nov 2021 14:20:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:20:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] cat-file: make --batch-all-objects a CMDMODE
Date:   Fri, 12 Nov 2021 23:20:04 +0100
Message-Id: <patch-v2-06.10-d945fc94774-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
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
index 411efc2771e..a5ceea5f624 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -14,7 +14,8 @@ for switches in \
     '-p -t' \
     '-t -s' \
     '-s --textconv' \
-    '--textconv --filters'
+    '--textconv --filters' \
+    '--batch-all-objects -e'
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
2.34.0.rc2.795.g926201d1cc8

