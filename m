Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCC1C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9974E61103
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhDHPEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhDHPEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:04:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A52C061762
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:04:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so2809470edu.10
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+d6pXeEC9cH26a7N+5HnU/jqtHaZtHFehcFwlOwOd4c=;
        b=OU4PvnY3X5MI6hNM7fhrdwnvRoyVeVFbcYQRFjjr7D+YOPy3Tl8awPYTHY6cIIOgUI
         UlXb4D3fRTVh/7yaXkc1E3LWtt/rdi0KirH9NCdmFd/vfvbJAt2qFQV0lVhtu9osG6gK
         bfLzMJJN4p+w0T16T4mjEWItPxwvHhlsIp7EaPnUrz1OsV4pDit5VQ9oSPdcZV++txRp
         VEk0kv22kAc2xHaFp0WD+WUHHNWRjXhqvcjGzPmXJ8hiVMcZQic+TvtX/AeJ2J/xvZQc
         8jK0nb9N51GaOec+nk4qW5CKW64LT5iL9PtcuXW2inZm62zzDuF9gHl1u0tM2Cak223O
         Qt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+d6pXeEC9cH26a7N+5HnU/jqtHaZtHFehcFwlOwOd4c=;
        b=Kl4VexHr3sP6M6HnedYEVnwymdJZAY5W9YLDyc1p+e/t/orN7FG+zG5v/d0/WK9kAk
         oKf9hQUvak4sw7pbfTbiLK3QUQ0iWavoGrVklQu6glijSYqmT5g4LE7rd2DZ149eB0Ut
         jUuibdmlVrdI7b6MVeHfpjSa6LJ4+VZRWDNryaIH9RNGeN1s9Ym4GOYYWsfF6yioK7DY
         5zd27Atr8/Av/eivTRwLM1b/adsXqMA1Cr3afTvyUM89p04BgC93UG4YfttuIWW2iOIO
         rG+6HnbBjo0eR/f0TyENffjTZpevEAxY2w0W2/ay947mhqzBOOPVp3SlPMmCi7Iu5qWp
         EzqQ==
X-Gm-Message-State: AOAM532StOB55SQJvxpa9m5V4ASScXjjX/1VOHWddO+rQXOs4M2bbOad
        k/ifKvJQi4AHbN3qZRcZgyuKWP1N1atGKQ==
X-Google-Smtp-Source: ABdhPJzELFyzuO//r/4IZf9pOVz57h8jZJF0cqKNOU5yvI9gVi+UYmSxF/KEA8k8W73K3rTv0GRBtw==
X-Received: by 2002:a50:f0da:: with SMTP id a26mr5974450edm.342.1617894275080;
        Thu, 08 Apr 2021 08:04:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h25sm2479253ejx.105.2021.04.08.08.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:04:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/9] userdiff style: normalize pascal regex declaration
Date:   Thu,  8 Apr 2021 17:04:18 +0200
Message-Id: <patch-03.10-dff2aa0d38-20210408T145833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com> <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare the pascal pattern consistently with how we declare the
others, not having "\n" on one line by itself, but as part of the
pattern, and when there are alterations have the "|" at the start, not
end of the line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 userdiff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 33b0ce4020..978ae64155 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -175,9 +175,8 @@ PATTERNS("objc",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
 PATTERNS("pascal",
-	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface|"
-		"implementation|initialization|finalization)[ \t]*.*)$"
-	 "\n"
+	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface"
+	 "|implementation|initialization|finalization)[ \t]*.*)$\n"
 	 "^(.*=[ \t]*(class|record).*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
-- 
2.31.1.527.g9b8f7de2547

