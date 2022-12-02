Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C526C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiLBL34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiLBL30 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:29:26 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B28AD4AF9
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ml11so10876856ejb.6
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScjFFWjE+a8ItBHXs676fLzK2xDPST38J5Ah1h+P+Og=;
        b=prQL3vCYjnn+fM0h0dZmI0H+YSk1Tifay6V5iParFZW+zDmF6lUkPlYHNCGw+0zVHA
         qmy17tQ4HcAn7il8iSdqohvs4iFwSCo4fO4HGgIQI2pKdMXwZVzeAHn2pk1mOtS6YWi7
         d7nTjZiw/v9Gwp3sGN8Tq6qyDpjOuNtq6tkKIekYjZfeKiU+iF9spyOLbjeWcE/Wj9rR
         70G5bg/sp0T4/9LpplWjGZfXjVEkdmX4+3KkVlcuXx/TRXAnt12QTynX6OZ/sDbB3OiL
         +BCFHSnhwXpOLJ9ko//rxTH/o2rLR702uGUyLQf8dmb76GXOzNABdmlW5MONdOA41nrV
         GedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScjFFWjE+a8ItBHXs676fLzK2xDPST38J5Ah1h+P+Og=;
        b=hGWFVpU8F7MNUCWDSMrZkNXQ1JaLyPZv/TrMmaLlSTXOyf0EjnMZ8b+3p0hwWWcqvb
         L6GnFdo+eeNiXR8zmYcfki4JYa+bErzsDZpLHnM/Lb15OKoO0i5EuQMvJejmiZdIFTkz
         Hg1/+w6oWMPFFZk/d22Gk5/1gNBUPPKFDZWnn2svtsL1mu48PLP3ud9OS800ojtCYgst
         MLJ3CNmwqv6QJp8O2Rnd+lYYsKq0Qc+U6AX+jIkNSaZICLVSL6KM2hNOfB5QjeB7UsSE
         AYj43iDYHe7HyBR+kN49LI+i/EA+YSoOvUwlaQeQFwS3ocYfpNYYouBOkR85KmP3sQzA
         jOKg==
X-Gm-Message-State: ANoB5plaban1a1dKmt3wtY74uLeGXAfg3CWHtDjcSnnsyKd804I1ry0u
        DgO2IRLGNOe1S/cwZUcZ0dtac5ZMtKZplA==
X-Google-Smtp-Source: AA0mqf7/UKjsA58qYCj9G+KkcmsXoeqIAGoU1oPTp+cn7+IVCHIFc3GQUUDE40lRdMmsK/vDb4GvxA==
X-Received: by 2002:a17:907:124d:b0:7c0:9ecb:a4f1 with SMTP id wc13-20020a170907124d00b007c09ecba4f1mr9755728ejb.692.1669980536754;
        Fri, 02 Dec 2022 03:28:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:56 -0800 (PST)
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
Subject: [PATCH v5 14/15] cmake: copy over git-p4.py for t983[56] perforce test
Date:   Fri,  2 Dec 2022 12:28:35 +0100
Message-Id: <patch-v5-14.15-c9c895bb794-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since [1] two git-p4 tests have relied on there being a "git-p4.py" in
the build directory, but the cmake recipe was not updated to account
for this. Let's copy the "git-p4.py" over.

We could also change the test to e.g. grab the built "git-p4" and
alter its shebang, which would be friendly to GIT_TEST_INSTALLED, but
let's just do the bare minimum here to get cmake+ctest working without
altering the test itself.

The reason this hasn't been caught by "vs-build" and "vs-test" is
because those tests added in [2] invoke "cmake" with
"-DPYTHON_TESTS=OFF", and therefore we'd skip this part of the git-p4
tests before getting past the "do we have python?" check. Even if we
got past that the Windows CI wouldn't have a "p4" or "p4d" binary
installed, so we'd skip the tests anyway.

In a subsequent commit we'll run "cmake" and "ctest" in CI with
"ubuntu-latest", so we'll need this "git-p4.py" file.

1. f7b5ff607fa (git-p4: improve encoding handling to support
   inconsistent encodings, 2022-04-30)
2. 4c2c38e800f (ci: modification of main.yml to use cmake for vs-build
   job, 2020-06-26)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index da47d9c8397..d989e534377 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -938,6 +938,7 @@ endforeach()
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
 write_script(${CMAKE_BINARY_DIR}/git-p4 "${content}")
+file(COPY ${CMAKE_SOURCE_DIR}/git-p4.py DESTINATION ${CMAKE_BINARY_DIR}/)
 
 #perl modules
 file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
-- 
2.39.0.rc1.981.gf846af54b4b

