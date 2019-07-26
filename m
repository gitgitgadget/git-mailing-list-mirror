Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39261F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfGZU0w (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 16:26:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44632 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfGZU0v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 16:26:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so25125882plr.11
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tSwuau3D/fAu4yeunWTjek3TMQMN3nHdAnoldXpGKAQ=;
        b=tIKzgUHRfHi2xsmLJCwG59swyjm3t7Oz+0JQoUp3i+KuWS9/M0E4fOqFFzqEByhBCO
         gRMAm2vbHHjDftP6Scqj7QRfHJ+BeaQqBF7kqIxohtqi3LnnFoNKoTac3lHEGxO8WBCA
         el4d780WHGTBqcTk0FUqzQ3Oi0BnSRlavSVpJskmDtm0dJdZ0qUOdg0jp5Dml4+SA2qe
         5MHE4+B02AeLy0dkiz/4Bld6Qx0UUq25iEC9JeAo+J78RwQIfZymCzHu0s07MyGfsEnY
         eIIUHpwI1hpEB+oYaoCGifAbN54HN7riaYBtF56uCqu91oIxOJKUL+V6mmdWfL6qW5k/
         u+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tSwuau3D/fAu4yeunWTjek3TMQMN3nHdAnoldXpGKAQ=;
        b=G2s6mB9ay9XD/3xxaNE4qlcfEo0Rp/Qj9TsTkaPu5+LpID2eX6eRAu7AYUDqiAoNEJ
         TG28JWfsFgpxhviFmzaVmfnhbCpcU3spowqqb6p8bvqJG4L6guPPx7ngbhrNEp+pva29
         e8fuDc8U8lEmRvXlD1mAggSlxcTqDtS8N0sKePYLOj5UoD247AxYYFyj6h3CF0NfRkW9
         ZazjeN/VuD90Njc20bVkj1Pub60YJgHJef/z0aVADOp0PByonacN8l67pXVMoZpZEkjk
         4yGxbX7tusBJVXDJ9bR2tyBmKvRrFia4nNP5r6R9YbOOBp8Rq84C4sPE/5O1f/4OvUF4
         EVig==
X-Gm-Message-State: APjAAAVTy0hNUXtEEVqCMc+WFO5e7IvSwN0T7hKTh2TTH0AAa9ktz0jr
        Qgx6tDERi2S3tLLcDhwx7r/4n4o0n5k=
X-Google-Smtp-Source: APXvYqxvYox1PAAIhYVTiPlGoRMVFgLlY0ZNMhjyhNW28yCD0OeLpL1+UxrL1tbY4ekca4IMrjVtAA==
X-Received: by 2002:a17:902:e65:: with SMTP id 92mr94078379plw.13.1564172810523;
        Fri, 26 Jul 2019 13:26:50 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id 4sm63754514pfc.92.2019.07.26.13.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 13:26:49 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Johannes.Schindelin@gmx.de, dev+git@drbeat.li,
        gitster@pobox.com
Subject: [RFC PATCH 2/2] grep: refactor and simplify PCRE1 support
Date:   Fri, 26 Jul 2019 13:26:42 -0700
Message-Id: <20190726202642.7986-3-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726202642.7986-1-carenas@gmail.com>
References: <87ftms7t6s.fsf@evledraar.gmail.com>
 <20190726202642.7986-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code used both a macro and a variable to keep track if JIT
support was desired and relied on the fact that a non JIT
enabled library will ignore a request for JIT compilation
(as defined by the second parameter of the call to pcre_study)

Cleanup the multiple levels of macros used and call pcre_study
with the right parameter after JIT support has been confirmed
and unless it was requested to be disabled with NO_LIBPCRE1_JIT

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 15 +++++++++------
 grep.h |  9 ---------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/grep.c b/grep.c
index 6b52fed53a..599765c5c1 100644
--- a/grep.c
+++ b/grep.c
@@ -386,6 +386,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	const char *error;
 	int erroffset;
 	int options = PCRE_MULTILINE;
+	int study_options = 0;
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern))
@@ -400,13 +401,15 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	if (!p->pcre1_regexp)
 		compile_regexp_failed(p, error);
 
-	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, GIT_PCRE_STUDY_JIT_COMPILE, &error);
-	if (!p->pcre1_extra_info && error)
-		die("%s", error);
-
-#ifdef GIT_PCRE1_USE_JIT
+#if defined(PCRE_CONFIG_JIT) && !defined(NO_LIBPCRE1_JIT)
 	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
+	if (p->pcre1_jit_on)
+		study_options = PCRE_STUDY_JIT_COMPILE;
 #endif
+
+	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, study_options, &error);
+	if (!p->pcre1_extra_info && error)
+		die("%s", error);
 }
 
 static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
@@ -435,7 +438,7 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 static void free_pcre1_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre1_regexp);
-#ifdef GIT_PCRE1_USE_JIT
+#ifdef PCRE_CONFIG_JIT
 	if (p->pcre1_jit_on)
 		pcre_free_study(p->pcre1_extra_info);
 	else
diff --git a/grep.h b/grep.h
index 2a74e28d94..30f2503121 100644
--- a/grep.h
+++ b/grep.h
@@ -3,15 +3,6 @@
 #include "color.h"
 #ifdef USE_LIBPCRE1
 #include <pcre.h>
-#ifndef NO_LIBPCRE1_JIT
-#ifdef PCRE_CONFIG_JIT
-#define GIT_PCRE1_USE_JIT
-#define GIT_PCRE_STUDY_JIT_COMPILE PCRE_STUDY_JIT_COMPILE
-#endif
-#endif
-#ifndef GIT_PCRE_STUDY_JIT_COMPILE
-#define GIT_PCRE_STUDY_JIT_COMPILE 0
-#endif
 #else
 typedef int pcre;
 typedef int pcre_extra;
-- 
2.22.0
