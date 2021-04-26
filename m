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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B264C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1266109E
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhDZQUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhDZQUR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:20:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E161EC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:35 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso38541160otm.4
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/EHczxNq6fJMk/YF46UPA4tVUWxxo6EtvVEuagpeZTc=;
        b=AZHDxzTiwlqeXvDW5R9tB32WHr6JnfkdCzjohZXTg1kgnMvXfFeKw7DoVS6b9imjbb
         ztQNbm6H4fknG/nhTPR8ZwuJqFDaveG3q6g6iZU8FFEdYLaSo47L9WW7bGNxLgZfS0p/
         O2k0EpByZP24sOL1QmJtJnMw4uOXPoswEE85ZB7ZsWa763NSJu4daGnxEkITaS047fna
         cPvxHKNbCvp0FA5OzubscLbboiE3VocGH7KUgJ/9YcZ1mO3uroANtGUU5t47tpyOFQTk
         A89g9EVHpMdsMHHI1IYGM+0cF3sZp8eAPob07ySjKiLiEfuVeqQpSLKuildb0c8FPKC4
         yDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/EHczxNq6fJMk/YF46UPA4tVUWxxo6EtvVEuagpeZTc=;
        b=bgpXUzmC17Y7revcdYgY11ZzXnUh3wkXZtewWx+1/rZkXUp77lpQB1J7pk1Mwlz3fg
         Nft1gy9BZ4f5dn/WuMNIGRnsknkebCEBfnDEOqbOdJhAzw/Wv5hg2cFw+/wdSz3d3Ga0
         v/cOrz0pUczqpqb0j+yPoti14pGuqbnVmDq61aZ+gKV+ZRvHnpOs5MI1YiGn5GIAOTBS
         nnZQwMYHKtdPiyfOTv+4wKQwovtoGNkZtaXqrzUr9v/QUjY4ttubF0RKcb7dCBKAeV5Y
         5HIgjgYKEFDercDui5T3qOHKEsrIoFDMra0FFoihXhUceS2rfBIh59EkshShPhv461H9
         bWTA==
X-Gm-Message-State: AOAM532WKR+eRedBZ0D31m/ANFPuQknWGd92PdxyjKAS1ejHDXztELJx
        qvygCZdaFot28iTk9zUsB3wghj/sKtwW6w==
X-Google-Smtp-Source: ABdhPJxTJWjZV8/6br5lxQF3LjuboO9Pt6GWQy4chvkljtBXYNocGXo0MrwzBHkjLhQa6LpkhfqZnA==
X-Received: by 2002:a9d:4e9a:: with SMTP id v26mr5507277otk.74.1619453975180;
        Mon, 26 Apr 2021 09:19:35 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x2sm73551ooe.13.2021.04.26.09.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:19:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 32/43] completion: zsh: simplify __gitcomp_direct
Date:   Mon, 26 Apr 2021 11:14:47 -0500
Message-Id: <20210426161458.49860-33-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not much different from __gitcomp_nl.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d5ec8a1417..6afcf1810b 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -89,9 +89,7 @@ __gitcomp_opts ()
 
 __gitcomp_direct ()
 {
-	emulate -L zsh
-
-	compadd -Q -S '' -- ${(f)1} && _ret=0
+	__gitcomp_nl "$1" "" "" ""
 }
 
 __gitcomp_nl ()
-- 
2.31.0

