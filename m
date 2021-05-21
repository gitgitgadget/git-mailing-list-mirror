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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590F3C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367CD6128A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhEUWii (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEUWie (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14706C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:10 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so19425451otp.11
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/P3GbnSpAi4jwHpDCRO08gI9/rsuAByW+B+eYDPeMY=;
        b=tcamo9MO/ceVbr4CtrTcY177a0pzRSFylkjvhLgiQy6EMV2CgH26WAlkmccwISeKAU
         JuiuXzib1o+0GPtrzwJyWfRmt48m9Fh7vakcKUomRsjjX+3GGXoDFlg/92WJVpnxbsgq
         0oP4PPz31hO1dn3rWSMViwDGBt/qatTGmehrepSURMTM69kGBICUEMnWH96VqFvqUjMF
         qhfKelGWGI5eVbm5KmE/LA0ssELPNB3UR+XYr/YK8mGyMrMaWjqLA1/nAbbfNImkZq1F
         SXrMORZIAm47gAj9tHrteb2ijpW8v0FXAcuck3AXzejxQ5QulfTBg6yOocsu6aV0itVF
         rk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/P3GbnSpAi4jwHpDCRO08gI9/rsuAByW+B+eYDPeMY=;
        b=g8tndmIfC3GwvxstIPdmtWubXrVg1OtrqqXWTBWhIypnXuP+1p/yD72EGZcKhjPRWG
         frCGe0sYbW795cshKhs7qoBHRsl+ZrIOp7VZ0TYd1JIcHzVr+D2OviREOMb85m5eCB6d
         9i03hY4wYa8agZAWEvrB3oEho8wj9R+0DaOmJi0xdzeTpbv+FVa0z0u+wPYJsTjAjdH3
         7aIqzqWwR6V2RbzhLqay6Oom1YrafPj9THYQpq2AzBtyOkZfaWLdTev5wv+QCCGl+CuG
         8m3V3dghL7ryePgk41bofYXZ2LmjNyUdPewjhQLttPI2zDlmWETX4Atky8w2LNmLMWdD
         82tg==
X-Gm-Message-State: AOAM530hf0x7nDmrTlyZuUANk30sXno7+GDPdssS8xqPRkCx1oOQNFtD
        2XvBnoiT/f43s+co5uo0jEId0kLsb3+iWg==
X-Google-Smtp-Source: ABdhPJxC6VmaMIGu/qLFlZZChWA/9WsI5Dg8qzUa9QLhqeN9/HT4tcaBgowRikv9Zzqt4LCyJIo3jQ==
X-Received: by 2002:a05:6830:1544:: with SMTP id l4mr10403563otp.154.1621636629213;
        Fri, 21 May 2021 15:37:09 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id w10sm1472589ott.75.2021.05.21.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/12] doc: asciidoc: remove unnecessary attribute
Date:   Fri, 21 May 2021 17:36:53 -0500
Message-Id: <20210521223701.526547-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's part of asciidoc global configuration since 2012.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoc.conf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 60f76f43ed..f7908f9dea 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -12,7 +12,6 @@
 
 [attributes]
 asterisk=&#42;
-plus=&#43;
 caret=&#94;
 startsb=&#91;
 endsb=&#93;
-- 
2.32.0.rc0

