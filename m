Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C79C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhLVENV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242246AbhLVENN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:13:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B848C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v11so2073502wrw.10
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIv5sB8N8jFCjaf3EwY+A+RiWEJ/iT+I3166FGXXB8E=;
        b=GTaaeXxwLPd2H72FZB/mo3zU0U4/rTpmLXmPNKCxk08kHcd7j66aJ9NnWCqqz/2mD5
         VkYgq1wmsIRmzBeBSeW6vO4rxa1+c/h2kb/JvemgXG/VKitt+8asStSBJM8eVQWKN2CE
         J5g6XFpPvjLMz6MWhRVoG0eBb4L7poGFMyz0OEHpFm80Q1WtWZ9rEtTFaO321/bUERan
         40kRMWKBmC0cWD175Ffd4BDXiuZhPb7cYqM8tK+XDBfZyb1tlWTtDGvsYCojfgP6yror
         xftEcO3ebQwdQuVbfPtrPJ6Im2IIF1mHsryYY53W+0LriMjBNqSetzYQ71lqt0JeL3dh
         GVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIv5sB8N8jFCjaf3EwY+A+RiWEJ/iT+I3166FGXXB8E=;
        b=7YEOXTS1tSJ1uxkoW9Vo9dzHKlw976AkL1MwQgUPjGdzr7mFQZY/3roJG5+WS7wxtH
         wjuotgp2sT7QaYW/rMcIS1f8rQ7wL+FPAZUcmMf4ovhCx/JF+FimAhblSR9z5IrN+fgx
         Yl2OtWnn/vWoLFwNPqIgBe0iVfOzq016eFCVcnNo8Hxta4YVpiTTeXJCESKAUfol342G
         prNp5wObnoqQfrukr/DAtparlzn9BaL99ZbaWuRQzroeypz5sWQww0YCW5ONVDSuIKFO
         QyXipnoL08c/fYnXMKfM8rx2lGUZIQQ1pcJeLJ+HWCHzrEj5/zcSYEwtJKzpH1Oa94eQ
         wiLg==
X-Gm-Message-State: AOAM532d76mplBbsRr3d/0OntCb33BqIeB3ZpqD1RZX4MnHHknsOhv84
        5GqYDMzBHiI8YuUCeogTkDHZSOx236YI1w==
X-Google-Smtp-Source: ABdhPJwfikWCXmlXssD/gF3tEZI1I3KRQFe79PJp5g1kcH99j28gRh4aDGohygYpR+ZCUz2bUBTxPg==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr723251wrx.426.1640146391504;
        Tue, 21 Dec 2021 20:13:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm749650wrd.92.2021.12.21.20.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:13:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/10] cat-file: make --batch-all-objects a CMDMODE
Date:   Wed, 22 Dec 2021 05:12:59 +0100
Message-Id: <patch-v5-06.10-227805d1804-20211222T041050Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
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
index 8a29f96809d..2ce5c8b1824 100755
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
2.34.1.1146.gb52885e7c44

