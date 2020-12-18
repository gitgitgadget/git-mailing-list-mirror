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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECBDC2BBD5
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C7C23B97
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgLRVLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgLRVLt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:49 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D4BC0611CB
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:43 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 9so886427ooy.7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nTC2i4Kqiy7b4NRapVUTn/nxdD61UKezGyvzG3JiejU=;
        b=gpdgbxAudyonMMtrdSRKn+w/T8eLv96yfXAq8aC1XDt21Ztnks5HS35rwxuktFtzSy
         akxieEoI7iBk0p3t3HbjsgpgpxlY/0hLbRAGJg1WR/Ay8zpiFGnGm15GlMbflN/MaaWt
         t121deiF355Rxqsn0fYsjwyMR92YydnkXxB2Z0HwKdGCZlq7cHJL26OJlaGjZhxRR2lV
         yyWTfQJd2z1HjunVd2tn1jOUzsL93jhzEaI0B0CE3B1apM/7Pas8Pqm+O8MHBEItZ/0w
         9GqwBcICknkJh5y+p+5lIA+sqM+W8XryxAWB14CQOn2tHPafTMNLA+k1Ei2sz6VJZZub
         XpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nTC2i4Kqiy7b4NRapVUTn/nxdD61UKezGyvzG3JiejU=;
        b=ThdycU9q0XyQz7TsJMEcQDf4tLGWmk6nR7WGsaab7i7t4iA74B51Pfy/y68b7veXwU
         dK+DN2Vcjju+yWPt6SAplW36Etnf1QBUeVfHT+QXoitam1s2THgSCnygt1TqKJrAniT3
         bo/sK1ItjrniDde2auHUMI3+RdIFUp0et0NcOoA0FEn9b0xWP6yQvNIPxzq2jyEpkyhb
         WkIniIJ3gtTjxQFoxHkr8c/YrqTHRX6Xs8sx/RQa1TOnHIh2v8Ja3U5u8d1uo1+gIOgY
         VgDlhUXYSq5x0NV76qUdrNzINqILxKnRykuV8iGHC0+qSUi9IJ9+iOIzqSkHVIfQjklY
         PcNA==
X-Gm-Message-State: AOAM533C27/5Uouyg2Hddca2f+0DsvVO6RaWW5k73u4oXrVBNjE/v/B3
        Mi6/kwsYXQpwuXLWC2FrgR1zMa6e6rKNsg==
X-Google-Smtp-Source: ABdhPJzwgMLnhAUn33k8EfwNsYM4mUj17BfP7iaWJtNCm3paHGnHulHncuqcxtBTB7uX+ZT0lXjTzg==
X-Received: by 2002:a4a:a2c5:: with SMTP id r5mr4245539ool.72.1608325842527;
        Fri, 18 Dec 2020 13:10:42 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id n16sm2252419oop.9.2020.12.18.13.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:41 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/13] pull: move configurations fetches
Date:   Fri, 18 Dec 2020 15:10:21 -0600
Message-Id: <20201218211026.1937168-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have FETCH_DEFAULT we can fetch the configuration before
parsing the argument options.

The options will override the configuration, and if they don't;
opt_rebase will remain being FETCH_DEFAULT.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index c0a90fa741..2fd5e44e03 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -951,6 +951,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct object_id rebase_fork_point;
 	int can_ff;
 
+	opt_ff = xstrdup_or_null(config_get_ff());
+	opt_rebase = config_get_rebase();
+
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
@@ -967,12 +970,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff)
-		opt_ff = xstrdup_or_null(config_get_ff());
-
-	if (!opt_rebase)
-		opt_rebase = config_get_rebase();
-
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
-- 
2.30.0.rc0

