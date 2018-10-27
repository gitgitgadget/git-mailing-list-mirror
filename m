Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91471F453
	for <e@80x24.org>; Sat, 27 Oct 2018 17:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeJ1CMH (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 22:12:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40958 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeJ1CMG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 22:12:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so4013837lji.7
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34AlMYInjUJvKBJ83Ba7wlLqRcceLi+ycsU6IviV8ho=;
        b=Nm1IhKdv44uK25Nb1C8Wg+IAquFSmo7iwESwtovJ8kT5zGHcPAZYEExzlalqNoaLjU
         ufYNa44hYKRbPwlaJZsAhkFyHYWlGI3iKBnXpz4I2V8RjLglZiNorgnu/51KChzFjGt9
         zUPdq4hm4xUdkZ3XSWkDxMlI+WO4v7NEJxwkMm435oM9IBEChucG3p5QvPx0Sxax3ll6
         zKoKiPRa6DHaWkicx39mb0CkwfiKZ0LNdhNDC+hbbeqfB14lHRfsBuE/gD8TrjANLfyL
         VDF3B/H5579TGoHu/hbqU17SQyWggMWBspKB6PmI5CUHpdbr6L1nbahFZkeEXQeEi0X0
         z14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34AlMYInjUJvKBJ83Ba7wlLqRcceLi+ycsU6IviV8ho=;
        b=Yl9MoEqOKKzpQfoWAhZBxfP49pZExOjZVD9WhTBTOOF4CfT/fgw3ylt/gwk+reTjcc
         lLj/QPUjUm/gKFh2Bz6leetJ5YA9BkWMU7cCKT4H7bnQ8QjQqURpFILBdswitoewRofO
         wHgQ+U0+tdlqFDy1fSV/OrbLHGuLbI+Qdt6SAI0XLXWQs9aThz1knXFWefiRE/a76Kzp
         iA5QOKNfo7guAS6F5jj/zzt4F1eKtqJAwL953ughLgcll9QP8RXS8boztx64Gf4TiniT
         kPE/XTbIwfRnKCmELR4trXx8NU6XQd79xruM4M2mJiNyt+wlW+hWzN/NPKN56EvpkVzV
         0TKA==
X-Gm-Message-State: AGRZ1gJFP/4qeR/nIMVn2zE72iaBjjWjtGvphCipkAx3o5IBCJpOhcfR
        DSNiSlZsYt6oTetEc34f2DU=
X-Google-Smtp-Source: AJdET5fF+YeX8cFOD7I8YpcKd2nPAivwa9EThosySooJimNxAZZs4x8K6CB6Ww6DUH+wa62fssUAuQ==
X-Received: by 2002:a2e:21d2:: with SMTP id h79-v6mr5292594lji.46.1540661423781;
        Sat, 27 Oct 2018 10:30:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i185-v6sm2333517lfg.89.2018.10.27.10.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:30:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v2 06/10] preload-index.c: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 19:30:04 +0200
Message-Id: <20181027173008.18852-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027173008.18852-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 preload-index.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 9e7152ab14..0e24886aca 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -7,17 +7,7 @@
 #include "fsmonitor.h"
 #include "config.h"
 #include "progress.h"
-
-#ifdef NO_PTHREADS
-static void preload_index(struct index_state *index,
-			  const struct pathspec *pathspec,
-			  unsigned int refresh_flags)
-{
-	; /* nothing */
-}
-#else
-
-#include <pthread.h>
+#include "thread-utils.h"
 
 /*
  * Mostly randomly chosen maximum thread counts: we
@@ -108,7 +98,7 @@ static void preload_index(struct index_state *index,
 	struct thread_data data[MAX_PARALLEL];
 	struct progress_data pd;
 
-	if (!core_preload_index)
+	if (!HAVE_THREADS || !core_preload_index)
 		return;
 
 	threads = index->cache_nr / THREAD_COST;
@@ -151,7 +141,6 @@ static void preload_index(struct index_state *index,
 
 	trace_performance_leave("preload index");
 }
-#endif
 
 int read_index_preload(struct index_state *index,
 		       const struct pathspec *pathspec,
-- 
2.19.1.647.g708186aaf9

