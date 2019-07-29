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
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C7D1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 10:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfG2K76 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 06:59:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39083 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfG2K76 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 06:59:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so28072559pgi.6
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 03:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afWFbKYw+ljgqyeKagakYT8yAvZSjJojU/ocGcMkcc4=;
        b=UitIc3nsV8SbWXF2qoZaQaGVWLAQTK7p/gC+g0oGhBA+J+gOYudWYj9UbPplCWriVZ
         iHNrUkimHEAGeHUtxm9j/H8VfxTpiWCRio7PY9LGMjpSe1y7oT9VMOfpMSOupWkUeVry
         SiZxf9QFkX9MboFME5CmpLnHKIWkKc1Qe6+cM4eUXhyFNhgsx708cEZZArA2sSt7mAKP
         XC9oaIk4OhO4QJk8OUJ2c0DtXcE8PGURgvrjEQ3AhW9rLS+Wo5URJXZKagIt4RuAOW1a
         Ui3+GWd7HrLxAQvmWGxQHXR6NcQ4PsojsjTSTcdxTaEEGMYbPn+3O0YHN9BOpWMmpWyG
         qrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afWFbKYw+ljgqyeKagakYT8yAvZSjJojU/ocGcMkcc4=;
        b=B6kvq+QZfhQ4d326PH+XddchbqUMOFDIcW3PBc3/OGWfrfamgqlN69UN7za6JCl/DS
         0Q8coIKMNYnA1nZCt1SEQ1lzv2/YdQUOwssFKNAa3gJFRAW19VS02QwggjJ02Tkq16PB
         fxt9mRT3E+Sz+EBbmh6euu35Ui3hk3nM8eUg97TlQsbdaiws7PXksJJfxrHQpjS9Pgr7
         smvXHguRry2Xi+dVKcgKv4PEbZWhyT2em65Uug4+IOk0XrZKwvtQejylUhE7Y7RMNrf5
         MaQrfFmmK4pqMVg1lyE+Ga84I4M5SlYHWuKadrJJtW/rYD9VXK+i73ibGjtd91OIS9qT
         hNRw==
X-Gm-Message-State: APjAAAVL6zXnXzD1jqcIt+U76okdXT1AB/KMF0Z2RzAZg5Z0RuSzAL8G
        TBUeNOd7ZDcrzR+EtXVmmHjKHOHKJB4=
X-Google-Smtp-Source: APXvYqwLNP6HO6hfOoMj/UHh/d1JWSh4BPZdSiwPc7rLacKT8gtJz+arm5uuIYdcw9K2U7kpP56nrw==
X-Received: by 2002:a63:cb4b:: with SMTP id m11mr29675338pgi.49.1564397996688;
        Mon, 29 Jul 2019 03:59:56 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id x9sm38323538pgp.75.2019.07.29.03.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jul 2019 03:59:56 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sandals@crustytoothpaste.net, gitster@pobox.com,
        dev+git@drbeat.li, Johannes.Schindelin@gmx.de
Subject: [RFC PATCH v2] grep: allow for run time disabling of JIT in PCRE
Date:   Mon, 29 Jul 2019 03:59:55 -0700
Message-Id: <20190729105955.44390-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190728235427.41425-1-carenas@gmail.com>
References: <20190728235427.41425-1-carenas@gmail.com>
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
knob will allow users a escape from situations where JIT might be
problematic.

JIT will be used by default but it can be disabled with the --no-pcre-jit
option in `git grep` or by setting 0/false into the pcre.jit config.

If a value of -1 is used instead then the following error is prevented by
using the interpreter when a JIT failure consistent with known security
restrictions is found at regex compilation time.

  $ git grep 'foo bar'
  fatal: Couldn't JIT the PCRE2 pattern 'foo bar', got '-48'

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
V2: add command line to grep as suggested by Junio

 Documentation/git-grep.txt | 11 +++++++++++
 builtin/grep.c             |  4 ++++
 grep.c                     | 30 ++++++++++++++++++++++++++----
 grep.h                     |  1 +
 4 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index c89fb569e3..895c6b34ec 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
+	   [-j | --[no]-pcre-jit]
 	   [-F | --fixed-strings] [-n | --line-number] [--column]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
@@ -69,6 +70,12 @@ grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
 	is executed outside of a git repository.  Defaults to false.
 
+pcre.jit::
+	If set to false, disable JIT when using PCRE.  Defaults to
+	true.
+	if set to -1 will try first to use JIT and fallback to the
+	interpreter instead of returning an error.
+
 
 OPTIONS
 -------
@@ -175,6 +182,10 @@ providing this option will cause it to die.
 	Use fixed strings for patterns (don't interpret pattern
 	as a regex).
 
+-j::
+--[no-]pcre-jit::
+	Diable JIT in PCRE with --no-pcre-jit.
+
 -n::
 --line-number::
 	Prefix the line number to matching lines.
diff --git a/builtin/grep.c b/builtin/grep.c
index 580fd38f41..b0e94875b2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -923,6 +923,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
 			   N_("allow calling of grep(1) (ignored by this build)"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_GROUP("PCRE"),
+		OPT_SET_INT('j', "pcre-jit", &opt.pcre_jit,
+			N_("when to use JIT with PCRE"),
+			1),
 		OPT_END()
 	};
 
diff --git a/grep.c b/grep.c
index c7c06ae08d..d58cad0257 100644
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
 
@@ -489,11 +498,24 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		compile_regexp_failed(p, (const char *)&errbuf);
 	}
 
-	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
+	if (opt->pcre_jit)
+		pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
+
 	if (p->pcre2_jit_on) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
-		if (jitret)
-			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+		if (jitret) {
+			if ((opt->pcre_jit < 0) &&
+				jitret == PCRE2_ERROR_NOMEMORY) {
+				/*
+				 * JIT compiler isn't available but we can
+				 * still fallback to the interpreter
+				 */
+				p->pcre2_jit_on = 0;
+				return;
+			}
+			else
+				die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+		}
 
 		/*
 		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
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

base-commit: 870eea81669bfff4333b37b11fedd870cd05fd90
-- 
2.22.0

