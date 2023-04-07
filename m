Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DEDC6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjDGHZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239225AbjDGHZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89AFA5D3
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t4so36368238wra.7
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppV69I8CpIOb2f5UaGJDykgFidnkTVaT2dBaMGHXrfw=;
        b=YKXN9DjOacVGOq6vvX+JwToUtp3O+z1sNvgaoaisW6sTxc2o31wLBzTz7hTnYQTTz+
         TNVVfk3I7oaZmkE0BUAMflGwV4XsQr6ORdMkkjxq7CbUaVUHE15qNeaMy7aopqUk6FoW
         9Fm9Lsvi5r3UfjyasHc8vJaBrta5hK3Lshr86E1ICfNZZkRfZqMzjrOW+EZ6ALWd3FD6
         12f95Rx8TMFfwPqrfqISfJmXpmGZ730Sj67Y614rWcFEZzknhvJoVvPTIDT9kod2kFcd
         +3ntSM6thdo1C+Hm378XWPKInrkD5nv8qOVHRuw7a7NK9SvnqKLaFCB/VT+Z8DORDQI0
         Lnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppV69I8CpIOb2f5UaGJDykgFidnkTVaT2dBaMGHXrfw=;
        b=LIBWJgacXVAmIY3kBHVxVfM/ojNPzDPwKj7tZLzJkmaU4eQqbbTftHAZVaa1WMPXl8
         DOrN2GJ9hhZhBOz1W7UXgU93OQp6UyO9KnM4xo7wu+a5qQ4eitPUf3DpTO5XQLsN2OZN
         eQ9dpEFHXkCLJSBKrx9NapamaXJFKI+aXS8ZKYxJaZUuth/6CJOb27M1hoe5pTNqPHt6
         7MmjcR/MFLRRmpba1MGfC7UNDFtHSA+96UEZjQ9GyBwjCi3K/7vHfc/pGpWM3I00SXCf
         6DQqw1JLREfpZTmvAHv2suKg607AudlKksqZapKuq/E36LnpNIux5S1vwYW53PbIraqE
         DVrQ==
X-Gm-Message-State: AAQBX9eEaEse9cz1hSw0AhUref91EcKxkiRWN3f+FaaEufHbGrwqUBwU
        c4djan2U4ejhPTWI4TOIcCY4ZFzvIrd95A==
X-Google-Smtp-Source: AKy350Zy0miSwxoxBaqxuAEpzuNAXDmUYnOivlaDB95jmcPxtqr2z97SzHaRp7wL1ETOpUf3TyMi3g==
X-Received: by 2002:adf:f20f:0:b0:2ef:64cd:46cf with SMTP id p15-20020adff20f000000b002ef64cd46cfmr604660wro.60.1680852285655;
        Fri, 07 Apr 2023 00:24:45 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:45 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/14] replay: don't simplify history
Date:   Fri,  7 Apr 2023 09:24:06 +0200
Message-Id: <20230407072415.1360068-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Let's set the rev walking options we need after calling
setup_revisions() instead of before. This makes it clearer which options
we need.

Also we don't want history simplification, as we want to deal with all
the commits in the affected range.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index ea12d4c8fe..59ebbc3b8f 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -164,15 +164,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	repo_init_revisions(the_repository, &revs, prefix);
 
-	revs.verbose_header = 1;
-	revs.max_parents = 1;
-	revs.cherry_mark = 1;
-	revs.limited = 1;
-	revs.reverse = 1;
-	revs.right_only = 1;
-	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
-	revs.topo_order = 1;
-
 	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
@@ -180,6 +171,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
+	/* requirements/overrides for revs */
+	revs.reverse = 1;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs.topo_order = 1;
+	revs.simplify_history = 0;
+
 	strvec_clear(&rev_walk_args);
 
 	if (prepare_revision_walk(&revs) < 0) {
-- 
2.40.0.228.gb2eb5bb98e

