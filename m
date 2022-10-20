Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CA1C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJTWny (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJTWnk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:43:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF222C804
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y10so1082279wma.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m951yLGWh7+MaGtAlkDmVq7h+VvR1y2JQWQIYBZ6KWo=;
        b=q6gOqPg8THxLxoPhNojziFDvFxhhiyP4fzmeYFMf9Br5JaiHh1yIhbFUeFRd4g4s8V
         KUjtl7r3Ulv14Epaf55XqIyn3JvnG/Ue3YZGRjL5YN8qGiwh4BVoKLCqCTc4ato8mBOW
         fcJAFt9DA0n802bbuF6mCwZWcZ3fqFONai5P4LXxCLUkQxx4Cv7ChmogV7Xvtkrav1uJ
         Gwz2I0ndCMc4QtMUdi/qcPi8rhxTxbepXYxy7PM/O+Lb/crtT0BuwHFn/Iglz8XA05y9
         NWFoNYgSN6iVlRjB0/0KXFXHfTUAAZtvRxDADI2l4BDXCOGdQhhp/qqquc/ja3yLyaLf
         Rx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m951yLGWh7+MaGtAlkDmVq7h+VvR1y2JQWQIYBZ6KWo=;
        b=G40aVBgcDi20k3kTZEXlrNaM+cbjwHxOBGak2CGP0PPwx2cDk+h+fQaTDkH3Cgq7hO
         lPvBB/SaUhlTVFftXZ36jZB6EmtZCScaDQ2CbSI18pHON5YGbX5tQRSiDyQD2J5O63FP
         cbQX3CMv10FCZjMjQoyTXlti0lWqlPFlvCfP3nlj7efou2hHN6YEYKBQ5C9+KccyzbRu
         1/6McTrsIB0wqp75rHNa/DsYTGHFGWUNP93YjGAv4qmdB2XkBQH7HLzd2AT2cVihJn6H
         HJz6NHRga7u+ftjuSN61qLAAu9MgXAXWkfrV16OwhaCOBJE9cCBbix9faA9qNAVoed/4
         3e4Q==
X-Gm-Message-State: ACrzQf0l+4Hvmio+5WdlFt3h4QUoOOZTOfrMNyMMqgtidwYWwLi3V8kC
        KBdSsKN3LVcS0ObVNqTrjRPtO4JkdRt4vw==
X-Google-Smtp-Source: AMsMyM4cgGNcydnoOIYrj3HHfqCBiEW8nQ8SmlN7jnQtkZQN2VXZZHm5XorCXLOKXnkjiDl9OHDpzw==
X-Received: by 2002:a05:600c:5490:b0:3c6:d8f2:6e1a with SMTP id iv16-20020a05600c549000b003c6d8f26e1amr11079030wmb.90.1666305816164;
        Thu, 20 Oct 2022 15:43:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm21102746wrq.72.2022.10.20.15.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:43:35 -0700 (PDT)
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
Subject: [PATCH v3 7/9] Makefile: document SHA-1 and SHA-256 default and selection order
Date:   Fri, 21 Oct 2022 00:43:08 +0200
Message-Id: <patch-v3-7.9-05edcfb9cd9-20221020T223946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
In-Reply-To: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
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

This behavior make it easier to e.g. integrate with autoconf-like
systems, where the configuration can provide everything it can
support, and Git is tasked with picking the first one it prefers.

1. https://lore.kernel.org/git/220710.86mtdh81ty.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 0bc8eaa4cf9..8a9f3e561f8 100644
--- a/Makefile
+++ b/Makefile
@@ -481,6 +481,14 @@ include shared.mak
 #
 # === SHA-1 backend ===
 #
+# ==== Default SHA-1 backend ====
+#
+# If no *_SHA1 backend is picked we'll fall fall back on using the
+# default.
+#
+# Multiple *_SHA1 backends can be selected, the first supported one
+# listed in "Other SHA-1 implementations" will be picked.
+#
 # ==== Options common to all SHA-1 implementations ====
 #
 # Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
@@ -505,12 +513,12 @@ include shared.mak
 #
 # ==== Other SHA-1 implementations ====
 #
-# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
-# with git (in the block-sha1/ directory).
-#
 # Define OPENSSL_SHA1 to link to the the SHA-1 routines from
 # the OpenSSL library.
 #
+# Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
+# with git (in the block-sha1/ directory).
+#
 # === SHA-256 backend ===
 #
 # ==== Default SHA-256 backend ====
@@ -521,14 +529,17 @@ include shared.mak
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
2.38.0.1178.g509f5fa8ce0

