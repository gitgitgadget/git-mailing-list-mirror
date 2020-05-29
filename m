Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D98C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F6F206E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvp8jS3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgE2Nkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2Nka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 09:40:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FE9C08C5C8
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y17so3607478wrn.11
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OhIjPJZOf7I1KB/jyyrVj2q85xSxOK3c5hJf/Vo2MLo=;
        b=bvp8jS3jjLm4kBuD8urirOnVMzmbYOMEs7K/E2H+onXndQlpKU4y5QFJVf6q0exDKY
         orVBfVvcLpk8g7hSWpDhy1NG2jihDkHl4zebW77X8bv3KfYVCINie8WwLYiqCqhq72J9
         2PCq1RFqULlSuKtF7eKNLyvWwN920G94Y4gqiUhEnrhszYgot4eQl+yhq40o//WugiN3
         d/FnBL1ZzRnls8KzKeD5YZDJt10tzgCj4zIKaM7ji1tdENMLSTqTtR7fqrKfj3AkAsYL
         b7dViX28NOdBBprBMm+gSitklTEwvyvd8i+ZQW1KKD7+4VnHI1Aj8jPLU0qm3Lq2iuUM
         vPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OhIjPJZOf7I1KB/jyyrVj2q85xSxOK3c5hJf/Vo2MLo=;
        b=TXRH2dh+fSc8jbrMqFSgCUp5IUKEozjLJzYBgFDvMwCCQI/g81ksg4Qj0K6iMjur7X
         Dod5Y9LQc4ZscDg7595bu67ypNjai/hKl2VxtRhur23smHYAk2piIXgHLf3Y5jAtwmBw
         M8c1hhQXFNN3a1XJCdsnIzzkBP4J7gZWCndR7qOB5XdgUScdqO/OgvAf19ZgqFiHTZ0D
         1G/Djo/t3DCY5pxWUfuu9FsWA1uzY/YAsVG5tx2pzYnmz65UwPGjgzd6pRI1OmvTKg7o
         1Z2mwYmYZ5m1xE3z9/F4Wetq0y6BtiJc4VSFbUKOfbEha2zFQl2ftz4MU78XeL8W56Bl
         zU9g==
X-Gm-Message-State: AOAM531+DRrMqCl5q2dYchNi4/zMdt8myYz72l33/z8nGz3bNX8rV6Hq
        6yVgXzdRcVGkfVaedqxXerbirh4y
X-Google-Smtp-Source: ABdhPJwrsSMDJw+iNjKt4fXzoQG4Uq6o2mDXBb5I0d9y+vB6Ts4ANy5sqbvO4ue7auxFhZM2I54qzA==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr1687781wru.268.1590759628227;
        Fri, 29 May 2020 06:40:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm10024855wrw.19.2020.05.29.06.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:40:27 -0700 (PDT)
Message-Id: <6ec73d3e967f41fe145e092e542235e3bf1b9869.1590759624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 May 2020 13:40:19 +0000
Subject: [PATCH v3 3/8] cmake: installation support for git
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

Changes:
Removed a comment regarding the installation of gitk.

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 49 +++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 11c909d23e3..0cde1a02cbc 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -57,6 +57,8 @@ project(git
 	VERSION ${git_version}
 	LANGUAGES C)
 
+#TODO gitk git-gui gitweb
+#TODO Add pcre support
 
 #macros for parsing the Makefile for sources and scripts
 macro(parse_makefile_for_sources list_var regex)
@@ -682,3 +684,50 @@ if(MSGFMT_EXE)
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

