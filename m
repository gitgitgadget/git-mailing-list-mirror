Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ACBC2D0F7
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB66220714
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIu7XGVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgELQvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgELQvC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:51:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E6C061A0F
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g14so9811074wme.1
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=um7YXcF1Y1OreHBAM56TlWXQ95395vW95to6ZQjeCvI=;
        b=JIu7XGVKc9nhwHM/82m/PY8Tb7LllfQkzDC84iRQs4YC2qM5FX2/WhkJ++AuVAg6KY
         4ksFpU4zfZb5BfdCb8Fih247NqhLLEK5Xl0R2jJgzdo9mANfZ0D72+zhmiZ8UuZgc2Hw
         6Scft7WTtDHyoZ/IrZ9IFZ7Bc5V3XvmP+9kd2WMSbJ07eiEdm31uO1yo3sy5ki1htOBB
         4/Y68PlT850aKhLcM7GMDisQqr1YNSF229HXwGI1G4liorto+26+eoolmuzntMyNaoOB
         Ep/+BWooAwxlYCAqa/y9AR70VHmMaIHW3tSI0qm7zjXZHFcpCVf70Y1bTBqI/W6Ez0H9
         cJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=um7YXcF1Y1OreHBAM56TlWXQ95395vW95to6ZQjeCvI=;
        b=VWwq5Qrs1X9qOkkUeea9u8sTNL7aC7vXo62g3Z5sDDaoyyQHRfDDg1NjLdutmjnK5K
         AigRCSuLjS5wlv4fVNfMBuVg91u14ZOQu2FqUdqbaylq7zHoK0nwrdXh4vAvm5yGksfP
         VnIj/giZsLgv+CH6s2V1BLhSb7fI3d3BqZIWBsmzmWS4X44O5oFPt771I8qi8lOh8K8R
         +i4YFpTFJVb2QWbQKkq7ZbVi0lN5AyyvHbJSxi+R7rImDL+EfYpDpfHIoXiwzoYfC1Zd
         ycRN3Z9qpgXgyo1VoDm5dUWurP/Mwq0chxiAfX3Y/xHL8OOFyipc9ZV55/0c5NnJUrrA
         Gx/Q==
X-Gm-Message-State: AOAM532+ZmhIt9MZ4Y3rr51UZGABr6ADG0TG2WmaLBCElBRlS/h9C6hv
        CxOtjPQF8uEZNunOVgIxVJvSOWv6
X-Google-Smtp-Source: ABdhPJxmeNoNr4W2eUjmNXZZbZm0+UWf8nj6+jOL2hdEIKNuKKO4+oqbekPzWY5AAqjD+YrUyNsnwg==
X-Received: by 2002:a1c:31d6:: with SMTP id x205mr5307692wmx.105.1589302260670;
        Tue, 12 May 2020 09:51:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e22sm8654650wrc.41.2020.05.12.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:51:00 -0700 (PDT)
Message-Id: <096f6311ad505130b5d92ab24845c9536a79bbab.1589302254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:50:48 +0000
Subject: [PATCH v2 05/11] cmake: support for testing git when building out of
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
 CMakeLists.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 05fbb05c6ad..47d3f3c2866 100644
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

