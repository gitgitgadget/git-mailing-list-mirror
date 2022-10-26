Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B10AFA373E
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiJZO5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiJZO5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:57:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01BE10F894
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:57:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y16so16334720wrt.12
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiWGpc9fc6h+QS9UXTGiHG17+pqeh2gM2zgDlcDq+vY=;
        b=p+c1Krvh+0S8AgDWsNl7l+4gH+jQPMoMA5zmo69sQChBRHWp/3jdzeSdYJ9HIO1VLz
         ZAiaV2p5zGlVVAz3MmK7W1pjvRJgKU+cDBWrK6V3XDkBb8IeH7e/zv5ifjyiElDVRUY+
         /f0tDmMKcVDS8ONBmrkbubAEHgk/ymHL6/A/ZnGqs3sTaYzoiFpkbgEH64fRSOgwtAmS
         hqctNFfl/gCbSXUpsobLd/hdv5j8eIbV2qz8m4MFhniEXcZjRD7M06LYG2x+MD8iWa2z
         XfDD2utHj4BNM6U+N/HATMuKAZ+HF8a6SnqQQtHuAk/9skdR1ajs5o4CxSHaCCCPZ620
         k3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiWGpc9fc6h+QS9UXTGiHG17+pqeh2gM2zgDlcDq+vY=;
        b=SeBV8cMWLT+0QN8StFa872oyoyY4escElAkf98mw/EPa5KGC1Rnk90+CgjkAEmKtW6
         Xy+V2IN+63hF8I2lXFXOy0Qh0XjT6LclKzzrZ+WoTq+2EiisH5LwQ/cA+W8M/9duk10L
         DUhHNaWRe1YgaOYmVxi7EkCR5xNZErM/5PKSyk4WOkO0ZhZnLx1T2mWDvIJhEN3LNapl
         TjUD3fitmdM4VdJjD3cbP+ZU/2m8bNMnv9gOdPPfo95wyuff5ZeTcoO0SVKT4bEppvea
         jKARdgFf9DuLV/1Go+9/QgaxxhkMLQ6Ekn1VZb+ueFSZ4u7tF5M3Ke2V4duQQsidwO15
         nTSg==
X-Gm-Message-State: ACrzQf20nhZtkWxtOpsLHRE9ujWvZXoVT+0pLWbggsMjKiLPnWLlhE4f
        428ROVVyo9tSmuJM7ags103ZhmUiRcRiyQ==
X-Google-Smtp-Source: AMsMyM7T+1KSwwYf/UUZKc7tRXIxddzIGwYTfzf2KJvcEFEJ2uEeaM5JFx7iODvn1RzCIVcbY36xKA==
X-Received: by 2002:a05:6000:1f18:b0:236:8e08:68e1 with SMTP id bv24-20020a0560001f1800b002368e0868e1mr1996509wrb.67.1666796219143;
        Wed, 26 Oct 2022 07:56:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i25-20020a1c5419000000b003c7084d072csm2180351wmb.28.2022.10.26.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:56:58 -0700 (PDT)
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
Subject: [PATCH v4 7/9] Makefile: document SHA-1 and SHA-256 default and selection order
Date:   Wed, 26 Oct 2022 16:56:45 +0200
Message-Id: <patch-v4-7.9-847be3d32e2-20221026T145255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
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
 Makefile | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 992eba9e0c8..9f7cf1f22d4 100644
--- a/Makefile
+++ b/Makefile
@@ -481,6 +481,13 @@ include shared.mak
 #
 # === SHA-1 backend ===
 #
+# ==== Default SHA-1 backend ====
+#
+# If no *_SHA1 backend is picked we'll fall back on using the default.
+#
+# Multiple *_SHA1 backends can be selected, the first supported one
+# listed in "Other SHA-1 implementations" will be picked.
+#
 # ==== Options common to all SHA-1 implementations ====
 #
 # Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
@@ -505,12 +512,12 @@ include shared.mak
 #
 # ==== Other SHA-1 implementations ====
 #
-# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
-# with git (in the block-sha1/ directory).
-#
 # Define OPENSSL_SHA1 to link to the SHA-1 routines from the OpenSSL
 # library.
 #
+# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
+# with git (in the block-sha1/ directory).
+#
 # === SHA-256 backend ===
 #
 # ==== Default SHA-256 backend ====
@@ -521,14 +528,17 @@ include shared.mak
 # The default SHA-256 backend is shipped with Git. No flag is required
 # to enable it. To select it don't define any other *_SHA256 flag.
 #
+# Multiple *_SHA256 backends can be selected, the first supported one
+# listed in "Other SHA-256 implementations" below will be picked.
+#
 # ==== Other SHA-256 implementations ====
 #
+# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
+#
 # Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
 #
 # Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
 #
-# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
-#
 # == DEVELOPER defines ==
 #
 # Define DEVELOPER to enable more compiler warnings. Compiler version
-- 
2.38.0.1251.g3eefdfb5e7a

