Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C70C43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C15064F72
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhCPA4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbhCPA4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:56:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FC9C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t37so10697877pga.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rl6UGS6/fd//X5zLxmR7QzJOdstld3TQFF86qC9cwBc=;
        b=QMSYgDP7PMprcLU2U9AYXij/r6Z3vtA26Rbkot8EYI2ryW6Di7Qr2jB9wR6lEJdZUr
         UNMIYoPrbWzzZqUJlnXvUw9r/RDv5nE+i+BXukqK77SXTAmh1wwhYGE2ncSu5QRhs0rs
         xFOXPiiKopTKp1jZq9z1nfck0JusinQh3BHULTqk3vjBxQsvUd23mRMi9amuPmAxcMrw
         UyQeAmFsj8XRtzuX9Gx1rAOiL+ySCQsWtjxsgGzolAJ0t4z7koX4uZAKfP9iH1xdoa52
         +8eXtpGNZLlFlOlSCI0Rree0HdeLA2v7XAV0vNXlaeXXX1e1aqLvLFun7aD1X5669rxy
         fLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rl6UGS6/fd//X5zLxmR7QzJOdstld3TQFF86qC9cwBc=;
        b=SG5oLhTtWVMUdrOosp6sQ70DJ0Mk0O8OhKaD284vkT9nlDzitYPemcN9qf3kX0Y/q/
         1+u3GZ5LRTJbHT2e8w1RywtH86RPcXeFb/ZgS2qyMoQaGsQuGw4vRQfnGR7wrpmq60Dt
         fo2f2VNShBgklG4IabE1vVJPUpfCDyjNhUp2B0BFvWAUEVdMuOiKyFR1LhEBBJoLHPAh
         +1TjLn0rkJXhyj38Y55ybdTUirtwj79RXrom+dkA5cCNF8lAWrF0e49mw8/W4saBgaVP
         Mkxu5xChciTkEQt+P3qBotbTqRo61Nc1cT/+J/GofGr1H6a2IqE4+BEA2YMtWG3zQgPj
         4qTQ==
X-Gm-Message-State: AOAM530s+ylFIcRDRDt5x8+JXRhbxE4Q7b6TAmBBQX7jcnJ0HAzE7lLT
        kOpm4bjhdTf0Sm0R2JfNTMaVHx4Zxcw=
X-Google-Smtp-Source: ABdhPJxFnnW+SSsI3P+3KAdgVM5U+GPM5dTdIZE05/i/xfDSJvmnj3iOCkKqbFaMdSwtgp893HoxMQ==
X-Received: by 2002:a63:cd08:: with SMTP id i8mr1499980pgg.49.1615856195973;
        Mon, 15 Mar 2021 17:56:35 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id h186sm14670312pgc.38.2021.03.15.17.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:56:35 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] ci/run-static-analysis.sh: make check-sort
Date:   Mon, 15 Mar 2021 17:56:26 -0700
Message-Id: <09c993a8f78d67bcff196c5b8173a8e5f6fd805b.1615856156.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615856156.git.liu.denton@gmail.com>
References: <cover.1615856156.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To ensure that lists in some files remain in sorted order, run the
'check-sort' target as part of static-analysis.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 ci/run-static-analysis.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 1ae122fc70..92437c09df 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -26,7 +26,7 @@ then
 	exit 1
 fi
 
-make hdr-check check-builtins ||
+make hdr-check check-builtins check-sort ||
 exit 1
 
 save_good_tree
-- 
2.31.0.rc2.261.g7f71774620

