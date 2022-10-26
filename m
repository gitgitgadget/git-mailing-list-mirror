Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6F1C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiJZO5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiJZO5A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:57:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D51103255
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so1776152wmq.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ipflk+X6Ery3onA+/410yNIkgz5nSEwQIf2FtpFcgc=;
        b=ctPGUWR0OG7rBsKQBLnDVk4UvB8gTVkHOsEke2kkWIP9vU8QWvw8oqvv72T+o8/xjG
         Yq+9B+AomYDNoVXDq8K6DlFtasLm1MW0ZcRbxgaIpaumwB4zX2j3pus5CEKkLn7f8kjF
         UkRRyHthT2z/BB7Q60x+nd9TxdYOW3yKGKnA8CbYoRKdvdzBi2RLL6mWeu4ezAXdD+SJ
         x0gqS5x0CFJeC0op/1zxnS7VWFHCsJOavxQqZIKPaXLJKhHQ9jYiJoMvgAvam/Xqb3Gj
         h1b5PU1RvmkAJt2c1/j7hp/TVitLQtiQVa4nYOj/NpTUZO403b58DbnkU9pfJIQ9sZvn
         56VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ipflk+X6Ery3onA+/410yNIkgz5nSEwQIf2FtpFcgc=;
        b=vHVBvAreA34IqLXN6+wox/+v949iqjSMDV0CG8tQOfpsOUxVoqhVagrIUekyXoOQEm
         2SFuvTbNk8v8WO8yI1M6IylSbdMglxm7tMZdXUXPKWuyZWhM7fh8A+ZjrsY77LgaeK3H
         tlumkxG4zQKPDP1g+088rrfHPTwBR7arKJfFinmV8tnPLzWPPlzlS6QkkS+HcMXwt2uO
         74UGW0Im/9NyIsfjJxOIxnkSgaVZESDluGLsd+ke/ikQ/57a1n0kQ+hfG+xgm92CpE15
         uVMkr77ybwK4uBhbeIX+ouRMebEoARobPvMhJifvX0hAYcb+Lqf9MbYdxX36PHGQdvDQ
         BOdw==
X-Gm-Message-State: ACrzQf1qGy9d7JtZKPnY+FS5Fxf0nVEA5s9cMXdR6HM+bmCwI4VmfvXC
        R3+TrRLE1ZJoUJ0mCH9FbvfXqAz1XynI4Q==
X-Google-Smtp-Source: AMsMyM5H9A11TGDbVwIB2ctpU4gM0P3kilvWl5mq9ho//rxiZVYzmoTGDQ1zuYUw8Ne3aEPB1ARCbg==
X-Received: by 2002:a1c:f20b:0:b0:3cf:4eca:900c with SMTP id s11-20020a1cf20b000000b003cf4eca900cmr700297wmc.102.1666796216634;
        Wed, 26 Oct 2022 07:56:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c7084d072csm2180351wmb.28.2022.10.26.07.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:56:55 -0700 (PDT)
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
Subject: [PATCH v4 5/9] Makefile: rephrase the discussion of *_SHA1 knobs
Date:   Wed, 26 Oct 2022 16:56:43 +0200
Message-Id: <patch-v4-5.9-b956d1c2640-20221026T145255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit the discussion of the *_SHA1 knobs was left
as-is to benefit from a smaller diff, but since we're changing these
let's use the same phrasing we use for most other knobs. E.g. "define
X", not "define X environment variable", and get rid of the "when
running make to link with" entirely.

Furthermore the discussion of DC_SHA1* options is now under a "Options
for the sha1collisiondetection implementation" heading, so we don't
need to clarify that these options go along with DC_SHA1=Y, so let's
rephrase them accordingly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index a983a57fb51..870ecdb0d85 100644
--- a/Makefile
+++ b/Makefile
@@ -492,12 +492,12 @@ include shared.mak
 # Define DC_SHA1 to enable the collision-detecting sha1
 # algorithm. This is slower, but may detect attempted collision attacks.
 #
-# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
+# Define DC_SHA1_EXTERNAL if you want to build / link
 # git with the external SHA1 collision-detect library.
 # Without this option, i.e. the default behavior is to build git with its
 # own built-in code (or submodule).
 #
-# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
+# Define DC_SHA1_SUBMODULE to use the
 # sha1collisiondetection shipped as a submodule instead of the
 # non-submodule copy in sha1dc/. This is an experimental option used
 # by the git project to migrate to using sha1collisiondetection as a
@@ -505,11 +505,11 @@ include shared.mak
 #
 # ==== Other SHA-1 implementations ====
 #
-# Define BLK_SHA1 environment variable to make use of the bundled
-# optimized C SHA1 routine.
+# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
+# with git (in the block-sha1/ directory).
 #
-# Define OPENSSL_SHA1 environment variable when running make to link
-# with the SHA1 routine from openssl library.
+# Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
+# library.
 #
 # === SHA-256 backend ===
 #
-- 
2.38.0.1251.g3eefdfb5e7a

