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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D77C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806B86108E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhFURBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbhFURAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:53 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF30C0219BB
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:30 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso18297152otu.10
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZowGFosxQNTSp1HaULaF54KTmux/ZDC0aL1rWrPQr8=;
        b=gfBapzW6WBJNlAzf+iHBx9aSmRdrgtv54CJQOgxd3ypY5iHqQdTl2LIwXfQlVflwSB
         bJvh2ltxAhGNZk/Bdsx/xXA8a8FUvc4FShRHbxNgxXnMzsbHZefXvJPBYsqH17hIdON/
         DB4vwB5SCHvT3OB4w29zNpc6tveX9njWkd+Cy2dLnEQ18Jd8wkTdbXeMk67Vp23PooOt
         7ptRfBKtfwfk1tSsl2rGxSGtwTxZ1PsAkyQWEuKZvcTqtZBwMSNl/wi/jlYb7fGUs9Mt
         sXsDL5y9KlS18hTXt4fORP9eHmYCOiMXiqPfh9VbHyfAS1D1KP/f0b/oxG4nDgUZDjjT
         ytYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZowGFosxQNTSp1HaULaF54KTmux/ZDC0aL1rWrPQr8=;
        b=EvsfP7k4awtS2v/YfHKeQU5dO2wCyIQBmqzitzRHULdZQ/e+qe+jFHKo2YZA7SgYIt
         sViifIfkVC+4DP+r+OoL7gV4Nl4t8bOSOxik4YC7CL6yRswN58oLBMbhBRJQAA3qqIJ2
         e3ywIEMasxWa2bkCE1aX+HUDJyi5GPnQ/2V4jXcDLq/+lRd//CR6R7sPiAuhNaF04mId
         pw3OgGaVuYzaAOgCSVw1z5kUVotOtyLPMjp3bAiTnoFBg/NBxD3PdgKHfR2T3hNWm8/c
         zLfyajDFMvG+wUYc0LrYgfM4G57Y9z6a9slXjA7NFaiP+6z6E2Gb3KgYMB3WsQhkHN5U
         lpdQ==
X-Gm-Message-State: AOAM533nFnNSYoqhvcK/hpdVOnd/I17XTX7xHNMDsuEK+EjiNNJH7bZt
        xqAuqc1XKdL9hEwlk0nLUMgIaaAj2hssCw==
X-Google-Smtp-Source: ABdhPJzWqRG02B9OX6C3Bt1wC+SwewIA2bGzpH93cMGq3ES5ZCT75e/dn+BBO7AlLO9u9JPtC3dCFw==
X-Received: by 2002:a9d:5885:: with SMTP id x5mr8563963otg.299.1624293089283;
        Mon, 21 Jun 2021 09:31:29 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id b20sm2115384otq.41.2021.06.21.09.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/23] doc: asciidoctor: remove unnecessary require
Date:   Mon, 21 Jun 2021 11:30:52 -0500
Message-Id: <20210621163110.1074145-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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
2.32.0

