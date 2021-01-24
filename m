Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A8C433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F1D225AC
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbhAXB7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 20:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbhAXB7V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 20:59:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EBBC061786
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 17:58:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g10so8791655wrx.1
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 17:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkLiDRvjYWqB9ua1Icgt5+S/Nsn+lGMOV0tzbjTodbI=;
        b=jaHfcPTd75nQvNAz/eV8ueRkZ4CZdJ7y7uLJGMLLvZtLZv/y/PvDhdDzlDSmui//Y7
         UkHxEBitBlD3fTbhOROtj2efQ9WE+l+akeGSkwAYfL4TOGGB4r/prTfE4V81yJ1mzLAr
         0IEmjOvuRMMzBTbkCOQq1RAdKREd3nonJ0j6m8QEoyIYXYRoticuPIirRZ0QEkEdkvEq
         vU1w5jwPIUN0utUpd5h/X7Pt8BGS8UOlO51qyep1QxxkH6vfHdsTfFq5yd4k/9Bef3ko
         hFd0SPQw7XhD80XNUAvBadx1Kzw0EywMgSq8mXntfaOFHzcYkE9ldgbtjbKWI2vevcf3
         UsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkLiDRvjYWqB9ua1Icgt5+S/Nsn+lGMOV0tzbjTodbI=;
        b=JtpiLhHbeFsqIADPE13NBJImVSuRvEj14GDb3nAnYdXvOCPSaz4nd2Bmg4ZP+97phX
         WNUuB9pYMEv2CUFbmkOIpogflYYAg+BslWGGLGJ4pZxJyj4/YqTBXbml8xevJGoCmR1S
         9zZchMPH44ggB4Gs/YVCJXkW/sk1TLscCDAA02EXgq2twVvs9ANAXBvJ4XBrmZkoWB2t
         I3P9prlR24xxOG0vSfI+C76anD8TDY+URqIj5yBdrZQIfDtgYA/iozsrH2wM31Spv16O
         IvhkCNWJcmL9AQ8YjWUp+FKdcisPsEr5yY5eB5JX4uhyBNIDZpEqeO3u5FaDGE12/rsD
         kRPA==
X-Gm-Message-State: AOAM531Z3oYzaxGmrFK2rABaCnWTNN5v5n6uLlOCCznFPNmIDSfqiLuB
        ZgYYWx0U/a+qv5ZmZjQ2JJ9zAcWAoUs/cA==
X-Google-Smtp-Source: ABdhPJwOJVmq+t7+rpYDmi4ydvEFajNy0rnU9s1r5Dg0InyaAJTEtiMEdxPewMWUhsTZMusWTatMHg==
X-Received: by 2002:a5d:6a85:: with SMTP id s5mr873374wru.283.1611453519146;
        Sat, 23 Jan 2021 17:58:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s19sm19810139wrf.72.2021.01.23.17.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 17:58:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] Remove support for v1 of the PCRE library
Date:   Sun, 24 Jan 2021 02:58:33 +0100
Message-Id: <20210124015833.2753-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210124015833.2753-1-avarab@gmail.com>
References: <20210124015833.2753-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove support for using version 1 of the PCRE library. Its use has
been discouraged by upstream for a long time, and it's in a
bugfix-only state.

Anyone who was relying on v1 in particular got a nudge to move to v2
in e6c531b808 (Makefile: make USE_LIBPCRE=YesPlease mean v2, not v1,
2018-03-11), which was first released as part of v2.18.0.

With this the LIBPCRE2 test prerequisites is redundant to PCRE. But
I'm keeping it for self-documentation purposes, and to avoid conflict
with other in-flight PCRE patches.

I'm also not changing all of our own "pcre2" names to "pcre", i.e. the
inverse of 6d4b5747f0 (grep: change internal *pcre* variable &
function names to be *pcre1*, 2017-05-25). I don't see the point, and
it makes the history/blame harder to read. Maybe if there's ever a
PCRE v3...

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                            |  32 ++------
 configure.ac                        |  51 ++----------
 contrib/buildsystems/CMakeLists.txt |   4 -
 grep.c                              | 119 +---------------------------
 grep.h                              |  14 ----
 t/README                            |  12 ---
 t/test-lib.sh                       |   3 +-
 7 files changed, 18 insertions(+), 217 deletions(-)

diff --git a/Makefile b/Makefile
index 4edfda3e00..cd0ff9a040 100644
--- a/Makefile
+++ b/Makefile
@@ -29,18 +29,11 @@ all::
 # Perl-compatible regular expressions instead of standard or extended
 # POSIX regular expressions.
 #
