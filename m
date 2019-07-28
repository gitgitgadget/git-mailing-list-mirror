Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D9F1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 23:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfG1Xya (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 19:54:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42847 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfG1Xya (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 19:54:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so27259554pgb.9
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSyYfP5Ab9LK657j+gymXJZKszSRpA+FqkS3IvqVxrE=;
        b=JdRNtkPYjjTtrWlG4yMmdemR+8njJ227KRxY01ts+YqzmKs2VllAd0Scr6rtlwBOob
         3nPmmACUNFPAz2VQwjHMcw3aqkQTKr6OogG3mlPSi5vK4uE8m3V2Ztpifmv2Z3EKUhOS
         MaJE3fAAMA3NUhGwf6NuARIYPO5sD39Z7a1okghkWdl3QAwxDX+oyxGl3lLw+5dV8uWC
         GBV2hcFWm6xezYPZHkbtfODeHpJWQJTfnNN59KOu6m12WcOhMcKP6ZVHx1dYBhzzH2IZ
         +OrLyL4KEvhHz4VhVT/HT8SXLWhxzbfvBlxPeitNPTdbXHCE2nXwbuJoIhQDY8IfU1Bf
         dhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSyYfP5Ab9LK657j+gymXJZKszSRpA+FqkS3IvqVxrE=;
        b=injcYwzh2hbXI/qJ15mgpxdiEYf610pzvGMigQrKfIQkX8ggG8hqt38FRlvE8EAtn9
         4wL1DWTjaGQYu9kDKG5ipARfB+gKfKmxEQm9CXO2LXqohwbVfYOD66ll3p8Rz9cs2aF7
         /JimNTj1vMxjMbedEI/RoXLY7WUsrGF9Q/m+ypkwk3rZ5127HPbmgiddDcwi7f7won5z
         I5YkDfJeb+bO4N5PkrZyZ5KhC+k0hxjtyZ4kFbgZhy1hqBerz1f6LprwTHR7FAM6RJf4
         ucTtXwitddxv7DXcX575qad7PGNK+QyR9x+O3EQjA5zknS987c/gSeuol4BJFX50oG4x
         tBhA==
X-Gm-Message-State: APjAAAWxqZpgZxeaT3kJfxV322BYkha4ngmgteDBgiKFwKgORB4qgdsU
        A19Lna5OR6/ZGMKKyP0l9yrZ1C69W0I=
X-Google-Smtp-Source: APXvYqyINRyXJznE9/Uk8qdE5lGlbWDI8Z/zLWqLMj2Nx6AY7KA0pA9J0gIC8EYde9VPIBKnI9BlbQ==
X-Received: by 2002:aa7:8b11:: with SMTP id f17mr33736832pfd.19.1564358068837;
        Sun, 28 Jul 2019 16:54:28 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 185sm68035539pfa.170.2019.07.28.16.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 16:54:28 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sandals@crustytoothpaste.net
Subject: [RFC PATCH] grep: allow for run time disabling of JIT in PCRE
Date:   Sun, 28 Jul 2019 16:54:27 -0700
Message-Id: <20190728235427.41425-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PCRE1 allowed for a compile time flag to disable JIT, but PCRE2 never
had one, forcing the use of JIT if -P was requested.

After ed0479ce3d (Merge branch 'ab/no-kwset' into next, 2019-07-15)
the PCRE2 engine will be used more broadly and therefore adding this
knob will give users a fallback for situations like the one observed
in OpenBSD with a JIT enabled PCRE2, because of W^X restrictions:

  $ git grep 'foo bar'
  fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
  $ git grep -G 'foo bar'
  fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
  $ git grep -E 'foo bar'
  fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'
  $ git grep -F 'foo bar'
  fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/git-grep.txt |  4 ++++
 grep.c                     | 15 +++++++++++++--
 grep.h                     |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index c89fb569e3..ff544bdeec 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -69,6 +69,10 @@ grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
 	is executed outside of a git repository.  Defaults to false.
 
+pcre.jit::
+	If set to false, disable JIT when using PCRE.  Defaults to
+	true.
+
 
 OPTIONS
 -------
diff --git a/grep.c b/grep.c
index c7c06ae08d..3524d353dd 100644
--- a/grep.c
+++ b/grep.c
@@ -56,6 +56,7 @@ void init_grep_defaults(struct repository *repo)
 	opt->repo = repo;
 	opt->relative = 1;
 	opt->pathname = 1;
+	opt->pcre_jit = 1;
 	opt->max_depth = -1;
 	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
 	color_set(opt->colors[GREP_COLOR_CONTEXT], "");
@@ -125,6 +126,12 @@ int grep_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "pcre.jit")) {
+		int is_bool;
+		opt->pcre_jit = git_config_bool_or_int(var, value, &is_bool);
+		return 0;
+	}
+
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value);
 	if (!strcmp(var, "color.grep.match")) {
@@ -163,6 +170,7 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 	opt->pattern_tail = &opt->pattern_list;
 	opt->header_tail = &opt->header_list;
 
+	opt->pcre_jit = def->pcre_jit;
 	opt->only_matching = def->only_matching;
 	opt->color = def->color;
 	opt->extended_regexp_option = def->extended_regexp_option;
@@ -393,7 +401,8 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 		die("%s", error);
 
 #ifdef GIT_PCRE1_USE_JIT
-	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
+	if (opt->pcre_jit)
+		pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
 #endif
 }
 
@@ -489,7 +498,9 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		compile_regexp_failed(p, (const char *)&errbuf);
 	}
 
-	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
+	if (opt->pcre_jit)
+		pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
+
 	if (p->pcre2_jit_on) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
 		if (jitret)
diff --git a/grep.h b/grep.h
index c0c71eb4a9..fff152e606 100644
--- a/grep.h
+++ b/grep.h
@@ -151,6 +151,7 @@ struct grep_opt {
 	int allow_textconv;
 	int extended;
 	int use_reflog_filter;
+	int pcre_jit;
 	int pcre1;
 	int pcre2;
 	int relative;
-- 
2.22.0

