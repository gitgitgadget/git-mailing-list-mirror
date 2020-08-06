Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EE0C433E1
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B6C22CE3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K16Lc6a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHFBFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgHFBFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 21:05:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6FCC061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 18:05:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 184so8070867wmb.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 18:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S8kn8pjI/+dxOHvK2BMvDNo0+HXwqDf+BvlJ3nxXU3M=;
        b=K16Lc6a4FFPoiwqlZL9lWOVpa14v6ILoNZfa6JHa7c9uU44RA3AZVa3qPyTkVKK7ou
         kDOvxvg5KTz5yA10p86blAjtwP9PMcyneHkISYI4+9g3fDBbrXIDTTx4DBxiFUDY4qrd
         Zs8/k/Jui3a3IGfQ7KddnNtNlMNBbTFqbnTnywCECNz2DgbFgrOMGGKec0uO47F24kjP
         ysL2sdZ+tnbU3QTO42lMo/IA0UtuAFdpv9G8dT4EXjFxl2pRoaBYn79MumaOEyVVbR9K
         HVChkjHr2aI4sbWyppolVaOBjAjvJm7FH8fpUFvj7IomNxBZo++X2PIhYJpT7sgRt5wi
         01Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S8kn8pjI/+dxOHvK2BMvDNo0+HXwqDf+BvlJ3nxXU3M=;
        b=YELqSSS8i/BI3WorrAfcRB4Ta4tRegaCpCkRe9WMByDUdCRL1NfwRfRc6eh4ZuaoZR
         ptjK3zjFlHKb8wNpGWjc/lZMToNHyj/by/8a8P8jlGppCcXwS0sYjru0lCqvUT93pm+F
         EMx6m/P/ePCaKIajJDzVNoqL1kIkx83nJpC7DEbmmsl3lNepFFWWq80sNmavlDM9Qeiz
         WkRbz1zUoklph/oySFXIJYsSXkSd34ZJjaOvaua6SibAeXDC0K59AxyN+RlWy/uWZXVs
         MfWLcWJIfgMC6e0K9lUHDq7LDGERX7MvwcDwJ39mu2em2ibFzf7ZqnJNqBeCB1peNG22
         aMuQ==
X-Gm-Message-State: AOAM533I0PiU8623sIMgxGFb76j5RqIxoWDwgbRJcKiA3ZS8G3Rm1o4W
        uy6gre4CwYPI4faDN+pxjcd/qhrO
X-Google-Smtp-Source: ABdhPJxa32So5dOEEtTwiz+Db2Z1Fb6NCPJaQI4Ud7bkAi9G31ozTbTR8LdDfQa3IR+g5zVPZs6fbw==
X-Received: by 2002:a1c:a7d1:: with SMTP id q200mr5316462wme.131.1596675909331;
        Wed, 05 Aug 2020 18:05:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 32sm4767749wrn.86.2020.08.05.18.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 18:05:08 -0700 (PDT)
Message-Id: <4ebd56a3c52c2a4a47d69d851f75deccc3ce8932.1596675905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.694.git.1596675905.gitgitgadget@gmail.com>
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 01:05:04 +0000
Subject: [PATCH 4/4] Use $(LD) instead of $(CC) for linking the object files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "KADOTA, Kyohei" <lufia@lufia.org>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

Plan 9's loader(aka. linker) is separated from the compiler.
The compilers are called 8c, 6c... for each machine architectures;
corresponded loaders are called 8l, 6l...

Signed-off-by: lufia <lufia@lufia.org>
---
 .github/workflows/main.yml |  1 +
 Makefile                   | 19 ++++++++++---------
 ci/lib.sh                  |  8 +++++++-
 config.mak.in              |  1 +
 config.mak.uname           |  6 ++++++
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 84a5dcff7a..37b006f371 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -243,6 +243,7 @@ jobs:
             pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
+      LD: ${{matrix.vector.cc}}
       jobname: ${{matrix.vector.jobname}}
     runs-on: ${{matrix.vector.pool}}
     steps:
diff --git a/Makefile b/Makefile
index e222241509..a52a05604a 100644
--- a/Makefile
+++ b/Makefile
@@ -543,6 +543,7 @@ export prefix bindir sharedir sysconfdir gitwebdir perllibdir localedir
 
 # Set our default programs
 CC = cc
