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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBC6C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF07613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhEUWij (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhEUWig (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:36 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7DFC0613CE
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:11 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y76so11839624oia.6
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUeBTCbvRvCVU56Lhu+lrJaMRNaVUL+GG3sub/sPFiY=;
        b=aIMMpm8DpvOOtv8HG8/MpypDvGuDZRmgWrCnvaKfYa9iTXKjMAReyEW9avM6WmbDqo
         NI6RDvq83RJH68M5asTn6Jlr5coLlThtdTWVTHF1fCJMJUQV74N96NPU9GSEl3+wXlwK
         Bz4uLs2X+yaQ+t93ESG9eFDEhmkdYdz+u9SneKQyn5ZKeThqEfkUvrA4+lbRDjRzgEP5
         FmowZoZJTMmF3RRNoXECS0BrkXaAnxsgHUWxIhLIuiOp3tDEst5p3TH4dNJC++Btb9tu
         +iOEGnItMOJjK+ihD+GWHDqiSVa9GHTI8U9mhxGq8wTVr+veMnj6RUTihNLAyEQRrVtA
         LJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUeBTCbvRvCVU56Lhu+lrJaMRNaVUL+GG3sub/sPFiY=;
        b=O01NgU0YFYP4PEsoLmKG808LLnhS12xz5TD3yf0qNJNYlhb3Seek06EAlzxbAdoXtD
         jYtZNGwJQ2IEIr9BoB3/YoBgr8aUW8FuZKc0/WjqpOUdNgtLZOeEWlOs2bdpDh3sH8fy
         qTy2OUXPjLVC2XAPL8IpQMsYz0aAvKCE2LjscN1/B0bgVy0U2NJqWGWXirl+xutI/g0V
         TQ/ALwWPl0Bo6ZJHDZPyS0fVsCms+r6jzzhr4+QMgtTWjmqhxR+hbS7DBoy1QBVOacSx
         IF4J569FDjOL9dN9lSo+yYE9O0imvla4NWcdX+b4Pmnnky/pGBKiGZRU9oSkXHMKXD9C
         1MoQ==
X-Gm-Message-State: AOAM530D+Vh9LquoQ+35kMejv4TL5Py/VKY++UsgFqQYfklTIfSJKEmT
        NlEqxqWTBts7/s44/NAkr9qIPKz0d5SSsQ==
X-Google-Smtp-Source: ABdhPJzf7Jx19bhFJdmMyDiDXyWfOCQ5W6gKdXPNN0CEArrWqgjAt0JA8oNUVVPx5psRik6TLwmfRA==
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr3697892oid.34.1621636631107;
        Fri, 21 May 2021 15:37:11 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v19sm1566979otq.35.2021.05.21.15.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/12] doc: asciidoctor: remove unnecessary require
Date:   Fri, 21 May 2021 17:36:54 -0500
Message-Id: <20210521223701.526547-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This file is loaded by asciidoctor, the module is already loaded.

In addition to being less redundant this fixes a problem while trying
use a development version of asciidoctor when the gem is available:

  $GEM_HOME/gems/asciidoctor-2.0.15/lib/asciidoctor.rb:51:
    warning: already initialized constant Asciidoctor::RUBY_ENGINE
  $HOME/asciidoctor/lib/asciidoctor.rb:52:
    warning: previous definition of RUBY_ENGINE was here
  ...

That's a bug in asciidoctor, but there's no need to trigger it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 70a0956663..423450392d 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,4 +1,3 @@
-require 'asciidoctor'
 require 'asciidoctor/extensions'
 
 module Git
-- 
2.32.0.rc0

