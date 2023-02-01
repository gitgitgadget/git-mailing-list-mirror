Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EF4C636D4
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 11:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBALbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 06:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBALbs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 06:31:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92A714E8C
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 03:31:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id m2so13141689plg.4
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 03:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV5iY8IF77qyhKNQCv8BS8boPxDmNUjlv+M7NhVd2ic=;
        b=PynnrcUpsn5A5raOKmKjtBflZQpIweNe3YSP8ofNH6YzwgiHz0KkIopeCCzWkDjkG4
         fVlB+Pjg1/jai/+ixyT6fx230cE5Ll6Mul0VQxxm2ULMbrEnJUuXiX7DOHZ8q2vmINLu
         8cc/hgD8Gt5f7gVanpBpqGEb/Di9t/lxN2DiYYXqJ4e8LEZSk2tLj+EVRgptPUT+MzoK
         wi/vZ8QX51dR3xJ/dxVNa+2izsFBr3zzRNzmhd21kHw6bt1k9y0L/Uw1LOOYNzw3YMEE
         i1/1cx5xCYp5+NP7NYRxkYTr01LFQoLVMulTIiYhhGZHnrxbmQNOk46qS8t1AYmakZGb
         Ltxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eV5iY8IF77qyhKNQCv8BS8boPxDmNUjlv+M7NhVd2ic=;
        b=5AO9m4RoKNZ/wwXcmzPOqOUTMKSIwN39LgpWo2rXbAfy6UQCwM4N6sqabpzyNh6FXZ
         x9B5MTjL2E7rvyIJVF37NfpjEKEsV+zPqybbkxbA+bAqdG3z20xCdO0eTL4sRON5F0Q/
         MXbYUfKp5PtVVpRoGDtCkkFt5Tpz0Ji+3m8Ok9wiDgihhDP6hyfmxOS89sSGp9hxDbuF
         djvEXv+qfPjj4QvW/o7Yl+hEqQv97Vn6jdLgkkF5YTgEb9RaOuBaFwF5j2kG0PYb3IsK
         i8TLkL6kE90lFoVtL6fh342j0LuIjNQswdwpTPu8HumuVkgeC77vIxWed570XbPbxBYy
         baUA==
X-Gm-Message-State: AO0yUKVS5zi7cfZo6B+5VR0Z7t7niHqPU6JgNI5XIbaxaz8t4H8/0+N7
        9JjZKK6Ewj6k9O9ckWqpw0GLbL9rv1U=
X-Google-Smtp-Source: AK7set9jfGnnskuzPF6yEZiAQ18A9YP/qsAFvkliUBetunoeGhm3+C/o2md6Wg+BbVAHDIQf/Eo/0w==
X-Received: by 2002:a17:903:2013:b0:198:b54c:8fd1 with SMTP id s19-20020a170903201300b00198b54c8fd1mr552029pla.58.1675251106226;
        Wed, 01 Feb 2023 03:31:46 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b00195f0fb0c18sm11641579plq.31.2023.02.01.03.31.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2023 03:31:45 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 2/2] imap-send: not define USE_CURL_FOR_IMAP_SEND in Makefile
Date:   Wed,  1 Feb 2023 19:31:33 +0800
Message-Id: <20230201113133.10195-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20230201113133.10195-1-worldhello.net@gmail.com>
References: <20230201113133.10195-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The definition and using of macro "USE_CURL_FOR_IMAP_SEND" are at
different locations. It is defined in Makefile and is used in file
"imap-send.c". Even though we have fixed the mismatched "curl_config"
issue in Makefile in the previous commit, moving the definition of the
macro "USE_CURL_FOR_IMAP_SEND" to souce code "imap-send.c" seems more
nature and may help us to use curl in imap-send by force in future by
removing "USE_CURL_FOR_IMAP_SEND".

