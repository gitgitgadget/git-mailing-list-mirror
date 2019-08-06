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
	by dcvr.yhbt.net (Postfix) with ESMTP id EA57F1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 08:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbfHFIuV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 04:50:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42582 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbfHFIuS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 04:50:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so41117695pff.9
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AX+oD6CSNXB2/rV4itcTdb6S0R0+X1YRzRRXVlINCak=;
        b=cD5u7u/Sgq0LTuRSFhHi857jj2zyzYIKPLNNZ053xiKOl7U2W62S4uAFMngwkpxvIb
         0dWIQUAulp0OIvFDNh6+cYTITnlGX7rYqUHsYI648qhybOWiTQHcCZfQ592yAR8PPoCi
         QQ99sgWl8lzRXN7UXTlBnomyMpVgSnUck0md+l1gBaoR3mU6PD44X1EqDcfZRTv6gtuK
         Ov0Hib6f2aj0dk5wb4+G/FBU5A6Od4EFg7H47SnVHrgmJ1k59rdUexCMBYSIw4m6ELb/
         mL7aAJR+xpUW5egiMlxeSp6LJ+/l5NWnmeny8VqJzIg+WiRmRZBWY+kOJlPzOS2FEkhc
         +JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AX+oD6CSNXB2/rV4itcTdb6S0R0+X1YRzRRXVlINCak=;
        b=LgzfQA2u1AQXmdH48PhymYBq7aHXzioabw9gOl/p9DPAyUa7ioX8i3b/J32YIDIr7k
         Ge7C4TAOm7bD9nNbvlq9DYB7h7tKNHZaZoSEatrLs2Spsd8z0ybNWWBJ9wJmV55iJyfP
         fU+VgQSZqXUHbwEWvohf0xSEBI1gu4aaKpopGVrIVsJd1INFFlB+Wj/r2LV4a7bQRYwx
         ldnESAJ4cyGF7TaqQom89pQZkZeYUpGznDGoV2uNluFZv8qaAJ6c+qagv+OX6zaFWS75
         ragZpr9c3eRvq0hItQEDO0I+h2c3K2kdu8mrmK6Pmon+pvRDeDSAEeYgNvPocAiX7pbZ
         y1Mw==
X-Gm-Message-State: APjAAAU3TaXYuJAdy8cPRiDFIfI0wzz1MlsD1a4GucRet3nyIH2l6tiO
        rqPdLbK5PveUflDgGrdzmtUcQ/kbFuM=
X-Google-Smtp-Source: APXvYqyBOWxjIcsASxZ3qzWaJZbKtT4xK9377duJBpWsKTMAaMifm1jWSo0WZ14bEDD3Pf1SmA4NGA==
X-Received: by 2002:a62:82c1:: with SMTP id w184mr2600988pfd.8.1565081417603;
        Tue, 06 Aug 2019 01:50:17 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id j5sm75743830pgp.59.2019.08.06.01.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 01:50:16 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: [PATCH 2/3] grep: make PCRE2 aware of custom allocator
Date:   Tue,  6 Aug 2019 01:50:13 -0700
Message-Id: <20190806085014.47776-3-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190806085014.47776-1-carenas@gmail.com>
References: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com>
 <20190806085014.47776-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the code stolen from[1] to easy on comparison and including
the deficiency of setting the global context even for patterns that
won't need it.

Ideally, the call from grep_init could be moved to a place where it
could be set without needing a lock and at least with this approach
we have a place to clear it (which is obviously missing more callers,
but at least shows how it will look for the grep subcommand)

I had also dropped most other users of the global context in a failed
attempt to make the change smaller, but also to keep the current
behaviour so that we could see the effect of enabling NED for PCRE2
more clearly.

Sadly, that will likely require a Windows box, as NED (at least our
version) is horribly broken in macOS (maybe it wasn't 64 bit clean)
and in Linux builds, but I can't reproduce your crasher and it is
most likely slower than the system malloc.

[1] https://public-inbox.org/git/pull.306.git.gitgitgadget@gmail.com/

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/grep.c |  1 +
 grep.c         | 31 +++++++++++++++++++++++++++++--
 grep.h         |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 560051784e..e49c20df60 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1145,5 +1145,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		run_pager(&opt, prefix);
 	clear_pathspec(&pathspec);
 	free_grep_patterns(&opt);
+	grep_destroy();
 	return !hit;
 }
diff --git a/grep.c b/grep.c
index 0154998695..e748a6d68c 100644
--- a/grep.c
+++ b/grep.c
@@ -16,6 +16,20 @@ static int grep_source_is_binary(struct grep_source *gs,
 
 static struct grep_opt grep_defaults;
 
+#ifdef USE_LIBPCRE2
+static pcre2_general_context *pcre2_global_context;
+
+static void *pcre2_malloc(PCRE2_SIZE size, void *memory_data)
+{
+	return malloc(size);
+}
+
+static void pcre2_free(void *pointer, void *memory_data)
+{
+	return free(pointer);
+}
+#endif
+
 static const char *color_grep_slots[] = {
 	[GREP_COLOR_CONTEXT]	    = "context",
 	[GREP_COLOR_FILENAME]	    = "filename",
@@ -153,6 +167,7 @@ int grep_config(const char *var, const char *value, void *cb)
  *
  * If using PCRE make sure that the library is configured
  * to use the right allocator (ex: NED)
+ * if any object is created it should be cleaned up in grep_destroy()
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
@@ -164,6 +179,10 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 	pcre_malloc = malloc;
 	pcre_free = free;
 #endif
+#ifdef USE_LIBPCRE2
+	pcre2_global_context = pcre2_general_context_create(pcre2_malloc,
+							pcre2_free, NULL);
+#endif
 #endif
 
 	memset(opt, 0, sizeof(*opt));
@@ -188,6 +207,13 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 		color_set(opt->colors[i], def->colors[i]);
 }
 
+void grep_destroy(void)
+{
+#ifdef USE_LIBPCRE2
+	pcre2_general_context_free(pcre2_global_context);
+#endif
+}
+
 static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
 {
 	/*
@@ -509,7 +535,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern)) {
-			character_tables = pcre2_maketables(NULL);
+			character_tables = pcre2_maketables(pcre2_global_context);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
 			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
 		}
@@ -560,7 +586,8 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 			return;
 		}
 
-		p->pcre2_jit_stack = pcre2_jit_stack_create(1, 1024 * 1024, NULL);
+		p->pcre2_jit_stack = pcre2_jit_stack_create(1, 1024 * 1024,
+					pcre2_global_context);
 		if (!p->pcre2_jit_stack)
 			die("Couldn't allocate PCRE2 JIT stack");
 		p->pcre2_match_context = pcre2_match_context_create(NULL);
diff --git a/grep.h b/grep.h
index 1875880f37..526c2db9ef 100644
--- a/grep.h
+++ b/grep.h
@@ -189,6 +189,7 @@ struct grep_opt {
 void init_grep_defaults(struct repository *);
 int grep_config(const char *var, const char *value, void *);
 void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
+void grep_destroy(void);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
-- 
2.23.0.rc1

