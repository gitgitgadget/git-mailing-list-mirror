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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD2E1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 21:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbfHGVjz (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 17:39:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36910 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfHGVjz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 17:39:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so10035851pgp.4
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmBq5ZKIig/4LhVeAhL3ftyPco3spB8iPnflmuZOQ80=;
        b=V0ZzlQ39/Jp2vWxt3khzIYnafL5aGXIVGeF5IaaI42QKZinuS+D0RUxH5QjpfmIA3r
         fviLBGcM0UrUf3HuZcSsODT+aYdS6TFrNz8YDgDlsM3v7NZR6MpSbGEbu5McsVsBlgzr
         fG9c7MU4fwP06X47eIkhyOW2w/pAs9oQuyy8kzniRDw/cfnGn6OiJr0WMU7anIkuiC2M
         XfgGTFMsdJYaVEYlTC+ek8xNqIBLBmJkiBlCHbr6d3ur0/0hckxcRprS+FpMLmMdqaNg
         8qQcRzeVdoFGGlTtP0wkD2IKiqdo59McFOmgKhg4BGImVkIgDC1jbW1AV5NZZ9z0S9OT
         FcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmBq5ZKIig/4LhVeAhL3ftyPco3spB8iPnflmuZOQ80=;
        b=UbbwQkcWS+qWHfLcTTNJrEeBmTgVXtKwryNKEwH/zAbSEEBUk6+Agb39bQUson73qf
         D4C8ikj1psayhdzOU1z4N4QmvbbxhRgDC3XmDgJfaumqTP0V5Ms4aqRe9Iuu3oWaP/Qy
         mb5sC9CmTbFRDJcH7dblgYU3HiruMtGkcshW+notwYq0AVa2wb9tlytD5p9k/9n2+kPg
         K7mDk+d1UdQ5MRZfIVgXJEHS8kPPCm/+tzxUGcKRsCz6c3XN6VAMrymsmqTiW3QbtZy0
         DX1I85qrRvCCSKN1qtW8RU39/Bkh792KN0HiwOS+9nDjgsavom0aldsQtEcP+slHPv47
         qMzg==
X-Gm-Message-State: APjAAAWICn7wqaQvGZK8R1MrhSHoWvuefi/6CxYOGc8BbL8xqAzXXfIr
        s6L0GFtGa7MB9pOeFVbOL9toVpCwtmI=
X-Google-Smtp-Source: APXvYqz0dD1ToxOa8RNK8RvXQYfFd5mM8v/i7FoCg+EBbteLHHXYQpRtT8ppu85oALX8+o3v3Fn66g==
X-Received: by 2002:aa7:8218:: with SMTP id k24mr11121318pfi.221.1565213994032;
        Wed, 07 Aug 2019 14:39:54 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id b24sm63840303pfd.91.2019.08.07.14.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 14:39:53 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v4 2/3] grep: make PCRE2 aware of custom allocator
Date:   Wed,  7 Aug 2019 14:39:44 -0700
Message-Id: <20190807213945.10464-3-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190807213945.10464-1-carenas@gmail.com>
References: <20190806163658.66932-1-carenas@gmail.com>
 <20190807213945.10464-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

94da9193a6 (grep: add support for PCRE v2, 2017-06-01) didn't include
a way to override the system allocator, and so it is incompatible with
USE_NED_ALLOCATOR.  The problem was made visible when an attempt to
avoid a leak in a data structure that is created by the library was
passed to NED's free for disposal triggering a segfault in Windows.

PCRE2 requires the use of a general context to override the allocator
and therefore, there is a lot more code needed than in PCRE1, including
a couple of wrapper functions.

Extend the grep API with a "destructor" that could be called to cleanup
any objects that were created and used globally.

Update builtin/{grep,log} to use that new API, but any other future
users should make sure to have matching grep_init/grep_destroy calls
if they are using the pattern matching functionality (currently only
relevant when using both NED and PCRE2)

Move the logic to decide if a general context will be needed to an
earlier phase so it will only be done once per pattern (instead of
at least once per worker thread) avoiding then the need for locking.

This change does the minimum change required to hopefully solve the
crash, with the rest of the users of it added later.

Helped-by: René Scharfe <l.s.r@web.de>
Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
V4:
* use xmalloc instead as suggested by René and Junio
* "fix" for regression in t7816 as reported by René

 builtin/grep.c |  1 +
 builtin/log.c  |  1 +
 grep.c         | 62 ++++++++++++++++++++++++++++++++++++++++++++------
 grep.h         |  1 +
 4 files changed, 58 insertions(+), 7 deletions(-)

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
diff --git a/builtin/log.c b/builtin/log.c
index 1cf9e37736..139b8770e7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2146,6 +2146,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		list = list->next;
 	}
 
