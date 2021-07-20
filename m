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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEBAC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D0661029
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhGTLCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbhGTK7d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 06:59:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E5EC0613DB
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k4so25633736wrc.8
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1MzRfzyqaVG9jzGJaiPUefdLQUsQ4UTbCbgFCyLTvks=;
        b=to9hbBJxRsikIIhwob6ct7YY8hQgI7ED6J9JW/dl9FpmDq85MyFaJBdSrF79L8QuxS
         h+BVcHP5viyL36AnbUNvuLFEkl690UvYmrL/5I72RdGJRzwDmfX1yjdV9OEpgyJccQ6/
         VD2eqL93wU6NYoDEk579HT5AwUeD9aI0Ai+t5FIZtJLVe6PdHQKaG+BET6vZaTMGKUEq
         l4hKbeO88BYK8pv9S5KMSa/y1p/xqNoe927qaOSElfLZQoSnflcshEl2ojLID0VWS0kc
         N7nDE96PUYnLW+GfVR9Onji0TlFO+2fCQAXJKiHiJpvg+RHG36yUmV+C7qRyT2Us33Bb
         caCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1MzRfzyqaVG9jzGJaiPUefdLQUsQ4UTbCbgFCyLTvks=;
        b=XdUf0n59tKLQbQ4NlLCOH74R1Kv2x1FdiMCl3xnq9J4SYl+aqL7cEw6OJ5Olu8qOd0
         itNYFqiyI7fsaI36zb1fZstJZOMXFSMIIvInP1Z/VFG3OtcQw7Y/WmoQYWW75Ef1KmsS
         uJYLUQ9Q6luXfvDIjhnwAzDywo6vnn5UUvec+B8uJOzgzy4bxcXDEfUoX0d5dSnhNLJh
         DVsJk1XVx5Jt5P/KUa4bz71MT+keGwApd0/13ThgzsBSem0XFNDcvnv4sm3Yo0IkPgYY
         6EHv3nsAfDronVtCCji4NJcnTLevCkp2BxHnzfh6b6RkwSZG6TlPfc5KqDDfQVjxtFx6
         mehw==
X-Gm-Message-State: AOAM530DIgqUpf/SCkU/es+dTeh25QeghSbAmZaJcxtdNaJVeMqJFAyU
        mcXau9kKNfJo1WoSJRsDPv+1gpAh7743Rw==
X-Google-Smtp-Source: ABdhPJzR6+9GBO2EGP2GXS40lZ4818rq6vfl2aTGRpSZKvsHPpgSNiU6T+K+lf9rEKdEOz3Ozzoc/w==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr34276159wrw.319.1626781206686;
        Tue, 20 Jul 2021 04:40:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y66sm19683595wmy.39.2021.07.20.04.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:40:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/6] commit-graph: early exit to "usage" on !argc
Date:   Tue, 20 Jul 2021 13:39:44 +0200
Message-Id: <patch-5.6-7acb4bd75ce-20210720T113707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com> <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than guarding all of the !argc with an additional "if" arm
let's do an early goto to "usage". This also makes it clear that
"save_commit_buffer" is not needed in this case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 6e49184439f..bf34aa43f22 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -331,16 +331,17 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 			     builtin_commit_graph_options,
 			     builtin_commit_graph_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (!argc)
+		goto usage;
 
 	save_commit_buffer = 0;
 
-	if (argc > 0) {
-		if (!strcmp(argv[0], "verify"))
-			return graph_verify(argc, argv);
-		if (!strcmp(argv[0], "write"))
-			return graph_write(argc, argv);
-	}
+	if (!strcmp(argv[0], "verify"))
+		return graph_verify(argc, argv);
+	else if (argc && !strcmp(argv[0], "write"))
+		return graph_write(argc, argv);
 
+usage:
 	usage_with_options(builtin_commit_graph_usage,
 			   builtin_commit_graph_options);
 }
-- 
2.32.0.874.ge7a9d58bfcf

