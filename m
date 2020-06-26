Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F98DC433E1
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18049206BE
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNPu5GHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgFZQLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgFZQLq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 12:11:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A0C08C5DB
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so9975684wrj.13
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dMhzHIupvQZAAfg3KRMzA+kC9O0WA5OztOAaIydAgaA=;
        b=dNPu5GHsOGdAqB9wiZnt0aMkjqNjH2P/84u3Yj4ECMWMX0JUu6kfoXwLwkInmbE/Zl
         HqJiN38Y+VjCrG5ibCMe20eXiiRDbx7SZ97XFpDxyPCSleQAY4d6SJYGwXlwcSjY6aqx
         jyWUeGNi33OY2VcFema7lDqQrMu2JP3iVXOWbfqseTYBkBE7i8wHHdazQxjD9F3pXT+q
         MVBibZsm6MDS/5fY69rzd7z65tkIkyc5r5eF/F6OLqzBsx2+9fPT4k9/pnWWRPOT9uYS
         1E09bIDNcenmZDjqyqJljo6jpxJATVsehLDImCTeAk2jdd9B2soyNjcvqmNdN2fb57DU
         mN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dMhzHIupvQZAAfg3KRMzA+kC9O0WA5OztOAaIydAgaA=;
        b=Y1QS4vpJACAbxfBvTq3VFHuOK56/7jn6cEaZZxbR0rq5Vc836ko+mRaletQkHNNlxN
         z9wNqQ8ExC1D/vGMJWB4jLJY0f4B2H4SYtSWbpmBd5YIgFjc67PYrMvmtC0l6uWNh0By
         HwW6J+SJqCqHnYjMD2SrvjS+zA1EIzavsPoGwU+0fvUf7UsTqHcgD8p16kmjiwuhOTli
         +5GiDJdOFmN86ZrRu7KiNamYnvJbQmPeqRInLIENEWnwXIzLLPEzgJOubQ77T2+wF8Hr
         OM+lq9NK35DEWTW8pDTbZONnuadxlptPEE4MVh5fv5VQPcw+v2XKzN5KdJ76zjdGq4Zw
         i9Pg==
X-Gm-Message-State: AOAM5333G6oCZJQLc04nlDgalk69gS15vtlBv3ZRee6upvfIav0Et/6c
        7GHBEUXvSJS/nx0iJ7/hDG3FijI3
X-Google-Smtp-Source: ABdhPJwYjHPtKfhU4OQg5nnV3r947Tki/kVlVV2pZDTJYRblRdd2QSSoDDpakBDailjA/ECgfO9Mbw==
X-Received: by 2002:adf:8067:: with SMTP id 94mr4327166wrk.427.1593187904891;
        Fri, 26 Jun 2020 09:11:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 30sm34291943wrm.74.2020.06.26.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 09:11:44 -0700 (PDT)
Message-Id: <398a578558b7c880770c04398cebdb7eeee23127.1593187898.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
References: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
        <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 16:11:35 +0000
Subject: [PATCH v5 5/8] cmake: support for testing git when building out of
 the source tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>

This patch allows git to be tested when performin out of source builds.

This involves changing GIT_BUILD_DIR in t/test-lib.sh to point to the
build directory. Also some miscellaneous copies from the source directory
to the build directory.
The copies are:
t/chainlint.sed needed by a bunch of test scripts
po/is.po needed by t0204-gettext-rencode-sanity
mergetools/tkdiff needed by t7800-difftool
contrib/completion/git-prompt.sh needed by t9903-bash-prompt
contrib/completion/git-completion.bash needed by t9902-completion
contrib/svn-fe/svnrdump_sim.py needed by t9020-remote-svn

NOTE: t/test-lib.sh is only modified when tests are run not during
the build or configure.
The trash directory is still srcdir/t

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 315f234b04..2768ee5b71 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -862,6 +862,26 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
 
+#Make the tests work when building out of the source tree
+get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
+if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
+	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
+	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
+	#Setting the build directory in test-lib.sh before running tests
+	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
+		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
+		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
+		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY\\\"/../${BUILD_DIR_RELATIVE}\" content \"\${content}\")\n"
+		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
+	#misc copies
+	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
+	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
+	file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
+	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
+	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
+	file(COPY ${CMAKE_SOURCE_DIR}/contrib/svn-fe/svnrdump_sim.py DESTINATION ${CMAKE_BINARY_DIR}/contrib/svn-fe/)
+endif()
+
 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 
 #test
-- 
gitgitgadget

