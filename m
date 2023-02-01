Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD5C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBAXEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBAXEv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:04:51 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB769B2F
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:04:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lu11so1109910ejb.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 15:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hzrHIZQT5L2ja2fpP/pHctbH35WS72VQ+vnW0km+uY=;
        b=ENH4bTEmiOwuRQ1sU4XAj512Gd8/U56pPN0irgR+utW9/YVkieT54dyOPMdpGlHZr7
         Wzgg7yll+yolPpLWtNJU4IdLFgPoQSQG9XplvJ3cd+Y8is82QE3ZzdEV3UxCytwe24/s
         Kd/rKMUis0Gi0jbPCbjhVdlEKyyMFCHKs03oG9GPdKP7wmpKcWnv4b3hhb3mOH0xZNtT
         B1jCuqHsF/GoReUpPIf8usjG8Mrvjr4QAWL6tcbrOvxCJ40CH1cambcANPkp/PtLrpBr
         SJpiz6Lct7byYwJKzIQJsRT/aoZCcgKq2SnEOjJhsiskMXSx16kVUwTT2si2g/14iHwz
         X+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hzrHIZQT5L2ja2fpP/pHctbH35WS72VQ+vnW0km+uY=;
        b=ezg2sd5LX8pvkpYbK/xNPikD39CnAkrGES0iOOABQkLt4VY7xayYtSCB7Xh4JN+bn+
         iQIFN/eeaFJ/P+Xv6Cp8hiD+w8NXPl6Ve07Cqb1+ve6ds9TBjfeqIHK6FJha0/eZdlbi
         Wlls6SnsC8SmMau4rqI8eYBDrdArGslHwbl29NRQsyRJ7RKf8nzuThABGuNPk9HAkMyT
         r8Zdj+X5SqUDlLxj9ixtqx0h7wAmt6603DKbG6rRsX9unEisOWAeYjCkHyJltOE+gzf9
         nvJuPjBi/TPDHfxGrtd2o3DENP5JUx0qaRU9PJW/9/U4adGtO/TBR8ZmspPMjvtsS3WG
         LuQA==
X-Gm-Message-State: AO0yUKU+Qa/bFp56ts4g+iqRthAuWjWeEmt9exQfrRr6ZQi+4+/rf242
        B+VUx2riwl2yLyZ/sT8sl3ovDH5RIDhnVY6x
X-Google-Smtp-Source: AK7set/GSAT2QikHHSiyaVtAExLzSJpOnetWlMcSwe5hyhRVIX8LVHJtC6an0U0kTe0neSypJe4HkA==
X-Received: by 2002:a17:906:7c88:b0:879:2a5:dc40 with SMTP id w8-20020a1709067c8800b0087902a5dc40mr4346323ejo.76.1675292688359;
        Wed, 01 Feb 2023 15:04:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18-20020a1709067b5200b00878530f5324sm10773457ejo.90.2023.02.01.15.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:04:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] imap-send: replace auto-probe libcurl with hard dependency
Date:   Thu,  2 Feb 2023 00:04:24 +0100
Message-Id: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1301.gffb37c08dee
In-Reply-To: <20230201113133.10195-2-worldhello.net@gmail.com>
References: <20230201113133.10195-2-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "imap-send" command to have a hard dependency on libcurl,
before this it had an optional dependency on both libcurl and OpenSSL,
now only the OpenSSL dependency is optional.

This simplifies our dependency matrix my getting rid of yet another
special-case. Given the prevalence of libcurl and portability of
libcurl it seems reasonable to say that "git imap-send" cannot be used
without libcurl, almost everyone building git needs to be able to push
or pull over http(s), so they'll be building with libcurl already.

So let's remove the previous "USE_CURL_FOR_IMAP_SEND" knob. Whether we
build git-imap-send or not is now controlled by the "NO_CURL"
knob. Let's also hide the old --curl and --no-curl options, and die if
"--no-curl" is provided.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Feb 01 2023, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> [...]

I don't have any issue per-se with your proposed change, but perhaps
we can go a step further here. I've had this as part of my local build
for about a year, but never got around to submitting it.

As argued above I think we should just make curl a hard dependency for
"git-imap-send", and that furthermore it's OK to require a newer
version of curl for that utility than we do in general (as the http(s)
transports are more widely required, git-imap-send is more obscure).

 Documentation/git-imap-send.txt | 10 ---------
 INSTALL                         |  8 ++++----
 Makefile                        | 18 +++++------------
 imap-send.c                     | 36 +++++----------------------------
 4 files changed, 14 insertions(+), 58 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index f7b18515141..dcd29f011ce 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -37,16 +37,6 @@ OPTIONS
 --quiet::
 	Be quiet.
 
---curl::
-	Use libcurl to communicate with the IMAP server, unless tunneling
-	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
-	option set.
-
---no-curl::
-	Talk to the IMAP server using git's own IMAP routines instead of
-	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
-	set.
-
 
 CONFIGURATION
 -------------
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
index a50af56b827..0e36ed4f854 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -30,26 +30,16 @@
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
 
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
-	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
+	OPT_HIDDEN_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
 	OPT_END()
 };
 
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
@@ -1531,17 +1519,8 @@ int cmd_main(int argc, const char **argv)
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-#ifndef USE_CURL_FOR_IMAP_SEND
-	if (use_curl) {
-		warning("--curl not supported in this build");
-		use_curl = 0;
-	}
-#elif defined(NO_OPENSSL)
-	if (!use_curl) {
-		warning("--no-curl not supported in this build");
-		use_curl = 1;
-	}
-#endif
+	if (!use_curl)
+		die(_("the --no-curl option to imap-send has been deprecated"));
 
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
@@ -1580,10 +1559,5 @@ int cmd_main(int argc, const char **argv)
 	if (server.tunnel)
 		return append_msgs_to_imap(&server, &all_msgs, total);
 
-#ifdef USE_CURL_FOR_IMAP_SEND
-	if (use_curl)
-		return curl_append_msgs_to_imap(&server, &all_msgs, total);
-#endif
-
-	return append_msgs_to_imap(&server, &all_msgs, total);
+	return curl_append_msgs_to_imap(&server, &all_msgs, total);
 }
-- 
2.39.1.1301.gffb37c08dee

