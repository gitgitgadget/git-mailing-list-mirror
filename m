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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60DC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2AA6108E
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhFURBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhFURAz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:55 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97AAC0A3BD9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:32 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id v11-20020a9d340b0000b0290455f7b8b1dcso5388834otb.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0GcwKfwR+3znYUICCLO8MTUtX/n0J3cecmCK947QEQ=;
        b=ly4gY1SF05PsU755s1qw+5IKKB4/ZgcGObf6jtRfgV+0BOsLsL3VsmDQMeg2Te/ooS
         HT/qYqoXvsxoZ7r1MDjEJH9MJ9SBtwhx8uZIr186Yt7EhutDr+VaoGzgoiRtEUVbeCgx
         ee0X9bjdPN5uv2NDc/NztVCbzaLD47iASwOHcP77G5/LNExoclWK2vlA0PoLOX+a8ehr
         1pez9r2VM7ePZa+03pHnAcIcgC/I2zHBCZDTYwwoCwL5Hj6Z5HdTCv9JsMfoXPKeSopE
         bGRzbwWIvtiPn4kGl07cjDyXAAmCQTcPoUwsR5kNGRBHuvlDxOGZcyed1ra/qpXHZLTN
         iSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0GcwKfwR+3znYUICCLO8MTUtX/n0J3cecmCK947QEQ=;
        b=pNcjNi68exLb4cSIu6YSVK28+bgcJBvL1hRTE4Y6rkAmqhkCac6AlSs3xRfbhJxGoa
         eDOZXoC17rbAkpdjD5neZbSXw56+fq9mggzR+rJuFqgpnoXErnpWwusT49fFQKce0OKm
         O384ftF86URQgQxABa/mNepD1dZOLD6rKSELosEwMB+BlxOwqCJzB/KKkq11FqdI6Fq3
         B7bRYkGgUNA22GInOIV0q9dAhHm14/v198J/XxKQNfE0lj5eXqFr6rno/dp9stxsDEC8
         NOISvuTGcbD2l/x+FrPKs3nSYWpAIEMYEmp6VRWUbVoNez+v/vJK05zTu/zHbib5zzZU
         BreQ==
X-Gm-Message-State: AOAM533aB3/kgOHJXm9HRpuYs+IoB33MqnrAi9QLpa4QJwpHCHF/04iU
        VL1CHEtqydsEYT3Pg6WNt7cIWXcckNBKDQ==
X-Google-Smtp-Source: ABdhPJzzWzSPwQY70Xcg7NUBNFyPd81RZaKm5mPlpswRW6ngANo4DfnxkIwagRxYS3S9JyRqwhQbnQ==
X-Received: by 2002:a05:6830:1f0a:: with SMTP id u10mr21909359otg.181.1624293091977;
        Mon, 21 Jun 2021 09:31:31 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id y17sm3692647oih.54.2021.06.21.09.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/23] doc: asciidoctor: remove cruft
Date:   Mon, 21 Jun 2021 11:30:53 -0500
Message-Id: <20210621163110.1074145-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These were probably copy-pasted from other extensions. The name is
already defined (:linkgit), and we are not using the DSL mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 423450392d..3dea106d00 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -3,10 +3,6 @@ require 'asciidoctor/extensions'
 module Git
   module Documentation
     class LinkGitProcessor < Asciidoctor::Extensions::InlineMacroProcessor
-      use_dsl
-
-      named :chrome
-
       def process(parent, target, attrs)
         prefix = parent.document.attr('git-relative-html-prefix')
         if parent.document.doctype == 'book'
-- 
2.32.0

