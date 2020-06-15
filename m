Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D8EC433E1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F28207F5
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 14:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfqmZJH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgFOOBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbgFOOBE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 10:01:04 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF203C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:01:03 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so19339948ljn.4
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4BQDDUNEeqvxzkuPfYERNXVVPIxZgIBJdfiqH97QCw=;
        b=lfqmZJH11C95xeyUoTUmKwNVxtGsyIGtQBZGvLzt+ZatbVAwEf8GJYHRrQ7e2VpYF6
         NGAVJBX2/QV6KkuTcGCqxLi3uNMgyNPHApTCLRn2wvzpIONqO/o88DqOsPQVW6WIpbkZ
         0bpRNk+NkrJHzYjX1P1FTZ/vMEjdiDzR7FDcObV0Jbnm57w9TLxUCAAsupmkMc8Nmu/C
         4uOllRQwToq4xkgWg4HwrA2mSZY7Co/p0iRczmieWYFjaT3a1yla4Rkw31JSWokaINjS
         saZLnbEFbGWYiexl562zug2lquPOdzltwoxTAn4njqmcwg/dJ5SHp4q7MQHlhR0R26mk
         Wlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4BQDDUNEeqvxzkuPfYERNXVVPIxZgIBJdfiqH97QCw=;
        b=NPPAK19hoSB/f59WscfDC5SpLlmXlMAyJszqZPqFTWn1jcDEo1DvytrcGI1Jqko7Mi
         +OEC98oSDSIUehctaNJPG0GfcyRqIue1Gc2Xj0Jh7F76V4Ghl4CVggvaHA1oN+TIL5l6
         8ftiphaanbgZOKuKpHFF5/w6IOEkzPzrwv5EOJ6YGS2w/8hVuEas42/F7T/E3yD11D4U
         ngUU/Z9GKDBPOm0KAsTDi//el9L7wOkgmnOctHaIu7kqlAVxU3hJoNoUIgv8/EyaJQw0
         zlfq2ppV68k6gS7V8/LmJrmdE+jAvH+l8liiihY2XOMjmWmQKObNepXtqt8Aw7RW5JeQ
         OI6A==
X-Gm-Message-State: AOAM531gPz2G/epZ4ZalDLvK8NFFQRbTs1sp+gn08GLNpOrw9IwrmpE0
        N3KS7XCH7drrqRPhV+aB7/k=
X-Google-Smtp-Source: ABdhPJyp/0i4fhaQBOabqYN5KzNGVouUhCOT0FglT+PzeJMYSzbPGHNhy0mnd45d69SIazOiS/OYUQ==
X-Received: by 2002:a05:651c:1213:: with SMTP id i19mr12066109lja.116.1592229660857;
        Mon, 15 Jun 2020 07:01:00 -0700 (PDT)
Received: from no92wrk-walle.osl.infront.as ([195.204.99.197])
        by smtp.gmail.com with ESMTPSA id l22sm3820080lji.120.2020.06.15.07.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:00:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sibisiddharthan.github@gmail.com,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: Re: [PATCH v4 1/8] Introduce CMake support for configuring Git
Date:   Mon, 15 Jun 2020 16:00:49 +0200
Message-Id: <20200615140049.1647-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <c4e1ba74464cfae882cde646d3c79778244b8f5e.1591986566.git.gitgitgadget@gmail.com>
References: <c4e1ba74464cfae882cde646d3c79778244b8f5e.1591986566.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I haven't been able to pay much attention lately. I see this is v4 of this
patch series and thought I took a quick look and didn't find anything, it's
possible some of this has been addressed already. If so I apologize.

> So let's start building CMake support for Git.

Yay!

> +
> +Instructions to run CMake:
> +
> +cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
> +Eg.
> +From the root of git source tree
> +	`cmake contrib/buildsystems/ `
> +This will build the git binaries at the root
> +
> +For out of source builds, say build in 'git/git-build/'
> +	`mkdir git-build;cd git-build; cmake ../contrib/buildsystems/`
> +This will build the git binaries in git-build directory
> +

