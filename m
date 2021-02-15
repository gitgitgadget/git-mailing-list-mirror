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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49719C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1C260202
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhBOSos (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBOSnf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:43:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95008C06178A
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v1so10151854wrd.6
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wgn004G3xcRSnJBx6EUVAXcvT7DfGNah5ap9esCamJE=;
        b=eaYwQ0o2nQyTjLD0oy1tgpI+75Kwbw4z/uS5fF9tVQ9Nmnwq9hUHxxOthYscQreXzV
         KkNneDQLQwthG81LC25MYVVkqimTVAPJZa2c7o9IqPTt5KXAqT8XSZWsGCcF3/bdiKUB
         UsDKI1uaVGh2ZUgYi3bgFEQak2v8zieHgBTNNEBuhmVvQ5XGL94fgdf5+aMsD0X+mlX7
         UG8L0Zl9mqnU5xhELW9yHtp0bBdKc9lcoxV7P1SNNrSMrLOsNh1lntI/Cz2N0Own0QYd
         ZK0bYJQFiMaRFLw6lgWHSAkMvk1fUgqhJtc8TFdSPWExGon1OFY3+HOmnxa9uVWHISBb
         yfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wgn004G3xcRSnJBx6EUVAXcvT7DfGNah5ap9esCamJE=;
        b=jqvr62rCUm1E0GJvK5RPif+7NunD8jymTUr2RTYTgcwEmFjq8OxaTbr7tmhKI0AuKJ
         bj5HB02ME0E5Ncao87qJ2cUQr/q9RcxkopH+C9RXWVzH7apR9xLNxmE0nijtyFOi5QjW
         GO7pO+tQ9izSnCWgqbMq/5N+phHL9bhzS3IlKGUifCzRbikp1JDOykx5YyekTlEeK3aT
         3R6Rpt/Uc2wPIOyq37SJh19a/e6Ie5AbdYOy3jZ/ImQ59hPXO/UbWkkTiaijhusVX6pu
         t0LTCFKkC/j2KWsDnLiEUSsYvdXKLq8YcR2Mv9Sw9U6M6Am5gmH59ZOHEB6CHyypvAX1
         VsSw==
X-Gm-Message-State: AOAM530viMVuJwKmnpg+MPPhPT8QyN9mvnPNPRlW9VrhG+6MsIIeb+fq
        NpaZGW3XZALexlG3eYyVdoZMcAjVBrZNwg==
X-Google-Smtp-Source: ABdhPJx4uj8CXKiKS338AEnfhHArjGPPBy9SqmstKn9TxE8sYeP37mmQHB/EEIP4Rm20B21/wMKT/w==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr20329461wrp.345.1613414505087;
        Mon, 15 Feb 2021 10:41:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v12sm11258979wrv.69.2021.02.15.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:41:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        dstolee@microsoft.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] commit-graph: show usage on "commit-graph [write|verify] garbage"
Date:   Mon, 15 Feb 2021 19:41:18 +0100
Message-Id: <20210215184118.11306-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87r1lhb6z7.fsf@evledraar.gmail.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
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
index 66fbdb7cb1..cb57771026 100644
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
index 567e68bd93..3f1c6dbc8f 100755
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
2.30.0.284.gd98b1dd5eaa7

