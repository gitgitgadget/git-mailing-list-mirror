Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538DC433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB83D64E13
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhBOSnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhBOSmY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:42:24 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A06C0613D6
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:44 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n10so10258659wmq.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F9IBskYvuRMaNYBuJ9lxjAVzqx3mm5wwkHChR5jOkS4=;
        b=FFrSc9wmFr6pG98INpE3AwNR9ICm6hVSrU9nrrELsGsp56sdH4q3I30xmX4lpr62Cc
         yh35fuNVRUWOnNyUapFr5iG3vIgI4sR+a0Dw0BQ38R5sZZV1dNnJNDjoeC8mKyckixc0
         0QHN13+UsDxKn+shjPmNquavfJaKhElBpXfZG0MT3Ig58YnT5BteePjZW/nSI0AvuWld
         JwNnJhih/UURq5EfizTsBOJIrXB2BW/3uJKB7BR2Vi9PhnLCeSS2Q1tYdxJ1PBFyQwXD
         eOzaPRc9RvEZPVbqZxr/HNyi0PI2myb57EDUatwmbEU3Si8x8tXc/uVryT30XJuKQMlU
         1koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F9IBskYvuRMaNYBuJ9lxjAVzqx3mm5wwkHChR5jOkS4=;
        b=MLcsgiUJq+WFpbAgtw04bWCdC5wkF8eg3KayEs2xqkNcOdeT43AUSrO6AfWdaqommn
         EFTQG2zaB/11jcyHJjLSrfmGPoST1T8dxHy10+3rAgstX/GyjrW5dV4m7qpyMZpwU9XT
         MRrd+VWIsUGx0SoEGAlxjWmIDI9uBqZgrw1heuQKvvguZn3BTocuXP+QxjdIphEMdpwH
         r6xuvJb18GoSYgLZhHt+052qkB6puG3KupyRPKzgMG24UTe/i8z2LM5/PZNkH9SD645w
         1IkdkiEn0qy1Pm9BQ6WO+JqhdP6M3lr7JNPWyPdAWh/hYO/G9sKnQ3mWwLDBEBIetszw
         b/3A==
X-Gm-Message-State: AOAM530s/tNBHyY1X8n7QO70Gh/hO7jSXNXAcJ4ett5v3mY+fVvHxio1
        LRQv09L2Vu9TMT6XqUDTjhyYI0av8wf2DA==
X-Google-Smtp-Source: ABdhPJzEHD+F60P1MaHE6Ii7GNlDILzhi0uW1RCZH8zcmytiyUCZZH1jNpFkRlAHJWTHbgVMyTz5hw==
X-Received: by 2002:a7b:c256:: with SMTP id b22mr194246wmj.108.1613414502578;
        Mon, 15 Feb 2021 10:41:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v12sm11258979wrv.69.2021.02.15.10.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:41:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        dstolee@microsoft.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] commit-graph: remove redundant handling of -h
Date:   Mon, 15 Feb 2021 19:41:15 +0100
Message-Id: <20210215184118.11306-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87r1lhb6z7.fsf@evledraar.gmail.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we don't handle the -h option here like most parse_options() users
we'll fall through and it'll do the right thing for us.

I think this code added in 4ce58ee38d (commit-graph: create
git-commit-graph builtin, 2018-04-02) was always redundant,
parse_options() did this at the time, and the commit-graph code never
used PARSE_OPT_NO_INTERNAL_HELP.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c  | 4 ----
 t/t5318-commit-graph.sh | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c3fa4fde3e..baead04a03 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -319,10 +319,6 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_commit_graph_usage,
-				   builtin_commit_graph_options);
-
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_commit_graph_options,
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2ed0c1544d..567e68bd93 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -5,6 +5,11 @@ test_description='commit graph'
 
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
+test_expect_success 'usage' '
+	test_expect_code 129 git commit-graph -h 2>err &&
+	! grep error: err
+'
+
 test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd "$TRASH_DIRECTORY/full" &&
-- 
2.30.0.284.gd98b1dd5eaa7

