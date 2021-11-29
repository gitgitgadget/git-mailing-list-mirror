Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1098DC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379306AbhK2Sbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378463AbhK2S3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:29:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5682C12B688
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:51:03 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j3so37417530wrp.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91NwFqjJFS4gpGXTeOfdS1oCedxkdgTYAJKBG1LEYNQ=;
        b=daMZCfQr4C00Cnontp47TuWPzoCFMXfRrL3F+11pEbBjLg9PkFET9inuYVagEiPpaZ
         FWmg5EZM8YF1D0KgpaIVxn1rtmub+mk1reO9REvkYX3zAVpcZBz0T24AKZjniBr31hn+
         ljX4SH80xa0FIQJLKnUw1PXCtcBTmZslFnbBZDGlaTrnC28VCdl+HvPi6HZBh2L3wGM9
         82G9UcrWWZyzq2Eu1w/7ZKGkLxTtO6ibT5DEnoZOJU8HMlRs71SAvwaKljVs2a+ouB7Q
         BH8H3BGJWPc6VrTYDESUWKvyk/J8CTLIS8ySvZRIQjVQ8A3NaxKB98ygJyP9a+7Q5de3
         y0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91NwFqjJFS4gpGXTeOfdS1oCedxkdgTYAJKBG1LEYNQ=;
        b=lcY4K3MJwZehavJqITIq+CKuWvTKkZc5r3xCVVbCX7N+hBO/oU014spfIveuhAKCKg
         my6iemnT3738aJoCjee7Wg50G6dAoH1CM5tf3NTu7pGvgXQ+2uNVhfgh6nF78lrfo6Ht
         8nP0Zf7fjQG5D8+r4lmV01YTfJfWSjrRhAm8cTjYkYLvOFqmwzw8DDCLJAiY1IbyUUh6
         x5Of9UYjy/XeuHjvK6W+MODxlw2T1PvIUog19S3CtcN23BgZ0Efr5DtvZ98OFVS9FfTM
         FC8ClaVwc0hboUfIMAVI2adDU0y8suZr/gLljoEwbM5cdCEdfVCGjGcgFI7qa5im6Uy4
         qhpA==
X-Gm-Message-State: AOAM532YINEypM24q2FY80cImC3TWjahD2jUSdTeOn2kZ3fZCJZPCHqu
        VbwoM7M7bhVUIZi8RyJIpmYDeqKRSLoczg==
X-Google-Smtp-Source: ABdhPJws78voxSCbuIxA/IP5bs0Tl9gJTCDQzUseCc9kDlPsNaGCmx3JK8KNeYpyHvqbJgTk7q3H2g==
X-Received: by 2002:a5d:4d11:: with SMTP id z17mr34109865wrt.458.1638197462135;
        Mon, 29 Nov 2021 06:51:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b11sm19579946wmj.35.2021.11.29.06.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:51:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/7] grep API: call grep_config() after grep_init()
Date:   Mon, 29 Nov 2021 15:50:52 +0100
Message-Id: <patch-v3-6.7-4e1be7c165b-20211129T143956Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The grep_init() function used the odd pattern of initializing the
passed-in "struct grep_opt" with a statically defined "grep_defaults"
struct, which would be modified in-place when we invoked
grep_config().

So we effectively (b) initialized config, (a) then defaults, (c)
followed by user options. Usually those are ordered as "a", "b" and
"c" instead.

As the comments being removed here show the previous behavior needed
to be carefully explained as we'd potentially share the populated
configuration among different instances of grep_init(). In practice we
didn't do that, but now that it can't be a concern anymore let's
remove those comments.

This does not change the behavior of any of the configuration
variables or options. That would have been the case if we didn't move
around the grep_config() call in "builtin/log.c". But now that we call
"grep_config" after "git_log_config" and "git_format_config" we'll
need to pass in the already initialized "struct grep_opt *".

See 6ba9bb76e02 (grep: copy struct in one fell swoop, 2020-11-29) and
7687a0541e0 (grep: move the configuration parsing logic to grep.[ch],
2012-10-09) for the commits that added the comments.

The memcpy() pattern here will be optimized away and follows the
convention of other *_init() functions. See 5726a6b4012 (*.c *_init():
define in terms of corresponding *_INIT macro, 2021-07-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c |  4 ++--
 builtin/log.c  | 13 +++++++++++--
 grep.c         | 39 +++------------------------------------
 grep.h         | 21 +++++++++++++++++++++
 4 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5ec4cecae45..0ea124321b6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,7 +285,7 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, NULL);
+	int st = grep_config(var, value, cb);
 	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
@@ -966,8 +966,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	};
 	grep_prefix = prefix;
 
-	git_config(grep_cmd_config, NULL);
 	grep_init(&opt, the_repository);
