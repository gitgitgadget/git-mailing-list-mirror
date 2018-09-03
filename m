Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD3E1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeICWbm (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39962 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeICWbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so1076678ljc.7
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idv+9ANYxAZgoS/bf9XB1nbfiE2C12ErxySsASWtJk0=;
        b=IeD/Dl2qCqTEwrprWz9FEF/FPeYp7quboUXfSK3TJsKgWjeKzG5vOz6SLsnyH7jVaY
         O+Gch4TGVW2IX4WJk3Z052G1dRpwvc8tkOry9F4yAxEcKSSkzsLj4czWgUi7CkW4W10k
         +HHFmdTWLFLkXZSR+61YGOGo6vE2Gj3p4Dcp4lO+SpGCxkTJzq7rqAN4Y3hAZIZj8kkj
         JRr7P/xGXQtOjXA1cTOOnzZ/ThVD0Cfqk6owj7VtfzCwRubQGyCc2dfA3t2x2z99cZ3C
         Eq8L/8L102ZXz3xSRb7dg5lM9fmYEyE+bcw3gEY0mcGGX7hpjB78UaQs5Q678MTSBCqC
         uEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idv+9ANYxAZgoS/bf9XB1nbfiE2C12ErxySsASWtJk0=;
        b=uWVz2hJ4lhp4GYiqvIfpB9oz2z3oVtKdiJCSYscA0+Ii0Qt2yr2e1FlPFMgIPLOuOI
         Loe9KteScUW4sMlg85XK3SpD98Vt27q7X2hds5JGc3k9ZKKG1bWvWH7PzGVF9vJ+U5jh
         783Zn8oWKGHIsIJDcUBjX5NLb/noVhUpss/3eIyuM1Cjzme0UvmCsEVtSARYpQ6uXB9w
         +bhM/uHYlHFvpwsC0ydH8kk2aavnwuPKGDsXegTpyLY2YYVH9g92Vk5lmdHKQwHsOsoL
         Nn5pHED/sU4/Gvwumui7xGd32SkIaeykhahhrRntRmGkelv9BXVX5nr/NN0GBwisHJsE
         xE0w==
X-Gm-Message-State: APzg51DKt7dkl7mFSXKoMiz0fY43TMnHyI6nlKariKYfAzq9uUy0OY6K
        xlLzxwCFNIKuncIUp+wJrow=
X-Google-Smtp-Source: ANB0VdaNbYCTUSd/Zc3XaHTH97XGZ2wK562HE3q9vlg0H0VpNWTlSEeFxOMrxrbuxOXOrICb1zuTPg==
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr17704128ljh.49.1535998221236;
        Mon, 03 Sep 2018 11:10:21 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 09/24] read-cache.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:17 +0200
Message-Id: <20180903180932.32260-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8e92b1e21f..b9df81e94e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -823,7 +823,7 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
-	ret = refresh_cache_entry(&the_index, ce, refresh_options);
+	ret = refresh_cache_entry(istate, ce, refresh_options);
 	if (ret != ce)
 		discard_cache_entry(ce);
 	return ret;
@@ -1493,7 +1493,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		if (pathspec && !ce_path_match(&the_index, ce, pathspec, seen))
+		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
-- 
2.19.0.rc0.337.ge906d732e7

