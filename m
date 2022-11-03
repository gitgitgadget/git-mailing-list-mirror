Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF570C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiKCQm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiKCQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9291CFDA
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y69so3907552ede.5
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w2znPlatasOeztggDw5IlVhFbmX8qYhO9JMuI+wu/g=;
        b=b4MTYgjYnsXm/101M7onb6++HPCW56/FoMBAefT/YdQOtGBN+RohhSHwDXjnySoZrt
         JBvMBxrz4UPvk0HWhTxPALIuFAq+I0ctc51MDV25W5tT+Llw9N1WNp+XrbxZskZi8fR7
         6AUDbB+HR2y5YWEw01juFMqfC9LME3VS20xRko+jvgrbZTJqpw2A6pI49F8u8Iv+Y+NS
         lUjN1vGS9dJeOxmFTPoIhDfVelZjteJWTxDQPvEeKOdPpzFbiwAGFk4We1MVdwT43CLL
         KM2tceULsK9HBII+Dal22b00uf7yWXbh22c63++KEbo2gnaKFuMBmSlAHLWqVm5toWsj
         5M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2w2znPlatasOeztggDw5IlVhFbmX8qYhO9JMuI+wu/g=;
        b=0SXtsJ+dJc8wjnpQAdf2YY5WStVzUA9fjT1wD+GU2sCwunuUIZ1uINo3awHfOExkGf
         InEPyK/TBava/Y/axSE37AMThSKusjQJU+7oiYhhasNsp+uhznqNcUHWRBDqiJvX28ng
         pNpu5QyQH62Gs4KX2Y98GKrJxTvnbSb+m76ZdcXNX4iwNqbI4ZaYJ2/rNUNYgwSbVDlP
         YHHEAC7RFYOrIDwJQut8apie86hj7ccgKHle2lFhAOs50IIeutT2Y4Hv2hlrEP1uEh6C
         dBoKHealilNGGZXyCjPbhO2YvvDef3flX0tMkUZFJV78efTvnUEqBDwpOvbIRWTBNiU2
         9SEA==
X-Gm-Message-State: ACrzQf1fjiE7s1tGzusRdZVGIUwz4hdcSr1IJK+WFFaN/3upaMjSVTaJ
        nQTf06UEudUiXor1IOzHwRdnvthSMYPnSQ==
X-Google-Smtp-Source: AMsMyM5szmK+xySQoBc/YJ2a8TKTFDRt4ppdz9rz6Y1SX7OE1Uj+WHYRGYoin91aBYy+RgZvt2KoLA==
X-Received: by 2002:a50:fe85:0:b0:458:5562:bf1e with SMTP id d5-20020a50fe85000000b004585562bf1emr30102366edt.167.1667493493492;
        Thu, 03 Nov 2022 09:38:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:12 -0700 (PDT)
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
Subject: [PATCH v4 07/14] cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
Date:   Thu,  3 Nov 2022 17:37:57 +0100
Message-Id: <patch-v4-07.14-1685a58e13a-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
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
index 812365e1dd8..5c51840887e 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1100,6 +1100,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\
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
2.38.0.1451.g86b35f4140a

