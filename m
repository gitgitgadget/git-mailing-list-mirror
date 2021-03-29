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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E987C433E2
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7AC61970
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhC2Ml5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhC2Mlv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:41:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917FBC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:41:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j18so12722282wra.2
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZxHk8HSij5XmrJ+Wn7lvAOCq5iqmEZQbbEWC0y+NBYM=;
        b=cJVO55sKcanaA1wVD0BOftK939Ho0JYTLKH0FtLOVx2DfUI44BQvGuGs8UNkbuOdSK
         brjKQEOJcWOM0sjnwKibZdADP/L7Kqx6rj1kdChRLd7mWUSzwVgJMIg5IasHRxVp6d/o
         Cah7xbcd5wK+1WhNFxgDQQ6wnaXAlccVh51/0CI6beu3hSxpIqcPU2IRce6eN1htDdta
         2zK/kc/6cqrXHC7F9ORUR6f3KXFXuqwY7rY73nLyodLVAfp03qlPL72s5QJnlmTSQWRU
         Xn+mqZfiIcI6ZAcAXyX6R/IFAWAgQYtseDRjNUFymsixFxYhq5bDFT4iIHu6t24NbMrC
         CyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZxHk8HSij5XmrJ+Wn7lvAOCq5iqmEZQbbEWC0y+NBYM=;
        b=o1bKKeKI7GcLznGLMLYdDmRR0us3XNfQtb3yJZ1HgxubE33cxMy8dtzOJRBs1S0VGS
         ZZMU3RRDv+I6TRV25/L6YUjvu7DNQwsbzuZ4pu8OEJ9NoOpEWXYYHEcG6hhAbxtarJAk
         tr4tk36YCryERYnsvrOQ4Ccns3wuQzE9MHoPUiKWLqkFaLdB0kOPUXsOPRwnxlW3uA8a
         48rE/8cftsNecWenN/U8/1ujMEQO6eesTWoeFOVvWvngSmnHTbxPYvaNEkY+GocFazc4
         ZsHbXTqsbeY+Kq9IV23pBHk5h3qH/znvHbYLtyrU6c65XfDs4l+2PjkWuZw2i7+WweKr
         i8nw==
X-Gm-Message-State: AOAM530v+NmyXnwZ6Pee/M7/qZoAPWMAcljMZDEJCQ49e4l/oyyDh6Qm
        ApgoCSuSB9cGbvnwZxQrMr2b0AclWBs=
X-Google-Smtp-Source: ABdhPJzAJtMCLn4eFm5Qdu+SBv5cfkWFWwxCSWE7ue2MtauzNa/YxEmzNGW/hcLw1P7G0BvEH5xLHQ==
X-Received: by 2002:adf:b355:: with SMTP id k21mr28868929wrd.156.1617021710419;
        Mon, 29 Mar 2021 05:41:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4sm30264610wrx.86.2021.03.29.05.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:41:50 -0700 (PDT)
Message-Id: <f020cb517dfc48e2619815e09110d4044eed1ebe.1617021705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.887.v2.git.1617021705.gitgitgadget@gmail.com>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com>
        <pull.887.v2.git.1617021705.gitgitgadget@gmail.com>
From:   "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 12:41:45 +0000
Subject: [PATCH v2 4/4] cmake(install): include vcpkg dlls
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dennis Ameling <dennis@dennisameling.com>

Our CMake configuration generates not only build definitions, but also
install definitions: After building Git using `msbuild git.sln`, the
built artifacts can be installed via `msbuild INSTALL.vcxproj`.

To specify _where_ the files should be installed, the
`-DCMAKE_INSTALL_PREFIX=<path>` option can be used when running CMake.

However, this process would really only install the files that were just
built. On Windows, we need more than that: We also need the `.dll` files
of the dependencies (such as libcurl). The `vcpkg` ecosystem, which we
use to obtain those dependencies, can be asked to install said `.dll`
files really easily, so let's do that.

This requires more than just the built `vcpkg` artifacts in the CI build
definition; We now clone the `vcpkg` repository so that the relevant
CMake scripts are available, in particular the ones related to defining
the toolchain.

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml          | 5 +++++
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index f6885e88ee6b..c13afe2bf058 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -186,6 +186,11 @@ jobs:
         ## Unzip and remove the artifact
         unzip artifacts.zip
         rm artifacts.zip
+    - name: initialize vcpkg
+      uses: actions/checkout@v2
+      with:
+        repository: 'microsoft/vcpkg'
+        path: 'compat/vcbuild/vcpkg'
     - name: download vcpkg artifacts
       shell: powershell
       run: |
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3b94b5f62109..485c7662dc58 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -58,6 +58,10 @@ if(WIN32)
 
 	# In the vcpkg edition, we need this to be able to link to libcurl
 	set(CURL_NO_CURL_CMAKE ON)
+
+	# Copy the necessary vcpkg DLLs (like iconv) to the install dir
+	set(X_VCPKG_APPLOCAL_DEPS_INSTALL ON)
+	set(CMAKE_TOOLCHAIN_FILE ${VCPKG_DIR}/scripts/buildsystems/vcpkg.cmake CACHE STRING "Vcpkg toolchain file")
 endif()
 
 find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin")
-- 
gitgitgadget
