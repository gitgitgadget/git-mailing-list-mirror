Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78121F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeB1BG0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:26 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39039 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeB1BGY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:24 -0500
Received: by mail-pl0-f66.google.com with SMTP id s13-v6so500578plq.6
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cc0iXc8jr6hHDs++y8kQhMWUYD2Xjxnr49CVeyxlO58=;
        b=Ic29eWQ0ZpAbxbINKILQ33QSRT+uV1dW51sObNB2K5ok/kTSnBy2UEkrxTzKOS4GXN
         mV/UeoQhCiFf4s2ed7jFnvD66T183nu4WL3ipf3pcGIR8XfnrHKyrdGZiIMYMVs7LRGO
         qo97FVG5nnq4kC+KMNyZOspoUlIRGkqnYPXTITSk+SPTUM4TsMwOMwz3to46WgkzLnmR
         ES9Ng0JjkiCmAiLzuctpFGkz8WUx0a3zBt/GMtoOqxqSDQpeq1YNOInjFM76sIjuB7wx
         o5tKm3wtTZ/fxanKI3tzUapAscXowIWNQIEaxMAkxq9FFlY55dbmGsKegniV6YgEmUp1
         9mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cc0iXc8jr6hHDs++y8kQhMWUYD2Xjxnr49CVeyxlO58=;
        b=hPRwu0JO8ioT9u3VVQSVLstMwIbivwobEyvr0LWXoI4wQuL0oBl4WPF2zInVEPg4Jm
         XzMVZqcYkIPGxrdxQ3YgnyJnbT5PPlhib36PJftwb8HPivLbXH3lz0eDh9LQgyI51+1Y
         VcjGWoDwg9Qi5SOKpphgTxW6zzAwnqSgZ9XYaLgds1r8caKqcKP7qe2OYsGzEc7cpR5d
         qFirH7KOwNsBh+kP4FVyWxyroLEm4CXBKJCKyckZYyr5WAXyKU48mzjaJX9+pqyC3O5b
         Di6+E2wmtwAyzoaG+/vQpEQh3b3idkGIrMge194fuxPXVjpbY2DE9dGVs1Z3hINGcs6w
         QbJA==
X-Gm-Message-State: APf1xPDDf6hp8Ka7YbN7ZUnMIbDWamgFnJh7wM79S65I80BGt8/QHmbB
        Bsgd5Cj7Ub8uG0rg4JqazPkiSur9Ftg=
X-Google-Smtp-Source: AH8x2247JzrmzUBarUEjHs5AhMtmUx7T/f3BA9cCbIwzmoSqTV6RdsOp2JF9gJcRyQUUyVF9NTjm5w==
X-Received: by 2002:a17:902:7593:: with SMTP id j19-v6mr15439190pll.408.1519779983899;
        Tue, 27 Feb 2018 17:06:23 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r14sm483718pfa.136.2018.02.27.17.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:23 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/11] packfile: allow prepare_packed_git_one to handle arbitrary repositories
Date:   Tue, 27 Feb 2018 17:06:04 -0800
Message-Id: <20180228010608.215505-8-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 6ea50230aab..c45516acd41 100644
--- a/packfile.c
+++ b/packfile.c
@@ -735,8 +735,7 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-#define prepare_packed_git_one(r, o, l) prepare_packed_git_one_##r(o, l)
-static void prepare_packed_git_one_the_repository(char *objdir, int local)
+static void prepare_packed_git_one(struct repository *r, char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -769,7 +768,7 @@ static void prepare_packed_git_one_the_repository(char *objdir, int local)
 		base_len = path.len;
 		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
 			/* Don't reopen a pack we already have. */
-			for (p = the_repository->objects.packed_git; p;
+			for (p = r->objects.packed_git; p;
 			     p = p->next) {
 				size_t len;
 				if (strip_suffix(p->pack_name, ".pack", &len) &&
@@ -783,7 +782,7 @@ static void prepare_packed_git_one_the_repository(char *objdir, int local)
 			     * corresponding .pack file that we can map.
 			     */
 			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(the_repository, p);
+				install_packed_git(r, p);
 		}
 
 		if (!report_garbage)
-- 
2.16.2.395.g2e18187dfd-goog

