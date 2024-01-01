Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C785610B
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjT6muDk"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dc049c7b58so2866684a34.3
        for <git@vger.kernel.org>; Mon, 01 Jan 2024 07:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704121454; x=1704726254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhF8+Q7UBwPH1USrnBEfF0VqgT6SC7XExP0Lmi9EMcY=;
        b=BjT6muDkDuWSVOfBm1FhfpeFEWtRa/jg9uhk4I0i+F8BUTRrARpY49qEcx4MLzdY6G
         pal0MxNvUTiTBAI0xaW/wP+p9R2+2za8F3/GD4CW54JoPiIpiZ5OH5mSgFjUWL/fa9wr
         xaq/6aoiXGcHKeirdq9hrqqEibMNOplWfKPtqJkEC4qnmmpJ7PQZ682qedp2p9yPZl8e
         Ia7S2C8kpUTr6WiICOswSrY1npMmkvsJZgh2ajhyHPoFoWjn8ATH4qF5uQ0+2xvhco6q
         RiFWt7YK5I7nhvpjTBV3RLIH70CqL5Z0ueFuiJ3qzvN24pfYR7BOM1RTpDzWwYMTuHy5
         xWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704121454; x=1704726254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhF8+Q7UBwPH1USrnBEfF0VqgT6SC7XExP0Lmi9EMcY=;
        b=E56Ltrw+xVIgfh/7KDbTEV41gtKy+DpLFa3QKMHbuR7moqZFfuh4U1gFTw0wTpxkor
         1FIJmuFgCtFrf5NcclGVUMUJFVUBWmgvAt+e0hwA1AtKC45T5c8dyKQJU4/PbDfop0I3
         TTFrg+JGOaRwhZvm+/IejigIGyrQlIBcZe4mrocIsMOZVxqr+dAJgfw0ByWmY5s+YQDk
         WGiz4EDopJxxtPyBIXDrmWvg2Sg/mmBfq6uBiNBj5KZcidka5Jij2Tb/tG53hIC9EWQP
         jTivq9FIYUvub4egokJaexkT2yyh87qMagE0xeZaaib1ZOwTC6En0jbyjv9PUsCDONIz
         niOA==
X-Gm-Message-State: AOJu0Yx1LDBpDbCff52G/LnHeG4PBiouHCd/85nJcmYUjGjceckiYLyG
	o18Ls1iT0v/hm3/bZFMoq4Nbez3Hvg0=
X-Google-Smtp-Source: AGHT+IEE3XRs3zNDM2mWrQY+caTva6qu90RQIl4IDHoU7hvYkxNsjJHPVGxWkM44R1NRR67gt8dwbw==
X-Received: by 2002:a05:6870:d88c:b0:203:e866:5141 with SMTP id oe12-20020a056870d88c00b00203e8665141mr21353120oac.56.1704121453645;
        Mon, 01 Jan 2024 07:04:13 -0800 (PST)
Received: from localhost.localdomain ([67.143.208.70])
        by smtp.gmail.com with ESMTPSA id a5-20020a0568300b8500b006dc47e166a7sm652387otv.50.2024.01.01.07.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 07:04:13 -0800 (PST)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [RFC PATCH] grep: default to posix digits with -P
Date: Mon,  1 Jan 2024 07:03:36 -0800
Message-Id: <20240101150336.89098-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since acabd2048e (grep: correctly identify utf-8 characters with
\{b,w} in -P, 2023-01-08), PCRE2's UCP mode has been enabled when
UTF content was expected and therefore muktibyte characters are
included as part of all character classes (when defined).

note that if the locale used is not UTF enabled (specially: C, POSIX)
or uses an extended charmap binary that is not unicode compatible, binary
match will be used instead.

It was argued that doing so, at least for \d, was not a good idea,
as that might not be what the user expected based on its historical
meaning and was also slower, and indeed a similar change that was done
to GNU grep was reverted and required further tweaks.

At that time, PCRE2 didn't have a way to disable UCP's character
expansion selectively, but flags to do so, and that will be
available in the next release (planned soon) were added, and
one of them has been in use by GNU grep since their last release
in May (only if built and linked against the prereleased PCRE2
library though).

Add flags to make sure that both \d and [:digit:] only include
ASCII digits so that `git grep` will be closer to GNU grep and
improve performance as a side effect, but add a configuration flag
to allow keeping the current behaviour (which is closer to perl
and ripgrep).

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/config/grep.txt       |  4 ++++
 grep.c                              | 37 ++++++++++++++++++++++-------
 grep.h                              |  5 ++++
 t/perf/p7822-grep-perl-character.sh | 11 +++++++--
 t/t7818-grep-digit.sh               | 32 +++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 11 deletions(-)
 create mode 100755 t/t7818-grep-digit.sh

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index e521f20390..4e405c8ad1 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -26,3 +26,7 @@ grep.fullName::
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
 	is executed outside of a git repository.  Defaults to false.