Since the mininum required version is sufficiently high I suggest you
recommend the following as well:

    cmake -B build-dir -S contrib/buildsystems

This might be easier for scripted tasks (packaging and whatnot) since cd
and mkdir aren't necessary.

> +#set the source directory to root of git
> +set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)

See if you can avoid this. This this will break if another project includes Git
as part of itself with add_subdirectory() or the ExternalProject module. If all
you use it for is paths to other files then you might as well do this:

    set(repo_root "${CMAKE_CURRENT_LIST_DIR}/../..")

and use ${repo_root} the places you use ${CMAKE_SOURCE_DIR} now.

AFAIK the places CMake accepts relative paths it's usually relative to
CMAKE_CURRENT_SOURCE_DIR and not CMAKE_SOURCE_DIR, anyway. I don't think it's
automagically updated when CMAKE_SOURCE_DIR is changed.

> +include_directories(SYSTEM ${ZLIB_INCLUDE_DIRS})
> +if(CURL_FOUND)
> +	include_directories(SYSTEM ${CURL_INCLUDE_DIRS})
> +endif()

This is better handled like this these days:

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 8367b73e94..ca1f90e58c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -121,10 +121,6 @@ if(NOT Intl_FOUND)
 	endif()
 endif()
 
-include_directories(SYSTEM ${ZLIB_INCLUDE_DIRS})
-if(CURL_FOUND)
-	include_directories(SYSTEM ${CURL_INCLUDE_DIRS})
-endif()
 if(EXPAT_FOUND)
 	include_directories(SYSTEM ${EXPAT_INCLUDE_DIRS})
 endif()
@@ -606,7 +602,7 @@ endif()
 #link all required libraries to common-main
 add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
 
-target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
+target_link_libraries(common-main libgit xdiff ZLIB::ZLIB)
 if(Intl_FOUND)
 	target_link_libraries(common-main ${Intl_LIBRARIES})
 endif()
@@ -659,17 +655,17 @@ if(CURL_FOUND)
 	add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/http.c)
 
 	add_executable(git-imap-send ${CMAKE_SOURCE_DIR}/imap-send.c)
-	target_link_libraries(git-imap-send http_obj common-main ${CURL_LIBRARIES})
+	target_link_libraries(git-imap-send http_obj common-main CURL::libcurl)
 
 	add_executable(git-http-fetch ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/http-fetch.c)
-	target_link_libraries(git-http-fetch http_obj common-main ${CURL_LIBRARIES})
+	target_link_libraries(git-http-fetch http_obj common-main CURL::libcurl)
 
 	add_executable(git-remote-http ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/remote-curl.c)
-	target_link_libraries(git-remote-http http_obj common-main ${CURL_LIBRARIES} )
+	target_link_libraries(git-remote-http http_obj common-main CURL::libcurl)
 
 	if(EXPAT_FOUND)
 		add_executable(git-http-push ${CMAKE_SOURCE_DIR}/http-push.c)
-		target_link_libraries(git-http-push http_obj common-main ${CURL_LIBRARIES} ${EXPAT_LIBRARIES})
+		target_link_libraries(git-http-push http_obj common-main CURL::libcurl ${EXPAT_LIBRARIES})
 	endif()
 endif()
 
With this change we're feeding proper CMake targets to target_link_libraries()
instead of just a bunch of strings. CMake can know a lot about a target, such
as it's dependencies, required macros and so on[1]. This means some boilerplate
code can be removed: Notice that the manual handling of Zlib's include path is
gone. The same can perhaps be done for the other libraries as well but I
haven't checked that.

> +include_directories(${CMAKE_SOURCE_DIR})
> +(...)
> +include_directories(${CMAKE_BINARY_DIR})

See if CMAKE_INCLUDE_CURRENT_DIR[2] makes this unneeded. It might not since you
overwrite CMAKE_SOURCE_DIR manually.

Øsse

[1]: https://cmake.org/cmake/help/latest/manual/cmake-properties.7.html#properties-on-targets
[2]: https://cmake.org/cmake/help/latest/variable/CMAKE_INCLUDE_CURRENT_DIR.html
