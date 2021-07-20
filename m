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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48945C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315DC610FB
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhGTK76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhGTK71 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 06:59:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CA1C061766
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k4so25633589wrc.8
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1N/+jHSzN5qPgpwQ3/t5A8jSh4+PXGQsWz0aHk9tjF8=;
        b=uJ6mKynStiZP1nZL1P5qPxS09FKTyua/ERn+rUmvm31XwKMeKtIK3CYvcwjKp+k3Bi
         uJDrspUoQ6yGjm3TCdOWbAlHNBI5csPBhomShimkMxMdKoS1koL22y4LOVpzlztK3q0P
         T0lnMIhuP5qheILOuXTVboV3lpdk9NOXoa3UXybJLfhTJoIIoScB7ksK+x7eH2jv2SW7
         ODYDxr9JczrekxJXWIKD7kOfXV3pJ8jkZkgmYWWWBDWJxGhq1rBRqwvf9JULacW3wDrk
         Go9tAN/n1y7qEcX49sd6DMxeRjbYIMacCZCdPbmdcH9G9+pXl9OODFWqyy6dqjMrc4FA
         uxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1N/+jHSzN5qPgpwQ3/t5A8jSh4+PXGQsWz0aHk9tjF8=;
        b=PZ391KKPkJVaCh9l//2I0ZqA86O9vUVrkj3591Ki60TOaZDn9D1yAnsgxJlEwaLkmH
         I4cbBUw0Oux6A1brJO76rBFnBTzubN4qAKMgON5z4sLWTkNMaBI9qvLRGS7P/ZgBcJOa
         CGXcUyWjwgac47sMEhqRgeePZHmaxSmvvZmc0vgi9Eyxv3FWrY9Skc0ALN01EGAUGlFl
         lu+Cq29Z4s64MC0PlcwjTHJPSsBTDufBfcf0bza++YOD1KRCph7QKUtCF2zX3H58qCMo
         wD7uczDeKrRqlE01AETPERrbfYzizQ3IIHN6Ouzivnzby8g/2IJXP8/Lx9hoU61PD1Rj
         9RJw==
X-Gm-Message-State: AOAM531cKn5fFM3ruHZjNHf0x3zpDzRS7bdHacA2mG28E2gNT3Cqsvzi
        I1tw6j/4Szg84++Ra94+C6AbzpDnT6j4Bg==
X-Google-Smtp-Source: ABdhPJzFP2WcPg7ddz8ZYJ9SIQSnrYW6faqnzMnU3oYwwYu0q9Ms2Ygz8doIFIo8dGpGjHFDFxyxkw==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr34821233wrp.317.1626781204483;
        Tue, 20 Jul 2021 04:40:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y66sm19683595wmy.39.2021.07.20.04.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:40:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/6] commit-graph: remove redundant handling of -h
Date:   Tue, 20 Jul 2021 13:39:41 +0200
Message-Id: <patch-2.6-8f50750ae5e-20210720T113707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com> <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
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

We don't need a test for this, it's tested by the t0012-help.sh test
added in d691551192a (t0012: test "-h" with builtins, 2017-05-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 5af3cd7178f..3cf18dc5345 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -321,10 +321,6 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_commit_graph_usage,
-				   builtin_commit_graph_options);
-
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_commit_graph_options,
-- 
2.32.0.874.ge7a9d58bfcf