The side effect of this change is that the "git-imap-send" program may
be larger than necessary if we have a lower version of libcurl
installed.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile                            | 11 ++---------
 contrib/buildsystems/CMakeLists.txt |  3 ---
 imap-send.c                         | 29 +++++++++++++++++------------
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index f4eaf22523..83721216fc 100644
--- a/Makefile
+++ b/Makefile
@@ -1621,15 +1621,8 @@ else
 	ifndef NO_EXPAT
 		PROGRAM_OBJS += http-push.o
 	endif
-	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
-	ifeq "$(curl_check)" "072200"
-		USE_CURL_FOR_IMAP_SEND = YesPlease
-	endif
-	ifdef USE_CURL_FOR_IMAP_SEND
-		BASIC_CFLAGS += -DUSE_CURL_FOR_IMAP_SEND
-		IMAP_SEND_BUILDDEPS = http.o
-		IMAP_SEND_LDFLAGS += $(CURL_LIBCURL)
-	endif
+	IMAP_SEND_BUILDDEPS = http.o
+	IMAP_SEND_LDFLAGS += $(CURL_LIBCURL)
 	ifndef NO_EXPAT
 		ifdef EXPATDIR
 			BASIC_CFLAGS += -I$(EXPATDIR)/include
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2f6e0197ff..d508db4d29 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -622,9 +622,6 @@ if(NOT CURL_FOUND)
 	message(WARNING "git-http-push and git-http-fetch will not be built")
 else()
 	list(APPEND PROGRAMS_BUILT git-http-fetch git-http-push git-imap-send git-remote-http)
-	if(CURL_VERSION_STRING VERSION_GREATER_EQUAL 7.34.0)
-		add_compile_definitions(USE_CURL_FOR_IMAP_SEND)
-	endif()
 endif()
 
 if(NOT EXPAT_FOUND)
diff --git a/imap-send.c b/imap-send.c
index a50af56b82..c0a2c2b4e6 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -30,20 +30,25 @@
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
 #endif
-#ifdef USE_CURL_FOR_IMAP_SEND
+#ifdef NO_CURL
+#define USE_CURL_FOR_IMAP_SEND 0
+#else
 #include "http.h"
-#endif
-
-#if defined(USE_CURL_FOR_IMAP_SEND)
-/* Always default to curl if it's available. */
-#define USE_CURL_DEFAULT 1
+/*
+ * Since version 7.30.0, libcurl's API has been able to communicate with
+ * IMAP servers, and curl's CURLOPT_LOGIN_OPTIONS (enabling IMAP
+ * authentication) parameter is available if curl's version is >= 7.34.0,
+ * Always use curl if there is a matching libcurl.
+ */
+#if LIBCURL_VERSION_NUM >= 0x072200
+#define USE_CURL_FOR_IMAP_SEND 1
 #else
-/* We don't have curl, so continue to use the historical implementation */
-#define USE_CURL_DEFAULT 0
+#define USE_CURL_FOR_IMAP_SEND 0
+#endif
 #endif
 
 static int verbosity;
-static int use_curl = USE_CURL_DEFAULT;
+static int use_curl = USE_CURL_FOR_IMAP_SEND;
 
 static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
 
@@ -1396,7 +1401,7 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	return 0;
 }
 
-#ifdef USE_CURL_FOR_IMAP_SEND
+#if USE_CURL_FOR_IMAP_SEND
 static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 {
 	CURL *curl;
@@ -1531,7 +1536,7 @@ int cmd_main(int argc, const char **argv)
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-#ifndef USE_CURL_FOR_IMAP_SEND
+#if !USE_CURL_FOR_IMAP_SEND
 	if (use_curl) {
 		warning("--curl not supported in this build");
 		use_curl = 0;
@@ -1580,7 +1585,7 @@ int cmd_main(int argc, const char **argv)
 	if (server.tunnel)
 		return append_msgs_to_imap(&server, &all_msgs, total);
 
-#ifdef USE_CURL_FOR_IMAP_SEND
+#if USE_CURL_FOR_IMAP_SEND
 	if (use_curl)
 		return curl_append_msgs_to_imap(&server, &all_msgs, total);
 #endif
-- 
2.38.2.109.g8b8c02ffae.agit.6.7.7.dev

