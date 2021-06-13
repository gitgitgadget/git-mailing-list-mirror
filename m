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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD2CC48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 05:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E52611B0
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 05:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFMFCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 01:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFMFCE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 01:02:04 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBACFC061767
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 21:59:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so5145501ott.1
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 21:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJwpQVDU2xZwafgpxfkEmqLIxA1focJGGFitdRyBInI=;
        b=o1OFqMiAY69dnqH6QVqttr7q9rQCRRCLiuyW6PPw32LFTkOxzHqude2Nboq0AkbDi3
         yakDPvH5T0EvS7q3vRL8LB/nw8AA8wkmLZu+2gMkFw2CFFu7cwnsAUHS2Tu7KWy04t8t
         53ys7u/rueAEevB8hOrmuGEhqrFA40YEDLUwOKMKN98RQFFX0tkXslLRZxGvGSC1Da+/
         6XzSoSHvgjTLuKdKW+lbvOXy+wMpnv83lQ+Roifm32rA+Mtwh6A/oBIEGAOQ2PaOc91W
         KFsASJ+IhQvnZIQr/Wfd4cHymn7DG+DWwJtypC/Q6CYm/unftLWB2H3EiNhkDQ71ATtH
         dt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJwpQVDU2xZwafgpxfkEmqLIxA1focJGGFitdRyBInI=;
        b=JYBO/mvUA9GJWEdDDWBzn6KON1Xj9PzOGL0S96VENiXNSjMXCvSXPOwFvYoMXqWoSo
         P1/FMamzVtr8M3HlfXfhmX9HbVSUXEGUoxpzzdL49BiZKaMQUR3/QaSzasLILzI4JBRf
         yCP9k2blWC0SABe1oTv6LaK+L/hwvXPRQ3R0JY/u31llu3G8z6QbeYWRGL/Y3DgdFgUH
         C44eECwvg7gNEk6WcftneSL5ODSZ+Jx/QGl+EztfXYPc1uPmMhyQWvz50LezlhgeCGbV
         XH5aTj7vYcuZDfRjlPA2CrAWQap13WJxw1vbT9Bm5zB59bca6GzbrWMSfqHICFfEyLzu
         j3xQ==
X-Gm-Message-State: AOAM532kDXsQq1QUBt0W6rOZOFFfWN7dIUw/9EWB+XS1PPvC4CxkMrSJ
        mWr+PKxoLRxxT1KuPJHx9+lrunrFylUkrw==
X-Google-Smtp-Source: ABdhPJw2FtjMPvCV86bIvyutphBtE52A087oItfgu5+embc6CaG/1F77QjFOS8C2/jOf4aEIriYYtg==
X-Received: by 2002:a9d:5d14:: with SMTP id b20mr9076003oti.307.1623560394552;
        Sat, 12 Jun 2021 21:59:54 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id b26sm2446167otq.43.2021.06.12.21.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 21:59:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] pull: trivial cleanup
Date:   Sat, 12 Jun 2021 23:59:48 -0500
Message-Id: <20210613045949.255090-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613045949.255090-1-felipe.contreras@gmail.com>
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to store ran_ff. Now it's obvious from the conditionals.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a22293b7db..80e2f55cbc 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1053,7 +1053,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (opt_rebase) {
 		int ret = 0;
-		int ran_ff = 0;
 
 		struct object_id newbase;
 		struct object_id upstream;
@@ -1068,11 +1067,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
-			ran_ff = 1;
 			ret = run_merge();
-		}
-		if (!ran_ff)
+		} else {
 			ret = run_rebase(&newbase, &upstream);
+		}
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
-- 
2.32.0

