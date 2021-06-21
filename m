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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA55C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38ED56102A
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhFURCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhFURBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:08 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD427C0A8882
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:32:05 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u11so20512236oiv.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ihFlmL3GsJqqwihRykD43JdaF5Q7V1UhEAt5ulPTk0s=;
        b=tU9Nylm7jVER3L4u/E4KSZvHlNxrr6kkLMOEAeV9yGIRebT6XJGXpAA+bWZO3mI8ij
         QxOvMYA+TQ0BhlsHesZ67V5uaiNapfUefyP8MzRw37mONxvhsYapzh0FpKAPhU65/M9O
         gpFsBQ5FTn2h70KSyVMtbhV1Ey4XXAtsJ3Vsgtu6z5wuCI2TcVHH1HuO8d5DM6n5xzSJ
         p4eqtQb1Xq8VRygLOLLUoBXsPwtEaGxHo74mq6byAVRN9ED6yd49BEz1bW+dr61/pYmn
         iegR2A20ke47kUwQIOBnRA917kvWdiluynU0/aYeESG4cx/ENPo4p6HRxcVTZ2oFwCqZ
         YWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihFlmL3GsJqqwihRykD43JdaF5Q7V1UhEAt5ulPTk0s=;
        b=dDJ4UGi2PuGqfOTgRgZlB05VOikzs9QbRQO1wJvvXsvo1G/jJ/pDxYEYlVHPnTdJ/8
         HUcaSc2GzDK/qEvQndlxzBfnLgBpYZ46TLAZBXyk8hRl93cFWrz5W03u4CMPo4YurNwF
         C1GNXfF6OblHmq2TIZi4tZQvkTnYvYbnFegPSaUbu0HHWUxjC2hDboDtbHOnPQEjA7D2
         72b2Us/WK2GxalWykKOWM3ruVbuH0PcfRniWxAb7BoFJX0Bwz6mLlMQKLkYTGHeLi3ej
         3hWqGWEMCO8W1ZjHnlKANPVGHz8W+rZOhIJs7EZULXmG5v8PMgcezVIPzfKOKpBlknyc
         tjDQ==
X-Gm-Message-State: AOAM533PAkepecHyQGQ2BIfN0V+/KfOdmknhK/841bRReXcGF5TsnxGV
        3l4xmn7Hkx/Z0ZKcran3Kt+B8A+qn6WmIw==
X-Google-Smtp-Source: ABdhPJxkTxvzSevDKkH8dxQLRLBtmMFOTT7jC4UEqoFgmJhPerJogsYTgBKH5/A1FLsPi2Abgc3bLA==
X-Received: by 2002:aca:2417:: with SMTP id n23mr7795557oic.110.1624293123440;
        Mon, 21 Jun 2021 09:32:03 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p5sm3675195oip.35.2021.06.21.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:32:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 22/23] doc: asciidoctor: cleanup man page hack
Date:   Mon, 21 Jun 2021 11:31:09 -0500
Message-Id: <20210621163110.1074145-23-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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
2.32.0

