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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DD2C48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1C261042
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhFURCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhFURBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:08 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B3C0A8883
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:32:06 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t140so20576116oih.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0MaeKGO6KcV/Dh4jK74fXeO25Bvnc/hokDYaumYAclA=;
        b=AGczBQUOGT0D008RinP94E/NvtbDkhsVZZz+ZGCbtMD7PkwT0QPcRmBA6lDdwb2hWr
         bhmOiOAV7UXVFqQBrVZGFFoRrnqG8imL1dOZt+gjpU2ZUQ4oP8kC8M6AKiHNDMZsq5Es
         E4cFPAuRB8YK/zdSZ2PS2TgtrovyN37Fp3m6P5j93LjHudQm1QO07x3whoWP9DdXdCQC
         Oyy7PA/tFxoKtHh4l736I4WRs517dlyHrm4Or+XhNJjO6ElhaOGlJuxd/Bf4rykGYdwT
         jp/y2i3EER3JImrNgNQecXELEtuxj1burXuqc+kCQ7yfYoIhd4GGuQnfL2ab3X7OPr/7
         1UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MaeKGO6KcV/Dh4jK74fXeO25Bvnc/hokDYaumYAclA=;
        b=tJFbPDpfcSmRj9PNRJMBAM6RMRNKtWvlytuX6IQE1ae6XmMs4WBit7eCicc+q7nxw2
         WIXKltL/+PQ74CkV+ncR8zKy+fyJ1WWKwEMIhaWxilPSQCHFTFQWMJiznpqGTUCiucy9
         kIxC8ZXsku/sqzOEa8f9MXJpvWijNBNOsYpOTkNEqNUEtdIXblEX62Ffpg5K3VXwJLhV
         7s22aYNHyDYcYCCH0AK5FZnsQ64q53b0eezwSSpYxRa13vqQBaZNUKuXDm/v16wcNvUc
         +DOzl+8+fEN6znHNU7KmScxs9G2QL2J4vFRudp7fmHS6AtvZXgqPcVbYlZ7to4u6reLL
         tuuw==
X-Gm-Message-State: AOAM532GyUYxn2LKJQoAPIdL0ouoSNjFzjmJRaJWQOvNJaRXrQ/PyI4J
        0rARDZscnFCCAtlssuIdHdtM8zoUxk/CHQ==
X-Google-Smtp-Source: ABdhPJypnWIE5a14lJiYlDWhVtVc4VL2iSsK0wJATo86Cbwn7aKaYUIznPKIOSWb+IUABVZjKsGpLg==
X-Received: by 2002:aca:fd44:: with SMTP id b65mr25209686oii.175.1624293125332;
        Mon, 21 Jun 2021 09:32:05 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n7sm3629480oom.37.2021.06.21.09.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:32:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 23/23] doc: asciidoctor: add hack for old versions
Date:   Mon, 21 Jun 2021 11:31:10 -0500
Message-Id: <20210621163110.1074145-24-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

\\ gets converted erroneously.

[1] https://github.com/asciidoctor/asciidoctor/issues/3456

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index e48a381b8f..3ab669dad8 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -38,10 +38,19 @@ Asciidoctor::Extensions.register :git do
 
   doc = document
 
-  # Override attributes for man pages.
-  # https://github.com/asciidoctor/asciidoctor/issues/4059
   if doc.backend == 'manpage'
+    # Override attributes for man pages.
+    # https://github.com/asciidoctor/asciidoctor/issues/4059
     doc.attributes.merge!({ 'litdd' => '\--', 'plus' => '+' })
+
+    # Fix bug with \\
+    if Asciidoctor::VERSION < '2.0.11'
+      postprocessor do
+        process do |_, output|
+          output.gsub("\\(rs\\\\", "\\(rs\\(rs\\")
+        end
+      end
+    end
   end
 
   inline_macro :linkgit do
-- 
2.32.0

