Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7AEC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhK2WWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhK2WVF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:21:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8733C091D02
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d9so18455209wrw.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sK0v7ziyFMvr9O6AveqOhAFrbYfb8paFOSsBARApIeI=;
        b=aeQZCxEmnkqS+2G9iGRRtgmUxM5cqjpZI2IaTLfmEyCR6JTUUhjAbz3urqapv4lRYC
         Rhcfno22g7tEkdbAg5nZUKXoS8nRfpHIyrkw1zqpwt8YSf4+3ASAM3Ban9DXStYb6IK8
         YmPMvrnEpFZU8+KYL0o0QW1025/5WoI/sjk+fi+rVLnLbB8VDtH44eqOjG4DaVU6gzmK
         sd4WIMtBHPcr4npaSjfkbGeiOkKUmfXK2kpCY0t48j6qt/HnZLkvDS+mZ1ROUZKhfXsS
         aU/2hQNorvKxgHcgwgbcXCWmB6HiVW8eArJHFMOOW3QhlhqXfHJunpqTGySmBVTgz3xW
         XvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sK0v7ziyFMvr9O6AveqOhAFrbYfb8paFOSsBARApIeI=;
        b=gkoz118FnNTeR6gaM1ILR4K199cAQZMEtBqzfUMe5tEdGMgD+IFk+C977kxBJ/Alhn
         oND7p8q+e68g8Dvfv57Iv0CG5R3Txx3eKu5Ml5P7Nu5X8MbjSFc1VHcyD4Mp5Jke5AaN
         kHJOM5x913pI5OFORVzMy4ZiSIXjnphThQVkPXQ9kDQ62rJC4Kc2tv2XdkPfyKuYre6v
         a6iSNVO3j0oxMtNkMlRY5v34o2k07T62VsWz9T9FVEWUT17spjspcCD4J5yS+Osm0EN7
         VXBbbasiULu4aY0bBP2x/hmj9Ct/mucoXm6J+XRyt/o7L7kW8268v5UuGjG+sn24Ubr7
         FaDA==
X-Gm-Message-State: AOAM530Nn5QdL4pEz7Uv7B/9IT7QXO2Y+/VkjW0ODhKD/fnsUJ6sgRWo
        g5uyqTGczbDjXz1DQSklruLNf59eMb2+8A==
X-Google-Smtp-Source: ABdhPJzTuGBZ/v3DTn+j3W/up7/UfEUFzHQwa8+yTuOcaLAcBhUUEs5VnWkobkF8I032vwNobTUSnA==
X-Received: by 2002:adf:f206:: with SMTP id p6mr36217165wro.509.1638215960197;
        Mon, 29 Nov 2021 11:59:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/10] cat-file: fix remaining usage bugs
Date:   Mon, 29 Nov 2021 20:57:47 +0100
Message-Id: <patch-v3-07.10-ad79e2afc89-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
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
index ebec2061d25..123801cfe2a 100755
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
2.34.1.841.gf15fb7e6f34

