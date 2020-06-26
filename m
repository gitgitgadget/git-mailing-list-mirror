Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA3C433E1
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEADD206BE
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEtTdOL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgFZQLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgFZQLo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 12:11:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0403C03E97B
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so9890510wmh.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/x5FPheG6hWCDJpCrV/NwBbEBPFC4LMt/4ECm57rE68=;
        b=qEtTdOL6kyq4thfDp29qmD9ZQN48UK9NhG+Uwa6HHb8iMnpRqarN787b+iONjGIzDO
         7LWI/ZSxPxrIOywF87EDO1RIOXX9Lipp0NUsqLu9cA3kbBDanT5N2juEczDb6YmAuQOX
         cyBUFvumNi/m7+4qSyNASLALrf6iZAGk8V/sLpy/n5E/s1VcoOocxN4kaDLYpy2FwX1D
         2OThGTzP16wlmraQC8SADYSe98mk/BOYtTf8BbYFWCzIwyCysdYMMmlWCiYzJlqFgfFz
         WPcLvvtuzJ/GIckI6BNd3QrfoFSLTKzCtrinbzDLeb218s9abPPSnr+9O2TmYEz40rP8
         vDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/x5FPheG6hWCDJpCrV/NwBbEBPFC4LMt/4ECm57rE68=;
        b=XFR+eVHHCUmamWWqRH4N7DYe7hiOMsN47dbHIHulZgh12x095Va/z5SgXYAqAC6oEW
         Z6faOpumigARmTPzFCftesMAuVeT4d7YNnJ75E1cOvbgC91DhtbwWqZo1cWMfykLeygw
         fWG+5oxrWDW9fUNiF7LEHAgFAkIR2IDfb6jQEKkkvn49IUv6XEdVqpi57IuX1wxJDpwf
         P2aIBOmr7FjpTHKiQ7JUSqmubWAGs/uJX8zrGHjNQeVzG+sWbuzT7oMYK3OWLIRcP6EJ
         GA2wLcuz3kl+zE5axaCuvEn4yunJOsB5NN0ugdHrLf2LRMaHepehGFkZfKZ8jyhEnoRN
         mWnA==
X-Gm-Message-State: AOAM533Vy+CAnRkEr2FtAdZ4eW5VauBry16b4QK8bqvlRTUXIurkctfF
        D2egQSkHFCFhrDKqazo4iGFZ+Noo
X-Google-Smtp-Source: ABdhPJwjmDPLTC2151LGwiaMHPDlfUW9Rg1xWBZ2DQPOVxN6rZyf3sXxpBUxeJ17iGaKrhfq+1MUMA==
X-Received: by 2002:a1c:b386:: with SMTP id c128mr4401610wmf.133.1593187903247;
        Fri, 26 Jun 2020 09:11:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm16910898wmh.26.2020.06.26.09.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 09:11:42 -0700 (PDT)
Message-Id: <a60e7472d31a24bb5517649e6fdf69e5b8af29d4.1593187898.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
References: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
        <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 16:11:33 +0000
Subject: [PATCH v5 3/8] cmake: installation support for git
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

Install the built binaries and scripts using CMake

This is very similar to `make install`.
By default the destination directory(DESTDIR) is /usr/local/ on Linux
To set a custom installation path do this:
cmake `relative-path-to-srcdir`
	-DCMAKE_INSTALL_PREFIX=`preferred-install-path`

Then run `make install`

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 49 +++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 6c5bb4e233..bc9258cf3b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -65,6 +65,8 @@ project(git
 	VERSION ${git_version}
 	LANGUAGES C)
 
+#TODO gitk git-gui gitweb
+#TODO Add pcre support
 
 #macros for parsing the Makefile for sources and scripts
 macro(parse_makefile_for_sources list_var regex)
@@ -699,3 +701,50 @@ if(MSGFMT_EXE)
 	endforeach()
 	add_custom_target(po-gen ALL DEPENDS ${po_gen})
 endif()
+
+
+#to help with the install
+list(TRANSFORM git_shell_scripts PREPEND "${CMAKE_BINARY_DIR}/")
+list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
+
+#install
+install(TARGETS git git-shell
+	RUNTIME DESTINATION bin)
+install(PROGRAMS ${CMAKE_BINARY_DIR}/git-cvsserver
+	DESTINATION bin)
+
+list(REMOVE_ITEM PROGRAMS_BUILT git git-shell)
+install(TARGETS ${PROGRAMS_BUILT}
+	RUNTIME DESTINATION libexec/git-core)
+
+set(bin_links
+	git-receive-pack git-upload-archive git-upload-pack)
+
+foreach(b ${bin_links})
+install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/bin/${b})")
+endforeach()
+
+install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git)")
+install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-shell)")
+
+foreach(b ${git_links})
+	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
+	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
+endforeach()
+
+foreach(b ${git_http_links})
+	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
+	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
+endforeach()
+
+install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
+	DESTINATION libexec/git-core)
+
+install(DIRECTORY ${CMAKE_SOURCE_DIR}/mergetools DESTINATION libexec/git-core)
+install(DIRECTORY ${CMAKE_BINARY_DIR}/perl/build/lib/ DESTINATION share/perl5
+	FILES_MATCHING PATTERN "*.pm")
+install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/templates)
+
+if(MSGFMT_EXE)
+	install(DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale DESTINATION share)
+endif()
-- 
gitgitgadget

