Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0819C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8103C604DB
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhHWMbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbhHWMbN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:31:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19338C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d22-20020a1c1d16000000b002e7777970f0so190910wmd.3
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/vSMw9jtVSN51XI2ETTdUtRFTm2nWIpWxSGXYF6QTk=;
        b=LzEpPXLeAGgYOW1MUyF+RBZb4gP+4ORpVsYPYoLkFGqu6FRRA42ZxB4kz5co+KNxwQ
         1lsiaLx6vPz6YIFOtI2Ln1Xehs8kOtQgYIpXiNww6G+4Xb7NZkUn5GMdAUtofhkjY81R
         o7N7BdOcmf9seLY6aH6P5J98W73j73Zldw0sYR1kX47EWFdNdI5ufiPa4wEXzsWISc2M
         e5i6FgcdZYyal852xRAVIIBLlfwNGIkIdMS/YMaqEWi7ee8EXM4w+ItTbTA3sQu9vSbN
         NR/gYgxoa34BnjEKfxx71U6FBkf+4WtT2syYsphgFExk9xAkIVdhXN6ML9UpjCrVheTq
         a5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/vSMw9jtVSN51XI2ETTdUtRFTm2nWIpWxSGXYF6QTk=;
        b=Y5WJdJY85oaEpSkoMuOF23OnAETaka48yoI4Z6wwfZPGPaPrQogqDbpf0FR7Pj8HzW
         oHNpBCavhJIasVveXUT2hLRTUUHveybR8NWX1UCIeD8zCxHi8CkuGXASy7feOmubtYJj
         3o5/jO1H9m9e5qhau/xO/GRB5tHETYYZylNzI0b3FQfj+pkWT8Xqv2N10epVaDKLqjHB
         bDAvlmuumHlxHhLk42uFVVxqco0x+QXQ0y5j+Va8pgQMsw2Gd1iYfHH6vcj9wHVTnjz3
         SF/iBohyHiN2R/q9udyNaGfk4GWE+7e3GXPU7VTMxTvWHUR8f7W03GRBbf0lPw46kM/W
         aEoA==
X-Gm-Message-State: AOAM533MRL8RL1BYnexzBbyjOUROaKdN9i/TRl4Ro5m2RNnuhaQDB8cd
        YuVx/DDWxD2fq/l0pgXGIND16qBjKegBesZY
X-Google-Smtp-Source: ABdhPJyOCrFWz+TIo9ZxGCE4WLORYciDtGCsymREVM5XKL4EPSHUb2Xdw6XJy95Ic24LVw4sgW7iKA==
X-Received: by 2002:a1c:7dd0:: with SMTP id y199mr16399407wmc.148.1629721829448;
        Mon, 23 Aug 2021 05:30:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9sm14762430wrt.95.2021.08.23.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:30:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/7] commit-graph: show usage on "commit-graph [write|verify] garbage"
Date:   Mon, 23 Aug 2021 14:30:20 +0200
Message-Id: <patch-v4-6.7-85552a6f88c-20210823T122854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
In-Reply-To: <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the parse_options() invocation in the commit-graph code to
error on unknown leftover argv elements, in addition to the existing
and implicit erroring via parse_options() on unknown options.

We'd already error in cmd_commit_graph() on e.g.:

    git commit-graph unknown verify
    git commit-graph --unknown verify

But here we're calling parse_options() twice more for the "write" and
"verify" subcommands. We did not do the same checking for leftover
argv elements there. As a result we'd silently accept garbage in these
subcommands, let's not do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c  | 4 ++++
 t/t5318-commit-graph.sh | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index bf34aa43f22..0457903f18f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -105,6 +105,8 @@ static int graph_verify(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL,
 			     options,
 			     builtin_commit_graph_verify_usage, 0);
+	if (argc)
+		usage_with_options(builtin_commit_graph_verify_usage, options);
 
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
@@ -262,6 +264,8 @@ static int graph_write(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL,
 			     options,
 			     builtin_commit_graph_write_usage, 0);
+	if (argc)
+		usage_with_options(builtin_commit_graph_write_usage, options);
 
 	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index af88f805aa2..09a2ccd2920 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -5,6 +5,11 @@ test_description='commit graph'
 
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
+test_expect_success 'usage' '
+	test_expect_code 129 git commit-graph write blah &&
+	test_expect_code 129 git commit-graph write verify
+'
+
 test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd "$TRASH_DIRECTORY/full" &&
-- 
2.33.0.662.gbc81f8cbdca

