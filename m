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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2502DC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D816613A9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhFQQUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhFQQTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 12:19:24 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AA8C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:17:16 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id d27-20020a4a3c1b0000b029024983ef66dbso1719019ooa.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJwpQVDU2xZwafgpxfkEmqLIxA1focJGGFitdRyBInI=;
        b=Wn+zQfjYKX+gVkYR1m7W9haDU03lI/mcSwv36jbVTCKN96oWOOwDeotkCFwBOYXGA1
         c4qC5wF8PVcPWQrKj8uEHxw8YlzU/5uHRrbVKvEBDWgNA7msWmEZEAZiFPYLdrwZawmv
         qQrhLlPUGCPb/euVpkGIIRfaaL1xy5rgG6Oe84kM79dIuiggLNfSIuPE7os0AWOdHxML
         TiOPvY9fo/NMxAirjEu5ARAoNTfcvYBGaH/GqY81fS46uftgSWCvgKuup1et4FA8xZk5
         tRdOA4/MxiJXyS4bfN+zeEhfihDjfbD2XLgg63Mb822jtINzQZxbOSmXW2djM90Lwp2D
         jc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJwpQVDU2xZwafgpxfkEmqLIxA1focJGGFitdRyBInI=;
        b=Aey2br2yhoSdCswjPoEOf+pQ6xqyBoby219MEUNSHuvA508mQXrNHvDwLoRsQ8jVtr
         qh9RXTpP4Fa2+3nI/75WJjVHtfkY+x5Wya7e8tuc+gyoXWgHtD6cUMMJcHW4UtOEIxck
         ItZZCu4Q7V244tLRcPfC+cs4mP1y5Cl5TBszpfk5LtCmjRTcXhQso8nouwZTMbtpuVLK
         cgRjhH38SKDgGLswT3hUo3K58ffcKNZj2Q1+e7YGyZvZq6Zx4v0cFqMsIBNzpCtq2vEJ
         BmvBZ7zP1McfQys+az65QPPcsZrRTp+16VMYKzoIEB3be+uDn5/kLt/nQZrU13BMgCRi
         xm/A==
X-Gm-Message-State: AOAM5332cz+TP2rPD1NuRwojzw4NGIbCgyI1BBT3iGt4X81zTtcNrfJz
        IthlLIObzN8ibWUYdE+sTaKXN8yEPY8BJA==
X-Google-Smtp-Source: ABdhPJxFdfRe5TrSKUnWFXKffZNnS7gvjhrtmbGB3fPDIJpIMzv4XxLy9ZGl6g2hbrm9bYHcB5WPaA==
X-Received: by 2002:a4a:e887:: with SMTP id g7mr5217665ooe.64.1623946636078;
        Thu, 17 Jun 2021 09:17:16 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e15sm1196282oow.38.2021.06.17.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 09:17:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/3] pull: trivial cleanup
Date:   Thu, 17 Jun 2021 11:17:09 -0500
Message-Id: <20210617161710.81730-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617161710.81730-1-felipe.contreras@gmail.com>
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
 <20210617161710.81730-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to store ran_ff. Now it's obvious from the conditionals.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a22293b7db..80e2f55cbc 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1053,7 +1053,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (opt_rebase) {
 		int ret = 0;
-		int ran_ff = 0;
 
 		struct object_id newbase;
 		struct object_id upstream;
@@ -1068,11 +1067,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
-			ran_ff = 1;
 			ret = run_merge();
-		}
-		if (!ran_ff)
+		} else {
 			ret = run_rebase(&newbase, &upstream);
+		}
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
-- 
2.32.0