-# USE_LIBPCRE is a synonym for USE_LIBPCRE2, define USE_LIBPCRE1
-# instead if you'd like to use the legacy version 1 of the PCRE
-# library. Support for version 1 will likely be removed in some future
-# release of Git, as upstream has all but abandoned it.
-#
-# When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if you want to
-# disable JIT even if supported by your library.
+# Only libpcre version 2 is supported. USE_LIBPCRE2 is a synonym for
+# USE_LIBPCRE, support for the old USE_LIBPCRE1 has been removed.
 #
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
-# in /foo/bar/include and /foo/bar/lib directories. Which version of
-# PCRE this points to determined by the USE_LIBPCRE1 and USE_LIBPCRE2
-# variables.
+# in /foo/bar/include and /foo/bar/lib directories.
 #
 # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
 #
@@ -1359,26 +1352,17 @@ ifdef NO_LIBGEN_H
 	COMPAT_OBJS += compat/basename.o
 endif
 
+ifdef USE_LIBPCRE1
+$(error The USE_LIBPCRE1 build option has been removed, use version 2 with USE_LIBPCRE)
+endif
+
 USE_LIBPCRE2 ?= $(USE_LIBPCRE)
 
 ifneq (,$(USE_LIBPCRE2))
-	ifdef USE_LIBPCRE1
-$(error Only set USE_LIBPCRE2 (or its alias USE_LIBPCRE) or USE_LIBPCRE1, not both!)
-	endif
-
 	BASIC_CFLAGS += -DUSE_LIBPCRE2
 	EXTLIBS += -lpcre2-8
 endif
 
-ifdef USE_LIBPCRE1
-	BASIC_CFLAGS += -DUSE_LIBPCRE1
-	EXTLIBS += -lpcre
-
-ifdef NO_LIBPCRE1_JIT
-	BASIC_CFLAGS += -DNO_LIBPCRE1_JIT
-endif
-endif
-
 ifdef LIBPCREDIR
 	BASIC_CFLAGS += -I$(LIBPCREDIR)/include
 	EXTLIBS += -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib)
@@ -2726,9 +2710,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@+
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
-	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE1)))'\' >>$@+
 	@echo USE_LIBPCRE2=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2)))'\' >>$@+
-	@echo NO_LIBPCRE1_JIT=\''$(subst ','\'',$(subst ','\'',$(NO_LIBPCRE1_JIT)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
diff --git a/configure.ac b/configure.ac
index 66aedb9288..031e8d3fee 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,16 +252,17 @@ GIT_PARSE_WITH([openssl]))
 # Define USE_LIBPCRE if you have and want to use libpcre. Various
 # commands such as log and grep offer runtime options to use
 # Perl-compatible regular expressions instead of standard or extended
-# POSIX regular expressions.
-#
-# USE_LIBPCRE is a synonym for USE_LIBPCRE2, define USE_LIBPCRE1
-# instead if you'd like to use the legacy version 1 of the PCRE
-# library. Support for version 1 will likely be removed in some future
-# release of Git, as upstream has all but abandoned it.
+# POSIX regular expressions. Only libpcre version 2 is supported.
 #
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
+
+AC_ARG_WITH(libpcre1,
+AS_HELP_STRING([--with-libpcre1],[DEPRECATED]),
+    AC_MSG_ERROR([support for --with-libpcre1 has been removed. Use --with-libpcre2!])
+    )
+
 AC_ARG_WITH(libpcre,
 AS_HELP_STRING([--with-libpcre],[synonym for --with-libpcre2]),
     if test "$withval" = "no"; then
@@ -277,22 +278,6 @@ AS_HELP_STRING([--with-libpcre],[synonym for --with-libpcre2]),
 	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
 
-AC_ARG_WITH(libpcre1,
-AS_HELP_STRING([--with-libpcre1],[support Perl-compatible regexes via libpcre1 (default is NO)])
-AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
-    if test "$withval" = "no"; then
-	USE_LIBPCRE1=
-    elif test "$withval" = "yes"; then
-	USE_LIBPCRE1=YesPlease
-    else
-	USE_LIBPCRE1=YesPlease
-	LIBPCREDIR=$withval
-	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
-        dnl USE_LIBPCRE1 can still be modified below, so don't substitute
-        dnl it yet.
-	GIT_CONF_SUBST([LIBPCREDIR])
-    fi)
-
 AC_ARG_WITH(libpcre2,
 AS_HELP_STRING([--with-libpcre2],[support Perl-compatible regexes via libpcre2 (default is NO)])
 AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
@@ -300,10 +285,6 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
         AC_MSG_ERROR([Only supply one of --with-libpcre or its synonym --with-libpcre2!])
     fi
 
-    if test -n "$USE_LIBPCRE1"; then
-        AC_MSG_ERROR([Only supply one of --with-libpcre1 or --with-libpcre2!])
-    fi
-
     if test "$withval" = "no"; then
 	USE_LIBPCRE2=
     elif test "$withval" = "yes"; then
@@ -554,25 +535,9 @@ GIT_CONF_SUBST([NEEDS_SSL_WITH_CRYPTO])
 GIT_CONF_SUBST([NO_OPENSSL])
 
 #
-# Handle the USE_LIBPCRE1 and USE_LIBPCRE2 options potentially set
-# above.
+# Handle the USE_LIBPCRE options potentially set above.
 #
 
-if test -n "$USE_LIBPCRE1"; then
-
-GIT_STASH_FLAGS($LIBPCREDIR)
-
-AC_CHECK_LIB([pcre], [pcre_version],
-[USE_LIBPCRE1=YesPlease],
-[USE_LIBPCRE1=])
-
-GIT_UNSTASH_FLAGS($LIBPCREDIR)
-
-GIT_CONF_SUBST([USE_LIBPCRE1])
-
-fi
-
-
 if test -n "$USE_LIBPCRE2"; then
 
 GIT_STASH_FLAGS($LIBPCREDIR)
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index c151dd7257..ac3dbc079a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -910,9 +910,7 @@ set(PYTHON_PATH /usr/bin/python)
 set(TAR tar)
 set(NO_CURL )
 set(NO_EXPAT )
-set(USE_LIBPCRE1 )
 set(USE_LIBPCRE2 )
-set(NO_LIBPCRE1_JIT )
 set(NO_PERL )
 set(NO_PTHREADS )
 set(NO_PYTHON )
@@ -949,8 +947,6 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TAR='${TAR}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_CURL='${NO_CURL}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_EXPAT='${NO_EXPAT}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "USE_LIBPCRE1='${USE_LIBPCRE1}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_LIBPCRE1_JIT='${NO_LIBPCRE1_JIT}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
diff --git a/grep.c b/grep.c
index efeb6dc58d..ad994d6923 100644
--- a/grep.c
+++ b/grep.c
@@ -166,11 +166,6 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 					pcre2_malloc, pcre2_free, NULL);
 #endif
 
-#ifdef USE_LIBPCRE1
-	pcre_malloc = malloc;
-	pcre_free = free;
-#endif
-
 	*opt = grep_defaults;
 
 	opt->repo = repo;
@@ -223,17 +218,7 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 		break;
 
 	case GREP_PATTERN_TYPE_PCRE:
-#ifdef USE_LIBPCRE2
 		opt->pcre2 = 1;
-#else
-		/*
-		 * It's important that pcre1 always be assigned to
-		 * even when there's no USE_LIBPCRE* defined. We still
-		 * call the PCRE stub function, it just dies with
-		 * "cannot use Perl-compatible regexes[...]".
-		 */
-		opt->pcre1 = 1;
-#endif
 		break;
 	}
 }
