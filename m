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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ABAC4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DDB61263
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFHJCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhFHJCp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:02:45 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47387C06178B
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 02:00:41 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so6031115otk.5
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HiXRJzWoSCCsCEp32rzDC0Al1zgvKH07HmijAfP2EQ=;
        b=Mi6h33Ik4sqH112q3SjZgFMseL9BN+yqiAR5LOOVq9Kf5HHZcc+wVUK3k8PCOFkauV
         P9oMpiWxGYx7XmhDm5S8w3Xlu0KcN6mdQ3x2cTMneOvXJIjewsa20qw3mKk8GDNWTGrl
         2sj0zj/FiSiq55tFCH1r8om8vmgmlLgUfBNcDgvF3vD1BMDbT2nY+b8JqZEpD+X7DGop
         ADg8c7DA/Nf5NIExAyoGNmWsRDkvwrT/YTPlv0wxlRROpporhPmwMtnQ7X3kQ1ew8abG
         IK+q/yuHmQYFZuJL4NXcCf23UapDxV7mfmyzuUjGOleuvC/wjNcGxxdM3iPzd6mWb6/K
         kNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HiXRJzWoSCCsCEp32rzDC0Al1zgvKH07HmijAfP2EQ=;
        b=ntD9trbeJp7w0m5sKb/sum/+oX0KwWtXpFUynRoR2F25Hx1C+/1my9IbQBEy3YBaca
         a8fd3vtHiRSr+qMk1L705gKXn2E9TIsVAOLJO4uuogAB/7YRvJJU93ijDKTtLiPnKAeo
         nH3Dr96E/kJnuub8Ui8oLii2c/uRfSIqeJQlJqfpI0FlKg3fT8G95WIYKF4i+xdJSJ2f
         O+Fwjfcu1uroycZu8h7/Pd/y5dNf6tQBUgpvfIM8Ixlw31Bf/ERIIjqz5aXyCWzaBpRZ
         R3nlGbuhhI1lZPmv/HbCLpZTvVoM/tcFlTFzZJ3GimyP7yADnwV9MFAPYWV+378X+WbF
         ys+w==
X-Gm-Message-State: AOAM531zqYFperpz4pqDQRtmkbgWRnjtp7i3H33oOgXIe2SbumpUnr+W
        WU5bmi1NsORQOBIiCy2Ue+waIoB3adv18Q==
X-Google-Smtp-Source: ABdhPJxs2Xf1+I1uF5W+Udot14Cp4wyjosyJaGikpU6T1/Z4LwPQPTAA3lwr0kUA25ylD8WN9mWgmQ==
X-Received: by 2002:a9d:6453:: with SMTP id m19mr17643522otl.63.1623142840509;
        Tue, 08 Jun 2021 02:00:40 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n11sm571313otq.63.2021.06.08.02.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 06/12] doc: asciidoctor: remove cruft
Date:   Tue,  8 Jun 2021 04:00:20 -0500
Message-Id: <20210608090026.1737348-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
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
2.32.0.2.g41be0a4e50

