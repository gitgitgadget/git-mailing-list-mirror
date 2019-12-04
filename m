Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A4CC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 20:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C815E2073B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 20:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vI2EYTh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfLDUjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:39:16 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:56401 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfLDUjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 15:39:15 -0500
Received: by mail-pj1-f74.google.com with SMTP id y11so493858pjr.23
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 12:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=iqzub3PKy3+znY6DUnqi40Vd38LdW1TTlT1J4bo602c=;
        b=vI2EYTh6CourgkOiqJxEii8jVPxKey9ze8lDvO6Uys4OGbKMDelMvmhkBigI6561IV
         iniH5rddGtL8+2BSqcYUvW7YYD5u7cw4cLixqqaSDc04Q4qmJHRpMdVPHdR/XHs0a+kX
         4par+k3l6BBHpgkwSDzYKS9PgWQzvCQJOT34eH3iiLnErwXEWORFkGxC7kTmvH0W1CLn
         bntkt8jodmU5oykdoJsvaFBFsLxHQUkau08VEed7WDUOLLVP+9b08LM3gECci/yhQb8v
         ucYHlpXor/u0afjUrvVD7tqQrV7kwN7D2u2aV5FB7eF/f15l2fFEn6ontAGbmTKsucQj
         x/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=iqzub3PKy3+znY6DUnqi40Vd38LdW1TTlT1J4bo602c=;
        b=spp0MN2WO/GGtYO64/6618itKUW/WIu0xatYoYv9So9wqH3QCWbGFdRpndi/XGPImR
         BeUMHb41h9CoC7ykvlltSXH9XdD3mpzYf7VoTZs+RFJQaqkASmBW3QgGmdC4akDVGYtw
         uScT+ixswa4/7qdu1nUxyIYr7nDm4SXNVnwXNUgWliAzTTFO2Oz32oyUqhdR4rRMF3MK
         n7/2TFFKBE4Uoy8HUu9s+jRMBeWJkN6uOLsa7SmvgMdoI5qXIp8YNBjl6xsTrmrn5GyT
         Ffc4/zR8oZmtEBk/jh5vQXbe/oxSGIkIsjv7SR0iSzUKZpSv0psDBUcQTMnxYOOLzEuu
         Gy1w==
X-Gm-Message-State: APjAAAUJIBAFE9pjUG9QxfdeIcBF545i1kPMj88JCNeU3YcDZliDA8oK
        cFv3T9bQfLAcMPvdDuLD8cLGDHmHFcGrfXW3Jj2ibFjJFe+MAYq4PTOOayGugjb15PmBsBf20ld
        Ga1z4sCixox1p6JoT4Kypz9flFABda3GIFk7DtFdKdBkoji0HOJFp4hhO7Y/qyy1YQxPLJhxz/Q
        ==
X-Google-Smtp-Source: APXvYqwqCFOph9OvydX004F6GkTa0mybFYiyLMCh2sW3OOpl+HYkO90Kdsv82OzdY4sV2dP+aM4Pq8Ig9aoxT7MLjs8=
X-Received: by 2002:a63:d501:: with SMTP id c1mr5343294pgg.356.1575491954657;
 Wed, 04 Dec 2019 12:39:14 -0800 (PST)
Date:   Wed,  4 Dec 2019 12:39:11 -0800
In-Reply-To: <20191122011646.218346-1-emilyshaffer@google.com>
Message-Id: <20191204203911.237056-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2] grep: support the --pathspec-from-file option
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git grep' to use OPT_PATHSPEC_FROM_FILE and update the
documentation accordingly.

This changes enables 'git grep' to receive the pathspec from a file by
specifying the path, or from stdin by specifying '-' as the path. This
matches the previous functionality of '-f', so the documentation of '-f'
has been expanded to describe this functionality. To let '-f' match the
new '--pathspec-from-file' option, also teach a '--patterns-from-file'
long name to '-f'.

Since there are now two arguments which can attempt to read from stdin,
add a safeguard to check whether the user specified '-' for both of
them. It is still possible for a user to pass '/dev/stdin' to one or
both arguments at present; we do not explicitly check.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Refactored to use am/pathspec-from-file. This changes the implementation
significantly since v1, but the testcases mostly remain the same.

This change builds on top of am/pathspec-from-file and is dependent on
at least "parse-options.h: add new options `--pathspec-from-file`,
`--pathspec-file-nul`". I followed the example of "commit: support the
--pathspec-from-file" option and retained the tests from v1 of this
topic.

 Documentation/git-grep.txt | 22 ++++++++++++++++--
 builtin/grep.c             | 35 ++++++++++++++++++++++++-----
 t/t7810-grep.sh            | 46 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index c89fb569e3..56b1c5a302 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -24,7 +24,8 @@ SYNOPSIS
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
 	   [--threads <num>]
