Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECE7C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiI1Il1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiI1IkL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15679DB66
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n10so18576599wrw.12
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JwW9+j7ZpAfyMgKw9qmyd2HRcrMPK75yQjTKQLqzqIM=;
        b=NtbRvJB+44W3VsnHm+YQnDcBz7MOoTNQcKnrxLmrPg0n1FqQAI8GsWWlkgg2cvYfaQ
         /K4HATkFwwjM5Jz0uzk1uoU21P5/w+/7zWye1eCRvC1SuFPeJUlZDAqIT3N9t3TMNYqr
         B2VmXfi4sHTPJflVzHAqQ3viZMT5VXpXcQKBh7D//VhbTtM258RymkyThU10owoXnaFr
         ukUSjjQHzs+yA3ZXaeyyGWLiTcI4DhCGYFrptC22r519SmAzoZHqTZZHQpSkxEJXV9zk
         QUkpBCOFDFZuxxQVN8jacX+/NMN1b8zucbIdLlTf2fbRsUfxvJ1QRj7xp4PLT8yf9OX1
         8Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JwW9+j7ZpAfyMgKw9qmyd2HRcrMPK75yQjTKQLqzqIM=;
        b=7FnBfYtP0tUrUH/nkAq118mqktKKv59XsKCM7A37+ozOGNr4184QoVJ7fofqD1RcMS
         8SnCKBaFnfrAiFVGaL3roFfwxJkBl54oawP2/1jAf5ApYEcpQRvgEJSrayjNQlobhgOJ
         5wj4B78tESRp7JbOlJRQLw4WlceIRT/aG8XcGUyss1E7hKpfe0VQZjeiD6csCKfCSroJ
         TXI81ZARDcg5ffccv4r8Dx+wuSSm9Q7G8l0G9gp8gYCT8F0z12UTQ9duuOn4c1a8jNCg
         s5p2HVBweVzUOV8YvNURYRrXSjNNnxYTgish3VQBqGh8NH0lXE/TagdJfmEKY3B5xW5d
         yQ5Q==
X-Gm-Message-State: ACrzQf1fVF3bUZlRmrbBNxBLGpqrLj1Fnsmei43bCFyr+XdQc/+wQrZq
        HsJ+ZWBMiLgWzJTXV2uQis50tKnpJhco3w==
X-Google-Smtp-Source: AMsMyM7Lw6m7vkUS9DNxQkfjplCHoFGP0+Octz8Q24/z5S0nhoaAyzrXKRXmGiCChWe34MZPNG5Lvg==
X-Received: by 2002:a05:6000:1b0e:b0:22a:e807:caf0 with SMTP id f14-20020a0560001b0e00b0022ae807caf0mr18788788wrz.569.1664354404953;
        Wed, 28 Sep 2022 01:40:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:40:04 -0700 (PDT)
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
Subject: [PATCH v2 27/35] doc txt & -h consistency: make "annotate" consistent
Date:   Wed, 28 Sep 2022 10:39:22 +0200
Message-Id: <patch-v2-27.35-42415194e3f-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
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
2.38.0.rc1.925.gb61c5ccd7da

