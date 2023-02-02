Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B363FC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjBBJpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjBBJpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:45:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423AB6B022
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:44:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h12so1106099wrv.10
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8La0wN/xIHK2Ufbt/xjrR/pRqVsyLn9u6RPoOlzSo3A=;
        b=czFHbZUlaLbxmPUp5dfYAgWk7SubycRUXMuxzydFcTPXqO5xEpmxQmKCMe9rSVwb8X
         aSjqzQE/UNDVINOVhlRl5YZPFVzyEm3g4xcMQhNbnoNgdfo6TpeTKMXJnQxWcLAgK4iD
         3k96zJbf+ymffldqdsI/JGL+Ac1Z7LX4MjD3nKyQHMSeVGHUth6WS0T8aUFtsicSJ4kf
         Yjy4kFq0DWFWv9wNlT6U17ydeTjt3E1nOYnY1+dkUAYcHf1sgYQ40fKh9aT3+vss8oPL
         8DF+cJReYwPv7+KzN3iptH8a4A5XV76KDdp9IkJE5ZF+y0gHOVXhjRq4AIkMO07aMo6y
         Jofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8La0wN/xIHK2Ufbt/xjrR/pRqVsyLn9u6RPoOlzSo3A=;
        b=BliWhRy9+lwDqRMd8xqajYHVa9bBYnRYylz7yeqO1fevXsyZRg1BIWSYxVUKy4345p
         cq7n01k0GKjZW7xt0FyS/n7DkOGDRW1pG47oszLVDkVSQer4F9P2BmqEGVOpYH6wXRbh
         gL7Ly+jpdOfG4jX544u8NTboevu/X9USg3Pl3TUZmlc/eR15W5dZ6Co8mPJ10tXxLJ6F
         ciciopPEP+p93lK3KVjZ7xLoJiidxBuOSbEohF5t2z49fRSSFzhXMIStWml5kX3oSttb
         dEQKDTpkYgC3rH4kalKRJOCCDDHRtJYw0yrVV9FRFvadHLAQxUjNwyhG8xeATi1eOtQw
         1jwg==
X-Gm-Message-State: AO0yUKUx9ctYxw0LFO75RrkjNBSYeSKUQwjo6dGEI8LJleUS/SJMHZPZ
        PwpcQ//ZyoAxIc0P05ItdKaX4ct5EI1M113U
X-Google-Smtp-Source: AK7set/PEH1TD9IBxtgj1Y3Nrcy7MfODeB+8ZNaNFAVztriR7kMvSm7ty35Xmxm61/kgcS3KCsN0RQ==
X-Received: by 2002:a05:6000:182:b0:2c3:57c5:d17d with SMTP id p2-20020a056000018200b002c357c5d17dmr4798808wrx.49.1675331066078;
        Thu, 02 Feb 2023 01:44:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm19487938wrx.115.2023.02.02.01.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:44:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] imap-send: replace auto-probe libcurl with hard dependency
Date:   Thu,  2 Feb 2023 10:44:14 +0100
Message-Id: <patch-v2-3.6-354b6a65a78-20230202T093706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "imap-send" command to have a hard dependency on libcurl,
before this it had an optional dependency on both libcurl and OpenSSL,
now only the OpenSSL dependency is optional.

This simplifies our dependency matrix by getting rid of yet another
special-case. Given the prevalence of libcurl and portability of
libcurl it seems reasonable to say that "git imap-send" cannot be used
without libcurl, almost everyone building git needs to be able to push
or pull over http(s), so they'll be building with libcurl already.

So let's remove the previous "USE_CURL_FOR_IMAP_SEND" knob. Whether we
build git-imap-send or not is now controlled by the "NO_CURL"
knob.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/imap.txt   |  3 +--
 Documentation/git-imap-send.txt |  3 +--
 INSTALL                         |  8 ++++----
 Makefile                        | 18 +++++-------------
 imap-send.c                     | 23 ++---------------------
 5 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/Documentation/config/imap.txt b/Documentation/config/imap.txt
index 96b1c0927d8..7f30080c409 100644
--- a/Documentation/config/imap.txt
+++ b/Documentation/config/imap.txt
@@ -37,7 +37,6 @@ imap.preformattedHTML::
 
 imap.authMethod::
 	Specify authenticate method for authentication with IMAP server.
-	If Git was built with the NO_CURL option, or if your curl version is older
-	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
+	If you're running git-imap-send with the `--no-curl`
 	option, the only supported method is 'CRAM-MD5'. If this is not set
 	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index f7b18515141..202e3e59094 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -44,8 +44,7 @@ OPTIONS
 
 --no-curl::
 	Talk to the IMAP server using git's own IMAP routines instead of
-	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
-	set.
+	using libcurl.
 
 
 CONFIGURATION
diff --git a/INSTALL b/INSTALL
index d5694f8c470..d9538bbcb45 100644
--- a/INSTALL
+++ b/INSTALL
@@ -129,13 +129,13 @@ Issues of note:
 	  itself, e.g. Digest::MD5, File::Spec, File::Temp, Net::Domain,
 	  Net::SMTP, and Time::HiRes.
 
