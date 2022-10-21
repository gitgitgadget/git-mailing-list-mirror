Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB8EC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJUJpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJUJou (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A274F679
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id iv17so1803227wmb.4
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9+HH8WhbvTFqa2GaTipptruhLSRoUinWGbJ30MnGcA=;
        b=h5sODOZleyE/mZgfpb+cwohbFXY3ujci+Dw45ncKpdf+7Bfnc2Q7uIaZ2M07p9+H9f
         2utvawWGOIQsuDcd+Fw2YMKzy1K62/2GJAhWwqz6BkizEDGx16ZXtFeAQRHQfpZQVtsK
         4DGuyAj0bGekDgf4ONYomcZyGIlVtFBcU5iTwXppvcYM9ahTkY8fxqun/CnMTPIAn1oZ
         On+Rs50PrViTt6L1BxB5Aj5AclGPTuZ8tby44iXQxlv1Xy+DVZNaksher1c5CtyH+y5R
         erGntz47RHmCjRvuf/uBQnkVoCV/mnvKq1v6eMcmSnwf0sYAanPBot238Qo4fRaAD+0H
         fBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9+HH8WhbvTFqa2GaTipptruhLSRoUinWGbJ30MnGcA=;
        b=luC4+4OWLUxY0hsyy7Q1QNbjHDDOM/yyAQ8AfYETWQ8HaFn34fgcOuaN/aUd9IzhcQ
         dAbMbRJlQZnUQK9dosNBkmsz7SHYsZ0/9sWo6T+EbsrCdlli0FLBmKeMEbR0/FdYL+AB
         yZsQujWtii7Rrf03GnGT/GnYaaJMiG37jtnoA+tNWm4RkaTWG//ORtRlaVCx/U3CA57m
         n+BKk30DRXLFoFdepZVNGneQiDNwGWCG8qipZGSmKfLIJbqZy3WGlUBEVzxge6ZCGJZr
         +qtBRmDibZzzPddwtDe3y1txxSAs8X3m2AO3pN7wyoqWUVWeoi7p+g2NnVOxuFD7yXJt
         S65Q==
X-Gm-Message-State: ACrzQf3kXVM43iLpiez/R1t231CGlFzbTLKdNJ17D/xtVM1kxwo2PQAw
        VD1T8AscB7FMgqbFcLjNPZ/avst49SG24w==
X-Google-Smtp-Source: AMsMyM4KrF/4T1UUZp/CqO5OnCXtulf5AFAbBCfW4+f312LLPXYgFi/tOiLIP7Q40K5shnwIlif45A==
X-Received: by 2002:a05:600c:5488:b0:3b5:634:731 with SMTP id iv8-20020a05600c548800b003b506340731mr31691776wmb.188.1666345487125;
        Fri, 21 Oct 2022 02:44:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm18277768wrn.61.2022.10.21.02.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:44:45 -0700 (PDT)
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
Subject: [PATCH 4/9] cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
Date:   Fri, 21 Oct 2022 11:44:17 +0200
Message-Id: <patch-4.9-52cd674d5b8-20221021T091013Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1205.gcea0601d673
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
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

1. 80431510a2b (cmake: add pcre2 support, 2022-05-24)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 84f5132f1ee..725b3f2ac82 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1063,6 +1063,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\
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
2.38.0.1205.gcea0601d673

