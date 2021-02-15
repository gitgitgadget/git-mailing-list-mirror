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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A68FC433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB31260202
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBOSnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhBOSm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:42:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57B0C061788
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:45 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l17so7020703wmq.2
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhmRgVhh+2U3JbAOPK2kv2BKguDIUQsYRGPfRdh/z28=;
        b=IPi498Kb+PLKuWvxH7OJHGgI8Wu8cYw3OBIfFPsALmnNoMWpn5jZX8EW/n+lAEDsqv
         myt2PF8f2AhmaJlKF/9LGkn7WGH70A/rCbztb+XvYbjz6V7exSThmj05C6q9BUGUAqLn
         FA+rtnx0ZsY6szOfVz9EzEP4W1w2BG+2ArB364vQoWeNbHspFG/1r/VJyk+oi2qz4LHG
         nI02kMg4ZORcxi2LXH1Ibvr/GCm966BivHiIeRbJ4rQjxLCr8LCmDVkRxGgqs8Sind/l
         6Q6Ww5zM2e2Tl4UpN4PNRNDQtsaIeOrk1lHDoR5CghHPBqyOavjHJl2TU6ifqdBuwQ8J
         FlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhmRgVhh+2U3JbAOPK2kv2BKguDIUQsYRGPfRdh/z28=;
        b=cLk5a0YYDDmHpf4ic+Ohp7p+np0hy8UxcO/zASCZkdWC+Oyv29SV9hv1rhUPHPkGAz
         RcZUvfD9GE+80Urh3uhl8Iew0EGkfTX4fgxW4DHPDdmaGcQfTigdiCg2Qs2wRTilitQf
         kSuU6WLaAfGZH8H8VdL6t9MEK+TRSt67XjuLiGcJZk4XttHdzvFEDNMxL6DyC5HbGXJh
         3fwAq1ufM4QNdi8tIviQG6WJP1fRA76knIEeN6qOATeUehqGCckm3PE2bPYGbgZ5uT3z
         y3kyRo24zD70KGfR+mZbN8o+fV10VfLtOVvPo95wOdNXloWQTKc0kb2ZO8gC25XrL+kz
         BlkQ==
X-Gm-Message-State: AOAM530HGA9ZTPp+VT/6DuHTjCrght7c8ACShZjtsCVStqGGppOsVVqB
        ebcRVimqm/OEFtu1rDzkUVhR+VO0ORSzmw==
X-Google-Smtp-Source: ABdhPJwW1ZWhNLAfSJVP64IVU8s6QmDk/mkNNc7pitsIWOzv6t68yDxS5BuZR+O1dthZuX0lSeXPiw==
X-Received: by 2002:a1c:2d87:: with SMTP id t129mr163751wmt.121.1613414504343;
        Mon, 15 Feb 2021 10:41:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v12sm11258979wrv.69.2021.02.15.10.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:41:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        dstolee@microsoft.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] commit-graph: refactor dispatch loop for style
Date:   Mon, 15 Feb 2021 19:41:17 +0100
Message-Id: <20210215184118.11306-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87r1lhb6z7.fsf@evledraar.gmail.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think it's more readable to have one if/elsif/else chain here than
the code this replaces.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index a7718b2025..66fbdb7cb1 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -334,13 +334,11 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 
-	if (argc > 0) {
-		if (!strcmp(argv[0], "verify"))
-			return graph_verify(argc, argv);
-		if (!strcmp(argv[0], "write"))
-			return graph_write(argc, argv);
-	}
-
-	usage_with_options(builtin_commit_graph_usage,
-			   builtin_commit_graph_options);
+	if (argc && !strcmp(argv[0], "verify"))
+		return graph_verify(argc, argv);
+	else if (argc && !strcmp(argv[0], "write"))
+		return graph_write(argc, argv);
+	else
+		usage_with_options(builtin_commit_graph_usage,
+				   builtin_commit_graph_options);
 }
-- 
2.30.0.284.gd98b1dd5eaa7

