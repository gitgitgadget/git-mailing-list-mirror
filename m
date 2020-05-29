Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F633C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE00206E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKR9iq20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgE2Nkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgE2Nkc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 09:40:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CBDC08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so3617788wrr.10
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1gQz2lKdCLziMdZQG/+1zrnyFmHSmjQZFG39JEF+4Qw=;
        b=qKR9iq20hdFYQNykZ0N5C3lKRTHoxtz8S2/xqADAPKHxQZNhMMOaPBr0YvKE1PF7na
         szkz4Rn0lO52dn89p6nMMs4gyXmnAdwjwrCO1/dg/dPxMigY17V2675iREWLxCF7u93f
         tMuZHz3h5rHC4gMVgcbS4CuQ/ptt8DAqnaDYMUUUPYK91Y3B+rWz+QoxGSjCzWpuW9CL
         33SyafRetFAH0hQBdvGPmKkS/K0yNJFTeQn79dV0LhJJzTMhDHfoOEK+LFm7nXEyqNPR
         YatJUzqg2g33ozXX9EfhulS4AFHGn3VZNBF8iZLKbD3dKrTAI76GBRnnBD1VHYX2Dq0U
         Bz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1gQz2lKdCLziMdZQG/+1zrnyFmHSmjQZFG39JEF+4Qw=;
        b=kGPVJzTdvU+JL+efhETREEWNUr3/uu6xE5HV/hHukdcUUjz9hhhj0aIjxCNhejjfoR
         0MSO4PRgCOkSk4wB1DQbkgxKAe4AcQPZy3/EiQ8PLcPouBe3pL8PebtmlZUbXJ3wa1/l
         4Rp49NaSKJsZVJ1MeOH7QmVXQbZAbmn97XhxTApflDwYSJv8etR36sSXr1e8ybUkjPMt
         cdTtSmBeYfqnaTkIo4361tt6uqTQtN+v4/By6D0Qj/Hz+05TuAfLZq+dgdqV4VUFTy+b
         +4I2CP/vTKSA3a0FjKYR67ClPhVQTuY8R3S4h4u6DwYq92sTIb7wt1L0BJXPFwqwODnE
         DV+g==
X-Gm-Message-State: AOAM532FF6JFGoia2XWbOAwlu1uk+aWimaGcDQFZuf4+DUgnnQP4lITO
        YYPs3Bb8UZigpIWzYRtTLWovqu9T
X-Google-Smtp-Source: ABdhPJz3F1AJ8wGW889BBGC3tJb9DqAXkygc6becOd2Dj1NTUMn9gxZRzNMLwF708pv/seE+usSy+Q==
X-Received: by 2002:a5d:6601:: with SMTP id n1mr8390692wru.23.1590759630286;
        Fri, 29 May 2020 06:40:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm10578443wrv.20.2020.05.29.06.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:40:29 -0700 (PDT)
Message-Id: <cdc68f102cb6e5c3eb19d771fee509a8166fa495.1590759624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 May 2020 13:40:21 +0000
Subject: [PATCH v3 5/8] cmake: support for testing git when building out of
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
index 33a3559eb8c..ea26f4612d3 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -845,6 +845,26 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
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

