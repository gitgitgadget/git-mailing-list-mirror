Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83257C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0E561027
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhKFVt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhKFVtw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:49:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1F8C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:47:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i5so19646130wrb.2
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNeutd+7Q6QYKDENZjGNOsI17wHLb60tv+jNnqHwQVY=;
        b=Rhf6abBWNLFiI9XaSRVUINug0ES3mJcVuU730UU/nQcpWzvhdbwck8Mv+kCx/HN1FZ
         4vYfzde2elsuuGjEn3LqQZQQ448PgSpN+SPBgN5DbnEi6ikZPMFAtZQqvGWOmCdf7+l3
         6A4ZlZB/r3+HrrbvtKZe/GhFS9W6hzCWqtus1+NJ7+ggKf9eTmFqHyUC0vNQ1GCO6AQS
         PVm2ymPL360jVgfZqKfA95xtwrrvOsof1x94PPWFGpppR3rF4vERCpEbZLcg9AmzEDO+
         dr2I/FR0qgyr5e2UaMd+Spkh27Q9UJ1hyhGRUZ5W+KvZLZkCIwwzAyAivo8+UhEbBKbI
         T6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNeutd+7Q6QYKDENZjGNOsI17wHLb60tv+jNnqHwQVY=;
        b=1QC1jNyzBE27QFFu+02CJld2dHbch0jPggQ9F5DzWlT25wHjNSgyYDDCrgzTzo99Ze
         +W16GTLs206xIbCMJygi4lLbBHlBImygWwq/7AAX/3ZWQLya5Zj4Jy9m2LpYkYHXIkEB
         o2LG+xJNmTRmLTLBbD+CiTVslZfsevY0efTox2aWm6ixFlXo0lT7UaVYNo2erVeUigcv
         NGH/CkKkYsZjUaPmIIR6pdNL/FufaTdGMFyVvRrogVXt+Ooz/rqJxByMf797nbhZUOgq
         Jm4m2wSzR21wGkDk7aDGUTknh7QJZvNqcizhQ0H9idC2mUxYhYMAH26H4Q/0ku9cecQS
         lgpQ==
X-Gm-Message-State: AOAM530THbbjCR5JUE8SnYXKXg5zILVRBjSM+TuQtRKo19uFMg6RLLZM
        4mhd3kJiOqUzsBATOObAV5wK4XdDuJdEMw==
X-Google-Smtp-Source: ABdhPJwZntuGpbAK+T946bBTSv8PJDjO9TLKN25l6gyqpLDl3ep/RCMq284wH6QUf6q0xmhw4IV8jg==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr36858875wri.343.1636235229104;
        Sat, 06 Nov 2021 14:47:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12736630wmq.34.2021.11.06.14.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:47:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] cat-file: make --batch-all-objects a CMDMODE
Date:   Sat,  6 Nov 2021 22:46:58 +0100
Message-Id: <patch-06.10-ee49e586483-20211106T214259Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
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
exclusive with one another we can get the die9) message being removed
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
index 0ad00e1fe73..44285f749cd 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -14,7 +14,8 @@ test_expect_success 'usage: cmdmode' '
 	test_cmdmode_usage git cat-file -p -t &&
 	test_cmdmode_usage git cat-file -t -s &&
 	test_cmdmode_usage git cat-file -s --textconv &&
-	test_cmdmode_usage git cat-file --textconv --filters
+	test_cmdmode_usage git cat-file --textconv --filters &&
+	test_cmdmode_usage git cat-file --batch-all-objects -e
 '
 
 test_incompatible_usage() {
@@ -37,10 +38,6 @@ do
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
2.34.0.rc1.741.gab7bfd97031