@@ -377,92 +362,6 @@ static int is_fixed(const char *s, size_t len)
 	return 1;
 }
 
-#ifdef USE_LIBPCRE1
-static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
-{
-	const char *error;
-	int erroffset;
-	int options = PCRE_MULTILINE;
-	int study_options = 0;
-
-	if (opt->ignore_case) {
-		if (!opt->ignore_locale && has_non_ascii(p->pattern))
-			p->pcre1_tables = pcre_maketables();
-		options |= PCRE_CASELESS;
-	}
-	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern))
-		options |= PCRE_UTF8;
-
-	p->pcre1_regexp = pcre_compile(p->pattern, options, &error, &erroffset,
-				      p->pcre1_tables);
-	if (!p->pcre1_regexp)
-		compile_regexp_failed(p, error);
-
-#if defined(PCRE_CONFIG_JIT) && !defined(NO_LIBPCRE1_JIT)
-	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
-	if (opt->debug)
-		fprintf(stderr, "pcre1_jit_on=%d\n", p->pcre1_jit_on);
-
-	if (p->pcre1_jit_on)
-		study_options = PCRE_STUDY_JIT_COMPILE;
-#endif
-
-	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, study_options, &error);
-	if (!p->pcre1_extra_info && error)
-		die("%s", error);
-}
-
-static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
-		regmatch_t *match, int eflags)
-{
-	int ovector[30], ret, flags = PCRE_NO_UTF8_CHECK;
-
-	if (eflags & REG_NOTBOL)
-		flags |= PCRE_NOTBOL;
-
-	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
-			eol - line, 0, flags, ovector,
-			ARRAY_SIZE(ovector));
-
-	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
-		die("pcre_exec failed with error code %d", ret);
-	if (ret > 0) {
-		ret = 0;
-		match->rm_so = ovector[0];
-		match->rm_eo = ovector[1];
-	}
-
-	return ret;
-}
-
-static void free_pcre1_regexp(struct grep_pat *p)
-{
-	pcre_free(p->pcre1_regexp);
-#ifdef PCRE_CONFIG_JIT
-	if (p->pcre1_jit_on)
-		pcre_free_study(p->pcre1_extra_info);
-	else
-#endif
-		pcre_free(p->pcre1_extra_info);
-	pcre_free((void *)p->pcre1_tables);
-}
-#else /* !USE_LIBPCRE1 */
-static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
-{
-	die("cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE");
-}
-
-static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
-		regmatch_t *match, int eflags)
-{
-	return 1;
-}
-
-static void free_pcre1_regexp(struct grep_pat *p)
-{
-}
-#endif /* !USE_LIBPCRE1 */
-
 #ifdef USE_LIBPCRE2
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
 {
@@ -588,11 +487,6 @@ static void free_pcre2_pattern(struct grep_pat *p)
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
 {
-	/*
-	 * Unreachable until USE_LIBPCRE2 becomes synonymous with
-	 * USE_LIBPCRE. See the sibling comment in
-	 * grep_set_pattern_type_option().
-	 */
 	die("cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE");
 }
 
@@ -693,11 +587,6 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
-	if (opt->pcre1) {
-		compile_pcre1_regexp(p, opt);
-		return;
-	}
-
 	if (p->ignore_case)
 		regflags |= REG_ICASE;
 	if (opt->extended_regexp_option)
@@ -1051,9 +940,7 @@ void free_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN: /* atom */
 		case GREP_PATTERN_HEAD:
 		case GREP_PATTERN_BODY:
-			if (p->pcre1_regexp)
-				free_pcre1_regexp(p);
-			else if (p->pcre2_pattern)
+			if (p->pcre2_pattern)
 				free_pcre2_pattern(p);
 			else
 				regfree(&p->regexp);
@@ -1116,9 +1003,7 @@ static int patmatch(struct grep_pat *p, char *line, char *eol,
 {
 	int hit;
 
-	if (p->pcre1_regexp)
-		hit = !pcre1match(p, line, eol, match, eflags);
-	else if (p->pcre2_pattern)
+	if (p->pcre2_pattern)
 		hit = !pcre2match(p, line, eol, match, eflags);
 	else
 		hit = !regexec_buf(&p->regexp, line, eol - line, 1, match,
diff --git a/grep.h b/grep.h
index b5c4e223a8..f8b495869f 100644
--- a/grep.h
+++ b/grep.h
@@ -1,15 +1,6 @@
 #ifndef GREP_H
 #define GREP_H
 #include "color.h"
-#ifdef USE_LIBPCRE1
-#include <pcre.h>
-#ifndef PCRE_NO_UTF8_CHECK
-#define PCRE_NO_UTF8_CHECK 0
-#endif
-#else
-typedef int pcre;
-typedef int pcre_extra;
-#endif
 #ifdef USE_LIBPCRE2
 #define PCRE2_CODE_UNIT_WIDTH 8
 #include <pcre2.h>
@@ -71,10 +62,6 @@ struct grep_pat {
 	size_t patternlen;
 	enum grep_header_field field;
 	regex_t regexp;
-	pcre *pcre1_regexp;
-	pcre_extra *pcre1_extra_info;
-	const unsigned char *pcre1_tables;
-	int pcre1_jit_on;
 	pcre2_code *pcre2_pattern;
 	pcre2_match_data *pcre2_match_data;
 	pcre2_compile_context *pcre2_compile_context;
@@ -144,7 +131,6 @@ struct grep_opt {
 	int allow_textconv;
 	int extended;
 	int use_reflog_filter;
-	int pcre1;
 	int pcre2;
 	int relative;
 	int pathname;
diff --git a/t/README b/t/README
index c730a70770..5398994eba 100644
--- a/t/README
+++ b/t/README
@@ -1104,18 +1104,6 @@ use these, and "test_set_prereq" for how to define your own.
    Git was compiled with support for PCRE. Wrap any tests
    that use git-grep --perl-regexp or git-grep -P in these.
 
- - LIBPCRE1
-
-   Git was compiled with PCRE v1 support via
-   USE_LIBPCRE1=YesPlease. Wrap any PCRE using tests that for some
-   reason need v1 of the PCRE library instead of v2 in these.
-
- - LIBPCRE2
-
-   Git was compiled with PCRE v2 support via
-   USE_LIBPCRE2=YesPlease. Wrap any PCRE using tests that for some
-   reason need v2 of the PCRE library instead of v1 in these.
-
  - CASE_INSENSITIVE_FS
 
    Test is run on a case insensitive file system.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 03c1c0836f..2996d7c54c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1524,8 +1524,7 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
-test -n "$USE_LIBPCRE1$USE_LIBPCRE2" && test_set_prereq PCRE
-test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
+test -n "$USE_LIBPCRE2" && test_set_prereq PCRE
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
-- 
2.29.2.222.g5d2a92d10f8

