Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6BCC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB5C6191C
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhEKWaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWaB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 18:30:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876BDC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 15:28:54 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so12592454oth.8
        for <git@vger.kernel.org>; Tue, 11 May 2021 15:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/I79IoKtnFXBiNjr1lC+ZxsHY2fEB+N43YOSvxOHF90=;
        b=pkwl8GuR9ad4qBBzgy3dv4x5UxAREyml04mPYaJ8Y2slOCdZe5hHE2CAjEwwg14zNy
         FG0AcwmJLhjHTUNUbVZIU9fGFrUrYVzjt2lOQvhlsvH0yKYBas9mFZS7R0NOv8x1S3Gl
         CbdseXa3TikdtkL1QPK0SQLhb+tzs8Xxfkne41/QEoiAJYiUcLQRjX1X0IF9pd7wzUh2
         r+XJZWk3h55gJH16YqzEBpVy7cnTWS2NzbkdOZ1GPeTIdLINof4Y7lsO8x1wO8saaUXX
         u/F7SQ5yRsgYTkhWT8fZGsTwrVgzezO9UzqN8KQVyoS9RsPVusJnBTFbOe0hVuRBhPel
         kLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/I79IoKtnFXBiNjr1lC+ZxsHY2fEB+N43YOSvxOHF90=;
        b=qo6t4i0eohn8baNWBZzexC5yNzAKT/YZFtvY3JbyjevvwxPMtKG3EdHkDsmN2ue8Ri
         VqZOuWCqrbdigCf2It3/ibZYsZuhRTyzLa6+oDxsJXak/T/M8H8BXcrk3b2yKslJpXsa
         IYRTohu1JmxAys2Krr22uJeVseFq1T9/uJTm73jfeWLGYlvc8D+AkKryAJgnieaAHioe
         NeyWC77sdzWyFXWeQQXjEfLw8s+YXL9iRZlwWmLG0CLACLIQaGCkuzu/kdrhu3JaPsaD
         Gw1646IoHPQvzYA1yYKRnDE2G1wCGUcgFsYsxExW4wKEODR1DVZmEs0K5k4KBaH7HOvj
         G1Dw==
X-Gm-Message-State: AOAM531Eu4JqbRxig3TZ0uDc3TjX+etsLPI9YZdJ7cW4o2p6WWlsfAWp
        93uYE4K3ZtVYgYp3bm9CmBNeXs0PSQaQqQ==
X-Google-Smtp-Source: ABdhPJwzFgJyQpFqkDaLlXe4tEwyp/zAnZkaHRl0f3jOkYnMP9nI4t6mZ9gC6JqNNbh5eXnFdbvPig==
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr1994825oth.306.1620772133539;
        Tue, 11 May 2021 15:28:53 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id q1sm4187392otc.21.2021.05.11.15.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 15:28:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] doc: use asciidoctor to build man pages directly
Date:   Tue, 11 May 2021 17:27:54 -0500
Message-Id: <20210511222754.417371-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to use xmlto to build the man pages when modern
asciidoctor can do it by itself.

This new mode will be active only when USE_ASCIIDOCTOR is set.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2aae4c9cbb..0cfa88a92b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -196,6 +196,7 @@ ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
+TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
 endif
 
 SHELL_PATH ?= $(SHELL)
@@ -367,9 +368,16 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-AS
 manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
+ifdef TXT_TO_MAN
+%.1 %.5 %.7 : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
+	$(TXT_TO_MAN) -o $@+ $< && \
+	mv $@+ $@
+else
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+endif
 
 %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-- 
2.31.1

