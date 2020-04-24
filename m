Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055A1C55186
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D955C20774
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYmCK/Nd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgDXEBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgDXEBn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 00:01:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DFEC09B047
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:01:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so9057453wrb.8
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LbSujEs5XRc7I6SzsBlq6sm5G3oKkNtRyS7/lMcVOJ0=;
        b=BYmCK/NdcxlFfR5WoCjQkhzeSBAViuQ8VTt239tVBNRxTCrmIc3gkqZzEYd981bTFS
         0pNJd5N/vHY0mNzPpc2d8J6LRJ2C5GxlkVoH4lBvnhW23MTy0b3+ivdUv9QGy7xvgZg4
         dCI9yOQiRQIRkgXLqX0gISM0Ng1gF+DULknytMnl98mw/EYhWdvS8tJ/TsQjjQH6zStv
         IVXNDrF/ll/vk8MwInEBts8yY90Dpwh8ZAi62LR/yWBc19AhgbZCRlfpXuhvtFh1a5/z
         uIFMeNMYc2KScuT7qzrn3lF6/aZ2EI6szyH4E7vUGPG7+PRjNQlaO7X0HrosJVbqMFvS
         P3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LbSujEs5XRc7I6SzsBlq6sm5G3oKkNtRyS7/lMcVOJ0=;
        b=pHg8l07io8a0Xyd6pgNvHRLYEtFiBXPC1Im11X/a88/mj4vi5OGc32gD8obq9Loo/g
         4b+iYDNeLBk52PzE94IWPzafA7PPbBWq5ANR1N3kbqprdrZ08oS7DirXHJ7Qk9O1ceja
         /WVjDlgXbwlwtFeuDWYn6MNCH8Vg3Ub+1wKzMdMA/NEQ60pr9sX1UWFZFWDwBj+DW1Hp
         4GpYrR3fh7k+IzF0OjthiCCyzE2SzG5GuvpVbsWW0+cEIOZEuMOZQYPuq1dXOLRgv3Lj
         PNypvBtumLBApVgzyMi3JQfW9j0CmUlq3sl0Gdaa4VfvYabT0oa87nBF/T6rSIXUo1I1
         xw7Q==
X-Gm-Message-State: AGi0PuYg3lh3o+395uzDhSygHdPff5PnC3Rd+s50lyPF2YS8heScCUbg
        CNG5HdbPWcb9FHvp60ukHSPSXZve
X-Google-Smtp-Source: APiQypL6cjFN/c9fLJPKIECbK88TTor9KTx+0qRQMUH3RpVS1VJNoMt9ni7NdB4JyXkHc2YkR4TYgg==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr9084189wrr.360.1587700901088;
        Thu, 23 Apr 2020 21:01:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17sm966635wmj.45.2020.04.23.21.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 21:01:40 -0700 (PDT)
Message-Id: <10390063a398feab86519ba4e4fd9d03f38cd0fd.1587700897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.git.1587700897.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 04:01:32 +0000
Subject: [PATCH 3/8] cmake: installation support for git
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

This patch provides the facility to install the built binaries and
scripts.

This is very similar to `make install`.
By default the destination directory(DESTDIR) is /usr/local/ on Linux
To set a custom installation path do this:
cmake `relative-path-to-srcdir`
	-DCMAKE_INSTALL_PREFIX=`preferred-install-path`

Then run `make install`

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 CMakeLists.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 788b53be873..25de5b5bc35 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -13,6 +13,8 @@ project(git
 	VERSION ${git_version}
 	LANGUAGES C)
 
+#TODO gitk git-gui gitweb
+#TODO Add pcre support
 
 include(CheckTypeSize)
 include(CheckCSourceRuns)
@@ -631,3 +633,50 @@ if(MSGFMT_EXE)
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
+install(PROGRAMS ${CMAKE_BINARY_DIR}/git-cvsserver  #${CMAKE_SOURCE_DIR}/gitk-git/gitk check
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
+install(DIRECTORY mergetools DESTINATION libexec/git-core)
+install(DIRECTORY ${CMAKE_BINARY_DIR}/perl/build/lib/ DESTINATION share/perl5
+	FILES_MATCHING PATTERN "*.pm")
+install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/templates)
+
+if(MSGFMT_EXE)
+	install(DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale DESTINATION share)
+endif()
-- 
gitgitgadget

