Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA8EC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiKGVYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiKGVX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:29 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F9C55AE
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id 13so33694421ejn.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE2SXbQNnSpsldc1vO15iKfQ0m7JfVbCB9aIamTJdE4=;
        b=U+nbAhHF42Gs9bBwtbRkhwoIWYGRHyEpVbvY3TF8tz6u59cJfA4mpop0ZXU+mxvBwt
         3njAEb7yGSQOp1qEO8BDdya4KtFJXBurTfXqMIFbHmMIJXby0PTku06bxDBgbBWgbpwc
         092LGibi6XrvqMHvlPb0F7Gj3CAp2FuxR3QOkAgD17pYPdPWlFh2354J1YKrJOKZoe5W
         eiEE1zHjJ/vmApg0q2cBtMU8OQnOrK2eYXGCoxxT8zCuSSMA7RsLc6vf9c/jFHfvVfLA
         HmAqgxf4SOUAYL99TI0Q/Bo2CbO91bZC29IqskLhRM1YZFdeQRAnjPaV3AwBHiPlIo9g
         AqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE2SXbQNnSpsldc1vO15iKfQ0m7JfVbCB9aIamTJdE4=;
        b=0FqQ+YJIGDSs7rMywKK3K1tJaMKm4nLVFqXWhCywzUrGX0AwaR9te7khhjHIT4w2h+
         X+jQq5ykogaYu5VHV7r0DzpCE+evEWfJrCRRDO1hjGkS/x0GaXa9HPGqHzAcFf+POV9M
         2RUMvAMvYYFq0fLIIFUQoRao3zjIIqpyKF9XkgF3fTb1FPFs20hXFSViHdTsg0YrfCJR
         kW5hm3NFgzMzqFXxvmR0SwITFeXCb2TmADggjxf7nXEht3/Ed51do4SHogNYBHWr0eiG
         USik+krCfndZ41OxZhoBnF+ga8aqC+CcghP01dEoyGtpRED8Tkk1bkNu6gkxDjL5t59v
         rivA==
X-Gm-Message-State: ACrzQf2gzogFGXilvVtFUi7NXyeCTfyEEzUPU9d05v5WN4jbCbAQIeVn
        KvgXfyy7miUPLL7awmWQtKJfvVBFR7BjiA==
X-Google-Smtp-Source: AMsMyM4HKoTgYhJq72Tani4JIWHPtU5IU3puyRpOHIB9zz9/IEYtJc7d8m1ung0aak3EytZ+nxjrhw==
X-Received: by 2002:a17:907:75d0:b0:7ad:8a7a:1a53 with SMTP id jl16-20020a17090775d000b007ad8a7a1a53mr49046238ejc.47.1667856205888;
        Mon, 07 Nov 2022 13:23:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:25 -0800 (PST)
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
Subject: [PATCH v5 09/10] Makefile: document default SHA-1 backend on OSX
Date:   Mon,  7 Nov 2022 22:23:11 +0100
Message-Id: <patch-v5-09.10-8d3dddf88a4-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since [1] the default SHA-1 backend on OSX has been
APPLE_COMMON_CRYPTO. Per [2] we'll skip using it on anything older
than Mac OS X 10.4 "Tiger"[3].

When "DC_SHA1" was made the default in [4] this interaction between it
and APPLE_COMMON_CRYPTO seems to have been missed in. Ever since
DC_SHA1 was "made the default" we've still used Apple's CommonCrypto
instead of sha1collisiondetection on modern versions of Darwin and
OSX.

1. 61067954ce1 (cache.h: eliminate SHA-1 deprecation warnings on Mac
   OS X, 2013-05-19)
2. 9c7a0beee09 (config.mak.uname: set NO_APPLE_COMMON_CRYPTO on older
   systems, 2014-08-15)
3. We could probably drop "NO_APPLE_COMMON_CRYPTO", as nobody's likely
   to care about such on old version of OSX anymore. But let's leave that
   for now.
4. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 0c79546712f..7d0fa7adb61 100644
--- a/Makefile
+++ b/Makefile
@@ -500,6 +500,11 @@ include shared.mak
 # Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
 # with git (in the block-sha1/ directory).
 #
+# Define NO_APPLE_COMMON_CRYPTO on OSX to opt-out of using the
+# "APPLE_COMMON_CRYPTO" backend for SHA-1, which is currently the
+# default on that OS. On macOS 01.4 (Tiger) or older,
+# NO_APPLE_COMMON_CRYPTO is defined by default.
+#
 # If don't enable any of the *_SHA1 settings in this section, Git will
 # default to its built-in sha1collisiondetection library, which is a
 # collision-detecting sha1 This is slower, but may detect attempted
-- 
2.38.0.1464.gea6794aacbc

