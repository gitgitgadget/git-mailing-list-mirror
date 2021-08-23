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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCB0C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF69F6137D
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhHWMbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbhHWMbO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:31:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D46C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso13955998wmg.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EaX10NCT4qa6I+PTQB1H7ApmHQ2Awpjc/lp8Kbnehs=;
        b=O6iv7tkBMePm8kXrKwAPRVdiU7tB2rbVFcyC4YzXMzoo/HvE2WpkTHXm/Q2kNfs7C3
         tqleCwlVd7ECfCZpyQc6wGA6mFSKaKqkkvUlAgZNm4pbWE2DDthrDgRdLcWdgaWXJaan
         omJNPUybUSw/SOvCR36XF9UTPRpBrR6nmt61tCvbEkkIDvJCRnRus3MjFpn9PjM8vM60
         CtZIAF/p15GnzfIUOIfU4z1Op+HtfAywy5BsRScvzKnONoRA7yFtfJhwxpfOuwQefEuf
         LLneYDIWqqkSZZ4ivP/HxqQxdfncmeb1ySNj6Dc8OHylrNFBA38mu5YkrUAe1ntTkDOG
         vVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EaX10NCT4qa6I+PTQB1H7ApmHQ2Awpjc/lp8Kbnehs=;
        b=tGzDWZY3qG7xxoMzWLM0lRJoaAK/xBEC47OIxnUrPFs5K2c20bn5dD8FztU69byn4m
         auIpKUVoGACP0r7+3u/mUqQoFQRhQI2XgWsWSfkqNIp+Egeb9xwcLQQ3gHE8t1oGyt35
         61sGGW/W+fWbGmCIcMmCtB0vT5bIBY0NQYLjn5dxo1uEr6MwvAFdIVpc7a9BBl5L97Ra
         LY3fpwDzXtyMVEhw0sZeoM79MKGeLBSG1TH8F7Q727yYFVdkRckyhJ701CUWY8VEbzpa
         xA7o1Y16wCJN4kE6qDJxRWRoOIdrtAf2P6ION/C9jkRw3rMMvKZ/tutX14ziWKoz4FYM
         P+9A==
X-Gm-Message-State: AOAM533WypcjipjTuDBFH9YkaSywg674xykhuFc/hCct5YfxSLWPAG8M
        gWDpMsnBthPYnGmhPijpUV3A3f7ohLFwB6hx
X-Google-Smtp-Source: ABdhPJw3MOIDsGNs/LHN2iLqHSRSSZQYYLvovcseCf+nUrq3cDqhNLWLd1oBRq4ceabqlFBHAPf8bA==
X-Received: by 2002:a7b:c3d6:: with SMTP id t22mr16248245wmj.117.1629721830204;
        Mon, 23 Aug 2021 05:30:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9sm14762430wrt.95.2021.08.23.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:30:29 -0700 (PDT)
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
Subject: [PATCH v4 7/7] commit-graph: show "unexpected subcommand" error
Date:   Mon, 23 Aug 2021 14:30:21 +0200
Message-Id: <patch-v4-7.7-962521cfa17-20210823T122854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
In-Reply-To: <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bring the "commit-graph" command in line with the error output and
general pattern in cmd_multi_pack_index().

Let's test for that output, and also cover the same potential bug as
was fixed in the multi-pack-index command in
88617d11f9d (multi-pack-index: fix potential segfault without
sub-command, 2021-07-19).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c  |  1 +
 t/t5318-commit-graph.sh | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0457903f18f..21fc6e934b0 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -345,6 +345,7 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 	else if (argc && !strcmp(argv[0], "write"))
 		return graph_write(argc, argv);
 
+	error(_("unrecognized subcommand: %s"), argv[0]);
 usage:
 	usage_with_options(builtin_commit_graph_usage,
 			   builtin_commit_graph_options);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 09a2ccd2920..295c5bd94d2 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -6,10 +6,24 @@ test_description='commit graph'
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
 test_expect_success 'usage' '
-	test_expect_code 129 git commit-graph write blah &&
+	test_expect_code 129 git commit-graph write blah 2>err &&
 	test_expect_code 129 git commit-graph write verify
 '
 
+test_expect_success 'usage shown without sub-command' '
+	test_expect_code 129 git commit-graph 2>err &&
+	! grep error: err
+'
+
+test_expect_success 'usage shown with an error on unknown sub-command' '
+	cat >expect <<-\EOF &&
+	error: unrecognized subcommand: unknown
+	EOF
+	test_expect_code 129 git commit-graph unknown 2>stderr &&
+	grep error stderr >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup full repo' '
 	mkdir full &&
 	cd "$TRASH_DIRECTORY/full" &&
-- 
2.33.0.662.gbc81f8cbdca

