Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDB2C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF04D6144C
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhENMQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhENMQB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:16:01 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AEBC06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:49 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso26264519otn.3
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mz1z7gqRyw2uDM7CnONNHPFangOX77UJaxmd1U+ADVc=;
        b=rV50yHqTa8+FUfL70DX62UvMkOvYbIFiv4h/Mo7ixM5BMXghIbAktCmIVA5+s4hmuQ
         iixLi73eXyV85NWL1FekX13aUz3tS6NAsnK/hGK3fc3cO5K2n1dk4aVhP8ZpqfiJ1VwB
         bdChuLe8pQ4kFzwDIwx+Xk2nyGWNAXAvhkjFhpQ47+HNR6Ppw4ixDNZ9EH+9ETAGC+95
         NK/H4WyL2a+XOhZsoNHNVinrf3/RdrKhLM9rlibHN9pyzLCmaeB2Ya+O3ghPDiZl5JWO
         V/hMbmRvh17xqcGlbU+kK0sghmdBpPgjV3O9s5Pa9YerTRKIdmchBtDyL2BUP7OulE9U
         +yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mz1z7gqRyw2uDM7CnONNHPFangOX77UJaxmd1U+ADVc=;
        b=Y9KU2lF70OB26/sxOarU7MT5j8aAf0no6TElEL6P4THEIPjXAVBZak/mIq1jpmPq5s
         GpfyHN+dSW1Ad+CCacEIPNefG/OI5LQ3ps6g6aqnxRYCdZZPmkjevYtFIqtjiwo9n4Wm
         KuJVmZhHCHTaOVQSrxk0yPzaLgF14xw26MAPjZXm4sf22PhVquVBrfNEuoK/RLTKzu2x
         gmXie63BGbRrxPflYwL2xyx2IjEZDW2u75oZw9Euun3g8s/WvJXqtUiBdQ0pKCV2j+dO
         4Jv9ooN5jqN15wsKs6UxSTZSpbGeFpAtM+4NukVZRMjkSXfUW+AHf6JECIBt0nRdYhL7
         0NSw==
X-Gm-Message-State: AOAM530vgUB69zhlq9OgChJ3w50A1uY4qNRCIR86XmjInteYgzuykBYh
        58R6JCjKoOWYi9MJM/w+V88zzrFpZ/oLKw==
X-Google-Smtp-Source: ABdhPJxqAV4fxP0cjUzuvNvLAMWGtwP5l9Ew7uzKNFpFF5qNcA1RkThc2ibysxiyz09NIb+tUxIupQ==
X-Received: by 2002:a9d:30c3:: with SMTP id r3mr39392037otg.292.1620994488297;
        Fri, 14 May 2021 05:14:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x18sm1137418oix.28.2021.05.14.05.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/11] doc: add man pages workaround for asciidoctor
Date:   Fri, 14 May 2021 07:14:31 -0500
Message-Id: <20210514121435.504423-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
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
 Documentation/asciidoctor-extensions.rb | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index ad68f7b0bb..11937c2c1d 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -45,6 +45,17 @@ module Git
 end
 
 Asciidoctor::Extensions.register do
+  # Override attributes for man pages.
+  # https://github.com/asciidoctor/asciidoctor/issues/4059
+  tree_processor do
+    process do |document|
+      if document.backend == 'manpage'
+        document.attributes.merge!({ 'litdd' => '\--', 'plus' => '+' })
+      end
+      document
+    end
+  end
+
   inline_macro Git::Documentation::LinkGitProcessor, :linkgit
   postprocessor Git::Documentation::DocumentPostProcessor
 end
-- 
2.31.1