+LD = cc
 AR = ar
 RM = rm -f
 DIFF = diff
@@ -2128,7 +2129,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
 git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
 help.sp help.s help.o: command-list.h
@@ -2459,25 +2460,25 @@ compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
 endif
 
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 git-bugreport$X: bugreport.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS)
 
 git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
 
 git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(LIBS)
 git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
 	$(VCSSVN_LIB)
 
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
@@ -2487,7 +2488,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	cp $< $@
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
@@ -2782,7 +2783,7 @@ t/helper/test-svn-fe$X: $(VCSSVN_LIB)
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
diff --git a/ci/lib.sh b/ci/lib.sh
index 3eefec500d..19c5beb277 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -125,6 +125,7 @@ then
 	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
 	CI_REPO_SLUG="$(expr "$BUILD_REPOSITORY_URI" : '.*/\([^/]*/[^/]*\)$')"
 	CC="${CC:-gcc}"
+	LD="$CC"
 
 	# use a subdirectory of the cache dir (because the file share is shared
 	# among *all* phases)
@@ -149,6 +150,7 @@ then
 	CI_REPO_SLUG="$GITHUB_REPOSITORY"
 	CI_JOB_ID="$GITHUB_RUN_ID"
 	CC="${CC:-gcc}"
+	LD="$CC"
 
 	cache_dir="$HOME/none"
 
@@ -184,6 +186,7 @@ linux-clang|linux-gcc)
 	if [ "$jobname" = linux-gcc ]
 	then
 		export CC=gcc-8
+		export LD="$CC"
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
@@ -207,6 +210,7 @@ osx-clang|osx-gcc)
 	if [ "$jobname" = osx-gcc ]
 	then
 		export CC=gcc-9
+		export LD="$CC"
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
@@ -222,12 +226,14 @@ GETTEXT_POISON)
 	;;
 Linux32)
 	CC=gcc
+	LD="$CC"
 	;;
 linux-musl)
 	CC=gcc
+	LD="$CC"
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3 USE_LIBPCRE2=Yes"
 	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
 	;;
 esac
 
-MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc} LD=${LD:-cc}"
diff --git a/config.mak.in b/config.mak.in
index e6a6d0f941..76ea7e781e 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -2,6 +2,7 @@
 # @configure_input@
 
 CC = @CC@
+LD = @CC@
 CFLAGS = @CFLAGS@
 CPPFLAGS = @CPPFLAGS@
 LDFLAGS = @LDFLAGS@
diff --git a/config.mak.uname b/config.mak.uname
index f3eb2b91a2..3c4c11eec1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -69,6 +69,7 @@ ifeq ($(uname_S),GNU/kFreeBSD)
 endif
 ifeq ($(uname_S),UnixWare)
 	CC = cc
+	LD = $(CC)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
@@ -90,6 +91,7 @@ ifeq ($(uname_S),SCO_SV)
 	endif
 	ifeq ($(uname_R),5)
 		CC = cc
+		LD = $(CC)
 		BASIC_CFLAGS += -Kthread
 	endif
 	NEEDS_SOCKET = YesPlease
@@ -435,6 +437,7 @@ ifeq ($(uname_S),Windows)
 	DEFAULT_HELP_FORMAT = html
 
 	CC = compat/vcbuild/scripts/clink.pl
+	LD = $(CC)
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
@@ -525,6 +528,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	ifeq ($(uname_R).$(uname_V),L17.02)
 		CC += -WRVU=L16.05
 	endif
+	LD = $(CC)
 	# Disable all optimization, seems to result in bad code, with -O or -O2
 	# or even -O1 (default), /usr/local/libexec/git-core/git-pack-objects
 	# abends on "git push". Needs more investigation.
@@ -665,8 +669,10 @@ else
 			BASIC_LDFLAGS += -Wl,--large-address-aware
 		endif
 		CC = gcc
+		LD = $(CC)
 		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 			-fstack-protector-strong
+		BASIC_LDFLAGS += -fstack-protector-strong
 		EXTLIBS += -lntdll
 		INSTALL = /bin/install
 		NO_R_TO_GCC_LINKER = YesPlease
-- 
gitgitgadget
