Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CA8C2D0E0
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A68A21D7E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnFseVrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIITrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgIITrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:47:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6833C061756
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 12:47:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l9so3575179wme.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n29OMrPMZQleVOpYfjKnlKg1uoenTVJWCGf9elILLM0=;
        b=AnFseVrmdeAnkA9il6CX7dLvStCWv0rcaTMCNlwubQ7Y/Gv8+A3lmukQfqNdWdEZdn
         niMIi9j1fTw4p8yR1lqer075bk/cLeJD0TnXe5/K2BQZGo9wbLYAKbKPzzmpoT6QYmNp
         fyIm3HYJmSEF6fj+hQl//AAH7A6JL/56WkaBuSTA5WWwTDcDkyRmZR02tixxFG/0pUOZ
         6rd1evNRbEcciOuN8K8jFmM3EZlYJVTXbUqXsdIvfj2nxYohMIscQhn5WnbJ7KsMoKU6
         57M6LWcdWudwATUWCDXfJ3UzOOrxkvy2imrOyDoFjcX3n3jGcOBuMlNZMWjRlva3nAU6
         KdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n29OMrPMZQleVOpYfjKnlKg1uoenTVJWCGf9elILLM0=;
        b=tD62f1JCU9aKiVS1srt+WB1VhYtICXnEcf67Fw/xCxe8Tkfx5PTHrIHgL7Ev3P9Kq8
         K+PyBxu9KSWvMAcYJaJRqZ5pc39TUfsiYykQSf572tSCSqEjHAfVd/TX03LtDCUjN89U
         7SDEiye56D/yFuE5eU7SIpygTOGQnu0lHVD0V9BUJbqcd3pCEMn84eYb32r8hcv9oBkS
         WYVWMNjuuHFcC7CdS5zD8uhFa7XquGbdyHwh1YVMWhuL2PBa/cqQI6w1fh96J94fZcfi
         mx7OzVLhg7UEfL9VTEuxG+rw81qXab2TdESo+VccyFpRPBSmPbWYYs/2SQ+gIZf3T7rW
         j9dQ==
X-Gm-Message-State: AOAM530i2+ys+VnV1XoJ/yyX9r1Qx4zxwQT0GCxByJ+iydHk1PL0EGhr
        9I4WP5YJ46j53wtaeelemMbv41kFcnA=
X-Google-Smtp-Source: ABdhPJxnAPrmXlTr6APw3VTGhFzZguBBm35N94QEZI/wOI1Mfe4xVYfYhxftGHdWLyRZCOPUnaPSLQ==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr4923540wmh.53.1599680864102;
        Wed, 09 Sep 2020 12:47:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm5652862wrm.92.2020.09.09.12.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:47:43 -0700 (PDT)
Message-Id: <6f35562965c2fd7fd7abe4e1c7952d9acd144508.1599680861.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.694.v2.git.1599680861.gitgitgadget@gmail.com>
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
        <pull.694.v2.git.1599680861.gitgitgadget@gmail.com>
From:   "Kyohei Kadota via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Sep 2020 19:47:41 +0000
Subject: [PATCH v2 2/2] Use $(LD) instead of $(CC) for linking the object
 files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "KADOTA, Kyohei" <lufia@lufia.org>, Kyohei Kadota <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyohei Kadota <lufia@lufia.org>

Plan 9's loader(aka. linker) is separated from the compiler.
The compilers are called 8c, 6c... for each machine architectures;
corresponded loaders are called 8l, 6l...

Signed-off-by: Kyohei Kadota <lufia@lufia.org>
---
 .github/workflows/main.yml |  1 +
 Makefile                   | 15 ++++++++-------
 ci/lib.sh                  |  8 +++++++-
 config.mak.in              |  1 +
 config.mak.uname           |  6 ++++++
 5 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 30425404eb..5ece32d4fa 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -252,6 +252,7 @@ jobs:
             pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
+      LD: ${{matrix.vector.cc}}
       jobname: ${{matrix.vector.jobname}}
     runs-on: ${{matrix.vector.pool}}
     steps:
diff --git a/Makefile b/Makefile
index 86e5411f39..c0c0c280f0 100644
--- a/Makefile
+++ b/Makefile
@@ -543,6 +543,7 @@ export prefix bindir sharedir sysconfdir gitwebdir perllibdir localedir
 
 # Set our default programs
 CC = cc
+LD = cc
 AR = ar
 RM = rm -f
 DIFF = diff
@@ -2121,7 +2122,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
 git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
 help.sp help.s help.o: command-list.h
@@ -2445,17 +2446,17 @@ compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
 endif
 
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
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
 
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
@@ -2465,7 +2466,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	cp $< $@
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
@@ -2753,7 +2754,7 @@ perf: all
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
index c7eba69e54..886ce068f8 100644
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
