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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1878EC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0004361430
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhEYKuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhEYKty (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:54 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C486CC06138B
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:22 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso6282991otl.13
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pswKRjqSmEQtoeNs6BztCFLOKuD6NGg7hYBvW2ja2Uc=;
        b=kqs8i7EMmMJH70sAXhEGsjy3wgMaxSyv1ONIiVBCJobWUXfzPbP4VI8gF3FNHGDBLz
         XXC+DtaAcxfggVewTrPw+MzYgBFqBbwBo436RaOR0lbpgHWI8PVfKUtl6euuwAx9ln8l
         x8owwQRm+3w+I/IEx2/txB7aKJcYXZ17zX+mwictqEGSmyZqh2fUJw8Hx33tsl1lUMFZ
         2hZnvjGXfVBuyk0pzWtxxz6WD4ZeHqP1dW85BujYskjp6hwNgHwujTIw+EcrbVePMmom
         bG1blZsR73k7BH9a/pvTp8MDyOqCnxXbgSTSlxZLqIYxrcn/IX7W1FEFMtSrIJvjEEpZ
         rcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pswKRjqSmEQtoeNs6BztCFLOKuD6NGg7hYBvW2ja2Uc=;
        b=kCus1t3w0A9I0akCvkBpM0YxfHD6aMGoL2WvrqnHodIYpf+vvEiItFff1Lm8Vjrhx4
         FpHzewOlQrrfBgTKAmtyVzfR83A3IbpzOJxZG2BmXcj3bPDUwEp+iuP3k287QzMJK0gd
         ufknSCQgi/KHAxEubF47vzmKESrztBQxzHS7W70XzmVCChHm1kBKe/yNm9ce+4ULIngq
         ma8cWsQGD7SmEdhBHt098O3vgTp/z1pSdW/0a9dcIb356pxvGhnLJYMq0X/0kpCbwiZb
         ZZ17Hl7Z2jma8ofbjx6KAOTceErRGzFL0w3Qr7jyBazd/E9Od0yx45EmdRX2SF/ECDvk
         zfrA==
X-Gm-Message-State: AOAM530V/B15zWei5HpcwHqUFxtqRtKS2DrqpjB+oPm/Ai4POqPVFdAq
        IMeMx+D2Xx5r5XeDO49l1XAz+j8IfSit4g==
X-Google-Smtp-Source: ABdhPJzCO2V72GfekOLwduBdtUJn/WoG6V2q6ObyZfaNZcibI6Vby7J9BSozK1Fco9+C8snZEAiG0A==
X-Received: by 2002:a05:6830:140c:: with SMTP id v12mr22384530otp.310.1621939701997;
        Tue, 25 May 2021 03:48:21 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x5sm3572646otg.76.2021.05.25.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:21 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 12/12] doc: asciidoctor: specify name of our group
Date:   Tue, 25 May 2021 05:48:02 -0500
Message-Id: <20210525104802.158336-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doesn't do anything, but otherwise we get a random name.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 51981af13c..b36317e4d2 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,6 +1,6 @@
 require 'asciidoctor/extensions'
 
-Asciidoctor::Extensions.register do
+Asciidoctor::Extensions.register :git do
 
   doc = document
 
-- 
2.32.0.rc0

