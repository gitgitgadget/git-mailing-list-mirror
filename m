Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FE4C4332B
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C9A64FE9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCKRFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhCKREw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:04:52 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32BC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:52 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v14so19535991ilj.11
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=giX1zS/myYoewg3Lc20PT3NkDhM4pkXExmujP187dQU=;
        b=kaTdou6LXVObgFS/7nH8dEQx9ZF9bK70dgAiZ/Mhf4yd7/ItPxZObgbcl+yK9MmtBL
         4S0BGGo92XqlgZrvli737kPByKj9TWiBe8EOQ/Z5eQQ5Zn1x/o8evgJl8b/kOEnpl8lC
         VH6ylaYOuA6lDQSbSQAx8RUl6q5PQ7nVpaYVb8UGKKVLhRtRz0jAmpDqt/IyjSUma6Bm
         ykZ05+sid3r5zzASyEKd4VASn6+Ye6y7hHuEFj6wyy3DbMHkB6a1+dIkdfd8GIf0a4vh
         +CJ1/xls7yVMRXyDSw9cFYK5qwoGeBWv6luKkaFX2B7IG9GQpZ18tDD9WsEVU1SEhzVQ
         S4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=giX1zS/myYoewg3Lc20PT3NkDhM4pkXExmujP187dQU=;
        b=B0S8KHzs0a7syfR7/LvuHsKZkHdxcBQtRjvIYgQiAFK4RMLG9PdzUMSu42XFBCM/Or
         unsSI0RCR92KqOPObJ230bw64V26SwL0BUqiGZj0YtKlb26OWLQTXKwmkAIGH9fkOzxz
         VLf2rYMREA+gxVa0/rw4TyYAL5jLjSY6lLu3J27p3ntZVzYcYItjexWzuQjwsLekpFw0
         skKJ5WiJ/ByD9W9eDfc8PnqJFTl1oA8c25V/rQ7hlgZDD9s5CJWROcIORChmHDkzCCoY
         UdrO+YOMhAz6AfTvkthBW0vUjKer3QsgheKw8J6umLWcz2ST1VRZBf/i5z77mIqxkAK2
         fUXA==
X-Gm-Message-State: AOAM530Xx3jYx5+HF3hHICkqwZpvD1ra9716dBBGajecKUUgGSdpH5df
        TxCqWlg5Q2w084YWAC7ws3h7ASb17KmvVggS
X-Google-Smtp-Source: ABdhPJzch7zQ8QsuPFYS/ljyFHgdgiT4oG1a7hY7jMwQhf7RYub1A2qfQOPrLuqWEKGYzI43em8oug==
X-Received: by 2002:a05:6e02:194a:: with SMTP id x10mr7653478ilu.165.1615482291737;
        Thu, 11 Mar 2021 09:04:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id y6sm1595054ily.50.2021.03.11.09.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:04:51 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:04:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 04/16] builtin/multi-pack-index.c: split sub-commands
Message-ID: <d084f90466813597feb27975654e57de36eb62a4.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
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
index eea498e026..23e51dfeb4 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -17,6 +17,22 @@
 #define BUILTIN_MIDX_REPACK_USAGE \
 	N_("git multi-pack-index [<options>] repack [--batch-size=<size>]")
 
+static char const * const builtin_multi_pack_index_write_usage[] = {
+	BUILTIN_MIDX_WRITE_USAGE,
+	NULL
+};
+static char const * const builtin_multi_pack_index_verify_usage[] = {
+	BUILTIN_MIDX_VERIFY_USAGE,
+	NULL
+};
+static char const * const builtin_multi_pack_index_expire_usage[] = {
+	BUILTIN_MIDX_EXPIRE_USAGE,
+	NULL
+};
+static char const * const builtin_multi_pack_index_repack_usage[] = {
+	BUILTIN_MIDX_REPACK_USAGE,
+	NULL
+};
 static char const * const builtin_multi_pack_index_usage[] = {
 	BUILTIN_MIDX_WRITE_USAGE,
 	BUILTIN_MIDX_VERIFY_USAGE,
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

