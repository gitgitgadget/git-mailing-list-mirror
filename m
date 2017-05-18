Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8AFB201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754993AbdERXWg (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:36 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32825 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932640AbdERXWa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:30 -0400
Received: by mail-pf0-f173.google.com with SMTP id e193so30806357pfh.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wZXN+mo8bZmKUoByjWsBBAGHyWGapfG8JyCVnoLbrJA=;
        b=PO3ShHw6og0xvl6M1sftx7BAoizXDYaB9w2d6ysBcLZdiYdDOarcvyMZ+v48f+EKTK
         BTEF4ozxnyQ8DHvIxS+9ow9nfn+UjKpDML9UwNm054Wj4xsTBTXE/MGkUZnoDxtz4m8y
         5Hd14wQgREuCwWvTcn3Sbb1zfemxF2Ob0WTOoeoQtFgjaXCKKBdry4EYIkkgPL+ej1hT
         50J/FmOZ9nekBD4TZa49/QOEo9uG/7syLXEg28colSqw/MzdhjJ45TyZRzfveXP/RnF0
         O60M+3VI5r8ff/iE8Jgv1GPOYE4z/1Vs3gK1JdNdsP0nt5TlsY/PNTDt+/YM6/Ydm0NZ
         eodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wZXN+mo8bZmKUoByjWsBBAGHyWGapfG8JyCVnoLbrJA=;
        b=mlmHvMGmiHUhbp9WxzyLl65f8hk6WybrmLlS6A2160y+vZJavTzCoPPukaRepdzawx
         hiX/Zec91oPEn3MWoblox7upllSdAxFOQ+Mxaffvn7UT33YancHYQWAYzJ0AU5OB636Q
         bPQYUtagmaCa8RXufxyuxo0rx8yPhPyittM3IY47TnE1F7bwqTk2y2uaueKVqhpVWw8b
         D8Pel0qk3T180k1tFskVLZj1kZ67vOkA/Pvg3A86n5RrqAeOGByNCyPmcKjy7+xnJWDM
         /Eor3M79mWonUXCqlGPNSuCHRR0qyBQsjxZ8dmBuwkrAxN3QVfqA3UdwHx6PTk1lfss6
         b6TQ==
X-Gm-Message-State: AODbwcC4WlZ+RAi2zDQNTsP3fjAdtnMBUUYZMzkPUuS2D4pySKUNEIBJ
        nuGuU8HNsfg2tmd7
X-Received: by 10.84.231.199 with SMTP id g7mr7818649pln.70.1495149744790;
        Thu, 18 May 2017 16:22:24 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:23 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 12/23] ls-files: convert ce_excluded to take an index
Date:   Thu, 18 May 2017 16:21:23 -0700
Message-Id: <20170518232134.163059-13-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 755dfc8d6..de02819c6 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -321,10 +321,11 @@ static void show_ru_info(const struct index_state *istate)
 	}
 }
 
-static int ce_excluded(struct dir_struct *dir, const struct cache_entry *ce)
+static int ce_excluded(struct dir_struct *dir, struct index_state *istate,
+		       const struct cache_entry *ce)
 {
 	int dtype = ce_to_dtype(ce);
-	return is_excluded(dir, &the_index, ce->name, &dtype);
+	return is_excluded(dir, istate, ce->name, &dtype);
 }
 
 static void show_files(struct dir_struct *dir)
@@ -345,7 +346,7 @@ static void show_files(struct dir_struct *dir)
 		for (i = 0; i < active_nr; i++) {
 			const struct cache_entry *ce = active_cache[i];
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, ce))
+			    !ce_excluded(dir, &the_index, ce))
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -361,7 +362,7 @@ static void show_files(struct dir_struct *dir)
 			struct stat st;
 			int err;
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, ce))
+			    !ce_excluded(dir, &the_index, ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
-- 
2.13.0.303.g4ebf302169-goog

