Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7261FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdEaVp6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:58 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34474 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbdEaVpU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:20 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so18588738pfj.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tkmN4laK4MlHPMk1+wjjcsZ/izkUTxPCfpyS+Od4dGo=;
        b=PgHs4MjYfg3NIq+pNlplFvw8lJJBEXwcNKzCBwCvluquirLoB5aEuecENhcX8+n54s
         CblgzND6b0rXEkOZIXdGHYmW+XS9IHnZz5tIMs/15G40XnlF2v+HawY8dkL7uNQsGRB/
         2JApUXvJ2dH5G8LoqWygep8cWb0bOP9u8K8WUV4XRqiY55gv21vT9aq8ekr4OeB/IH1Y
         1jDGqjjcEAEAvv3yk0hxv/MmKxeqW3l5Ei1yuo1IoYfdA0jaUU7wnc/XcUpHfgtz1nvj
         RxoD7yS9MwR3XRyWKb3Ig1NoH4E+XJr7ahNrSjgp1LU1w1nNtbgCweDjgdiNhG5oP9kz
         KfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tkmN4laK4MlHPMk1+wjjcsZ/izkUTxPCfpyS+Od4dGo=;
        b=P9u+JJef9xFoDZfq2TfrNjWEOU/OurgjFsCAFxWYtKM6J7bHl3DPdqed2v6VfdG/Q2
         /nHQgTvv9RoDh+T7GT8vLwjT6qIVFa+ZOfVkCZvlsWNuBdPWPnDnsE9SVk7zWZ33rrx4
         9Bj0RgeOOFcDftEUs4cNVcws3JGHTBYB5FWLleCfK66fiB8panfdMHDyvUYf3Pud4uew
         ncscoS8ZhMd0jALgpW7rJOFa8pEtMbZnx2PXLOsPJS2EjgNZfcnQW2fuU34Ua+ypi+jL
         QJBflkcsVLchnyzJNRW6mZA6zwHDYo+EemLNpesGeZJlEhAIEjcH3UrJZUCBxpb7uPE9
         PzgQ==
X-Gm-Message-State: AODbwcD2DD2cu01jeMxRDuM4xdc60HW0sGYINZCr7jevCESaX7V1xY4o
        szDwi0e0KY4BnOqDKlvKLQ==
X-Received: by 10.98.16.28 with SMTP id y28mr32628902pfi.163.1496267114525;
        Wed, 31 May 2017 14:45:14 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 26/31] ls-files: convert ce_excluded to take an index
Date:   Wed, 31 May 2017 14:44:12 -0700
Message-Id: <20170531214417.38857-27-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
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
2.13.0.506.g27d5fe0cd-goog

