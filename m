Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AD0C433E3
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875E0619E1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhC3PEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhC3PEA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:00 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05BDC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:00 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q26so16146186qkm.6
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W4SDY+1YxIrmLwpqmBLyRI1mkSOd6U18NqzhGj2GmDk=;
        b=r2kwAdUd3nz8cP7sbRO77yAtLZGGxAwrDRzxPkn1moEHu+srhuUSaWla2NvNqF6oRs
         tpSaj2FlwlSFXCpdwrGbOn6b3X3Pd347PmPAsocuXxkn//Px75Hv1S+KHcsmM4PJlK0l
         28YjEhmpYLaY6EVGdK3JT0AAcHYkoTH+n/cOk1Ewy3zATaT6eBI2NJ+zW8WWrh/F1HZl
         YsVbqCM2XD0mOt+si9/6avIgWEBRki4vHnDT4eZrc/I5q2bmIGH7qZ1yqM5Xm4Deukhs
         /xHsZWs1RtUzIkjN7TOel0Q6WOzrj2eUKE4s4KXBA46dYn+ArVbTmPonEQ21fyyKMiOS
         +y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W4SDY+1YxIrmLwpqmBLyRI1mkSOd6U18NqzhGj2GmDk=;
        b=rl2Xt7Fm0ZLsOdxTtVA+1qgpgQzVMw4OrCAd/MCZPeQOexeHXvG9qrZ2T3xVNtGtIy
         llevtMR/tjrvCVf6eZz3oQlD8d+eQHyJJ3otxHh/dyoqt1ifPVPJ1ZRAJhvVtbl9SiFv
         10RqsRID16VPhjtlZ20ZylodjMb96fFKNo4M/dvSM/l7KSrppIUqyrm4Ee7/ckEZ3ZK1
         UUG4N26dGERsAQhdrQ5QdwbxrhPD8AmI4DoKJZMacBpohh/VDMzR7scjxwuW0ojF2UGI
         PnW79Cg696UF5Y4Hkg+9E+E5cMTzl1uxhQONMwOqifYfHITPHe+1T7ecxoHwiPiabNoA
         ZMvA==
X-Gm-Message-State: AOAM532aVv+x5FaKnSBLXYae4Tr/KcbiKri1HIm3bd/OJFjCDHRxuiFa
        bhavFpy//dLUI5tHfQFVLl/DT/U29JYd8g==
X-Google-Smtp-Source: ABdhPJz0xRzLXaLe+ZJh21CGi8n7TgjQDpwCTeSXyL8WGkPkgyyK5ms7z3sfwVPVoWQ3mtVSYUXZLg==
X-Received: by 2002:a37:66cd:: with SMTP id a196mr31650657qkc.374.1617116639575;
        Tue, 30 Mar 2021 08:03:59 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id 79sm16287312qki.37.2021.03.30.08.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:03:59 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:03:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 04/16] builtin/multi-pack-index.c: split sub-commands
Message-ID: <b8c89cc239f75bd4e0d81058801684ec8ea7a270.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
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
 builtin/multi-pack-index.c | 130 ++++++++++++++++++++++++++++++-------
 1 file changed, 105 insertions(+), 25 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index eea498e026..a78640c061 100644
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
@@ -31,25 +47,98 @@ static struct opts_multi_pack_index {
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
+	return parse_options_concat(common_opts, prev);
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
 
+	options = add_common_options(builtin_multi_pack_index_repack_options);
+
+	argc = parse_options(argc, argv, NULL,
+			     options,
+			     builtin_multi_pack_index_repack_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+	if (argc)
+		usage_with_options(builtin_multi_pack_index_repack_usage,
+				   options);
+
+	FREE_AND_NULL(options);
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
@@ -58,25 +147,16 @@ int cmd_multi_pack_index(int argc, const char **argv,
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

