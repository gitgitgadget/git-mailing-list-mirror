Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2E51FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbdFHXmK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:42:10 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33678 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdFHXmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:42:01 -0400
Received: by mail-pf0-f169.google.com with SMTP id 83so22172939pfr.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XO0OZicUwmX/EXqVI51wNOZHQK0bhFIrJsTPMiGEwN0=;
        b=FW8+WrCaDBIY6iLXDV19190MsjtcAKXLcUCCC3Yx3u9HuMrpdF0evcbRB/yK0oOv7c
         IqhuBoZvn94gXvMOrnksDMDtvslAIbrExEgZt7Ji8OCwPgNxB1McRWyvODV/obxWVYLw
         gJKl/GlRrFu4UT5+l4ER1VagP03aB8C0KvZAzTCY1ePCH4SRClg/Ff4pHxIr/mVrbW0D
         V4a0GPU6BCRgQg/CnMKNRfacRAxfK9NML/jBMg2t60GdzlEd0wOruJ7/NpbOM3Jj6LcA
         Zhqg9C/ZdEWAk2vjFczNzzv7qFwIYSitckUDsms3teSpZQHYYOGgKTnKE8i1h2quV24x
         pTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XO0OZicUwmX/EXqVI51wNOZHQK0bhFIrJsTPMiGEwN0=;
        b=RcNsiskg2n8y/Et+HhZnGa+noXOmWtSXiykJrspZWfexlaH2Jk2wsmVIXMPSckkomT
         rbWgiCLQ5F9qHL3G05BXzE88wixj3bptTKzW7nXefXSTpNr4rjpzh4g69S9TGhWZCZ6J
         Q/h0+gI2wl/63YRJXMEfIcGJVbiSBmTYPZUBnG3iUThASueDSEvvVeHaZFwRE8VQ+9wt
         YZ9Nkxy9VaCT1jrc5BzfirVgDFvPJqbGJ/CHIe1CJf8m3vLso4SFDZSYudiG117mtu0W
         dA4HiIcc2dQGKgGAc04T12+vRvH7Y9SFhgjlZm/BJS2XYdLMhNE6tohcBk3F/mJ2CZm5
         pcBw==
X-Gm-Message-State: AODbwcB/q/2z8kfYoUuR4ApYrQ5mu9qRPA7mY79F+GCQk8gEaz+tifsC
        Xw5SinNIVsSRdKGzts6UMQ==
X-Received: by 10.98.59.92 with SMTP id i89mr40223957pfa.122.1496965320417;
        Thu, 08 Jun 2017 16:42:00 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 27/32] ls-files: convert ce_excluded to take an index
Date:   Thu,  8 Jun 2017 16:40:55 -0700
Message-Id: <20170608234100.188529-28-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2838e2f75..289c6b2a5 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -322,10 +322,11 @@ static void show_ru_info(const struct index_state *istate)
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
@@ -346,7 +347,7 @@ static void show_files(struct dir_struct *dir)
 		for (i = 0; i < active_nr; i++) {
 			const struct cache_entry *ce = active_cache[i];
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, ce))
+			    !ce_excluded(dir, &the_index, ce))
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -362,7 +363,7 @@ static void show_files(struct dir_struct *dir)
 			struct stat st;
 			int err;
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, ce))
+			    !ce_excluded(dir, &the_index, ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
-- 
2.13.1.508.gb3defc5cc-goog

