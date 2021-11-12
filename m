Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC8C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEFB60F6B
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbhKLWX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhKLWXu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:50 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0DAC061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:58 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso7861032wmf.0
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anM0TfbFxag75Wg2pba/YvElWgFmnC+DOQTqyTZ6BHE=;
        b=Q2ipQsu36D56skwIHnqlPQ6X626TEP3/91qnYlAS5aT3L4wYlaG0JAMJxPXZZvZ+uJ
         FpnuL9J7pxyPnfrh4U/xy+CEjLruzYsA5V3l/tfFWhYaY0VgP2w4B/Lh9/hgWyTxU9+S
         TFarhirGT/wDxEupztWDfEksx6TEqvnmP+W/j2rr2hTc/GFygeyyIptwMngftkxWFJye
         Dc7dZYoyAQYQaRcpqiZZECOunFSYLS9U9ouI3rPZJTKCKSSG4t0cSxhLOjo8Gvdpb3dl
         tHSWiqEmsZrOVgBVd2WMBGtQ1Vk/Qxs99vzw2F34/8eeCJ2N5xyvWEfRhpMrb7zghpY/
         YtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anM0TfbFxag75Wg2pba/YvElWgFmnC+DOQTqyTZ6BHE=;
        b=J+viMeDLyGyR5+GkICVq3HRlnOiAKHlk7SO5nWNC2Nbo8xV8dllvgey/iolTzyzRTM
         b+iYBgTUsZkajLlqkidW4DmDMcZ9rmYAzA4JjUZXHr6w3xOqErJZzpfj8tuuaIrRoF43
         5WTvXaGBkoFqAZnIPre8dhROuaPKhFSkNblg+3L7+8JQU3jbclhOYDA9MWa4gAJBF81+
         AXWwN0hZ5eEaPsfn6PvWz0n/ZSR/WMs8bwc5wVWrCNVNj8kArtWPkK0kmVs/XZAOKg4m
         XSDWQD+Imr0W/ArRQ15LLNfabJb5LVRjBS/T5MPrNJ8Iky2ofHvoT9b93PgGSfI2XwZL
         +mfA==
X-Gm-Message-State: AOAM530Y+D7FFAvE+zXv5inPXPgI+CQlBvLGI8jeP/P/isA04E4aUTc6
        wazbFQH1q7Vw4Cfb0dS0o+66JlVaxNrHjg==
X-Google-Smtp-Source: ABdhPJx9blUYMB2F4BLsJULhWg6YngFGA7Ype3GCiQfBegn+qWsB4qPpzkOy9ib7JjWcdoOtLVpZZw==
X-Received: by 2002:a1c:9dc6:: with SMTP id g189mr20479265wme.87.1636755657145;
        Fri, 12 Nov 2021 14:20:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.56
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
Subject: [PATCH v2 07/10] cat-file: fix remaining usage bugs
Date:   Fri, 12 Nov 2021 23:20:05 +0100
Message-Id: <patch-v2-07.10-22f55e1fb6b-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the migration of --batch-all-objects to OPT_CMDMODE() in the
preceding commit one bug with combining it and other OPT_CMDMODE()
options was solved, but we were still left with e.g. --buffer silently
being discarded when not in batch mode.

Fix all those bugs, and in addition emit errors telling the user
specifically what options can't be combined with what other options,
before this we'd usually just emit the cryptic usage text and leave
the users to work it out by themselves.

This change is rather large, because to do so we need to untangle the
options processing so that we can not only error out, but emit
sensible errors, and e.g. emit errors about options before errors
about stray argc elements (as they might become valid if the option
were removed).

Some of the output changes ("error:" to "fatal:" with
usage_msg_opt[f]()), but none of the exit codes change, except in
those cases where we silently accepted bad option combinations before,
now we'll error out.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c  | 95 ++++++++++++++++++++++++++++++---------------
 t/t1006-cat-file.sh | 41 +++++++++----------
 2 files changed, 84 insertions(+), 52 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 87356208134..f507e3ae46c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -648,6 +648,8 @@ static int batch_option_callback(const struct option *opt,
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	int opt = 0;
+	int opt_cw = 0;
+	int opt_epts = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 	struct batch_options batch = {0};
 	int unknown_type = 0;
@@ -701,45 +703,74 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	batch.buffer_output = -1;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	if (argc && batch.enabled)
-		usage_with_options(usage, options);
-	if (opt == 'b') {
-		batch.all_objects = 1;
-	} else if (opt) {
-		if (batch.enabled && (opt == 'c' || opt == 'w'))
-			batch.cmdmode = opt;
-		else if (argc == 1)
-			obj_name = argv[0];
-		else
-			usage_with_options(usage, options);
-	} else if (!opt && !batch.enabled) {
-		if (argc == 2) {
-			exp_type = argv[0];
-			obj_name = argv[1];
-		} else
-			usage_with_options(usage, options);
-	} else if (batch.enabled && batch.cmdmode != opt)
-		usage_with_options(usage, options);
+	opt_cw = (opt == 'c' || opt == 'w');
+	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
-	if ((batch.follow_symlinks || batch.all_objects) && !batch.enabled) {
-		usage_with_options(usage, options);
-	}
-
-	if (force_path && opt != 'c' && opt != 'w') {
-		error("--path=<path> needs --textconv or --filters");
-		usage_with_options(usage, options);
-	}
+	/* --batch-all-objects? */
+	if (opt == 'b')
+		batch.all_objects = 1;
 
-	if (force_path && batch.enabled) {
-		error("--path=<path> incompatible with --batch");
-		usage_with_options(usage, options);
-	}
+	/* Option compatibility */
+	if (force_path && !opt_cw)
+		usage_msg_optf(_("'%s=<%s> needs '%s' or '%s'"),
+			       usage, options,
+			       "--path", _("path|tree-ish"), "--filters",
+			       "--textconv");
 
+	/* Option compatibility with batch mode */
+	if (batch.enabled)
+		;
+	else if (batch.follow_symlinks)
+		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+			       "--follow_symlinks");
+	else if (batch.buffer_output >= 0)
+		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+			       "--buffer");
+	else if (batch.all_objects)
+		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
+			       "--batch-all_objects");
+
+	/* Batch defaults */
 	if (batch.buffer_output < 0)
 		batch.buffer_output = batch.all_objects;
 
