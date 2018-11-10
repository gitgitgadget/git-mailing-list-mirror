Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653DE1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeKJP1H (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:27:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46773 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbeKJP1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:27:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so2806839lfc.13
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPfYpgWuqsllTsgO4pqsrtMX4jmXCTuYZuwiZBIGK18=;
        b=Mr3u3uUsT/1p8kxRTwSRu6UkosuKewFMJGlrP5lPZ4bCXrO+uHt/x0vJBEPUgYGyKk
         2lZsGYxqImhylgsQFIfjRpaVuWCbv8fUIjPACuSfSAiZJBth/NM9uu9jgN+6eAc5y2V5
         JEVTJiYGoGeEjTKAYX179Ru+HON5Q2XIH0l9fxi20NlF5BLImdFbCYvGKCC2z0RwqZjm
         UdRlLg1GWXmR9G4RVLb6mEnXdXrluNNSfvpLEStxOk/47QC5GNHU+s1KfpD3q5ZcTkFB
         Q5LGtEV9uWicctv4JV65ycbd4EGmo39oHhfF9VNxWYyq9CleSYjt9kr6YZIr91513LNF
         OMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPfYpgWuqsllTsgO4pqsrtMX4jmXCTuYZuwiZBIGK18=;
        b=sz/s6LX5KkSBUOvuJOTo5KJirooFO6fNpibxVitiGVVFU5ojTlKY+Oi+1wkJRNK1oN
         Br83RZIczYvHCOHsbBMscr9jyfNCoETmTZsVD6aH6CUsRpufiHQkgxZS0VFaTwGETVlP
         HvFc9hMhWJ3XJB+4WcBAbF94GMOAnfYo6anpDZDRcb4B+C8K6laftLK1Vb9CoKfOSXEM
         Q8M/2ydTrlZi3Da0pnJTB2N3uq883+8uDlsXfNgzr/29xOHDMF1Up1HK+F97geDX7jpN
         EwRpRe+bV8Qol+emb2p9zm1M1UY0Dl76SCJkhaxXMlipMocaN5R9Zuo1k25MgLnJjTJu
         i/yQ==
X-Gm-Message-State: AGRZ1gLcQ39sblDNc1Y5zw6SRiS787OEyxUftVZ1iw9HlDkKHIFeLNWp
        cieUD4HBu1lTFqL4fRB+Zxo=
X-Google-Smtp-Source: AJdET5cKAKKDaind/EU/qQ1nGmWRs51fZg6wgn7iJ9V76Xff03qzzQJAlwEGVA/A8o03BrSVXxmERw==
X-Received: by 2002:a19:945b:: with SMTP id w88mr6581361lfd.15.1541826988106;
        Fri, 09 Nov 2018 21:16:28 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:27 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 05/16] read-cache.c: turn die("internal error") to BUG()
Date:   Sat, 10 Nov 2018 06:16:04 +0100
Message-Id: <20181110051615.8641-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index d57958233e..0c37f4885e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -316,7 +316,7 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 			changed |= DATA_CHANGED;
 		return changed;
 	default:
-		die("internal error: ce_mode is %o", ce->ce_mode);
+		BUG("unsupported ce_mode: %o", ce->ce_mode);
 	}
 
 	changed |= match_stat_data(&ce->ce_stat_data, st);
@@ -2356,14 +2356,14 @@ void validate_cache_entries(const struct index_state *istate)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		if (!istate) {
-			die("internal error: cache entry is not allocated from expected memory pool");
+			BUG("cache entry is not allocated from expected memory pool");
 		} else if (!istate->ce_mem_pool ||
 			!mem_pool_contains(istate->ce_mem_pool, istate->cache[i])) {
 			if (!istate->split_index ||
 				!istate->split_index->base ||
 				!istate->split_index->base->ce_mem_pool ||
 				!mem_pool_contains(istate->split_index->base->ce_mem_pool, istate->cache[i])) {
-				die("internal error: cache entry is not allocated from expected memory pool");
+				BUG("cache entry is not allocated from expected memory pool");
 			}
 		}
 	}
-- 
2.19.1.1231.g84aef82467

