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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9BAC433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C90613BE
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhEOL6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhEOL62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:28 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3670C061761
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:14 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u144so2063611oie.6
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6N4jxMo55GMX5lrFsIFzBI3CPTu1IHcZkXoi2Fld7I=;
        b=Qk7dYMH3FTjUcdQXEgesU6ZzAzyhhxau2RAN/Ro0UKRJGniDaHPPzaHIkT63fFN+O1
         UjhhWOZmV6Zs3wgjlC4a7j5xiaQUUIctuANwfqHcSf/Pl2nsck+p+YhJUd8/SJAlxdtM
         oEx/uxtEZ8w7IMRNhFPA/zrWjnf0rPBo+jpWlqF+X1Zi/EFTHsTuLZzTAa3Mb2qw6mEu
         3ExU7l1GnD9KCaQIB+1dlCFE1rKXKdOl/J/Q7JyqKEwt4katrtXGfiw87+Xo9U9aVqWf
         CZsVHIztn4UwawcRglDld/Q4zT/0HXFrWFZgzLaJ+DEWFPf6lg8QyKhr1t4U4yJUeRc2
         9ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6N4jxMo55GMX5lrFsIFzBI3CPTu1IHcZkXoi2Fld7I=;
        b=rc1mQLcf9w5RzcpW3PQ6ad3lzS7nNR4HcB5zSHLzf0BQpYgA7CdrH2pdstRYiXUHCA
         3wICNePmHkewsOywXaSm0AZ9QzG/1/rlz7dMczEnMFIMtC31pxqq4Wuq8lX9rlov4gd+
         Si8gdEEYsJ3NFO1xJfSeStmg7orDUPX3CnhOSdW3+hVaU+xuGI/j4nKG88qmWuoWISYz
         ycVkjHE4WEbLRRnEtnsvbD3LBO9lZCNN1WVnm9Xqep/Xa6HLQERp1RDENWaYhv2mSJNb
         WGAM+WRPDC3yKNxODqY2wHITNBh4vDNdyOUInS8UBtCrUuIyFhPgNj90HCEaN0gxlqWz
         /4fw==
X-Gm-Message-State: AOAM532vDPAKeNKOMG5A7EyrwQYtfdkri8xXdwNtA4Gx1KDM1Dfyy8Mx
        IPjfi3HhYKhK13g8mjcXrw0bwrn2/Mxi0w==
X-Google-Smtp-Source: ABdhPJyL5jwo4erloEj0g6epx2ezzv1h8nrttJsWPKSyX1EKPkbj8+JEVCEUYBQYkd1zzNe43wmVWw==
X-Received: by 2002:a05:6808:214:: with SMTP id l20mr8227111oie.62.1621079834253;
        Sat, 15 May 2021 04:57:14 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id w66sm1909474ooa.37.2021.05.15.04.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:57:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/12] doc: asciidoctor: specify name of our group
Date:   Sat, 15 May 2021 06:56:53 -0500
Message-Id: <20210515115653.922902-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
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
index f7696f19f6..7d1b94a266 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,6 +1,6 @@
 require 'asciidoctor/extensions'
 
-Asciidoctor::Extensions.register do
+Asciidoctor::Extensions.register :git do
 
   doc = document
 
-- 
2.31.1

