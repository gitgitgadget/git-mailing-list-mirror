Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33784C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19AC16102A
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhFURCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhFURBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:08 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C857C0A887B
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:57 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso9113469otp.8
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIVcIx4p5b7UOoXiWVfyrYbePlxnKg1y8d2KQT2zXw4=;
        b=egukfP3Ty+TKx12/KscoqEONsdq+kyDWM1TMUfzmJsTn5L2w72REwaXc8vtnsuoFXL
         VaVttbcBEhkqpbdtQuGdh9IxjyfDPbS+eFiluQRszdNy3LsBakzvPlvGpTOgEfkyx+Ii
         798pgiKwOrALBRA5AKjgihmMoZdU/EQsaS3XEfVO3l+3KfaZIaZ8ipzF/Xe6ZlC/FRwZ
         LZtePnXliuVQBHXCeTcv+5UK002tBGIxfA9aF6q//Sxcm1qzFDKvBavfgKB+Vy2Q/brl
         4NjI5GWXy48zTeN+yW4SFqoQrJGTgP5MYtEY/9BiqV1o6YsSXGsONhVDwlC5r8LxGuKu
         LmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIVcIx4p5b7UOoXiWVfyrYbePlxnKg1y8d2KQT2zXw4=;
        b=KiuPC9/gZeMT0UmkG6s2XSOD/OBkCdPfbt2jo9DNG30R1dNI1kuiX+EdL9TanoiOOM
         iA0cH5gQlunabPBSdVDqWcsxiFMimAPAno1ZxOgnVV8OeKSWO+f5rIbf7i7VVyQY9zqY
         mMYI7kBLhd/oYesX8oBuyWAJkI5ojgc7OmBCTn3+MTPOPm5CALEg+opsxjqsj1JugEC8
         98Ni4Ze0ePSvf2pZTnSsH/HW5yqeWQzXupXPOhXNWy1aWsdaELORPSL0AAFVDEflvGzK
         PYVJHXITWVoEF2RbiW9d76dVWcNwdgbuLXa8ga5b7hVO3iFISAEBUDvMRrh7Q77mC0xA
         B42w==
X-Gm-Message-State: AOAM532NYF4YPDLlCjpmQK5DN8KOsfK7kB1Q8xwUiYIe43v7jz94oWbn
        6IZ52yvEOz5Txk3LcvH6Fti5XKSlAUBZrA==
X-Google-Smtp-Source: ABdhPJycZkmNLbnQlfWkgxzCY+gVSZHct0jd7I3kjIfXVYfeG5j5CVpAwnJ7yGpQ0fnHZf8s/4O/6w==
X-Received: by 2002:a9d:5c16:: with SMTP id o22mr22177862otk.319.1624293116752;
        Mon, 21 Jun 2021 09:31:56 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u15sm3714771ooq.24.2021.06.21.09.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 18/23] doc: add man pages workaround for asciidoctor
Date:   Mon, 21 Jun 2021 11:31:05 -0500
Message-Id: <20210621163110.1074145-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently asciidoctor doesn't convert number character references
(&#xx;) correctly for man pages.

This hack fixes the issue with minimum changes elsewhere so it's easy to
remove when fixed.

Fixes doc-diffs like:

            so line count cannot be shown) and there is no difference between
            indexed copy and the working tree version (if the working tree
            version were also different, binary would have been shown in place
-           of nothing). The other file, git-add--interactive.perl, has 403
-           lines added and 35 lines deleted if you commit what is in the
-           index, but working tree file has further modifications (one
+           of nothing). The other file, git-add&#x2d;&#x2d;interactive.perl,
+           has 403 lines added and 35 lines deleted if you commit what is in
+           the index, but working tree file has further modifications (one
            addition and one deletion).

https://github.com/asciidoctor/asciidoctor/issues/4059

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 6c4153f628..954acb3e7d 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -4,6 +4,12 @@ Asciidoctor::Extensions.register :git do
 
   doc = document
 
+  # Override attributes for man pages.
+  # https://github.com/asciidoctor/asciidoctor/issues/4059
+  if doc.backend == 'manpage'
+    doc.attributes.merge!({ 'litdd' => '\--', 'plus' => '+' })
+  end
+
   inline_macro :linkgit do
     if doc.doctype == 'book'
       format = '<ulink url="%1$s.html">%1$s(%2$s)</ulink>'
-- 
2.32.0

