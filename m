Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59301F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeB1BGT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:19 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39030 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeB1BGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:17 -0500
Received: by mail-pl0-f68.google.com with SMTP id s13-v6so500373plq.6
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/r5qyO6N3jnAFB83V37Qv6qtb5/6/rQHPbZiIle4/vs=;
        b=cNt2CCRsqWNGHmdx4JR21RHqT64kACF34OA60rgeyF+WIvzBK8Etlh02yqRDA399r+
         pfm0QSNhtAvNEkY/L7OeTHHAiO4OUKT8w7tjdYrSWY/eQZdIgTbLyN3FGAbDRICXwJlq
         m4ywKI8W1oDBULiC3ujmOGVbvPH+TUkJwV/xeWeFBVdCdad+QGpgY2s7XkPU3PphNnSU
         9gI1YN1Y2ThYodvRgosaG81L/4izYg589Gdawr3l3HJf04sGZMn4ElKVc7zKSNjtG5Z3
         gnk9IH4rv6FDfL2XskwMdrHqLA8Nv06p8kBlPMXa4xtKOCPCwpwb7qeCij5wE4GjlyBP
         UzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/r5qyO6N3jnAFB83V37Qv6qtb5/6/rQHPbZiIle4/vs=;
        b=d9z3EW4/JSsl0ZLvEVN9VPnDHD+ga8/4/+bWE3HfqUPKi21yeRbv5U+Hs0Ficd8SDr
         lXVK6zfrjpJ86vZ1Rlz1rKsmok5rPg6XK724RNaFf2arLuo2BrmcSAco+TeVq8YkXn5M
         91zpDSKeGMmEJPgNUIP3qRttTTimCnT7oJdhfDEt52Y7K76lAjJ5FRbeQGX04kgcxpzM
         Fbz6KWICQ+ul2QYdzQt+aztWVKCoO+zmXcBW/1MW4/4FIbvC1/WDKi1RQQR6ldHCaEOq
         7ao2B/Os4Wdta6uLrfrXpXs+FqkmACVrlzwGJSXAVeyuRp1gJhII5hKNBKtnSB4WTN2v
         pZ7Q==
X-Gm-Message-State: APf1xPBnxstD800madOGKXIfGGrkNz64eLqcYj7+ARHz/HgltgxEbj50
        YHKS7eEl0xwF/21/LndYls6ITFZEjHE=
X-Google-Smtp-Source: AH8x224NC74wHBrTmq8UtyYBJXA7XfnQMazL6oSp/02rpjmk/JPbqRB1PzN2EV6mGpo2BZiPySQTWA==
X-Received: by 2002:a17:902:5716:: with SMTP id k22-v6mr16375795pli.229.1519779976731;
        Tue, 27 Feb 2018 17:06:16 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r70sm468345pfk.177.2018.02.27.17.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/11] packfile: allow rearrange_packed_git to handle arbitrary repositories
Date:   Tue, 27 Feb 2018 17:05:59 -0800
Message-Id: <20180228010608.215505-3-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index b844b653265..5ccce419354 100644
--- a/packfile.c
+++ b/packfile.c
@@ -866,10 +866,10 @@ static int sort_pack(const void *a_, const void *b_)
 	return -1;
 }
 
-static void rearrange_packed_git(void)
+static void rearrange_packed_git(struct repository *r)
 {
-	the_repository->objects.packed_git = llist_mergesort(
-		the_repository->objects.packed_git, get_next_packed_git,
+	r->objects.packed_git = llist_mergesort(
+		r->objects.packed_git, get_next_packed_git,
 		set_next_packed_git, sort_pack);
 }
 
@@ -893,7 +893,7 @@ void prepare_packed_git(void)
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
-	rearrange_packed_git();
+	rearrange_packed_git(the_repository);
 	prepare_packed_git_mru(the_repository);
 	the_repository->objects.packed_git_initialized = 1;
 }
-- 
2.16.2.395.g2e18187dfd-goog