-	   [-f <file>] [-e] <pattern>
+	   [-f | --patterns-from-file <file>] [-e] <pattern>
+	   [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [--recurse-submodules] [--parent-basename <basename>]
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
@@ -270,7 +271,10 @@ providing this option will cause it to die.
 	See `grep.threads` in 'CONFIGURATION' for more information.
 
 -f <file>::
-	Read patterns from <file>, one per line.
+--patterns-from-file <file>::
+	Read patterns from <file>, one per line. If `<file>` is exactly `-` then
+	standard input is used; standard input cannot be used for both
+	--patterns-from-file and --pathspec-from-file.
 +
 Passing the pattern via <file> allows for providing a search pattern
 containing a \0.
@@ -289,6 +293,20 @@ In future versions we may learn to support patterns containing \0 for
 more search backends, until then we'll die when the pattern type in
 question doesn't support them.
 
+--pathspec-from-file <file>::
+	Read pathspec from <file> instead of the command line. If `<file>` is
+	exactly `-` then standard input is used; standard input cannot be used
+	for both --patterns-from-file and --pathspec-from-file. Pathspec elements
+	are separated by LF or CR/LF. Pathspec elements can be quoted as
+	explained for the configuration variable `core.quotePath` (see
+	linkgit:git-config[1]). See also `--pathspec-file-nul` and global
+	`--literal-pathspecs`.
+
+--pathspec-file-nul::
+	Only meaningful with `--pathspec-from-file`. Pathspec elements are
+	separated with NUL character and all other characters are taken
+	literally (including newlines and quotes).
+
 -e::
 	The next parameter is the pattern. This option has to be
 	used for patterns starting with `-` and should be used in
diff --git a/builtin/grep.c b/builtin/grep.c
index 50ce8d9461..54ba991c42 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -31,6 +31,7 @@ static char const * const grep_usage[] = {
 };
 
 static int recurse_submodules;
+static int patterns_from_stdin, pathspec_from_stdin;
 
 #define GREP_NUM_THREADS_DEFAULT 8
 static int num_threads;
@@ -723,15 +724,18 @@ static int context_callback(const struct option *opt, const char *arg,
 static int file_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
-	int from_stdin;
 	FILE *patterns;
 	int lno = 0;
 	struct strbuf sb = STRBUF_INIT;
 
 	BUG_ON_OPT_NEG(unset);
 
-	from_stdin = !strcmp(arg, "-");
-	patterns = from_stdin ? stdin : fopen(arg, "r");
+	patterns_from_stdin = !strcmp(arg, "-");
+
+	if (patterns_from_stdin && pathspec_from_stdin)
+		die(_("cannot specify both patterns and pathspec via stdin"));
+
+	patterns = patterns_from_stdin ? stdin : fopen(arg, "r");
 	if (!patterns)
 		die_errno(_("cannot open '%s'"), arg);
 	while (strbuf_getline(&sb, patterns) == 0) {
@@ -742,7 +746,7 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 		append_grep_pat(grep_opt, sb.buf, sb.len, arg, ++lno,
 				GREP_PATTERN);
 	}
-	if (!from_stdin)
+	if (!patterns_from_stdin)
 		fclose(patterns);
 	strbuf_release(&sb);
 	return 0;
@@ -809,6 +813,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int use_index = 1;
 	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 	int allow_revs;
+	char *pathspec_from_file;
+	int pathspec_file_nul;
 
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
@@ -896,8 +902,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('W', "function-context", &opt.funcbody,
 			N_("show the surrounding function")),
 		OPT_GROUP(""),
-		OPT_CALLBACK('f', NULL, &opt, N_("file"),
+		OPT_CALLBACK('f', "patterns-from-file", &opt, N_("file"),
 			N_("read patterns from file"), file_callback),
+		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		{ OPTION_CALLBACK, 'e', NULL, &opt, N_("pattern"),
 			N_("match <pattern>"), PARSE_OPT_NONEG, pattern_callback },
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
@@ -1062,6 +1070,23 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
 
+	if (pathspec_from_file) {
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		pathspec_from_stdin = !strcmp(pathspec_from_file, "-");
+
+		if (patterns_from_stdin && pathspec_from_stdin)
+			die(_("cannot specify both patterns and pathspec via stdin"));
+
+		parse_pathspec_file(&pathspec, 0, PATHSPEC_PREFER_CWD |
+				    (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
+				    prefix, pathspec_from_file,
+				    pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
 	if (list.nr || cached || show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7d7b396c23..355890a72a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -549,6 +549,10 @@ test_expect_success 'grep -f, non-existent file' '
 	test_must_fail git grep -f patterns
 '
 
+text_expect_success 'grep --pathspec-from-file, non-existent file' '
+	test_must_fail git grep --pathspec-from-file pathspecs
+'
+
 cat >expected <<EOF
 file:foo mmap bar
 file:foo_mmap bar
@@ -582,8 +586,8 @@ mmap
 vvv
 EOF
 
-test_expect_success 'grep -f, multiple patterns' '
-	git grep -f patterns >actual &&
+test_expect_success 'grep --patterns-from-file, multiple patterns' '
+	git grep --patterns-from-file patterns >actual &&
 	test_cmp expected actual
 '
 
@@ -1125,6 +1129,44 @@ test_expect_success 'grep --no-index descends into repos, but not .git' '
 	)
 '
 
+test_expect_success 'setup pathspecs-file tests' '
+cat >excluded-file <<EOF &&
+bar
+EOF
+cat >pathspec-file <<EOF &&
+foo
+bar
+baz
+EOF
+cat >unrelated-file <<EOF &&
+xyz
+EOF
+git add excluded-file pathspec-file unrelated-file
+'
+
+cat >pathspecs <<EOF
+pathspec-file
+unrelated-file
+EOF
+
+cat >expected <<EOF
+pathspec-file:bar
+EOF
+
+test_expect_success 'grep --pathspec-from-file with file' '
+	git grep --pathspec-from-file pathspecs "bar" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --pathspec-file with stdin' '
+	git grep --pathspec-from-file - "bar" <pathspecs >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep with two stdin inputs fails' '
+	test_must_fail git grep --pathspec-from-file - --patterns-from-file - <pathspecs
+'
+
 test_expect_success 'setup double-dash tests' '
 cat >double-dash <<EOF &&
 --
-- 
2.24.0.393.g34dc348eaf-goog

