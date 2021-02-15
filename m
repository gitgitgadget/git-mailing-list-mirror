Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D4C4332B
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBEF64DF0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBOVCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhBOVCd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 16:02:33 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DAEC061788
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:01:51 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id x14so7652176qkm.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/b52xhIUWI7qN7nCecignICrg1moxxqCSViEAWPuqHk=;
        b=t2gh6gLFHPFgn8GUNASvZF7aybMgZktktVGMKNxRWUEneKOZRBN512fcFHkPC0IPaK
         qSv43+H+E3/FJsD6/YLmrl4rblMzckLbeaRAwZr+/tbUYBvreEJlUGxokN8R00H0oRzx
         ZcJ3kjYtC21gO6+hRGRi8EM7UOQKuPbPSGXbwvgbtTNzOqvrcX043h+/6V/FhBkNaW2N
         sxLovdWF1K4SOFXUXbBO0IjXGZg4WYNrGZHPqucbevjX1FicSAjLGJCW5aKXDZIb0V6h
         G0zRV/doQNHTCOkPVMBOu1syMrtgXoHhONCTprz+47xzq/PcUrZp1a8LeEyeqDf7KCC0
         Tj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/b52xhIUWI7qN7nCecignICrg1moxxqCSViEAWPuqHk=;
        b=kzms+9mMyxBDSiNegA9e+6NIyKdkZCXjdydJW9ifYRHpYdNG778paJysfisRcdSrKu
         S/FV99ASGHTvU40e3Z6mzNIYwr4whg9iG5/BkRN4T8o/Oc7Pm+Ta1LbCGMxMdZeTDqFC
         O3aVD0F1MB6A4q679/rsAfRxx2cd8Enkc08Ba1+97YEUBvFDsQmlPqfy21fMd7cMAJWc
         xlBA6ol/DAk9SAD8Oe1wYHzw5GeixB5basKgPRTYaZNKNudy0WeAnvCDVyTrhu7zyarS
         Sxdo8W0CwDjoM/u9O3SMDHJDUA3wg2fL9BHtKvFfrN233ChS3uvHHwe/PdCA/fRV7J0U
         kDaA==
X-Gm-Message-State: AOAM531S97B0eup3WU+TFmHdl8ecbk3oCLXkldHgEOiILhDTqfh1QAtv
        n2V4X0OUPVMS3yxlBORY4qhkUCAOG61YrbOf
X-Google-Smtp-Source: ABdhPJxqQxwQ3rdXIHyl6lD/PjkKzaijOk5zB2YLix7rMDUImqdLFTQoxeBapq2b1nRA+VIqAuKZZQ==
X-Received: by 2002:a37:b346:: with SMTP id c67mr16682784qkf.212.1613422910901;
        Mon, 15 Feb 2021 13:01:50 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:808e:e46a:5ad1:bdf0])
        by smtp.gmail.com with ESMTPSA id t71sm12754191qka.86.2021.02.15.13.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 13:01:50 -0800 (PST)
Date:   Mon, 15 Feb 2021 16:01:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
Subject: [PATCH v2 4/4] builtin/multi-pack-index.c: split sub-commands
Message-ID: <16f33e41388ed431f70e09ef68717bd30fbee67f.1613422804.git.me@ttaylorr.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1613422804.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Handle sub-commands of the 'git multi-pack-index' builtin (e.g.,
"write", "repack", etc.) separately from one another. This allows
sub-commands with unique options, without forcing cmd_multi_pack_index()
to reject invalid combinations itself.

This comes at the cost of some duplication and boilerplate. Luckily, the
duplication is reduced to a minimum, since common options are shared
among sub-commands due to a suggestion by Ævar. (Sub-commands do have to
retain the common options, too, since this builtin accepts common
options on either side of the sub-command).

Roughly speaking, cmd_multi_pack_index() parses options (including
common ones), and stops at the first non-option, which is the
sub-command. It then dispatches to the appropriate sub-command, which
parses the remaining options (also including common options).

Unknown options are kept by the sub-commands in order to detect their
presence (and complain that too many arguments were given).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 131 ++++++++++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 25 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index eea498e026..caf0248a98 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,17 +5,33 @@
 #include "midx.h"
 #include "trace2.h"
 
+static char const * const builtin_multi_pack_index_write_usage[] = {
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write")
+	BUILTIN_MIDX_WRITE_USAGE,
+	NULL
+};
 
+static char const * const builtin_multi_pack_index_verify_usage[] = {
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
+	BUILTIN_MIDX_VERIFY_USAGE,
+	NULL
+};
 
+static char const * const builtin_multi_pack_index_expire_usage[] = {
 #define BUILTIN_MIDX_EXPIRE_USAGE \
 	N_("git multi-pack-index [<options>] expire")
+	BUILTIN_MIDX_EXPIRE_USAGE,
+	NULL
+};
 
