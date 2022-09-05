Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E0EECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiIEI3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbiIEI2U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:28:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D828735
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e13so10305706wrm.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ce3XLDISzey2ieFLGY+uKGw7rUCZk2DD+kz5cP1bPzo=;
        b=qVSkFUmUEw6LZfCTNt4VYFdCf4oNOMGtRWHaMKEYOOxu5IlCDp0gt3vb25/YwIOHWb
         etoxxiqstvczTGAHCU4GZiscoMe0qYLWzXrXWuLsMPt1hGzYznPVygCWh0vgEQkEx6tm
         nuPuQKF8QYhL1U0x+Mjgps8kfr5YGq7udr1td/2WvArDYjt45sllQ+EI67r0Ewr+jXei
         /IMFJE0fVivFyt7ZqDdBwupmqTt0pxRo41A8Vfu6iX5IlvWzU8UoPuKxtw/6tekbdzMg
         XSp8mnDPsRa9yFdmdobQ8D2ITYjw5y9y3bpQTYxav+fkljIpYM+6iTbW+tFZHjVjqgqE
         dciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ce3XLDISzey2ieFLGY+uKGw7rUCZk2DD+kz5cP1bPzo=;
        b=M7S+Kfsg6NiQ5uGE+aUeryGYyCA5p2iCX4fkLWInu0r2GkiMdAzPC4OwwAIvTvHS+z
         hXqCHSMzWmNvbMzA2zOlKBNCbTyi6QeJcEssNPrsZy8GTdU0Vqh2b5js1uLC+pkrTtBz
         wPG5SNuC9xP9K8uJQPbcc33MYrMhgUBI9wuVn1hSYrcYCXpuuyj/xVCsjnzOmUSbHD39
         owZi/n1wvWTtngNLURCsGzQqrA3EAzteEikha4MG/qLmfYquSLdnvBcY32m36IDj6Tf+
         qDWvuY342wwDzr43QEvxt5lWO1b/AyMqam+nA8zpbyZQuSO8fJsJO8xnCl1jqwqYlygE
         RiRA==
X-Gm-Message-State: ACgBeo3MAJYGQEG4lUOTO3x2YmhuOV8awtWyI5a0ngN9iREsa9xeI9SD
        kjOkCfdRinvN/sJdKcrcweXV2F02RR6rTQ==
X-Google-Smtp-Source: AA6agR7mLup5M+EX0u8qy9EDNpqDV1IrmFdwAkbnwc9EBv5JlOhPg99bVxag5Q0Xy9tvAKWULZN8og==
X-Received: by 2002:a05:6000:381:b0:221:7540:b1ee with SMTP id u1-20020a056000038100b002217540b1eemr22985682wrf.307.1662366438091;
        Mon, 05 Sep 2022 01:27:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 27/34] doc txt & -h consistency: make "annotate" consistent
Date:   Mon,  5 Sep 2022 10:26:38 +0200
Message-Id: <patch-27.34-f6c9fb63a08-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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
 builtin/blame.c                | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

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
index 8ec59fa2096..be9e091a86b 100644
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
@@ -899,6 +907,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	long anchor;
 	const int hexsz = the_hash_algo->hexsz;
 	long num_lines = 0;
+	const char **usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
 
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
@@ -914,7 +923,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	parse_options_start(&ctx, argc, argv, prefix, options,
 			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
 	for (;;) {
-		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
+		switch (parse_options_step(&ctx, options, usage)) {
 		case PARSE_OPT_NON_OPTION:
 		case PARSE_OPT_UNKNOWN:
 			break;
@@ -934,7 +943,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			ctx.argv[0] = "--children";
 			reverse = 1;
 		}
-		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
+		parse_revision_opt(&revs, &ctx, options, usage);
 	}
 parse_done:
 	revision_opts_finish(&revs);
@@ -1040,7 +1049,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		switch (argc - dashdash_pos - 1) {
 		case 2: /* (1b) */
 			if (argc != 4)
-				usage_with_options(blame_opt_usage, options);
+				usage_with_options(usage, options);
 			/* reorder for the new way: <rev> -- <path> */
 			argv[1] = argv[3];
 			argv[3] = argv[2];
@@ -1051,11 +1060,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			argv[argc] = NULL;
 			break;
 		default:
-			usage_with_options(blame_opt_usage, options);
+			usage_with_options(usage, options);
 		}
 	} else {
 		if (argc < 2)
-			usage_with_options(blame_opt_usage, options);
+			usage_with_options(usage, options);
 		if (argc == 3 && is_a_rev(argv[argc - 1])) { /* (2b) */
 			path = add_prefix(prefix, argv[1]);
 			argv[1] = argv[2];
@@ -1114,7 +1123,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				    &bottom, &top, sb.path,
 				    the_repository->index))
 			usage_msg_optf(_("failed to parse -L argument '%s'"),
-				       blame_opt_usage, options, arg);
+				       usage, options, arg);
 		if ((!lno && (top || bottom)) || lno < bottom)
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
-- 
2.37.3.1425.g73df845bcb2

