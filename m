Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2B3C433E1
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AC920801
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clVAMyRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFLS3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgFLS3f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 14:29:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6242C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:29:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so10701342wrt.5
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lig3s9AWgywdUyWpCTRvL9K8bsPccbZcjhlpnmmTzN0=;
        b=clVAMyRvQX63ZQVEz1YjsxMN4hJ9UB4FOoEnEzgwxdkroKcpl+yHgxF0f+M3r1Pz16
         NWSxGtdk7T4yHxAF/4pHQiVzJgPX6YdT9jP2spjQ2YVn4zu6Wzb2TnKFxeXjlNXNcvnI
         Iz8jdPCOke1C3kdyj2Vwe3sIEH1xkbk+YQ4NB8t/i4G8pEjxcVV/10I+HcLRQAnPm5/g
         4UVH/L3su8C1dyeph/AEyptUcMF7wPOrxxAkcKKS/FI8aeH4NMx6ivb4T9qr1nfEH1mj
         h9TZdfIr8cANSE712djlYCk9kD+6DFjn6X2KZYcr6nDXHG+cRAhsiRcB+tk2lPMmkBju
         scbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lig3s9AWgywdUyWpCTRvL9K8bsPccbZcjhlpnmmTzN0=;
        b=XEyap5MC5TWoZ8SkupvFj+r+SgloN12eL9sGzfQYna2YklXA9A8q1Fg8BmHubGiYlI
         uapLk+m+wWVcxmTJIvGVI0/JTDaKsxX/C787cvHHWIx6srf7ivDGQEU0bERGJC9QE6nN
         mUOA7SyVpiKWqXylq9mEPCTm1vjoogDPIH5iUfa6hlBjAxOPF/tKJp8+LA/2C5CULBwW
         dPi8+9tBAH8GvnhzJnQMirf4IotGjs2tcNpfBPNZ97oyOrQMp5OwnGSLlq6Wm6F5wzNJ
         UrMqXRxItU1GRShrfYiBrPJdPcBFrW25FURaa/U6JlEb+Nk7lrCZ+qkK473GC7o7CYZE
         +uGA==
X-Gm-Message-State: AOAM5331HKPR9yXqDlG+lKSdghy/ACwabMRgqdijhjWCdyo1B/teeK5w
        e+x04j7xW4rdsd10BU2SaLK+erZw
X-Google-Smtp-Source: ABdhPJzprNaUJ4yPQ+vWTwkyqLfWhJF7mXCD6+0fP56yKDg8AaabzSsHVPVV8Fz7NMYlYucuwdc4Cg==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr16679525wrt.416.1591986573448;
        Fri, 12 Jun 2020 11:29:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm10013175wmh.37.2020.06.12.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:29:32 -0700 (PDT)
Message-Id: <17e7f3e9de65f7275b56f47e7ae727c7f3e1b34d.1591986566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
References: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
        <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Jun 2020 18:29:23 +0000
Subject: [PATCH v4 5/8] cmake: support for testing git when building out of
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
index 1d57ac86772..f9976378d2d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -861,6 +861,26 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
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

