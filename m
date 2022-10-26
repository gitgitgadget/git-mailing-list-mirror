Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9275C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiJZO5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiJZO5J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:57:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C533A105372
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1807710wmb.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNmBiOiXxfokbe6Hh/IWlqf/FXlb1NwIsJx6uOmQDxs=;
        b=hqSYz6Z4SgQ9lc/rv8UP5ND6xU1UmIeDgAZiEw9OObWBc12aqSkzKioUi8GsSfzXKn
         yigMZzZaofg1jSV2FCJVQFGtq2/2UxZfOA4NGW9f+7jOuj8cLQps6aBt2TfgykseRDSw
         tImVQPBfH6FmwL8ZSZOAQDamc6Cc9ZNJabtZw+lIJj0GvMxs2azkcYiooNTlbU/X55zA
         vaTwb4Ht/7/m8BKzx6L3Swu0j0EXm/HWE+SEX1XL8jfNCa1NQr3xHDVWMhh6Lhy1bkyO
         Ih6hmcaJ1/qXdoZu7ffyjXhtISc6U7VeAB5UL4NCi4m1BKHRyi72VhG2fmm3ix6WzrpC
         YqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNmBiOiXxfokbe6Hh/IWlqf/FXlb1NwIsJx6uOmQDxs=;
        b=Ulio/1HR0UjpJXZ6WmSpyTbghujkMx6m6lJ464yWIu+d6v6iW2mkgKhEzKAU0jQQeO
         e9o1fi+4L4x3miNcggLE0cHPYIRF//ae7W+nQDBh1bExOoQobj3RKr7BALp6Xntx/zxX
         1KJTP4ZxZmTqFpfzie3Qi1nesvSfORn5vJz8NzH8qAqYk48u5dA5FLV94ZhAFq++Ob7G
         xwIDTl//xmXG31X83x75ksnufqHxdO3vN1s+8MahtoxM1lpJ9ztlUBMijxVB39jn3plc
         HGu8acoaoToVmrzNa9LDQIv0sHYQkUl7AMDrCaEtSXxDluZhfkaj+oiNI9DzJsoMgZX2
         VigA==
X-Gm-Message-State: ACrzQf3QdTDEp3UCq2cEjSrIlYNQ+e2lnKzk1cEjKOU6k2e9QacvtWIO
        YQn+VIBIppxaCDFukeQrnuD1vgWru4VZtA==
X-Google-Smtp-Source: AMsMyM4SCoXrYo3cB/z1qT/jlBxpIcO1Y09k4biXM31DSl01skGfNtDBnYQ+4eABDDkIUbUAfFxJMw==
X-Received: by 2002:a05:600c:1c1f:b0:3c6:bfda:d485 with SMTP id j31-20020a05600c1c1f00b003c6bfdad485mr2670644wms.59.1666796218068;
        Wed, 26 Oct 2022 07:56:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c7084d072csm2180351wmb.28.2022.10.26.07.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:56:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/9] Makefile: document default SHA-256 backend
Date:   Wed, 26 Oct 2022 16:56:44 +0200
Message-Id: <patch-v4-6.9-1e4695d0ba0-20221026T145255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 27dc04c5450 (sha256: add an SHA-256 implementation using
libgcrypt, 2018-11-14) we've claimed to support a BLK_SHA256 flag, but
there's no such SHA-256 backend.

Instead we fall back on adding "sha256/block/sha256.o" to "LIB_OBJS"
and adding "-DSHA256_BLK" to BASIC_CFLAGS.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 870ecdb0d85..992eba9e0c8 100644
--- a/Makefile
+++ b/Makefile
@@ -513,7 +513,15 @@ include shared.mak
 #
 # === SHA-256 backend ===
 #
-# Define BLK_SHA256 to use the built-in SHA-256 routines.
+# ==== Default SHA-256 backend ====
+#
+# If no *_SHA256 backend is picked we'll fall fall back on using the
+# default.
+#
+# The default SHA-256 backend is shipped with Git. No flag is required
+# to enable it. To select it don't define any other *_SHA256 flag.
+#
+# ==== Other SHA-256 implementations ====
 #
 # Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
 #
-- 
2.38.0.1251.g3eefdfb5e7a

