Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F9BC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiKAWwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiKAWv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:51:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E991A20A
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:51:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x2so23912554edd.2
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiLnAmzVH2NQH/OlOe2WFY8+6IlcVCBZzzKpVOQRU28=;
        b=Ft4e+lkCA15sVd0y7cWNZEc+nKKMceKhe6rYx9BouqpecAnapBUJvtuTA8bSwXTjgy
         +9Imq8G62sxoS35z/frEMZFzJUDyXLVvvdee6OHQ0PBiQpTjK2WG+tos8hbDvmbVEX9I
         MfjknVewjHiPbMLEPMSkagXAOrDLCPM2lw4a8OaTKHZAwpzYMdwD4EUwK8+4X5Q7GtMF
         ELNTpEVbAl+ZIt+LvFIDQihv4eKZdcwxSKdvPEt418/mcOKi9nbOtnrJOQ6vOmFIYCDO
         yFCklMP2wwWByoQChekktXgo60z3pVYYdQWHHCDzQpfBeLs0P13CcvOkTN2JRbkIScwd
         5ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiLnAmzVH2NQH/OlOe2WFY8+6IlcVCBZzzKpVOQRU28=;
        b=vfdSvkxlk6nrPXt3eoZUuZCT/78PRdz+ywL0JgwPntA+hNy4fFRc9Ui6ORgVl2BCRO
         HJe72g64tJKTWZO5da3g6/8bzULBicyjNVNj4iuhm4ALmVPxBisj0V2c7TBOkxnlfArE
         /tS5cSH4UtJXh/UigsTjv2+wjIt2S9+bTqiIgarn0SNrIrNELKKZ66SQ4uXwARgDVeTE
         nlsY+6x93+iwG9L4be9Qp3gtvp9VjPfqyWfdffI+lOWyhzOlNGC1DkoWaZZcJVrmF0mz
         uURhXxAlrf/zjw68bwrj6wlqAhlckjackOLYFr+sUjcs6c4LFZP8elEcXmzU3CdtNluv
         047Q==
X-Gm-Message-State: ACrzQf0MbanQTamidVT8HjIqeS3Ww/IWuajA0154Gk88uN9zSFg40dwZ
        71fX1Xk85C9iDxqj62c7H5iWF3j2xTNXBg==
X-Google-Smtp-Source: AMsMyM6817kwAsiw5ERsfmlJfMG75qPkgZSvzBrZE41dZKr/FBTmOuz0oyyNgfr8AgGDMSptpwUJYA==
X-Received: by 2002:a05:6402:43cb:b0:461:912d:90f with SMTP id p11-20020a05640243cb00b00461912d090fmr21635013edc.375.1667343114270;
        Tue, 01 Nov 2022 15:51:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/12] cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
Date:   Tue,  1 Nov 2022 23:51:30 +0100
Message-Id: <patch-v3-06.12-cba90650879-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we build with libpcre2 which cmake has supported since [1] we
need to set "USE_LIBPCRE2='YesPlease'" (or similar) in
"GIT-BUILD-OPTIONS".

Without this e.g. t7810-grep.sh will fail, as it has tests that rely
on the behavior of !PCRE2. The reason this hasn't been noticed is that
the Windows CI doesn't have access to libpcre2.

With this the remaining two failures we had left after the preceding
step are resolved, but note that that test run didn't include the
git-p4 tests, which a subsequent commit will address).

1. 80431510a2b (cmake: add pcre2 support, 2022-05-24)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 26a93b7b2cf..fc45004226a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1091,6 +1091,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TAR='${TAR}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_CURL='${NO_CURL}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_EXPAT='${NO_EXPAT}'\n")
+if(PCRE2_FOUND)
+	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "USE_LIBPCRE2='YesPlease'\n")
+endif()
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
-- 
2.38.0.1280.g8136eb6fab2

