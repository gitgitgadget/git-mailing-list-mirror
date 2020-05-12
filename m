Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD703C47077
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE37420720
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7pdrIj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgELQvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgELQvC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:51:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85669C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so22602987wmk.5
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SaDbDWKgn+XsEkMK7SpA8xeep5C1W+WmcG91ULWvzRs=;
        b=c7pdrIj9uhX8QDRtryr+GhBhy6FZJjxAGMgDUg+C/n08wYJJf57I3KsAhxg/t67MOQ
         kUqIqdCvqLQlHigFwtMHVptSE6M+5o7ZfimREs8ktv9aC4qIVMpNpqfZA6csuqFMlCvY
         f4Gtc4Cge4IuIWtnVU/D2hwC5Rg9Du8OeXr/dmDi078dmeDDzK6QzZF9Ol5UxdkLuCg1
         8fk6csNmfgI4OCeBFmABzCxpd9NYgRuE/lR1DB0GIVToytOMXcJr43nMymZX+pBlvvcO
         YEfOk1LhrXW4pFoZ3LqMkMVmznJxVfofJZo6QdNQKljROJELn5BLx4PUd/pDYoI7jWbD
         wOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SaDbDWKgn+XsEkMK7SpA8xeep5C1W+WmcG91ULWvzRs=;
        b=ktbJ8Nr67rk14DmXlC1jexaqTCNR4B2TbfXcrvGefbdb5AsSoJLBepa5DQZfbdKP1R
         EZKPSnM3Pjt/6lZXOhAlMZheBZ9ErygkG87F/PGHr8z1BGlM7JNB3FcPLqw9HipYHzyA
         2/opzz8iXbWB326DeIDidB20HYsRp8rpe7bK447Anv9b6oN5H3uBSjBCSQ4EGMAIdV4n
         0AOeSHge1LNotlFJrYSLcF8lx/Q0fIfN+7ohNW/HAr/6OBJjYPpkAxMdAcu4dsrWRaiE
         W2xxb/zMINwYUWk5XHp3ujWuR0v2D50V3uM9/m4+xYWA3sxxpc6x0qAmPj8P2lypHErm
         0dQA==
X-Gm-Message-State: AGi0PubugjjyLMnrb9Cg6s8ubZonFQ1jeyYCXufAtNTfwIdwFUgx+y8w
        GvI7hPkQpuQGx7gbldrDszCSFLbt
X-Google-Smtp-Source: APiQypI75EkP79Ujfgg7SclzC+LWBroeTtZXGcwdjiHSmrPhw5Xd7AhnOI82RPYi2tIZVLqmL+DzFg==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr40617511wmi.83.1589302259132;
        Tue, 12 May 2020 09:50:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9sm8277841wmb.34.2020.05.12.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:50:58 -0700 (PDT)
Message-Id: <b2974432d771e735e69a8724a59fb25da88f0bf9.1589302254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:50:46 +0000
Subject: [PATCH v2 03/11] cmake: installation support for git
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

Changes:
Removed a comment regarding the installation of gitk.

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 CMakeLists.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 788b53be873..1e9f2fe8ff6 100644
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

