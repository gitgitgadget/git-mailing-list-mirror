Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0AEE20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfCHJ6n (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:58:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45110 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHJ6n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:58:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id v21so13784562pfm.12
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDTa/3HgzhnPPF2WfCIFYmBb+hpVNaGQFmlWfc1DD9c=;
        b=tdzpGoW2JpnykhCnWNrbGEldtauCdtaXrqY78qO3N+yxVGfty2Kn43R1/37ikaoBzg
         grjjirAl6/bmDsQ/E8UCbKGSeFKnoTYi5jdSAT+8YUgXJeAf5zdMpff/f0MVT5ri/MGL
         qR8rVNLEQpbNUQxJ4I1Plm7XDKpch7Aba1G7xxTXfwNA3XOqm452uKZAWadsyOyiMNjx
         pMvZSB1cFF2DUNL/IN5Ndoyow1mWxMOFabHnxQal7nk+ln7v27vbYKwU1GIGQLXsuo9f
         kA6pIgp7X//TrpUVxYr+RINDdNfE6Gl6z4zFw0pISJ76T9ouFAxgAC+3WtBvZgzTWZIN
         kglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDTa/3HgzhnPPF2WfCIFYmBb+hpVNaGQFmlWfc1DD9c=;
        b=XOXK8ogltf+d8XTWJn/BVrXzbs2u6Y0C76V1Cl910sYsgpzLBQhaXb5BPjFdV29kTH
         qlvnVWfiAQ/hQoHQC30GgNeJD38Ddy1qj2f2EwV9cVzXWqRsrS1zXou9eNAw9q6sBR+y
         TzDIcEfkruNoSvUuTIGvYNyzVz6y5fao5XA4FlnCaCOaXtib0cEeGqG7fik0JwtvSc/M
         ky22Y96MyrG+55AOfzu9Opxvk0ZeYp0iOTIJPBpBv6OdlE8gPQA8v2qOUanf0BRexzfN
         SOOPSS408M81R7ftj0xo3xwJKyDaLcobYeCXSBDybFj1ij90i2+0qYUmL1EjLzBZFt9L
         leRQ==
X-Gm-Message-State: APjAAAVc1AyRbP6GTMakqZ0mC3lwH3bOdgRpUQVtUmHLS0KVuJlgZ5IS
        yg0cUZK8zGiDQ5wHvXh4IDY=
X-Google-Smtp-Source: APXvYqwtHIRi2vmy5XAX6pxTus/zoOQAeQG9nFMkDvDkyf5a+hZG0WfCEltMVGRUS9Wq0tCjbLTM0A==
X-Received: by 2002:a17:902:204:: with SMTP id 4mr1152020plc.180.1552039122595;
        Fri, 08 Mar 2019 01:58:42 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id b138sm18242330pfb.48.2019.03.08.01.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:58:41 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:58:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 08/21] checkout: move 'confict_style' and 'dwim_..' to checkout_opts
Date:   Fri,  8 Mar 2019 16:57:39 +0700
Message-Id: <20190308095752.8574-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These local variables are referenced by struct option[]. This struct
will soon be broken down, moved away and we can't rely on local
variables anymore. Move these two to struct checkout_opts in
preparation for that.
---
 builtin/checkout.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index baefe3c942..4b43433941 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -47,6 +47,8 @@ struct checkout_opts {
 	int show_progress;
 	int count_checkout_paths;
 	int overlay_mode;
+	int no_dwim_new_local_branch;
+
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -58,6 +60,7 @@ struct checkout_opts {
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
+	char *conflict_style;
 
 	int branch_exists;
 	const char *prefix;
@@ -1344,8 +1347,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct checkout_opts real_opts;
 	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
-	char *conflict_style = NULL;
-	int dwim_new_local_branch, no_dwim_new_local_branch = 0;
+	int dwim_new_local_branch;
 	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
@@ -1370,12 +1372,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
+		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_BOOL(0, "no-guess", &no_dwim_new_local_branch,
+		OPT_BOOL(0, "no-guess", &opts->no_dwim_new_local_branch,
 			 N_("do not second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
@@ -1393,6 +1395,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts->prefix = prefix;
 	opts->show_progress = -1;
 	opts->overlay_mode = -1;
+	opts->no_dwim_new_local_branch = 0;
 
 	git_config(git_checkout_config, opts);
 
@@ -1401,7 +1404,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	dwim_new_local_branch = !no_dwim_new_local_branch;
+	dwim_new_local_branch = !opts->no_dwim_new_local_branch;
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
 			opts->show_progress = 0;
@@ -1409,9 +1412,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			opts->show_progress = isatty(2);
 	}
 
-	if (conflict_style) {
+	if (opts->conflict_style) {
 		opts->merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
 	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
-- 
2.21.0.rc1.337.gdf7f8d0522