+
+grep.perl.digit::
+	If set to true, use the perl definitions for \d and [:digit:].
+	Defaults to false.
diff --git a/grep.c b/grep.c
index fc2d0c837a..fec36ccb30 100644
--- a/grep.c
+++ b/grep.c
@@ -88,6 +88,11 @@ int grep_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "grep.perl.digit")) {
+		opt->perl_digit = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value);
 	if (!strcmp(var, "color.grep.match")) {
@@ -301,6 +306,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int patinforet;
 	size_t jitsizearg;
 	int literal = !opt->ignore_case && (p->fixed || p->is_fixed);
+	uint32_t xoptions = 0;
 
 	/*
 	 * Call pcre2_general_context_create() before calling any
@@ -321,17 +327,22 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		}
 		options |= PCRE2_CASELESS;
 	}
-	if (!opt->ignore_locale && is_utf8_locale() && !literal)
-		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
+	if (!opt->ignore_locale && is_utf8_locale() && !literal) {
+		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
 
-#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
-	/*
-	 * Work around a JIT bug related to invalid Unicode character handling
-	 * fixed in 10.35:
-	 * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
-	 */
-	options &= ~PCRE2_UCP;
+#ifdef GIT_PCRE2_VERSION_10_35_OR_HIGHER
+		/*
+		 * Work around a JIT bug related to invalid Unicode character handling
+		 * fixed in 10.35:
+		 * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
+		 */
+		options |= PCRE2_UCP;
+#ifdef GIT_PCRE2_VERSION_10_43_OR_HIGHER
+		if (!opt->perl_digit)
+			xoptions |= (PCRE2_EXTRA_ASCII_BSD | PCRE2_EXTRA_ASCII_DIGIT);
 #endif
+#endif
+	}
 
 #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
@@ -339,6 +350,14 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		options |= PCRE2_NO_START_OPTIMIZE;
 #endif
 
+	if (xoptions) {
+		if (!p->pcre2_compile_context)
+			p->pcre2_compile_context = pcre2_compile_context_create(p->pcre2_general_context);
+
+		pcre2_set_compile_extra_options(p->pcre2_compile_context,
+						xoptions);
+	}
+
 	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
 					 p->patternlen, options, &error, &erroffset,
 					 p->pcre2_compile_context);
diff --git a/grep.h b/grep.h
index 926c0875c4..cd5c416a0a 100644
--- a/grep.h
+++ b/grep.h
@@ -4,6 +4,9 @@
 #ifdef USE_LIBPCRE2
 #define PCRE2_CODE_UNIT_WIDTH 8
 #include <pcre2.h>
+#if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 43) || PCRE2_MAJOR >= 11
+#define GIT_PCRE2_VERSION_10_43_OR_HIGHER
+#endif
 #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 36) || PCRE2_MAJOR >= 11
 #define GIT_PCRE2_VERSION_10_36_OR_HIGHER
 #endif
@@ -178,6 +181,8 @@ struct grep_opt {
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
 	void *output_priv;
+
+	unsigned perl_digit:1;
 };
 
 #define GREP_OPT_INIT { \
diff --git a/t/perf/p7822-grep-perl-character.sh b/t/perf/p7822-grep-perl-character.sh
index 87009c60df..cc88d5a695 100755
--- a/t/perf/p7822-grep-perl-character.sh
+++ b/t/perf/p7822-grep-perl-character.sh
@@ -8,6 +8,13 @@ etc.) we will test the patterns under those numbers of threads.
 
 . ./perf-lib.sh
 
+# setting a LOCALE is needed, but not yet supported by :
+#. "$TEST_DIRECTORY"/lib-gettext.sh
+
+# Invoke like:
+#
+# LC_ALL=is_IS.utf8 ./p7822-grep-perl-character.sh
+
 test_perf_large_repo
 test_checkout_worktree
 
@@ -27,13 +34,13 @@ do
 	if ! test_have_prereq PERF_GREP_ENGINES_THREADS
 	then
 		test_perf "grep -P '$pattern'" --prereq PCRE "
-			git -P grep -f pat || :
+			git grep -P -f pat || :
 		"
 	else
 		for threads in $GIT_PERF_GREP_THREADS
 		do
 			test_perf "grep -P '$pattern' with $threads threads" --prereq PTHREADS,PCRE "
-				git -c grep.threads=$threads -P grep -f pat || :
+				git -c grep.threads=$threads grep -P -f pat || :
 			"
 		done
 	fi
diff --git a/t/t7818-grep-digit.sh b/t/t7818-grep-digit.sh
new file mode 100755
index 0000000000..44007e6be6
--- /dev/null
+++ b/t/t7818-grep-digit.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='git grep -P with digits'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./lib-gettext.sh
+
+test_expect_success 'setup' '
+	echo 2023 >ascii &&
+	printf "\357\274\222\357\274\220\357\274\222\357\274\223\n" >fullwidth &&
+	printf "\331\241\331\244\331\244\331\245\n" >multibyte &&
+	git add . &&
+	git commit -m. &&
+	LC_ALL="$is_IS_locale" &&
+	export LC_ALL
+'
+
+test_expect_success PCRE 'grep -P "\d"' '
+	echo "ascii:2023" >expected &&
+	git grep -P "\d{2}[[:digit:]]{2}" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success PCRE 'git -c grep.perl.digit' '
+	test_config grep.perl.digit true &&
+	git grep -P "\d{2}[[:digit:]]{2}" >actual &&
+	grep fullwidth actual &&
+	grep multibyte actual &&
+	test_line_count = 3 actual
+'
+
+test_done
-- 
2.39.3 (Apple Git-145)

