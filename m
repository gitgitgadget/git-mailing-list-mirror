Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF6C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 07:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDMHr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 03:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjDMHr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 03:47:56 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156329014
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 00:47:41 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id k101-20020a9d19ee000000b006a14270bc7eso4294235otk.6
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681372043; x=1683964043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHkiG6zGPDv1iDqQvjxt8W269TzqjX7Fyh5jrlc7qk4=;
        b=UD/qlJEmQxYlt3L/Gq+9Hd1tjCwCOlRFWaOKJrgTHLzMK4T4fHyZV2FLcMI+KZEe/y
         AgyEz8W099LufMk4/yZmlCYVYaSZ2cmlKDtKlsqRlTuTWEj3ICfaRzs4wTV2ZBW78PFi
         ChJDAAkvi2a7Z3FyxwCyJ9GlqdcYjzcak2Y9yHfpCWtWd2aZwnoJ50qH4JXg961koR+3
         hmZtA1pwQ87wjLnX6zbGRXa3f2QAKg5lSV+aOB9+rxO/sp1Wy3ayigu3L/oivx9d6NNi
         1L8WJnYSmIkpBlzYqdrDA5Qfh7rukZehE8G7plpI4JFR8VycQtAZm2xL2SKudDDdvRgi
         Nnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681372043; x=1683964043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHkiG6zGPDv1iDqQvjxt8W269TzqjX7Fyh5jrlc7qk4=;
        b=QJVC69Rq/Bv2rjxUiIt2+mr0Lbmv7SVm7x4FlshUirR51iWEqw207OnI9j054IenFx
         uEALulgq6Wm7oOgd/LUhnHPCmqA/eGOr/dB3xWM/y9A9mosmsQYbBFUOybvJz3UqEWty
         kXjHS6twzP5RNV5rDHAGNBurzmJv7J4QG9P5bEJJkfPozciyoW8uBTZ1KHrZo1ciwqjZ
         aIq2UDT2ONav2Y5EbP9xUrBMkzAfzclnt7Zre1rnyt6QAFsKaCyimYZx5VA1BOI5fAO/
         W4FffTK9CVr54c81+M8yJnPQD8XAQOy2QanMGX/buxm1ER79fNAoz96bO0kkMMyTH0wd
         2I8A==
X-Gm-Message-State: AAQBX9cf+Ao9ZuiELx5NpIM0l0rK4S4MMrw09GS++nF3N9rZDn6CC7ag
        5XkFCrBwklSzQ8HB95xmC7qYDbqUjoE=
X-Google-Smtp-Source: AKy350b4+N1drAhTKTxoOxOI1R9JDiWt8w+3Q1ntbBLBh+3CsToTtOWKapH8nXNJjWRnTksJG7lWbQ==
X-Received: by 2002:a05:6830:1051:b0:6a4:319a:6d7f with SMTP id b17-20020a056830105100b006a4319a6d7fmr504369otp.9.1681372043641;
        Thu, 13 Apr 2023 00:47:23 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o2-20020a9d6d02000000b006a2f4a754e8sm443065otp.60.2023.04.13.00.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 00:47:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] doc: set actual revdate for manpages
Date:   Thu, 13 Apr 2023 01:47:22 -0600
Message-Id: <20230413074722.71260-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

manpages expect the date of the last revision, if that is not found
DocBook Stylesheets go through a series of hacks to generate one with
the format `%d/%d/%Y` which is not ideal.

In addition to this format not being standard, different tools generate
dates with different formats.

There's no need for any confusion if we specify the revision date, so
let's do so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This patch requires [1] to actually work, and has a simple conflict with
[2], so it's written on top of both.

[1] https://lore.kernel.org/git/20230323221523.52472-1-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/20230408001829.11031-1-felipe.contreras@gmail.com/

 Documentation/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3133ea3182..b629176d7d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -144,13 +144,16 @@ man5dir = $(mandir)/man5
 man7dir = $(mandir)/man7
 # DESTDIR =
 
+GIT_DATE := $(shell git show --quiet --pretty='%as')
+
 ASCIIDOC = asciidoc
 ASCIIDOC_EXTRA =
 ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
-		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
+		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)' \
+		-arevdate='$(GIT_DATE)'
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
-- 
2.40.0+fc1