+	git_config(grep_cmd_config, &opt);
 
 	/*
 	 * If there is no -- then the paths must exist in the working
diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7f..bfddacdfa6c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -505,8 +505,6 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (grep_config(var, value, cb) < 0)
-		return -1;
 	if (git_gpg_config(var, value, cb) < 0)
 		return -1;
 	return git_diff_ui_config(var, value, cb);
@@ -521,6 +519,8 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	git_config(git_log_config, NULL);
 
 	repo_init_revisions(the_repository, &rev, prefix);
+	git_config(grep_config, &rev.grep_filter);
+
 	rev.diff = 1;
 	rev.simplify_history = 0;
 	memset(&opt, 0, sizeof(opt));
@@ -635,6 +635,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 
 	memset(&match_all, 0, sizeof(match_all));
 	repo_init_revisions(the_repository, &rev, prefix);
+	git_config(grep_config, &rev.grep_filter);
+
 	rev.diff = 1;
 	rev.always_show_header = 1;
 	rev.no_walk = 1;
@@ -718,6 +720,8 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 
 	repo_init_revisions(the_repository, &rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
+	git_config(grep_config, &rev.grep_filter);
+
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
@@ -751,6 +755,8 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	git_config(git_log_config, NULL);
 
 	repo_init_revisions(the_repository, &rev, prefix);
+	git_config(grep_config, &rev.grep_filter);
+
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
@@ -1833,10 +1839,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_hdr.strdup_strings = 1;
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
+
 	init_log_defaults();
 	init_display_notes(&notes_opt);
 	git_config(git_format_config, NULL);
 	repo_init_revisions(the_repository, &rev, prefix);
+	git_config(grep_config, &rev.grep_filter);
+
 	rev.show_notes = show_notes;
 	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
 	rev.commit_format = CMIT_FMT_EMAIL;
diff --git a/grep.c b/grep.c
index 12b202598a9..8dfa0300786 100644
--- a/grep.c
+++ b/grep.c
@@ -19,27 +19,6 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 	fwrite(buf, size, 1, stdout);
 }
 
-static struct grep_opt grep_defaults = {
-	.relative = 1,
-	.pathname = 1,
-	.max_depth = -1,
-	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED,
-	.colors = {
-		[GREP_COLOR_CONTEXT] = "",
-		[GREP_COLOR_FILENAME] = "",
-		[GREP_COLOR_FUNCTION] = "",
-		[GREP_COLOR_LINENO] = "",
-		[GREP_COLOR_COLUMNNO] = "",
-		[GREP_COLOR_MATCH_CONTEXT] = GIT_COLOR_BOLD_RED,
-		[GREP_COLOR_MATCH_SELECTED] = GIT_COLOR_BOLD_RED,
-		[GREP_COLOR_SELECTED] = "",
-		[GREP_COLOR_SEP] = GIT_COLOR_CYAN,
-	},
-	.only_matching = 0,
-	.color = -1,
-	.output = std_output,
-};
-
 static const char *color_grep_slots[] = {
 	[GREP_COLOR_CONTEXT]	    = "context",
 	[GREP_COLOR_FILENAME]	    = "filename",
@@ -75,20 +54,12 @@ define_list_config_array_extra(color_grep_slots, {"match"});
  */
 int grep_config(const char *var, const char *value, void *cb)
 {
-	struct grep_opt *opt = &grep_defaults;
+	struct grep_opt *opt = cb;
 	const char *slot;
 
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
-	/*
-	 * The instance of grep_opt that we set up here is copied by
-	 * grep_init() to be used by each individual invocation.
-	 * When populating a new field of this structure here, be
-	 * sure to think about ownership -- e.g., you might need to
-	 * override the shallow copy in grep_init() with a deep copy.
-	 */
-
 	if (!strcmp(var, "grep.extendedregexp")) {
 		opt->extended_regexp_option = git_config_bool(var, value);
 		return 0;
@@ -134,14 +105,10 @@ int grep_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-/*
- * Initialize one instance of grep_opt and copy the
- * default values from the template we read the configuration
- * information in an earlier call to git_config(grep_config).
- */
 void grep_init(struct grep_opt *opt, struct repository *repo)
 {
-	*opt = grep_defaults;
+	struct grep_opt blank = GREP_OPT_INIT;
+	memcpy(opt, &blank, sizeof(*opt));
 
 	opt->repo = repo;
 	opt->pattern_tail = &opt->pattern_list;
diff --git a/grep.h b/grep.h
index 62deadb885f..b651eb291f7 100644
--- a/grep.h
+++ b/grep.h
@@ -177,6 +177,27 @@ struct grep_opt {
 	void *output_priv;
 };
 
+#define GREP_OPT_INIT { \
+	.relative = 1, \
+	.pathname = 1, \
+	.max_depth = -1, \
+	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
+	.colors = { \
+		[GREP_COLOR_CONTEXT] = "", \
+		[GREP_COLOR_FILENAME] = "", \
+		[GREP_COLOR_FUNCTION] = "", \
+		[GREP_COLOR_LINENO] = "", \
+		[GREP_COLOR_COLUMNNO] = "", \
+		[GREP_COLOR_MATCH_CONTEXT] = GIT_COLOR_BOLD_RED, \
+		[GREP_COLOR_MATCH_SELECTED] = GIT_COLOR_BOLD_RED, \
+		[GREP_COLOR_SELECTED] = "", \
+		[GREP_COLOR_SEP] = GIT_COLOR_CYAN, \
+	}, \
+	.only_matching = 0, \
+	.color = -1, \
+	.output = std_output, \
+}
+
 int grep_config(const char *var, const char *value, void *);
 void grep_init(struct grep_opt *, struct repository *repo);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
-- 
2.34.1.841.gf15fb7e6f34

