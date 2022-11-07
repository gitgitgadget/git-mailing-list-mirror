Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F215C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiKGVXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiKGVX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE7C1150
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:25 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id 13so33694199ejn.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYyPO10BDw0VnriYKZuvAFp2lTbRUcqJFJepXrDzzY8=;
        b=ZviUd+AEsfUJ8GlF8O+ylfsMSj1tUfX4uAzn2Ew7gKo/qgMGDi+kI/Bo9g97Rz6mCk
         XhkS6LbR22AbOkjWxbB7vbN4KuB1OT3OqQVZdT17Da/rpmSAmM8m2rEWCa3tJm/nRJxo
         abX9flrXn9uDrV5ZVcc7p2lBEnVNcqPE+5dnQ/fVNRdhvSaGMuwTyv7bwT0dsEY/Z1Wx
         BhX/5uqd/UzDETnnXrBRG1GvIrVLK79LHtF5gyc2oN+UsWHtxFaiXAZYlJGkRus9CZ46
         GT2zjfkTV88S92aoCoRk316EI/tDXwORLOv9aCU1durfVjinVCW88E9w0T2XQmOeh7Eg
         xbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYyPO10BDw0VnriYKZuvAFp2lTbRUcqJFJepXrDzzY8=;
        b=A8mk1sTa8ewtyMQq8lHrrUyMzSKMdD+c3mGi6eMyshwkQcnaPGSXFr2IMEfhgQwsny
         ZNkcw2HbFii4pdLTRsH5aYOrauORTYid1SHvsnhZTsIZoNXKh1ZwDXCK3rIkFDCDCYpA
         WaMpW/ld/DJemom6tXIKhrCPWrjiRQSSVD3KOp/Wb1De0fTCacksmZ+mKThJYH1OCKFT
         YpPNzCTtXv6KhACMKF2iZJ7BGPzoYIjYG72eA2RC9alBqfjwQ9Wz4K+z9GCh1/4Rf1sE
         J9ZvW+KA18Q4josGcwLUYwMUgExhtWT6+HevCS97po/6jr3XWbyxU5HWuoMLsOqW7dE7
         UVpQ==
X-Gm-Message-State: ACrzQf2lSuhRCwRtPeUNuu2TjjgbCMJ6Eciznom2buClmpnrqAcFbHJp
        VOtt/3qrQ44QtvhTVteM23bbe9hTjz4OLA==
X-Google-Smtp-Source: AMsMyM4ZjoP7V8lyG8X5npzV3TXnx6bIJHUFTs9JYZKrJApRatYnNR0hyGRIrq/8lBdxTe/LXgGpMA==
X-Received: by 2002:a17:906:bceb:b0:7ae:75e:3929 with SMTP id op11-20020a170906bceb00b007ae075e3929mr28368228ejb.400.1667856203477;
        Mon, 07 Nov 2022 13:23:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:22 -0800 (PST)
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
Subject: [PATCH v5 07/10] Makefile: document SHA-1 and SHA-256 default and selection order
Date:   Mon,  7 Nov 2022 22:23:09 +0100
Message-Id: <patch-v5-07.10-0d62359649f-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the *_SHA1 and *_SHA256 flags we've discussed the various flags,
but not the fact that when you define multiple flags we'll pick one.

Which one we pick depends on the order they're listed in the Makefile,
which differed from the order we discussed them in this documentation.

Let's be explicit about how we select these, and re-arrange the
listings so that they're listed in the priority order we've picked.

I'd personally prefer that the selection was more explicit, and that
we'd error out if conflicting flags were provided, but per the
discussion downhtread of[1] the consensus was to keep theses semantics.

This behavior makes it easier to e.g. integrate with autoconf-like
systems, where the configuration can provide everything it can
support, and Git is tasked with picking the first one it prefers.

1. https://lore.kernel.org/git/220710.86mtdh81ty.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 646fbe5b7dd..9b5f872d107 100644
--- a/Makefile
+++ b/Makefile
@@ -481,6 +481,11 @@ include shared.mak
 #
 # === SHA-1 backend ===
 #
+# ==== Default SHA-1 backend ====
+#
+# If no *_SHA1 backend is picked, the first supported one listed in
+# "SHA-1 implementations" will be picked.
+#
 # ==== Options common to all SHA-1 implementations ====
 #
 # Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
@@ -489,14 +494,14 @@ include shared.mak
 #
 # ==== SHA-1 implementations ====
 #
-# Define DC_SHA1 to enable the collision-detecting sha1
-# algorithm. This is slower, but may detect attempted collision attacks.
+# Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
+# library.
 #
 # Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
 # with git (in the block-sha1/ directory).
 #
-# Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
-# library.
+# Define DC_SHA1 to enable the collision-detecting sha1
+# algorithm. This is slower, but may detect attempted collision attacks.
 #
 # ==== Options for the sha1collisiondetection library ====
 #
@@ -515,12 +520,12 @@ include shared.mak
 #
 # ==== SHA-256 implementations ====
 #
+# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
+#
 # Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
 #
 # Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
 #
-# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
-#
 # If don't enable any of the *_SHA256 settings in this section, Git
 # will default to its built-in sha256 implementation.
 #
-- 
2.38.0.1464.gea6794aacbc

