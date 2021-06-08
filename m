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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A06C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903306124B
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFHJC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFHJC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:02:56 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8654FC061787
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 02:00:51 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id h9so20883348oih.4
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CL6MtsaVIn8Y0nCHQe+rTnd4ME8ALZMwqbKEtbIDr4U=;
        b=eODs2nv1xa4yC5n+eP3TDwTREQH7qTQbs7vqZEvGs2Vpk7KRM1phDbu6FtKMb5DcPg
         kXAXDdf6VulWSl5r/IgasYfDx/v7VaZPpOaHoG2bUEuxUtA1jOLot3X4W5Dygk+3NLhd
         GM/6xbQcKTLQ9Rv/drq05l+Q7FPqoctySqwG/gVB6/L4kH87wOY3ru/+Jg5uQdd6+V+N
         dL3D9KAUIVrocD/39cYkhKFgMQSqn+nr4Td+WU94UfJj0Asmo5EmdOJTU5kW/DpqQBro
         Vh4ywPJO81tCAU7UU8awtah20qx3IDvwyubWPp2FLzE6/ZiwxT2rZAP22R2Z9/G+qMVD
         C4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CL6MtsaVIn8Y0nCHQe+rTnd4ME8ALZMwqbKEtbIDr4U=;
        b=J8Dppq5r7q4cImU/W/oxRbgbKI/vphV65El3bQJ/8MmD9iP8uWXRU4JvdN31NKv6lf
         c8dzgKwHvTwygUfnS+x1n+ym4GYtR9XKAgjja/KmmLhpr7/ROqbnaBQMOeKKg+NFh5va
         e0AmrGz0f6K2k7sn3xNyQN48HXP6k2axh5t0Vz/UBa99boi2BHk8VEZfp6QezWj4lUYm
         2eCboR2mBm3+t2xEGwwuAWtQTF1pcZzu+k8RG/lGqvrymo2KJdD+hxKYhuGlx4i2xzX+
         JI+PSWCE4NEDLtC1HXaFc5Mvt/I0BP/JxIDABON9o9usBS+OTbpS5u9X19kl868K7jyv
         vIGQ==
X-Gm-Message-State: AOAM530aSErO3j89GlAbacgwpnwjXdyKzVZ11skouhOjacs59gUYmHs8
        QUk9Wbcy4Rtbs0ck9V8XVQTqpa7OduuVTg==
X-Google-Smtp-Source: ABdhPJwBX3ei3BGjbVwaDYcVfYgRxChq2Ux0JuvyGnBkWR/+rWWLPw5Jn3xqcjHcSVmNlS9+obbjPQ==
X-Received: by 2002:aca:bd86:: with SMTP id n128mr2208810oif.75.1623142850761;
        Tue, 08 Jun 2021 02:00:50 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l24sm1851564oii.45.2021.06.08.02.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 12/12] doc: asciidoctor: specify name of our group
Date:   Tue,  8 Jun 2021 04:00:26 -0500
Message-Id: <20210608090026.1737348-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
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
2.32.0.2.g41be0a4e50

