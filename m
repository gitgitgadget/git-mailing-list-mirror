Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E116C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiI3SLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiI3SLB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:11:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14F02B257
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so2618214wmb.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ATY170yQD8dqtN+/uOXCLrSfdU/i5/QrOyX5VN/4Tgg=;
        b=Yt/t6z7een7u1rR3pUpn+DdfcnIC7mh46k5bQALPzNudfS+3Yl5OcHhtFyYC/5v7jd
         M+I3DWS+q9tR6ESqYuBMWA0dd5ravEmU/PwmLeqfqiLaimQurS2mVVkZtzBXJrQePPbQ
         yCxC0w1On2w9rVPs9RaMj24FEiqSFHExCmt8rZ7ecjqCeLf626OfxbUztdGAFurwFIw9
         YC5660YN9rjRil0I55jUHGPgPTVinJHwC40+XLjzJbc3Ho9vMbrxu8Xtj0cXBnoQT8/Y
         zqaeGTo+3oW/DLRI6rckdA1MWS3lAf0zJISLu7Lhh+lWmqXiBRdMzfGUdaqcKpijfoEw
         xNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ATY170yQD8dqtN+/uOXCLrSfdU/i5/QrOyX5VN/4Tgg=;
        b=HwxzoMrujd9CjTWAoGOzCzdsL3kPB+r4NqIbXf3zVsnVLbeTy17hzhZJHAGF6u4O5B
         KikdJnaM1IFeBD63cKMFp+WuUlZy044h4y/zdhhQs9JhKDUqCqoKdwTnvApWfOo6vZHu
         Ki8aIysjAna3Ig5mEGMpFBJ7yEznmx7nqyIi60IG61Kgl37z2Q8rYf7usE1AShFvikr7
         AqqBKhYOgBTFKR2yawreyoQgXzicsxiOnd7FCePn52wbqGuPklJz9v19fDIxuUtDFTsg
         fl+XcQoz4B73UKKZAduqRvvb5ZzI6avIa76+UuJoTvGQ23n445w0k2zJVBHwnq6QGQLH
         B+CQ==
X-Gm-Message-State: ACrzQf278+1aCIzhMUNABw2dFZonH5dTnQyTjZNoOdTSGvr3PoLy30D4
        hF+3RroAfMG7hVPWtAO1mMTJBJBv3Y2MyQ==
X-Google-Smtp-Source: AMsMyM6e5qB02RBjMXM3xarNUh0u6DNbhT6OcrvgNC5gRVe6EmaYHr5F+aTKYBdJKf5bJhk4AL0glA==
X-Received: by 2002:a7b:c8d6:0:b0:3b4:868b:afc3 with SMTP id f22-20020a7bc8d6000000b003b4868bafc3mr14628815wml.66.1664561383104;
        Fri, 30 Sep 2022 11:09:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:41 -0700 (PDT)
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
Subject: [PATCH v3 28/36] doc txt & -h consistency: make "annotate" consistent
Date:   Fri, 30 Sep 2022 20:07:51 +0200
Message-Id: <patch-v3-28.36-f617375ea9e-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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
2.38.0.rc2.935.g6b421ae1592

