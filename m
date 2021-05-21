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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E90C4707E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04AFA613D8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhEUWik (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhEUWih (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:37 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A62AC0613ED
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c196so12908991oib.9
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vv31O72HlaW7pfx8KxRQpSn0tEZuIxic3nwHjKUSexU=;
        b=mca5goIQ6zTOYAHvBsF9X2FkKAhVFOkSKp90RphqFHJGqFolFhiIxuSP/SfuzobwkH
         ewptOzjGd+GPjqa9mmBfE19OC1YX6esLu0okNkrAvqWdJrMPtjV7lyXnfgZbugT/dW92
         UhAH58gNV8GAyPVDNKWbLw07CzOaXPSfVy9qJYg66ny+RsWVb1MYLHPcnLlRUUu1vcF8
         MNWmccZJvI0QilhQlC90cZK8vryrmN217iUcnkBw1qr2+ZqaBk/Mv51aDhb47aRwbvsi
         RG/Zsj2nVe91p6EaVNL9rHwrXawEbuc0z9jhLRbXn1mi7vEB01YOzJiEaHp6uG2B9n8t
         RXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vv31O72HlaW7pfx8KxRQpSn0tEZuIxic3nwHjKUSexU=;
        b=M2tqSPxgM4VmAEa3PO6tfz9dIZaSZvK6hlAXlhwdnl/fOsGKrX+wDmilethlM+PczR
         lrLszsuSI/u76/zSIXLAYh4AyWDa6TWc4Y8lBhw7nWH8Gy3/ebxHD1PaT9qtvQuiNgWt
         /m8sY1iw+eQiemIgfFhc5S7LPtZijkYfXRfBvLLbUmmrnW2/NE/fW+9TVT5QV8JdvXmw
         Kc2X2vlS0BKE+l+dPOR0Pan2PHuI8zIkxpjYz8OUDCtlomWhJhUVascFBtwIudFri85y
         wtNKQVmOc3oxdOGR6kE/D9aPCzqz82+TDtp2f0y82mSN5tJkul+iuOILYtigF3Xgn2U2
         Jo1A==
X-Gm-Message-State: AOAM533V+znTGapOu3GFbO/XOFpjdn2Pl4mWO6LcUkxhgd/Aemq++rkK
        j91qd6Rd87k4duQBwPMwt3V2pAqQnqs7OA==
X-Google-Smtp-Source: ABdhPJzhCL9dx6fMy8PsaFyNft8DiklNRHISJKiO21fP6Ku0Tj8eOevc92icem2veQS5K+Ei3ORf8A==
X-Received: by 2002:a05:6808:138e:: with SMTP id c14mr3868436oiw.55.1621636632557;
        Fri, 21 May 2021 15:37:12 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id q14sm1263988ota.31.2021.05.21.15.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:12 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/12] doc: asciidoctor: remove cruft
Date:   Fri, 21 May 2021 17:36:55 -0500
Message-Id: <20210521223701.526547-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These were probably copy-pasted from other extensions. The name is
already defined (:linkgit), and we are not using the DSL mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 423450392d..3dea106d00 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -3,10 +3,6 @@ require 'asciidoctor/extensions'
 module Git
   module Documentation
     class LinkGitProcessor < Asciidoctor::Extensions::InlineMacroProcessor
-      use_dsl
-
-      named :chrome
-
       def process(parent, target, attrs)
         prefix = parent.document.attr('git-relative-html-prefix')
         if parent.document.doctype == 'book'
-- 
2.32.0.rc0

