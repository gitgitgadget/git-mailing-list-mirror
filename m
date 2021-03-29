Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2155EC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B7A6196C
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhC2Ml4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhC2Mlv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:41:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37BDC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:41:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so8457592wmd.4
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QbZM+qD3QAqbEeMknEQLLxH0yCMKuloVgYgcGFkw/CM=;
        b=fbcMij/j64qqJbzJhrN5CqTarfigzxDdDmjUyMYY+OYm8Ke7ijZ03GkgS3+qI7zN2G
         U9O5zvIrnk6fgUehIFVh9sSVTPkZVV9kUKdyRzWqBEzpVAoIQhQMdLYDFjLHqxs8A+7D
         Gj8t9iMdSUhd/ByDOs+swW9fWMFZEE4Ekko7aSKHQqi8ggTB5ihUC2tSj7cnrCdqmS4E
         JtpuEyZWywaA/qA1LlSYpPhfi7gSTwrlztx2O08jWksmVEU3WA1lk2ezENN97Cgjv0In
         eSym1DuYNp4RAUtc0Brc2jstCvZ2A94H1752u9iugThXIY9lrb44Ii6v/93kmL9GFIgh
         uYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QbZM+qD3QAqbEeMknEQLLxH0yCMKuloVgYgcGFkw/CM=;
        b=tjLqk2Edfp/1t19DeTgepujMRD5Hk4o06Uzmh8F1XeK768CFe1EP/smnM30/DZqm6M
         0uTuS4gFVmeyJbcwBq4WSGHJo8u1Lyh5s+edDeeEwUGRvMGVWwCfa9V4mc6C8Y8fh8uS
         6OAYh+X8ks3vxtTOYpJBjAboxs6MQKV/S8KvhI4fjG6ZLD8AIb0KWaK+JfvVTNG5F/Cs
         W2/Y3mRsalpaj+w3M5R7raA3fse51Ve2cSvDAxL0LwRFAktvHdlV4YuPu2T8ePssXg6c
         zKDdLteF+k4j+DtXGYl4ZZUKEOiRukvfIu1rBHUUNmV4PCrnjL/kQnpCwNbK4l1wigml
         c/HQ==
X-Gm-Message-State: AOAM533OyAr77ky3UApAOup8Zmx28dLiEAf38T3aWrkkFqRKIsiykK30
        Re/yxPy6/HjfxRReR2ei38FIeWEtVZU=
X-Google-Smtp-Source: ABdhPJyqfaQDQdttjE1hoo7UDpute937keHuONFKKQqpCURWOtk+9c5lmwUSMHnUdkOGRAPy8eCBcw==
X-Received: by 2002:a05:600c:19ce:: with SMTP id u14mr24384099wmq.109.1617021709740;
        Mon, 29 Mar 2021 05:41:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm24710551wmh.13.2021.03.29.05.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:41:49 -0700 (PDT)
Message-Id: <5d953a21e9bd6b5da562c9d285159bda2289b4fa.1617021705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.887.v2.git.1617021705.gitgitgadget@gmail.com>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com>
        <pull.887.v2.git.1617021705.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 12:41:44 +0000
Subject: [PATCH v2 3/4] cmake: add a preparatory work-around to accommodate
 `vcpkg`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to add support for installing the `.dll` files of Git's
dependencies (such as libcurl) in the CMake configuration. The `vcpkg`
ecosystem from which we get said dependencies makes that relatively
easy: simply turn on `X_VCPKG_APPLOCAL_DEPS_INSTALL`.

However, current `vcpkg` introduces a limitation if one does that:
While it is totally cool with CMake to specify multiple targets within
one invocation of `install(TARGETS ...) (at least according to
https://cmake.org/cmake/help/latest/command/install.html#command:install),
`vcpkg`'s parser insists on a single target per `install(TARGETS ...)`
invocation.

Well, that's easily accomplished: Let's feed the targets individually to
the `install(TARGETS ...)` function in a `foreach()` look.

This also has the advantage that we do not have to manually cull off the
two entries from the `${PROGRAMS_BUILT}` array before scheduling the
remainder to be installed into `libexec/git-core`. Instead, we iterate
through the array and decide for each entry where it wants to go.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index da2811ae3aad..3b94b5f62109 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -811,15 +811,19 @@ list(TRANSFORM git_shell_scripts PREPEND "${CMAKE_BINARY_DIR}/")
 list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
 
 #install
-install(TARGETS git git-shell
+foreach(program ${PROGRAMS_BUILT})
+if(program STREQUAL "git" OR program STREQUAL "git-shell")
+install(TARGETS ${program}
 	RUNTIME DESTINATION bin)
+else()
+install(TARGETS ${program}
+	RUNTIME DESTINATION libexec/git-core)
+endif()
+endforeach()
+
 install(PROGRAMS ${CMAKE_BINARY_DIR}/git-cvsserver
 	DESTINATION bin)
 
-list(REMOVE_ITEM PROGRAMS_BUILT git git-shell)
-install(TARGETS ${PROGRAMS_BUILT}
-	RUNTIME DESTINATION libexec/git-core)
-
 set(bin_links
 	git-receive-pack git-upload-archive git-upload-pack)
 
-- 
gitgitgadget