-	if (batch.enabled)
+	/* Return early if we're in batch mode? */
+	if (batch.enabled) {
+		if (opt_cw)
+			batch.cmdmode = opt;
+		else if (opt && opt != 'b')
+			usage_msg_optf(_("'-%c' is incompatible with batch mode"),
+				       usage, options, opt);
+		else if (argc)
+			usage_msg_opt(_("batch modes take no arguments"), usage,
+				      options);
+
 		return batch_objects(&batch);
+	}
+
+	if (opt) {
+		if (!argc && opt == 'c')
+			usage_msg_optf(_("<rev> required with '%s'"),
+				       usage, options, "--textconv");
+		else if (!argc && opt == 'w')
+			usage_msg_optf(_("<rev> required with '%s'"),
+				       usage, options, "--filters");
+		else if (!argc && opt_epts)
+			usage_msg_optf(_("<object> required with '-%c'"),
+				       usage, options, opt);
+		else if (argc == 1)
+			obj_name = argv[0];
+		else
+			usage_msg_opt(_("too many arguments"), usage, options);
+	} else if (!argc) {
+		usage_with_options(usage, options);
+	} else if (argc != 2) {
+		usage_msg_optf(_("only two arguments allowed in <type> <object> mode, not %d"),
+			      usage, options, argc);
+	} else if (argc) {
+		exp_type = argv[0];
+		obj_name = argv[1];
+	}
 
 	if (unknown_type && opt != 't' && opt != 's')
 		die("git cat-file --allow-unknown-type: use with -s or -t");
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index a5ceea5f624..cc478a9c87a 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -24,7 +24,7 @@ done
 
 test_incompatible_usage () {
 	test_expect_code 129 "$@" 2>err &&
-	grep -E "^error:.**needs" err
+	grep -E "^(fatal|error):.*(requires|incompatible with|needs)" err
 }
 
 for opt in --batch --batch-check
@@ -34,48 +34,54 @@ do
 	'
 done
 
+test_missing_usage() {
+	test_expect_code 129 "$@" 2>err &&
+	grep -E "^fatal:.*required" err
+}
+
 short_modes="-e -p -t -s"
 cw_modes="--textconv --filters"
 
 for opt in $cw_modes
 do
 	test_expect_success "usage: $opt requires another option" '
-		test_expect_code 129 git cat-file $opt
+		test_missing_usage git cat-file $opt
 	'
 done
 
 for opt in $short_modes
 do
 	test_expect_success "usage: $opt requires another option" '
-		test_expect_code 129 git cat-file $opt
+		test_missing_usage git cat-file $opt
 	'
 
 	for opt2 in --batch \
 		--batch-check \
-		--follow-symlinks
+		--follow-symlinks \
+		"--path=foo HEAD:some-path.txt"
 	do
-		test_expect_failure "usage: incompatible options: $opt and $opt2" '
+		test_expect_success "usage: incompatible options: $opt and $opt2" '
 			test_incompatible_usage git cat-file $opt $opt2
 		'
 	done
-
-	opt2="--path=foo HEAD:some-path.txt"
-	test_expect_success "usage: incompatible options: $opt and $opt2" '
-		test_incompatible_usage git cat-file $opt $opt2
-	'
 done
 
+test_too_many_arguments() {
+	test_expect_code 129 "$@" 2>err &&
+	grep -E "^fatal: too many arguments$" err
+}
+
 for opt in $short_modes $cw_modes
 do
 	args="one two three"
 	test_expect_success "usage: too many arguments: $opt $args" '
-		test_expect_code 129 git cat-file $opt $args
+		test_too_many_arguments git cat-file $opt $args
 	'
 
 	for opt2 in --buffer --follow-symlinks
 	do
 		test_expect_success "usage: incompatible arguments: $opt with batch option $opt2" '
-			test_expect_code 129 git cat-file $opt $opt2
+			test_incompatible_usage git cat-file $opt $opt2
 		'
 	done
 done
@@ -84,14 +90,9 @@ for opt in --buffer \
 	--follow-symlinks \
 	--batch-all-objects
 do
-	status=success
-	if test $opt = "--buffer"
-	then
-		status=failure
-	fi
-	test_expect_$status "usage: bad option combination: $opt without batch mode" '
-		test_expect_code 129 git cat-file $opt &&
-		test_expect_code 129 git cat-file $opt commit HEAD
+	test_expect_success "usage: bad option combination: $opt without batch mode" '
+		test_incompatible_usage git cat-file $opt &&
+		test_incompatible_usage git cat-file $opt commit HEAD
 	'
 done
 
-- 
2.34.0.rc2.795.g926201d1cc8

