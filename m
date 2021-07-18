Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0636AC636CB
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC56461179
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhGRIBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 04:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhGRIBR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 04:01:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849E3C061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l7so17483892wrv.7
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcInMiKy6QIwPB9pu0S7hvC/P2xtfp/7oo4vUwvPHxI=;
        b=SSocmmtRS5DVlVaAoSIxE9KTD56ZFG74J3MXkhmVoy1n1ELWvCdeeXdzYziJYu0J9O
         7T9M4gpJs0SXmIjTluiAH3X8Abn1tAAYGZFu0GVlRN3dqbQ4wWKkkFFAOdYro7OgQ+fr
         AG8lpNUiKtkw6c7XTalhszMSEdM8InqXjUoKMjCnUfYgrOG88vsaQIzP9SZ2Yx9PVbHF
         jqvWVzHr4yQHxOdupWGAflXJ+tRywuOQpD2wfj7yBIL1D/7Z6CwGBvvwr/J/KXeOOyFx
         CL2nIXhRo6rqsKspJ7se7CoPwG8Ag0/k2kB0ZjI9DuuiMOj0Y/rgFxMcFgGmxJRwp6gt
         1wHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcInMiKy6QIwPB9pu0S7hvC/P2xtfp/7oo4vUwvPHxI=;
        b=crmA2SFUFOEEqisT5YruklN6Daf4+mjm8FXspjcxeM0FZsIggoXo/YDBcAeBYZPnho
         9v4yFysDsfCf+jYSvanCA9FUpIDJYDeLmzefQB8q7Hu+hpOfi2aIlrBQtLKhyqlfcGOG
         1q911yN8PXTEucme/7f1++CoBD6SE60UiK9SAUuoCFQFH1203XcuL+c8AxE1r69QrjPJ
         X1Hg1V+qi7YMB5tFMELWWO1eVdpsJqrWs9w4MbUEfB804x9/xWRY0ue53NOYGFAqXQEJ
         poQRWG84sPrETYoMbpCvRvNrS+6RikOTApCQ1TDW505gx3BlmNcRx3mXRCYbLCy2pYhn
         9wpw==
X-Gm-Message-State: AOAM530zjLujuy5kSgDNG9+8AfD5fwk8RF0G/PTYpNsTnDjsAuxuHVYG
        72O2HDiA5kZfmCbTOh68Da9jp0W7FeyuBA==
X-Google-Smtp-Source: ABdhPJzfNHKhO5uOB3hRQRnMuc3f4YezMHR+Utc1W5poROK/CFtZf3/zR0B+iENc1ibMaxMGRXnsYQ==
X-Received: by 2002:a05:6000:156c:: with SMTP id 12mr22940117wrz.400.1626595097000;
        Sun, 18 Jul 2021 00:58:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm15904685wrt.55.2021.07.18.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 00:58:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] commit-graph: show usage on "commit-graph [write|verify] garbage"
Date:   Sun, 18 Jul 2021 09:58:09 +0200
Message-Id: <patch-5.5-57ffd5812d6-20210718T074936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.873.g94a0c75983d
In-Reply-To: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the parse_options() invocation in the commit-graph code to make
sense. We're calling it twice, once for common options parsing, and
then for the sub-commands.

But we never checked if we had something leftover in argc in "write"
or "verify", as a result we'd silently accept garbage in these
subcommands. Let's not do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c  | 10 ++++++++--
 t/t5318-commit-graph.sh |  4 +++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 16d2c517e72..bb3e767db33 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -104,7 +104,10 @@ static int graph_verify(int argc, const char **argv)
 	opts.progress = isatty(2);
 	argc = parse_options(argc, argv, NULL,
 			     options,
-			     builtin_commit_graph_verify_usage, 0);
+			     builtin_commit_graph_verify_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+	if (argc)
+		usage_with_options(builtin_commit_graph_verify_usage, options);
 
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
@@ -261,7 +264,10 @@ static int graph_write(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, NULL,
 			     options,
-			     builtin_commit_graph_write_usage, 0);
+			     builtin_commit_graph_write_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+	if (argc)
+		usage_with_options(builtin_commit_graph_write_usage, options);
 
 	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 5fccce95724..5cf07a6dded 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -7,7 +7,9 @@ GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
 test_expect_success 'usage' '
 	test_expect_code 129 git commit-graph -h 2>err &&
-	! grep error: err
+	! grep error: err &&
+	test_expect_code 129 git commit-graph write blah &&
+	test_expect_code 129 git commit-graph write verify
 '
 
 test_expect_success 'setup full repo' '
-- 
2.32.0.873.g94a0c75983d

