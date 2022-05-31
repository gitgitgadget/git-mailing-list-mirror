Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E080C433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346648AbiEaRq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346634AbiEaRqU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:46:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB38985B2
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e25so9048221wra.11
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9V22CmzYfo7xS0b+P3ewBd73L94wegeB3nTTlElRsW8=;
        b=Aghyg3yq1yQlI26AIPfUlfuo6hxaXHgxQp7t/nYYC6rpzOBsjuY8qhVWYPZ5JmxCdt
         z6Ofcr+v13TMntMIc7HYQP5UUfvnJivSERFAzDdSqgcEOzKtG5bxLexpXio/KTvITLWD
         U7qZXJIoicEeNGkygg/2vMqgrTgmlfF02kxCvGmP2IateAFb3fnnoyfHJktaiKuzGDxO
         JxMv7g7hz1UGsY8y1q9GQIthFr6LM8L6aEHfsR/uHfS4/VWfiEvW8ZAjTwAKbsZzzeap
         a3mGBgDptjaFJM6Ebz0W8/ChTQIs9xFmA+dX1daFPrTtI3PyMZAk6DsZx3NCw2785op+
         yJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9V22CmzYfo7xS0b+P3ewBd73L94wegeB3nTTlElRsW8=;
        b=xtSrexW2mSpz/tfaL2+HL7hRL5+3CupAemDUzZbc7bIkWZJ4JTL5xPnkHY4EulLQl4
         WOtplejefAIPBq9Pi/F06eMudr1F6R0HvBltM4MlFrhD+wVnme2agXRRyKqXap24zxY+
         w+Fa6ZhC/wm2i3ZfZ0CJfOzDlunx7sW4kdWFbED9Lu13ZbV+8C8JU1yjwSWljZD2VO3u
         B/G78a7BCLMo4CoTzToGAEFFXJ0t9Zhw4sluRxx6xCBkRbCE7u674TMFaCJSoqL7Y5e/
         JnlDbdfJpJO1sdaXJDrluKRgPgGbqzpQCjLvuD/XyZb4PthmnIpe+cDZO3ullShGY0qc
         HsZg==
X-Gm-Message-State: AOAM531RkFC5sH+yqH5eY785Akglbrg1N0FyTrJx53w64L/UXs8TJAGr
        Sldxbg9FWpAVtKFsz/PP9PuJGj6NWxePaw==
X-Google-Smtp-Source: ABdhPJyo8jmQPS1agHZFHlEIfMZFYdvpq/hhmDQUZiRDsdemzV6i5LeoaURSDfalwPsW19OjduRluw==
X-Received: by 2002:adf:f44d:0:b0:210:e82:75c3 with SMTP id f13-20020adff44d000000b002100e8275c3mr20746045wrp.366.1654019177070;
        Tue, 31 May 2022 10:46:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b003973e27b789sm3826656wms.27.2022.05.31.10.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:46:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/7] gitweb/Makefile: add a $(GITWEB_ALL) variable
Date:   Tue, 31 May 2022 19:45:55 +0200
Message-Id: <patch-v2-2.7-7d920a13518-20220531T173805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.g036c05811b0
In-Reply-To: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com> <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare the targets that the "all" target depends on with a new
$(GITWEB_ALL) variable. This will help to reduce churn in subsequent
commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index abb5c9f9ab6..733b60f925e 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -54,6 +54,11 @@ ifneq ($(MAKECMDGOALS),clean)
 -include ../GIT-VERSION-FILE
 endif
 
+# What targets we'll add to 'all' for "make gitweb"
+GITWEB_ALL =
+GITWEB_ALL += gitweb.cgi
+GITWEB_ALL += static/gitweb.js
+
 ### Build rules
 
 SHELL_PATH ?= $(SHELL)
@@ -92,7 +97,7 @@ ifndef V
 endif
 endif
 
-all:: gitweb.cgi static/gitweb.js
+all:: $(GITWEB_ALL)
 
 GITWEB_PROGRAMS = gitweb.cgi
 
-- 
2.36.1.1103.g036c05811b0

