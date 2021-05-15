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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7D5C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382C561354
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhEOL60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhEOL6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5503FC061756
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:02 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id b25so2121638oic.0
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIqQBfEdH5opye+2jtHlPSoJoDotMhI4gSjXvYXRgUc=;
        b=jkZ2feUk8Qey3LXmfI6fn/knMwIgJAwMsh39J+9Ul+QlaoGVVAn1PPMNBOfo3j14H3
         Sdf7CEhiCFPbvIYmVtw1zLMx2OqlOrX2q0EwJAsivxDZrlz9WEdGKnDSrZOoL2rBWpJ5
         uzHYtE7qFWQxp3UollICW86xSiTEsyajsK+RcYQ4PiCDcLX2X4WZtDZrW79qKXM3TLly
         2aas8YxY67tWm3LlawXRfrBHnS52w+fXOQVO9i0PC5zbNauVF9b6GVAM5iqZ4M9SFDpU
         TvqWSXJce5BnwiBFINmLw1+GvI75ABPRBJoYG1mXg1CvyWCzf2oEp8m/uf8AMKX/MoLa
         fR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yIqQBfEdH5opye+2jtHlPSoJoDotMhI4gSjXvYXRgUc=;
        b=rHxSj7kvuYTIrYZLH3+L+B131Ik1rZ+A89b3Ap8xq6O8RViJyKJAyuXs4+lMeAR2C8
         KAHpFnuyuZ/L+AGgvVXaSSIcJwl5BXXhygbCPHEe0GyHr5TtcwVkEJ0VjCxZOUJfy9i7
         oX/eiKyg16xvacLqD3SUGElfSDCeReor/rzmWhyWhu6fNyiJ8zTDDnbDyIKUMruCQXcF
         BaH67h3XwpgfSIzjeezN9BVA6g25ssFc4UnmuUoz9Q2w7VEW+DhrdqZoczFLzDcaoP7Q
         byj1rIpZYsLwuEPAQixFmx3tzdHqNwiDxU7z+zNQjx8SLOIhtqqQwxynWhtdXSx1WcWe
         jIcQ==
X-Gm-Message-State: AOAM530nAsx+F2lJXeSvPWYiKRxxCAdpdTvZxQJwj8SHxqsXkA7wtWQM
        7oeq+TUvkPcU1tAvtn97ZVKiyQYNMp/22g==
X-Google-Smtp-Source: ABdhPJz+H4w7dwKgdQwT3GRxnYhztLkbfWQ76mBdRwuYH21Tb2+w9D2CI8DqSNIY2phQ9GZAeZbKxw==
X-Received: by 2002:a05:6808:345:: with SMTP id j5mr9911495oie.106.1621079821575;
        Sat, 15 May 2021 04:57:01 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id z9sm1912823oog.25.2021.05.15.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:57:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/12] doc: asciidoc: remove unnecessary attribute
Date:   Sat, 15 May 2021 06:56:45 -0500
Message-Id: <20210515115653.922902-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
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
2.31.1

