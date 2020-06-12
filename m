Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBA2C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4ADD20836
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDBqUptY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFLS3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgFLS3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 14:29:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91FFC08C5C2
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:29:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so10659068wrn.11
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fURAHxugl/54YAv8Vg6SRJrk5YXkw2FCbp51L+M8b5o=;
        b=aDBqUptY5crjCiEgSkY+6Ge56Hg7VBuJKmbmlt1HwNPQaryOjhutwdvs4Z4/0BuIKi
         0fNK/sVqclXOBP/MOQPRCSGd32OnC5vL95goQ4r74do0cf/DGwme3eRoMW/L7MjgDUqA
         iBhjstviTERGqq9jIhnC98odBwfUk7LPTlo4wX+h0unV0U9/IOQ87QvCx8lMaUhnRm+H
         GNgm1/ao2ZKwyP8K+3milp5XC++XR04aOk0MfVnB/C933qg798hJa3cuosfYxnH4Rb75
         0j8VUALE6KZ1RXnKttPg9BNY6g2pqzDGKR9ilM/IIsPhBjDDxXG+gJX19ZG6npIoJW6A
         SF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fURAHxugl/54YAv8Vg6SRJrk5YXkw2FCbp51L+M8b5o=;
        b=gXRTsC1iJX5WE9/CfqpdsrJQ/dyVynDgejQDYABKbME5mwgQT3gHZq2cEHGwS8uflf
         VoRUFmvynn5oGgZ12s/6ciqSB5SUzfdkpfIuenHXHR0wZVIY1urnmmcePCCfilSP6N45
         mugUzHqUlmDq11sjCPeMNaOwlGXMYCSMtoWS3RLtlJoxQM76GS43NLZQaF2fjTs1VIsZ
         TscLQUjoSPu0h1wwlDMEOJzfLxXAO7KXmnZav7LWUOqjp05ekj/eDttlqa4WKucPdU6k
         NQFApI4/sLWgLG2MkecakCkB4h1A1f0FSh8kgXHpKbpqtPcssO9qwM3dkURg5wzq09Mi
         RiCg==
X-Gm-Message-State: AOAM5311ZzlXPJBi5EjN51Uk4S3KBc0GsFUXC/+waAuQBZ9QR1jUBs5k
        1cCG/H8XQA5Tu2jKCogd9qo4KbSP
X-Google-Smtp-Source: ABdhPJyQBsTuvGBgw7mfx34nI8X/8CCsO/cq9ke6U/xF47DYof0h4fEjH4fmhqQQrpYcCQu/CC8fyg==
X-Received: by 2002:adf:a157:: with SMTP id r23mr17044426wrr.92.1591986571419;
        Fri, 12 Jun 2020 11:29:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g82sm10164233wmf.1.2020.06.12.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:29:30 -0700 (PDT)
Message-Id: <4a0dd23cbbf3f3f45df9ba70057827e216d8c491.1591986566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
References: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
        <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Jun 2020 18:29:21 +0000
Subject: [PATCH v4 3/8] cmake: installation support for git
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
index b3863bffee6..e8ed2439e46 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -65,6 +65,8 @@ project(git
 	VERSION ${git_version}
 	LANGUAGES C)
 
+#TODO gitk git-gui gitweb
+#TODO Add pcre support
 
 #macros for parsing the Makefile for sources and scripts
 macro(parse_makefile_for_sources list_var regex)
@@ -698,3 +700,50 @@ if(MSGFMT_EXE)
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

