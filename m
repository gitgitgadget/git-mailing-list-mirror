Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ABFC55186
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F88F2075A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvYTwcq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDXEBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgDXEBp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 00:01:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C734AC09B046
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:01:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d15so7455699wrx.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+CnoiZmIBAAVuOZIE8uXwy9Jqy6QRzanK3ctkdevz38=;
        b=XvYTwcq237n97iD+TWsS0ebpT6FaCRzgLReLQ2WEJoU7hov+9QkUfoG+cxF46wr6BH
         xfwMdWuxj2d++SzfWtP5MOevJ4FsSK/c8RFKl+vzySoGSISwmRQ1Mpvbgve9S178XWp4
         utbB/hVTSer4xRAxfKn+WU3gbChEFM3dsVEA4qGbiB3ZAPevLFsmvHkDi90vo8v2WIei
         wshhH2t/TljvtG0CnkieWKuhAxF4if0nLJpqFl2V5EnV8dSXHAGy1AxXhDomjd27Upvh
         mH0xu8aLGX1TsraywG82BHSJgF/cTLIPZUCeugw/QZ9y976J67JqGL1RS+Ma/4G+Yrcv
         +2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+CnoiZmIBAAVuOZIE8uXwy9Jqy6QRzanK3ctkdevz38=;
        b=HeW+wC5fZHTUc4U0CN2FbzTDVsy6Pb1+2l0WxaSd8/Xf+nWXvhD0eqX7jJ6iWPW+VE
         TXCHtbL4WGKE8wwooBIiPVA0RVMvoiQn1MczzCOYBSXwtp1row3/Zq7RxJI/Pz8rCrWI
         Whe7kcC0A6MwplswXWViKv8SeuiSotGP/Ee5+fFpdzMJ28NF3Tnqtc66/GdNbNUIKmqd
         ifrjW/fK78NoikukgKwInOW+V5u/VU6GqcgVhus/U79RpGTYegvwa4pid9MuqTuCRr4U
         nS8ontbzZ8PIpMoRv2L84UKI+Q0K9m6NtT/pRPr7k7E/yDnlBt30/Lf+pW+LqmEHwXRC
         dLRA==
X-Gm-Message-State: AGi0PuYoXjCWIPSCJosSTGgp8h3Fww6pVtdYgVjH7Pb/YHZECNuS+qyl
        wfIo9GJGWQ38NbQjBfSZTibprQTf
X-Google-Smtp-Source: APiQypLfy/ma4uwdxFKmP/TFJZhhIS4EiXcmtLk94nEol5tFCR69ytMponBlvEitXjokFCUTycUNoA==
X-Received: by 2002:adf:f40b:: with SMTP id g11mr9094927wro.178.1587700902440;
        Thu, 23 Apr 2020 21:01:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a125sm1059394wme.3.2020.04.23.21.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 21:01:42 -0700 (PDT)
Message-Id: <166b78f71755bb3f9967b32bfe282210c2bb240d.1587700897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.git.1587700897.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 04:01:34 +0000
Subject: [PATCH 5/8] cmake: support for testing git when building out of the
 source tree
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
 CMakeLists.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 141ccefa559..29a23eb11f7 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -812,6 +812,25 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
 
+#Make the tests work when building out of the source tree
+if(NOT ${CMAKE_BINARY_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
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

