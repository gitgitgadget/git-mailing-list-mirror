Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2311F461
	for <e@80x24.org>; Sun, 25 Aug 2019 18:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfHYSWc (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 14:22:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41243 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbfHYSWb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 14:22:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so8693657pls.8
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNK7H4FLgmJjjQBLd/JcmLq5uqoc6dMRyUJUtYhLKbc=;
        b=V6p89itQQkngabVTgP6nTDoXA9gSkH8YSwd+dwGfcS7mcUUiG5zOBoUoqDsB4BX7AT
         CZGgGhBHHgWlYyZ2qkOuiNRck25RApb5ZuTjQcNf4trt/XXlSTcmd4cZqHh6S3xgVG41
         87UT3LS/i1OmZIcCv9QGAK6zjahex5x+AreNJB2DrZoteyhyrDV0nyvE0tC5G2CVNLdm
         5yiriqT8iTdOh+SKr1wFgkbmKIPuGGtgR8TZ9lD6PEadGa5u9bxptRsG6e3g53YQxlDq
         KdHhRAcS851+tAT19G1EdQDT5M6NwK6JFlLMAiebilUXDNasRxYxTvFgThvz9FIbLul9
         UnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNK7H4FLgmJjjQBLd/JcmLq5uqoc6dMRyUJUtYhLKbc=;
        b=RGIFY10Rymtj0OEE4FiWvnppK5T4cc5KUPpcspcyzk/ipyRMheIAep2uQut8OCoRcp
         fxN8/QGAMsT2ppPjBRSpxMlXGeK/JLShZ5bGnwEKwwmC4bzQBPzYoje/UgU8ctXjKR9c
         LbC+MYouH9Dn75Vu+88t/fmY+wwmNvkH9dh/sCG9D255CvsSlyUhcgnjWoaufTYAc5qH
         0bg+FJm1+NuwngrRvqDPKp7X4DUsR+wBAZHr2oGVr9dJr8kaRkDR35oh5tmPXP46jGUZ
         FSGRSqbXM78XyJP+J5HUOX1XLfQRdnprBCDiEc2/OANzBILgYnbsmH03oZJdd/0odZW7
         wRNg==
X-Gm-Message-State: APjAAAVg8o7KJ+cAbxZhhO9hB48LKAWbU56fKlsS6VZkRNHCP4eIkNR0
        lVcPsHlThHbrXGVQALZcI3EhgTsh9sY=
X-Google-Smtp-Source: APXvYqwzQP8olNBl4V8mAm/oHWffq20ZW42kT38+D1rtE/zNpHruW2mVU5DH+ChksX1cJdu3mObq1Q==
X-Received: by 2002:a17:902:a01:: with SMTP id 1mr14663600plo.278.1566757350106;
        Sun, 25 Aug 2019 11:22:30 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id y194sm10334693pfg.116.2019.08.25.11.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Aug 2019 11:22:29 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     cbailey32@bloomberg.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 2/2] grep: refactor and simplify PCRE1 support
Date:   Sun, 25 Aug 2019 11:22:23 -0700
Message-Id: <20190825182223.76288-3-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825182223.76288-1-carenas@gmail.com>
References: <20190825182223.76288-1-carenas@gmail.com>
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
 grep.c | 16 ++++++++++------
 grep.h |  9 ---------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/grep.c b/grep.c
index 76088784e3..05d31c2bcc 100644
--- a/grep.c
+++ b/grep.c
@@ -374,6 +374,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	const char *error;
 	int erroffset;
 	int options = PCRE_MULTILINE;
+	int study_options = 0;
 
 	if (opt->ignore_case) {
 		if (!opt->ignore_locale && has_non_ascii(p->pattern))
@@ -388,15 +389,18 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	if (!p->pcre1_regexp)
 		compile_regexp_failed(p, error);
 
-	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, GIT_PCRE_STUDY_JIT_COMPILE, &error);
-	if (!p->pcre1_extra_info && error)
-		die("%s", error);
-
-#ifdef GIT_PCRE1_USE_JIT
+#if defined(PCRE_CONFIG_JIT) && !defined(NO_LIBPCRE1_JIT)
 	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
 	if (opt->debug)
 		fprintf(stderr, "pcre1_jit_on=%d\n", p->pcre1_jit_on);
+
+	if (p->pcre1_jit_on)
+		study_options = PCRE_STUDY_JIT_COMPILE;
 #endif
+
+	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, study_options, &error);
+	if (!p->pcre1_extra_info && error)
+		die("%s", error);
 }
 
 static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
@@ -425,7 +429,7 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 static void free_pcre1_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre1_regexp);
-#ifdef GIT_PCRE1_USE_JIT
+#ifdef PCRE_CONFIG_JIT
 	if (p->pcre1_jit_on)
 		pcre_free_study(p->pcre1_extra_info);
 	else
diff --git a/grep.h b/grep.h
index 1a044c501e..ff620d784a 100644
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
2.23.0