+	grep_destroy();
 	free_patch_ids(&ids);
 	return 0;
 }
diff --git a/grep.c b/grep.c
index 0154998695..8ee982e2e8 100644
--- a/grep.c
+++ b/grep.c
@@ -16,6 +16,22 @@ static int grep_source_is_binary(struct grep_source *gs,
 
 static struct grep_opt grep_defaults;
 
+#ifdef USE_LIBPCRE2
+static pcre2_general_context *pcre2_global_context;
+
+#ifdef USE_NED_ALLOCATOR
+static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
+{
+	return xmalloc(size); /* will use nedalloc underneath */
+}
+
+static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
+{
+	return free(pointer);
+}
+#endif
+#endif
+
 static const char *color_grep_slots[] = {
 	[GREP_COLOR_CONTEXT]	    = "context",
 	[GREP_COLOR_FILENAME]	    = "filename",
@@ -153,6 +169,7 @@ int grep_config(const char *var, const char *value, void *cb)
  *
  * If using PCRE make sure that the library is configured
  * to use the right allocator (ex: NED)
+ * if any object is created it should be cleaned up in grep_destroy()
  */
 void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
 {
@@ -188,6 +205,13 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
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
@@ -254,12 +278,29 @@ void grep_commit_pattern_type(enum grep_pattern_type pattern_type, struct grep_o
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, opt);
 }
 
-static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
+static struct grep_pat *create_grep_pat(struct grep_opt *opt,
+					const char *pat, size_t patlen,
 					const char *origin, int no,
 					enum grep_pat_token t,
 					enum grep_header_field field)
 {
 	struct grep_pat *p = xcalloc(1, sizeof(*p));
+
+#if defined(USE_LIBPCRE2) && defined(USE_NED_ALLOCATOR)
+	/* BUG: this is technically not needed if we will do UTF matching
+	 *      but UTF locale detection is currently broken  */
+	/* SMELL: opt shouldn't be needed at this level but it is used
+	 *        here to keep the way we were detecting the need for
+	 *        the chartable consistent and until it can be refactored
+	 *        properly.  the NULL check is needed as a workaround
+	 *        for segfaulting in t7810.102 and should also go */
+	/* TODO: has_non_ascii doesn't support NUL in pattern */
+	if (!pcre2_global_context && opt && opt->ignore_case &&
+		has_non_ascii(pat))
+		pcre2_global_context = pcre2_general_context_create(
+					pcre2_malloc, pcre2_free, NULL);
+#endif
+
 	p->pattern = xmemdupz(pat, patlen);
 	p->patternlen = patlen;
 	p->origin = origin;
@@ -291,8 +332,10 @@ static void do_append_grep_pat(struct grep_pat ***tail, struct grep_pat *p)
 			}
 			if (!nl)
 				break;
-			new_pat = create_grep_pat(nl + 1, len - 1, p->origin,
-						  p->no, p->token, p->field);
+
+			new_pat = create_grep_pat(NULL, nl + 1, len - 1,
+						p->origin, p->no, p->token,
+						p->field);
 			new_pat->next = p->next;
 			if (!p->next)
 				*tail = &new_pat->next;
@@ -309,8 +352,8 @@ static void do_append_grep_pat(struct grep_pat ***tail, struct grep_pat *p)
 void append_header_grep_pattern(struct grep_opt *opt,
 				enum grep_header_field field, const char *pat)
 {
-	struct grep_pat *p = create_grep_pat(pat, strlen(pat), "header", 0,
-					     GREP_PATTERN_HEAD, field);
+	struct grep_pat *p = create_grep_pat(opt, pat, strlen(pat), "header",
+					 0, GREP_PATTERN_HEAD, field);
 	if (field == GREP_HEADER_REFLOG)
 		opt->use_reflog_filter = 1;
 	do_append_grep_pat(&opt->header_tail, p);
@@ -325,7 +368,7 @@ void append_grep_pattern(struct grep_opt *opt, const char *pat,
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen,
 		     const char *origin, int no, enum grep_pat_token t)
 {
-	struct grep_pat *p = create_grep_pat(pat, patlen, origin, no, t, 0);
+	struct grep_pat *p = create_grep_pat(opt, pat, patlen, origin, no, t, 0);
 	do_append_grep_pat(&opt->pattern_tail, p);
 }
 
@@ -507,9 +550,14 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 
 	p->pcre2_compile_context = NULL;
 
+	/* pcre2_global_context is initialized in append_grep_pattern */
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern)) {
-			character_tables = pcre2_maketables(NULL);
+#ifdef USE_NED_ALLOCATOR
+			if (!pcre2_global_context)
+				BUG("pcre2_global_context uninitialized");
+#endif
+			character_tables = pcre2_maketables(pcre2_global_context);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
 			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
 		}
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