-	- git-imap-send needs the OpenSSL library to talk IMAP over SSL if
-	  you are using libcurl older than 7.34.0.  Otherwise you can use
-	  NO_OPENSSL without losing git-imap-send.
+	- git-imap-send needs libcurl 7.34.0 or newer, in addition
+	  OpenSSL is needed if using the "imap.tunnel" open to tunnel
+	  over SSL. Define NO_OPENSSL to omit the OpenSSL prerequisite.
 
 	- "libcurl" library is used for fetching and pushing
 	  repositories over http:// or https://, as well as by
-	  git-imap-send if the curl version is >= 7.34.0. If you do
+	  git-imap-send. If you do
 	  not need that functionality, use NO_CURL to build without
 	  it.
 
diff --git a/Makefile b/Makefile
index 45bd6ac9c3e..b08a855198c 100644
--- a/Makefile
+++ b/Makefile
@@ -773,7 +773,9 @@ PROGRAMS += $(EXTRA_PROGRAMS)
 
 PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += http-backend.o
+ifndef NO_CURL
 PROGRAM_OBJS += imap-send.o
+endif
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 .PHONY: program-objs
@@ -1583,7 +1585,6 @@ ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
 
-IMAP_SEND_BUILDDEPS =
 IMAP_SEND_LDFLAGS =
 
 ifdef NO_CURL
@@ -1592,6 +1593,7 @@ ifdef NO_CURL
 	REMOTE_CURL_ALIASES =
 	REMOTE_CURL_NAMES =
 	EXCLUDED_PROGRAMS += git-http-fetch git-http-push
+	EXCLUDED_PROGRAMS += git-imap-send
 else
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
@@ -1617,19 +1619,9 @@ else
 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
 	PROGRAM_OBJS += http-fetch.o
 	PROGRAMS += $(REMOTE_CURL_NAMES)
+	IMAP_SEND_LDFLAGS += $(CURL_LIBCURL)
 	ifndef NO_EXPAT
 		PROGRAM_OBJS += http-push.o
-	endif
-	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
-	ifeq "$(curl_check)" "072200"
-		USE_CURL_FOR_IMAP_SEND = YesPlease
-	endif
-	ifdef USE_CURL_FOR_IMAP_SEND
-		BASIC_CFLAGS += -DUSE_CURL_FOR_IMAP_SEND
-		IMAP_SEND_BUILDDEPS = http.o
-		IMAP_SEND_LDFLAGS += $(CURL_LIBCURL)
-	endif
-	ifndef NO_EXPAT
 		ifdef EXPATDIR
 			BASIC_CFLAGS += -I$(EXPATDIR)/include
 			EXPAT_LIBEXPAT = -L$(EXPATDIR)/$(lib) $(CC_LD_DYNPATH)$(EXPATDIR)/$(lib) -lexpat
@@ -2786,7 +2778,7 @@ endif
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
+git-imap-send$X: imap-send.o http.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
 
diff --git a/imap-send.c b/imap-send.c
index b7902babd4c..26f8f01e97a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -30,20 +30,10 @@
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
 #endif
-#ifdef USE_CURL_FOR_IMAP_SEND
 #include "http.h"
-#endif
-
-#if defined(USE_CURL_FOR_IMAP_SEND)
-/* Always default to curl if it's available. */
-#define USE_CURL_DEFAULT 1
-#else
-/* We don't have curl, so continue to use the historical implementation */
-#define USE_CURL_DEFAULT 0
-#endif
 
 static int verbosity;
-static int use_curl = USE_CURL_DEFAULT;
+static int use_curl = 1;
 
 static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
 
@@ -1396,7 +1386,6 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	return 0;
 }
 
-#ifdef USE_CURL_FOR_IMAP_SEND
 static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 {
 	CURL *curl;
@@ -1515,7 +1504,6 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	return res != CURLE_OK;
 }
-#endif
 
 int cmd_main(int argc, const char **argv)
 {
@@ -1531,12 +1519,7 @@ int cmd_main(int argc, const char **argv)
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-#ifndef USE_CURL_FOR_IMAP_SEND
-	if (use_curl) {
-		warning("--curl not supported in this build");
-		use_curl = 0;
-	}
-#elif defined(NO_OPENSSL)
+#if defined(NO_OPENSSL)
 	if (!use_curl) {
 		warning("--no-curl not supported in this build");
 		use_curl = 1;
@@ -1580,10 +1563,8 @@ int cmd_main(int argc, const char **argv)
 	if (server.tunnel)
 		return append_msgs_to_imap(&server, &all_msgs, total);
 
-#ifdef USE_CURL_FOR_IMAP_SEND
 	if (use_curl)
 		return curl_append_msgs_to_imap(&server, &all_msgs, total);
-#endif
 
 	return append_msgs_to_imap(&server, &all_msgs, total);
 }
-- 
2.39.1.1392.g63e6d408230