+static char const * const builtin_multi_pack_index_repack_usage[] = {
 #define BUILTIN_MIDX_REPACK_USAGE \
 	N_("git multi-pack-index [<options>] repack [--batch-size=<size>]")
+	BUILTIN_MIDX_REPACK_USAGE,
+	NULL
+};
 
 static char const * const builtin_multi_pack_index_usage[] = {
 	BUILTIN_MIDX_WRITE_USAGE,
@@ -31,25 +47,99 @@ static struct opts_multi_pack_index {
 	unsigned flags;
 } opts;
 
-int cmd_multi_pack_index(int argc, const char **argv,
-			 const char *prefix)
+static struct option common_opts[] = {
+	OPT_FILENAME(0, "object-dir", &opts.object_dir,
+	  N_("object directory containing set of packfile and pack-index pairs")),
+	OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_PROGRESS),
+	OPT_END(),
+};
+
+static struct option *add_common_options(struct option *prev)
 {
-	static struct option builtin_multi_pack_index_options[] = {
-		OPT_FILENAME(0, "object-dir", &opts.object_dir,
-		  N_("object directory containing set of packfile and pack-index pairs")),
-		OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_PROGRESS),
+	struct option *with_common = parse_options_concat(common_opts, prev);
+	free(prev);
+	return with_common;
+}
+
+static int cmd_multi_pack_index_write(int argc, const char **argv)
+{
+	struct option *options = common_opts;
+
+	argc = parse_options(argc, argv, NULL,
+			     options, builtin_multi_pack_index_write_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+	if (argc)
+		usage_with_options(builtin_multi_pack_index_write_usage,
+				   options);
+
+	return write_midx_file(opts.object_dir, opts.flags);
+}
+
+static int cmd_multi_pack_index_verify(int argc, const char **argv)
+{
+	struct option *options = common_opts;
+
+	argc = parse_options(argc, argv, NULL,
+			     options, builtin_multi_pack_index_verify_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+	if (argc)
+		usage_with_options(builtin_multi_pack_index_verify_usage,
+				   options);
+
+	return verify_midx_file(the_repository, opts.object_dir, opts.flags);
+}
+
+static int cmd_multi_pack_index_expire(int argc, const char **argv)
+{
+	struct option *options = common_opts;
+
+	argc = parse_options(argc, argv, NULL,
+			     options, builtin_multi_pack_index_expire_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+	if (argc)
+		usage_with_options(builtin_multi_pack_index_expire_usage,
+				   options);
+
+	return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
+}
+
+static int cmd_multi_pack_index_repack(int argc, const char **argv)
+{
+	struct option *options;
+	static struct option builtin_multi_pack_index_repack_options[] = {
 		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
 	};
 
+	options = parse_options_dup(builtin_multi_pack_index_repack_options);
+	options = add_common_options(options);
+
+	argc = parse_options(argc, argv, NULL,
+			     options,
+			     builtin_multi_pack_index_repack_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+	if (argc)
+		usage_with_options(builtin_multi_pack_index_repack_usage,
+				   options);
+
+	return midx_repack(the_repository, opts.object_dir,
+			   (size_t)opts.batch_size, opts.flags);
+}
+
+int cmd_multi_pack_index(int argc, const char **argv,
+			 const char *prefix)
+{
+	struct option *builtin_multi_pack_index_options = common_opts;
+
 	git_config(git_default_config, NULL);
 
 	if (isatty(2))
 		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_multi_pack_index_options,
-			     builtin_multi_pack_index_usage, 0);
+			     builtin_multi_pack_index_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
@@ -58,25 +148,16 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		usage_with_options(builtin_multi_pack_index_usage,
 				   builtin_multi_pack_index_options);
 
-	if (argc > 1) {
-		die(_("too many arguments"));
-		return 1;
-	}
-
 	trace2_cmd_mode(argv[0]);
 
 	if (!strcmp(argv[0], "repack"))
-		return midx_repack(the_repository, opts.object_dir,
-			(size_t)opts.batch_size, opts.flags);
-	if (opts.batch_size)
-		die(_("--batch-size option is only for 'repack' subcommand"));
-
-	if (!strcmp(argv[0], "write"))
-		return write_midx_file(opts.object_dir, opts.flags);
-	if (!strcmp(argv[0], "verify"))
-		return verify_midx_file(the_repository, opts.object_dir, opts.flags);
-	if (!strcmp(argv[0], "expire"))
-		return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
-
-	die(_("unrecognized subcommand: %s"), argv[0]);
+		return cmd_multi_pack_index_repack(argc, argv);
+	else if (!strcmp(argv[0], "write"))
+		return cmd_multi_pack_index_write(argc, argv);
+	else if (!strcmp(argv[0], "verify"))
+		return cmd_multi_pack_index_verify(argc, argv);
+	else if (!strcmp(argv[0], "expire"))
+		return cmd_multi_pack_index_expire(argc, argv);
+	else
+		die(_("unrecognized subcommand: %s"), argv[0]);
 }
-- 
2.30.0.667.g81c0cbc6fd
