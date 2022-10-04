Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E929C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJDNZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiJDNYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BBF550B8
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a10so8966666wrm.12
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdcXZOF9MFAdkRo2pbGTUoEFaTN4YPLQX/US2iYRYJw=;
        b=LjIcWzXDwFwxyPCbSqlQtRDf8E+CXOjJrOmoT3LMXYGqGXoWhjeIYTomBC6zdH2p6B
         UsdQNlstvJ3RT969mbJ/XYwh1CbMwlLqeKHJOTHXbRpBff0eXa1r42tp6TE7HShMfQpd
         cQ7BveSuguoJIYFKIrMc9AkDh6DIKpXrTfL4JpbMxCdNyBVJjbfSUQR3FfuzhzAAidAs
         BsijHzHEqsHb0srJ7UeTwnQujis0D6kPUKEUxTIH+c5+GwAIwOLAuldspr1PMPCwagGO
         czCYs5NFH3aesvSv12R/62zU95mjQgRBDr9lpOG+GSCwe4Sy/uHv5FKDMSygAQ9q+z6Q
         Hvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdcXZOF9MFAdkRo2pbGTUoEFaTN4YPLQX/US2iYRYJw=;
        b=eqH1cJ6fp5ZKXmWa8yP6umDuxUkg5PcwYXWeM7jmaUUap/C4KnsaERV3aIjj4NZzud
         T68ML4zCRGrbNZBbQzdHiNLNwl/AFvUbG3B0g/00wn+y3uSf1Q4/fKSP3O0rHmkDp6UC
         65Nnxyk7Dq2IRpBKr0SRAcZ2mCThUS3OzFc77DdnopFJjjZK5uthF3fTDjAPJLkbjekW
         qJy1atG7HZWeAHo9wJjzyJqo12kivJ4GeA52ee10JWANmocCmlIZAEj2W9m+GLgXzQIZ
         9p5DsV7Q4CSN00pSKm/63UDgUABrvs3FG50YVtqfrie4xJl3JSnzKxBWRrvgYKK8eQNE
         QlTA==
X-Gm-Message-State: ACrzQf1g3K0/2UNxgVgLoSUiXDOsW2Jv+Rw2KEETJsEZjs1n0btf5+eY
        2fkQDbqEjknMo/KyBrqKcc0xJPL85mcrkg==
X-Google-Smtp-Source: AMsMyM53HGwhFwRA8VsBUMLyeHmA47+gXzLfzudjPh6mkUMcETfyXzSzyMGPixyuYiXjOYpA6KP+7g==
X-Received: by 2002:a05:6000:1541:b0:22a:3b77:6ef4 with SMTP id 1-20020a056000154100b0022a3b776ef4mr16148910wry.303.1664889864035;
        Tue, 04 Oct 2022 06:24:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 26/34] doc txt & -h consistency: make "annotate" consistent
Date:   Tue,  4 Oct 2022 15:23:40 +0200
Message-Id: <patch-v4-26.34-c02fc626542-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cmd_blame() already detected whether it was processing "blame" or
"annotate", but it didn't adjust its usage output accordingly. Let's
do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-annotate.txt |  2 +-
 builtin/blame.c                | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index e44a831339d..5ae8aabe0f8 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -8,7 +8,7 @@ git-annotate - Annotate file lines with commit information
 SYNOPSIS
 --------
 [verse]
-'git annotate' [<options>] <file> [<revision>]
+'git annotate' [<options>] [<rev-opts>] [<rev>] [--] <file>
 
 DESCRIPTION
 -----------
diff --git a/builtin/blame.c b/builtin/blame.c
index a9fe8cf7a68..71f925e456c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -30,6 +30,7 @@
 #include "tag.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
+static char annotate_usage[] = N_("git annotate [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
 static const char *blame_opt_usage[] = {
 	blame_usage,
@@ -38,6 +39,13 @@ static const char *blame_opt_usage[] = {
 	NULL
 };
 
+static const char *annotate_opt_usage[] = {
+	annotate_usage,
+	"",
+	N_("<rev-opts> are documented in git-rev-list(1)"),
+	NULL
+};
+
 static int longest_file;
 static int longest_author;
 static int max_orig_digits;
@@ -899,6 +907,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	long anchor;
 	const int hexsz = the_hash_algo->hexsz;
 	long num_lines = 0;
+	const char *str_usage = cmd_is_annotate ? annotate_usage : blame_usage;
+	const char **opt_usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
 
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
@@ -914,7 +924,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
 	for (;;) {
-		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
+		switch (parse_options_step(&ctx, options, opt_usage)) {
 		case PARSE_OPT_NON_OPTION:
 		case PARSE_OPT_UNKNOWN:
 			break;
@@ -934,7 +944,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			ctx.argv[0] = "--children";
 			reverse = 1;
 		}
-		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
+		parse_revision_opt(&revs, &ctx, options, opt_usage);
 	}
 parse_done:
 	revision_opts_finish(&revs);
@@ -1040,7 +1050,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		switch (argc - dashdash_pos - 1) {
 		case 2: /* (1b) */
 			if (argc != 4)
-				usage_with_options(blame_opt_usage, options);
+				usage_with_options(opt_usage, options);
 			/* reorder for the new way: <rev> -- <path> */
 			argv[1] = argv[3];
 			argv[3] = argv[2];
@@ -1051,11 +1061,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			argv[argc] = NULL;
 			break;
 		default:
-			usage_with_options(blame_opt_usage, options);
+			usage_with_options(opt_usage, options);
 		}
 	} else {
 		if (argc < 2)
-			usage_with_options(blame_opt_usage, options);
+			usage_with_options(opt_usage, options);
 		if (argc == 3 && is_a_rev(argv[argc - 1])) { /* (2b) */
 			path = add_prefix(prefix, argv[1]);
 			argv[1] = argv[2];
@@ -1113,7 +1123,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				    nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path,
 				    the_repository->index))
-			usage(blame_usage);
+			usage(str_usage);
 		if ((!lno && (top || bottom)) || lno < bottom)
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
-- 
2.38.0.rc2.935.g6b421ae1592

