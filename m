Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC31C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiLFCKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiLFCKH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:10:07 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E99F24BC2
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:42 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vp12so2809459ejc.8
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xv1B1ji+0XJiZ8hE0aP94bCqA6HfbJJL8lQvuxuS6E=;
        b=GD6FBn3mNNrpgVQJg3kuhGA1TXFhmGrd34e+36Vh5SIyxmGBOUsUGUrHxwM2RS0v//
         7Mb+1BrHrZlOCH1RDsj98sLenPM0CYSSBuXx3JLpLXRvxxdLgunSMfg21zm+YHM5I3Zq
         I7eNKWDJSkafkOhq8ajVleWLbQGXfuqMJ70kK06RFAuApuj2HXMk47Tw7M6IqAXTkUOF
         6FBXk9phIA+MCYNbw2AGlcpE4EylbRQgB5RJsNmwKTxBaFwN5X977G8XFVXCN9yQNy8C
         V6bk60aZIYOvW6xV5GaLzDh/o73xb1xzNLX3kYcXcldYoYEWxHjuf9OT1NrYSHJJ8KYt
         ybaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xv1B1ji+0XJiZ8hE0aP94bCqA6HfbJJL8lQvuxuS6E=;
        b=hZhJ3xqkZKaBm3GaPNGv9vUjjpSMb9VQ3/ToCVf1wV4i9AubePexjEhuuux0knsJbL
         MiOg+T/bFsQYWuiJUidDc4mp8HsyOo99Tl9rkcgkLEuyRV4Ueb6rG61gYgcOkBiYZ77Z
         SYMnr3BPVcjbrEKFCC5l4AsGQhbmRnaPfpo4xguaHjn+ym91FZANhBHnextE+hq+M2N4
         E+RHc1jBWrlJJi8K6CDKYDNEmaJ18d9cXm/u7mm1kQtD6HQ8IzKWpqIRnNjdvs8UVKDp
         EtODNZGgDCexjyt/sBwNQ3K3/EMkiWpD84XTLoLgJRQowN6J3nBN6XJmZrmUyBZIKRXf
         8aKw==
X-Gm-Message-State: ANoB5pn90faEH8Qz3drEVkMKBxMN93t/gS10/og7vJnkbCTdN3ockdwP
        17vl0mnoQ9kGIfJygqsJdP7T2uEOseU1Pw==
X-Google-Smtp-Source: AA0mqf71Yht8wUBKLa9kWUVeVqMAwBvY9e+K2RpPOsa14EsiTaJNwKmIs9zyx9KvK6PerpWXxnssfQ==
X-Received: by 2002:a17:906:abcf:b0:7c0:fb28:96ee with SMTP id kq15-20020a170906abcf00b007c0fb2896eemr4407191ejb.660.1670292581550;
        Mon, 05 Dec 2022 18:09:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:40 -0800 (PST)
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
Subject: [PATCH v6 14/15] cmake: copy over git-p4.py for t983[56] perforce test
Date:   Tue,  6 Dec 2022 03:09:12 +0100
Message-Id: <patch-v6-14.15-563f1b9b045-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
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
index 9e3e46c93f5..b1b1f327e95 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -940,6 +940,7 @@ endforeach()
 file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
 write_script(${CMAKE_BINARY_DIR}/git-p4 "${content}")
+file(COPY ${CMAKE_SOURCE_DIR}/git-p4.py DESTINATION ${CMAKE_BINARY_DIR}/)
 
 #perl modules
 file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
-- 
2.39.0.rc1.1006.gb4c675778ba

