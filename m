Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70ACC43217
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJMPlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJMPkr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9D060CBF
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so3469105wrr.3
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4M93J1gNcSH2P6msEHYVMivY0l4xZDSBRF0GyBezBc=;
        b=qjSCWFuQiGM0wM1RPVEgj6T51pflNSZ9Hhn4LHSH0DnJNnBIm5aYCUMpS+FGQ1Pwb6
         1TsgJA4MiNjnN/lp4SfT71HOzU92pD4GAtuwi9leeOpkRpna2UjzwBFr9neAybfqwRd8
         pyV8o4kpPt8jzvs7Oc6spWunAE6zuZuUVgP0MNAxnzWsTnFWjIfKXU6qkiAhpfuOP2Mj
         KTFaadYvcx3j79MOEsuDGuUcn6mxXy9fZqQKV0lF6dAO+g6b0n+SlpEZIQFzmtWZYFJw
         RO2BqwY6VNmIAwyumY8G44nwj7yCDu9T8WhrX1xwwu4L32ZMhufnRrE9SzxtYQC0SrOR
         r8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4M93J1gNcSH2P6msEHYVMivY0l4xZDSBRF0GyBezBc=;
        b=FMG0iGYb9axhmEIxZUQbJ2lwcYJzDBJn2pbBpZKQA+sD5NqZTetQpgSa56tNoLKIdg
         6RNWDA1hTKT21q97zg126VpQC4CGGB1nbIZBJpLru3pEy6sQ7gU3Trc802Ucw/hlGoBZ
         EEgjO9D4QbQ5Cq0+we5D3jzXGoPmfgTHfNPlpm5VhgbwHjoALkmJZ2pFn+bq9XzWljHt
         r5eAVQro44vcJI3b0L2LRPL/kbEJvCj359GebzKA95+92ECNWWO6KPeKoVFPyW+fv3k2
         zt9YUsL5ILVCO37d7rrKZff43ZALjFIKq3dliUPZvGyVSUAF5dP4CUDfCpHDegq9Ihet
         8iBA==
X-Gm-Message-State: ACrzQf269DPxJwCzDnIhzLs34+8+63z5CCgNiCUcLuDNF4ED1PwWvJ3n
        DbKcvjKGSjqKrZdC85muOK7sLIT9BqDgeA==
X-Google-Smtp-Source: AMsMyM5ZvQGPSFne6HCQMDKlWjkNqMnXN8KMymG0sZG4yMlZ014QyrfPk/UgdSSSU31j2qUyNFB/7Q==
X-Received: by 2002:a5d:5691:0:b0:22c:db35:7939 with SMTP id f17-20020a5d5691000000b0022cdb357939mr411030wrv.102.1665675602265;
        Thu, 13 Oct 2022 08:40:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:40:01 -0700 (PDT)
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
Subject: [PATCH v5 26/34] doc txt & -h consistency: make "annotate" consistent
Date:   Thu, 13 Oct 2022 17:39:20 +0200
Message-Id: <patch-v5-26.34-a7762e82f71-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
2.38.0.1085.gb7e61c3016c

