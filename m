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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93854C4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DA56124B
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFHJCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhFHJCb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:02:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42EC061789
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 02:00:38 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id c13so15324260oib.13
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8ZnKz3xfrhMWL3GYiDOz5gzuaiMqVIYBIb2dnJ3AXw=;
        b=m6s0nim9QNnR+lSuf8U6vcF1vS4XOQaRRF7L1nlMuNkTDgqfyql4SZbSRZVx6piqea
         yqlA7+L/0V98B1OtLFlXYvNHkw4/BftZS/QafT4UIgjeBUFvjZopiQthlyK4GuZdcQTk
         QVK/5ttIZw/rsKUhv/07WRVBRip7vo3k00uSBZXuSYgaz4v8oqjYSfb/rj/CO5TGrObZ
         7FTHpvN+3etNJWmknCyzT3zHYnukioh2752QHmNVNMYeEyuhpjdM1aDbuQXDdnFVgHtC
         tRw31GG1i+LA6mZaBThT9LnJ7Yy/KDCfDgJWJURlXleHIkfKlMvUhJO1EqYGyxSnEilZ
         /Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8ZnKz3xfrhMWL3GYiDOz5gzuaiMqVIYBIb2dnJ3AXw=;
        b=bH6Avp9783fUl8AAJl0bYNHFVP8WkP2ws3TesR5znRdttzWY3ZBCXKLZZRGGuH6yDZ
         cSvitR2YvtTOgH9OdSOie0obaZnCbZbF+Bgb91+LBZ/7QqnD6Nwc98Gn4/On9AC4v1tN
         K4H7670keK7nujh98qrLFmw0PRSUpOppHbYNoLV894ef/UsBIWlOTdb/71Z6SPmV31x3
         ov2knP/4yy8zGTy99LImxy1P6a6SwZEh2tnDcZFgaqEi0D7OKHnM3WeqP5XLQ4p1TnkE
         eWGlfdABSy2BbSIdhT6/ayMo6kHOEAwrmioE+C+thkxBTs2sv9Wa61LJInB0kbWJspSv
         nEgw==
X-Gm-Message-State: AOAM5329kBu7/5KWnwDSMgHHiMwR+LoWsOv7w96nAYO0Kyo/tNxcHiM8
        nl/lkfJGumlLzs+213mJbEBjU8s2p8XL/Q==
X-Google-Smtp-Source: ABdhPJxYSS6N7Df8CVRLxsxr5JvqU2yJXjBeBGqTXdDojUCaw38VIT/mT0gUM8usGXAPNuJYRZ1otA==
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr2056937oid.34.1623142838155;
        Tue, 08 Jun 2021 02:00:38 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 22sm197076otv.8.2021.06.08.02.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 05/12] doc: asciidoctor: remove unnecessary require
Date:   Tue,  8 Jun 2021 04:00:19 -0500
Message-Id: <20210608090026.1737348-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
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
2.32.0.2.g41be0a4e50

