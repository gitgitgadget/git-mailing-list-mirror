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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B10DC4707F
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B70613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhEUWqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhEUWqh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2349BC061342
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:13 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s19so21104064oic.7
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+PF8VNqX3CxWZcWikvCpbjoN5l4qx72eHU1ZnJexGhI=;
        b=N3mB5LMfXIOHmeqeD3mBtsmH1dfB4VECYix3mImt1uvm+jo2ieIcoP9cjMtiSQMSI+
         VKWskP3l5awX4fypURqSf858HHtTNtdlXeG4b5uL5ZRXvBS7gLnQMBqUTnbBSGdSCO0j
         Swr3/L1swXASpxvyRJVqx1peVZ7stZhRenR+J7x8hyUMSqXKdc3RonXVAwmFlXR3D3RN
         7kLMZ1z24Cv8VHc4lQRyFzHylNO0aVZ3l8Of/EAlIASn1WOPf4OQ+Ybiav9zz0TAKaH5
         UR+KE5WNmG8Oc7pTx+6rpn5to7T1ZnaVGBtNk8gXoD7LP4XGbuVVKMVXeEOTpmwpdobX
         rkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+PF8VNqX3CxWZcWikvCpbjoN5l4qx72eHU1ZnJexGhI=;
        b=Cj0YPCxBBA+0hBF14C2peS6dRgsOUQL/GfoIelARuDX66P0Hpditve+uFeonOcYUWr
         FY6Q5gJV91ICdg/djgxpCyctA89CDimhTWVqQ9esYpEYrqdiXMUjKy3TDYaiok4wk9SK
         /mq5vWRGEpcNFFGfmltPe7S8PjttOrZOm3quzkFnuhLLSZP83DfGxOn8IHezFHIqByNd
         o4ffSp78UKS5+PA2KX/fPz9sKV7uA4WsNfhY4SWZFxPjxytUutIJ9IYrCcfjUDLQvM9i
         qGbJzK4oun+Mvt5EY0KNoFWvFEvwb3mQ45+7u8PP1Gqv+jOSogZFL+Az5czf0d+tKEgd
         t96w==
X-Gm-Message-State: AOAM531WnKUjdbuR6+GParVc0Zat8CtFflsOW8ctC0Fe1qQfbjrcMNVR
        sMvMWz6saSFvE7bd5nfUwDNeBuqF/cPMUg==
X-Google-Smtp-Source: ABdhPJzwlUJMuwUxuwq9cOQtvjy8Ta7inUL0neyx4TO+6H6trf1CYDAk3raNH4NZ8MqXeErKzElVxQ==
X-Received: by 2002:aca:f207:: with SMTP id q7mr3830068oih.24.1621637112310;
        Fri, 21 May 2021 15:45:12 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id s76sm1366847oie.50.2021.05.21.15.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:45:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/11] doc: asciidoctor: cleanup man page hack
Date:   Fri, 21 May 2021 17:44:51 -0500
Message-Id: <20210521224452.530852-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's basically nothing we need from the original
orig_convert_inline_anchor(), so let's remove calls to it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 8856f2febd..e48a381b8f 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -3,7 +3,6 @@ require 'asciidoctor/converter/manpage'
 
 module Asciidoctor
   class Converter::ManPageConverter
-    alias orig_convert_inline_anchor convert_inline_anchor
     def convert_inline_anchor(node)
       case node.type
       when :xref
@@ -25,8 +24,10 @@ module Asciidoctor
         end
 
         "\e\\fB%s\e\\fR[%d]" % [node.text, footnote.index]
+      when :ref, :bibref
+        ''
       else
-        orig_convert_inline_anchor(node)
+        nil
       end
     end
     alias inline_anchor convert_inline_anchor # For old versions of asciidoctor
-- 
2.32.0.rc0

