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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB7C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3846142B
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhEYKt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEYKtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:43 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42289C06138C
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:12 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so28153772otp.11
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUeBTCbvRvCVU56Lhu+lrJaMRNaVUL+GG3sub/sPFiY=;
        b=Ncm1jUqzwSr+8Vpez4LgF+kC+1c0LHrEgQU4hfwGAwOvbZ90SevHFujPxPf5xK88Gz
         MBwWK4vuIHOmaFjCvavxuKtt2MbiIZDhIzH6RStthqqxGo5fer+t8IemDOUbK9Kd+m3p
         tV+T/LX0Xxi6ivTOUEH1wqx90C7DF7ERaclJK75vDt51oJR46xwtn4FVWw9QrX64zpGn
         obSGP9o8ZCzhFdoAOq53G8JRxdbQFzQ5/pxTqULUhaBRVi5ujlcoYsd9cTo1mBIBg7Yv
         QQG6V/Cnh8PIVTV5HNKxNoSFcCc68QQcV3jMYmZqasbmWvm4nDtXNoHQOe24x49U3SzX
         n8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUeBTCbvRvCVU56Lhu+lrJaMRNaVUL+GG3sub/sPFiY=;
        b=FffwAqTVSI6hBeL78rnkcVMW1+f/ancuVtF+wFXhn3pAEukgq2G64X1qqESAlrRfrU
         TsewajYM+4yOsorB/5iH7JF2B6OzQ2Sf3R3fr7TQe5OS6n2V6FBR3oVAhMcuCulBBsoY
         Dcczt0a5aRuvrKVzR8haiM4/PRCnvwFoEiNdKfipQ1tEc8J2DUwh0poyCZ3Ixt5ilEra
         K2AVXq+m6Ip4wBPiaiqXrfLDdZ3iQ3UEk0Jy0MIYFAC7hNR8qjT3CG8NJeW5YGvigbIx
         2cgkZUWS70+0xa4LwuZZtTL+59iXZqjJXpWT6ncxIhOWAPt31EFMhk2SYSjVwTaJCVFE
         rYiw==
X-Gm-Message-State: AOAM531no184/jYEaIUzz/tC6eyvhIIpzu95BW9NTQ4Cb7i0gdD10mZ2
        D7OrojNPe0gT86DwtGgEJbvndHnh/+e+6Q==
X-Google-Smtp-Source: ABdhPJyK8U06p+gsrw+OsBYHZSbRijXxFTQyNUK7HnRMo94MNhMRj3ZPDrohxTHPuVym5ybCQ20bEw==
X-Received: by 2002:a05:6830:1184:: with SMTP id u4mr22867395otq.324.1621939691402;
        Tue, 25 May 2021 03:48:11 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u201sm3132609oia.10.2021.05.25.03.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 05/12] doc: asciidoctor: remove unnecessary require
Date:   Tue, 25 May 2021 05:47:55 -0500
Message-Id: <20210525104802.158336-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
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

