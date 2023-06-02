Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9540DC7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbjFBK2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjFBK2A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:28:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB8EE4D
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:26:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f603d4bc5bso18227705e9.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701560; x=1688293560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oC3Plisdt966JyNz69Px1c/osGOg6I3auirVRmndbg=;
        b=Vrf1QwgJxi7C3jGQYQ3ePEJXalHYuZmGW+ejddv2sUsGarT25kqtIKaJmd3YEpM6AK
         5rEMgX8hqxHsDzzNhncPlnRs7y3/ir9kh8+7+LHkb1kn8fFYaqJg1S6kTx/DkiGwltCh
         juUSUIcCC5EcchkYRBCt+Esqak0OURCjzbURFrnKWOuDpVskZRXK2AqznTQsZfGC3JcM
         J/yr2sgeo/EFt8/av23N4P9WM0OKfy4ByJIyX41zZex59A47O83m+0/8BJSQyF9H+7Ug
         72RYurMIm9jroMricdHSYJZ1v3kU5ayPqKc536qt2lmc1Uhn54bNhTDa6AxCynV5naGw
         akDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701560; x=1688293560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oC3Plisdt966JyNz69Px1c/osGOg6I3auirVRmndbg=;
        b=RinuRbmMjp4192hS+idAn6m9ld3vplmDyd9Fffa0He2XB+gt0vRlgIbr7fGg3YZUej
         dNKkx0k1/H0VPEs8G6YitxNhGhSDwNlB9DRe7dBpfVxnrndPgwRr89W2mpje4XhIn7ie
         36Y9QGulHmH3DhrtIlVEuzxTdR+Nuc/arXTPdomyRs4G0RCFRE38SgSlwFzIjMTUJsg9
         H8FLAcnjik/6fBmj4uXJsuNPeYGzl7PLGC1r5zpBvdNG7yxQUnhd8uKRXMpIpQgCyX+P
         52wVO7pLKWplFLe9g7AvNwhTisBQ3OrWGdMFILDyFOrAsg164Etlq0KEbHZ4do8wmJv3
         GGpQ==
X-Gm-Message-State: AC+VfDzHY0cND1E8ihjRQEWMvd+C1jkVLzAZW7rINB+ooO8VX6eSfddY
        gRkFCPmn2FQYDDl44IpBggO3lP8kTTMefQ==
X-Google-Smtp-Source: ACHHUZ5Kibt0nYRZcx6tLLVsANiBnevCh4e4o37CDFkU80togBtDipKXDx9VMzO2tHkAqFVoVnXUPA==
X-Received: by 2002:a7b:c8d9:0:b0:3f4:271a:8aaf with SMTP id f25-20020a7bc8d9000000b003f4271a8aafmr1793687wml.38.1685701560342;
        Fri, 02 Jun 2023 03:26:00 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:25:59 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 06/15] replay: don't simplify history
Date:   Fri,  2 Jun 2023 12:25:24 +0200
Message-ID: <20230602102533.876905-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
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
index 319020f5fd..d28d468008 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -172,15 +172,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
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
@@ -188,6 +179,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
2.41.0.15.ga6d88fc8f0

