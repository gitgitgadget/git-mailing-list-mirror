Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A47C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJTWn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJTWns (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:43:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FEE22C810
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bu30so1838134wrb.8
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub6ezkVZrRDnpSMOiOQ09h5FXzlEoQvGnXg04MXZBz4=;
        b=EIDrL8WGvyFgOQ6excckYWfFM8stJx7kndIJcLR0iLiDi4OLdKKiqJGL8o9V9fTdVN
         +TwAFTlL6hZ3BpwrCxuKNLli8/vtHzgrAkg0BOPd9cPE1cxnHCZQexg3uwbAWgJhDbY9
         C+kTkJYZ1iGUx4fZ+OZ36euYxGU8e0RtiAio70t9WYSraMP5R3zz4P/aD5TgAGDDbpNz
         hEdy5AexKklD+ntduWHZ3zR1+lRgISRyffKmQ+oMJizcgAvwQGfEX/srEayq6ZiNyNsn
         widN9tUu+kkt1xtynEADYSzehH4nQd55snhOqFzYxLYeenO4X8CnBjR+hAZ1Bgk1PP7n
         pLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ub6ezkVZrRDnpSMOiOQ09h5FXzlEoQvGnXg04MXZBz4=;
        b=Dk8JW6ny5flDy9SE1BEAXcwQan4WQ+Ldh069lIwppxph07sf0m+CKJoNXPK7eoZnYZ
         h6OYyJCCKS9jZH2G09fcjYsjtT2923I4YxopCuishsMoE4Q+zbGd9X78PjiBK5BS5Zgd
         +TtivGfYjQKkx+lsp1PakQBLkP1R/ASTeRUjAfAApq+4GTelxWENrN3i42yQuwh7wf+F
         DQLwZ4qFyrO6RU1KrXZe67PlH59PgDJnrkjXoc0yiU9TWPy2RZi8D1ZJdPBinW6oCkHN
         iC0zY1A435RG+72ohBnQ+bU8BCZEjMlUGA4WSm3eg454inuuC8weEE95U2XOCMWHXzZ5
         6/ag==
X-Gm-Message-State: ACrzQf1kgiNn9f2rquYhWvKGhNt82/9ZjNaTheArvFF45PbyU5B4eaWv
        J8BtzXT61t/eUa1I0LW6omUFMSV2NXvDVw==
X-Google-Smtp-Source: AMsMyM6/RIf6wrKW4Xlibo9bFsGUFtlS1S+fOT3da4g9BRxgTfAfOMKmEzrNVUJShbPblloeoZRf4Q==
X-Received: by 2002:a5d:654f:0:b0:22d:ac82:f870 with SMTP id z15-20020a5d654f000000b0022dac82f870mr10359754wrv.7.1666305817529;
        Thu, 20 Oct 2022 15:43:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm21102746wrq.72.2022.10.20.15.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:43:36 -0700 (PDT)
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
Subject: [PATCH v3 8/9] Makefile: document default SHA-1 backend on OSX
Date:   Fri, 21 Oct 2022 00:43:09 +0200
Message-Id: <patch-v3-8.9-859e69fbe9f-20221020T223946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
In-Reply-To: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
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
index 8a9f3e561f8..0ca8a9eb318 100644
--- a/Makefile
+++ b/Makefile
@@ -519,6 +519,11 @@ include shared.mak
 # Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
 # with git (in the block-sha1/ directory).
 #
+# Define NO_APPLE_COMMON_CRYPTO on OSX to opt-out of using the
+# "APPLE_COMMON_CRYPTO" backend for SHA-1, which is currently the
+# default on that OS. We'll define NO_APPLE_COMMON_CRYPTO on Mac OS
+# 10.4 or older ("Tiger", released in early 2005).
+#
 # === SHA-256 backend ===
 #
 # ==== Default SHA-256 backend ====
-- 
2.38.0.1178.g509f5fa8ce0

