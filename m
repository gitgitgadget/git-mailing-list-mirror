Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C0EC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiLSSkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiLSSjh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:39:37 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27308199
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m14so9585158wrh.7
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6YVaFRzsNbkZQybg4GKOCYXlan5Z+iC+DG7Zc/bHrE=;
        b=HyX4lT3Ij3si+Ka6rBuilJc8U1bLNjkjFrjnoCrAthuwHyYNSa4WXsY3BgIo8xVC0x
         Pm0FbWg7CyCz/ysU+qIH9oQbIxQQkL5/aOA0KRHZH6RAk+WigW4NhlDYQOORGJL3u+mf
         BOAqMBQ/4P/gU0cqpQBcpyMW5Zgr1f+K9LyYzIkbda5sxfpUx5xzrYetQWIH8UKCMudq
         oYC7zON0QoVue3a7BycpXsaUm6zA8EdbGnyo9qQuZp6HXkSK2TmUtJV+Nb25vaAkvzZZ
         cmMRuSlcEEEBmOZUSwW7ATjjiWCuwp/8MyQjZ4bLh2fDhQou3oNKosLJUgLjzALDaAUT
         wJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6YVaFRzsNbkZQybg4GKOCYXlan5Z+iC+DG7Zc/bHrE=;
        b=x5q9TGkuJHLJS4lnOtHcseUzzEoNRY31IEqKxsano2kfDFuX1Mf8lD0LNhU0fhVXA9
         Z49psPreLljquAJavzDlouc3qw7nF9J+NOutyYBdoWGiXzOfDxGu1ne3Fv9ljaVg2EkH
         cBKekLGVXGz2G6Vaxz2rbXbX20KZnXGsP5GoIo0oQkzGJm1xWbzGYM/RI1xU8CTqVBtH
         kgnM2pFgrNKlHtZ8d1fIxEtNth2cka6L+M7M/CD+imPZFD/VOaFfoLs1MHTDVXe/q/eT
         REqIE9B/ct1cLVA8JTwpBg6gLYsCN+T4fYvaFO1MkBv0IgsErk1URih6WC3lj2MA8pAv
         eBxQ==
X-Gm-Message-State: ANoB5pkwQip2Bk5sci2t+xHa9heMU6DvO+YkBYjpdrVwUs5/zdOvROtn
        uQKSlGVtb7xsmZUqluyi0EsUVVYvA6l8Gw==
X-Google-Smtp-Source: AA0mqf6qFr9FRkwcygtjYmA0HQAnyURr88J5Kkv0wqnI9l8smso+aVzzOctXd4b5HbX8qXNd7dmXQg==
X-Received: by 2002:a5d:5b08:0:b0:242:6e5d:c0fb with SMTP id bx8-20020a5d5b08000000b002426e5dc0fbmr28085307wrb.28.1671475174405;
        Mon, 19 Dec 2022 10:39:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b0025dac4b615dsm7286790wrn.3.2022.12.19.10.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:39:33 -0800 (PST)
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
Subject: [PATCH 5/6] cmake: copy over git-p4.py for t983[56] perforce test
Date:   Mon, 19 Dec 2022 19:39:23 +0100
Message-Id: <patch-5.6-70a7f3e19b2-20221219T183623Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
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
index 560a15ed35a..29b73ecbbbc 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -894,6 +894,7 @@ endforeach()
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
+file(COPY ${CMAKE_SOURCE_DIR}/git-p4.py DESTINATION ${CMAKE_BINARY_DIR}/)
 
 #perl modules
 file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
-- 
2.39.0.1071.g97ce8966538

