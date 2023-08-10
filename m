Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E513C41513
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjHJQiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbjHJQhe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:37:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FEB30D3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58419550c3aso14772407b3.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691685443; x=1692290243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeeSCGVal+lLSyuK1TBxWJ3N0STmynS4GPGYpM/R5aE=;
        b=xQHv6LtNAmWuvXZ+TJYLAcgE0H8w/1OiSh2NX6j4CKkg6ezep2TSIabWMLpDCdpg6k
         JOTYUTWk9u0Y4I4sh8wIwudUfdaGol1CLncADROuBkQSQ1gE4Zx5FgaWOPmzoS1afcDy
         GiczmPuaeZdvFO9D1Qm9TleN45bmey0UP6S5tVDyh9RyGUS51x+iUB7ohpGQeNLqo8OL
         rxiZG0R7/eUJhrHkZz591CjNtecsq6zbBwq+IvXmLVJzayBIpogke7+yyUJcZAsbTJ9b
         ddBUudniXxvlZcVM+oZk2scdk91In3zbEX6cwThq3Cbe4JNaxjJdeteYFJaUdTakLcg9
         4hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685443; x=1692290243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeeSCGVal+lLSyuK1TBxWJ3N0STmynS4GPGYpM/R5aE=;
        b=P0sQIoXUhiuTwehQqIxXF4nWFPnXGQ8vy50ClWbDTPqkOLm7rfc/Q4kVFwACOxY/fq
         AmgRxJJ5hu89iBSezchMOYD4gF5cTps14AdnYl70Mg1szSyxHNZIGrXASWfXdLRV6qbe
         oMYTBW2+C7lFkeEaLQdX3YedS2jEoSyNoG+KfZTZSf9v2/uq9Sc0XjHo0JWzXjWGna+C
         YvHqwZ+LwAUw5ngYlixRa/P/E5VKFNKsp/AE3BqglQGb8o8PGeyAZvnI019sA38LirJa
         hHKwda/xPE0tgdzTFhMHDMK+RgdPhNuTCGIyBCG4cooN2EYRaiF5Z2VT8Ryr3BQlsys3
         MBHA==
X-Gm-Message-State: AOJu0YyeJ77NBAMMl7mX7VMtWdMaR/whFtJoXRbq1sPSoQ2P2e9g7NQi
        Et7UrDOh7mZOy1dK+/Y3r2l0J8aoVmLC2VQ2qcTFQlm0ezqAFQdl7OHnHNFCBtvk8sN244Ttl0H
        +eAeYaUTG9oGWIMXQcXz/BRg4u1MHNs9c/AUv7dPx46CnkTOTmAbKummLhOffWZg53Q==
X-Google-Smtp-Source: AGHT+IFMxIMICHD+2danBkcFfpAZwBrJ8Q1ejXhKL99ShXmbLBZzWP+JxYIV8mF0BzNX+1x2ByIzFoWuo3mfLP8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:b654:0:b0:56c:e2da:f440 with SMTP id
 h20-20020a81b654000000b0056ce2daf440mr53736ywk.0.1691685442761; Thu, 10 Aug
 2023 09:37:22 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:36:54 +0000
In-Reply-To: <20230810163346.274132-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230810163346.274132-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810163654.275023-7-calvinwan@google.com>
Subject: [RFC PATCH v2 7/7] git-std-lib: add test file to call git-std-lib.a functions
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test file that directly or indirectly calls all functions defined in
git-std-lib.a object files to showcase that they do not reference
missing objects and that git-std-lib.a can stand on its own.

Certain functions that cause the program to exit or are already called
by other functions are commented out.

TODO: replace with unit tests
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 t/Makefile      |   4 +
 t/stdlib-test.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 t/stdlib-test.c

diff --git a/t/Makefile b/t/Makefile
index 3e00cdd801..b6d0bc9daa 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -150,3 +150,7 @@ perf:
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
 	check-chainlint clean-chainlint test-chainlint
+
+test-git-std-lib:
+	cc -It -o stdlib-test stdlib-test.c -L. -l:../git-std-lib.a
+	./stdlib-test
diff --git a/t/stdlib-test.c b/t/stdlib-test.c
new file mode 100644
index 0000000000..a5d7374e2f
--- /dev/null
+++ b/t/stdlib-test.c
@@ -0,0 +1,239 @@
+#include "../git-compat-util.h"
+#include "../abspath.h"
+#include "../hex-ll.h"
+#include "../parse.h"
+#include "../strbuf.h"
+#include "../string-list.h"
+
+/*
+ * Calls all functions from git-std-lib
+ * Some inline/trivial functions are skipped
+ */
+
+void abspath_funcs(void) {
+	struct strbuf sb = STRBUF_INIT;
+
+	fprintf(stderr, "calling abspath functions\n");
+	is_directory("foo");
+	strbuf_realpath(&sb, "foo", 0);
+	strbuf_realpath_forgiving(&sb, "foo", 0);
+	real_pathdup("foo", 0);
+	absolute_path("foo");
+	absolute_pathdup("foo");
+	prefix_filename("foo/", "bar");
+	prefix_filename_except_for_dash("foo/", "bar");
+	is_absolute_path("foo");
+	strbuf_add_absolute_path(&sb, "foo");
+	strbuf_add_real_path(&sb, "foo");
+}
+
+void hex_ll_funcs(void) {
+	unsigned char c;
+
+	fprintf(stderr, "calling hex-ll functions\n");
+
+	hexval('c');
+	hex2chr("A1");
+	hex_to_bytes(&c, "A1", 2);
+}
+
+void parse_funcs(void) {
+	intmax_t foo;
+	ssize_t foo1 = -1;
+	unsigned long foo2;
+	int foo3;
+	int64_t foo4;
+
+	fprintf(stderr, "calling parse functions\n");
+
+	git_parse_signed("42", &foo, maximum_signed_value_of_type(int));
+	git_parse_ssize_t("42", &foo1);
+	git_parse_ulong("42", &foo2);
+	git_parse_int("42", &foo3);
+	git_parse_int64("42", &foo4);
+	git_parse_maybe_bool("foo");
+	git_parse_maybe_bool_text("foo");
+	git_env_bool("foo", 1);
+	git_env_ulong("foo", 1);
+}
+
+static int allow_unencoded_fn(char ch) {
+	return 0;
+}
+
+void strbuf_funcs(void) {
+	struct strbuf *sb = xmalloc(sizeof(void*));
+	struct strbuf *sb2 = xmalloc(sizeof(void*));
+	struct strbuf sb3 = STRBUF_INIT;
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	char *buf = "foo";
+	struct strbuf_expand_dict_entry dict[] = {
+		{ "foo", NULL, },
+		{ "bar", NULL, },
+	};
+	int fd = open("/dev/null", O_RDONLY);
+
+	fprintf(stderr, "calling strbuf functions\n");
+
+	starts_with("foo", "bar");
+	istarts_with("foo", "bar");
+	// skip_to_optional_arg_default(const char *str, const char *prefix,
+	// 			 const char **arg, const char *def)
+	strbuf_init(sb, 0);
+	strbuf_init(sb2, 0);
+	strbuf_release(sb);
+	strbuf_attach(sb, strbuf_detach(sb, NULL), 0, 0); // calls strbuf_grow
+	strbuf_swap(sb, sb2);
+	strbuf_setlen(sb, 0);
+	strbuf_trim(sb); // calls strbuf_rtrim, strbuf_ltrim
+	// strbuf_rtrim() called by strbuf_trim()
+	// strbuf_ltrim() called by strbuf_trim()
+	strbuf_trim_trailing_dir_sep(sb);
+	strbuf_trim_trailing_newline(sb);
+	strbuf_reencode(sb, "foo", "bar");
+	strbuf_tolower(sb);
+	strbuf_add_separated_string_list(sb, " ", &list);
+	strbuf_list_free(strbuf_split_buf("foo bar", 8, ' ', -1));
+	strbuf_cmp(sb, sb2);
+	strbuf_addch(sb, 1);
+	strbuf_splice(sb, 0, 1, "foo", 3);
+	strbuf_insert(sb, 0, "foo", 3);
+	// strbuf_vinsertf() called by strbuf_insertf
+	strbuf_insertf(sb, 0, "%s", "foo");
+	strbuf_remove(sb, 0, 1);
+	strbuf_add(sb, "foo", 3);
+	strbuf_addbuf(sb, sb2);
+	strbuf_join_argv(sb, 0, NULL, ' ');
+	strbuf_addchars(sb, 1, 1);
+	strbuf_addf(sb, "%s", "foo");
+	strbuf_add_commented_lines(sb, "foo", 3, '#');
+	strbuf_commented_addf(sb, '#', "%s", "foo");
+	// strbuf_vaddf() called by strbuf_addf()
+	strbuf_expand(sb, "%s", strbuf_expand_literal_cb, NULL);
+	strbuf_expand(sb, "%s", strbuf_expand_dict_cb, &dict);
+	// strbuf_expand_literal_cb() called by strbuf_expand()
+	// strbuf_expand_dict_cb() called by strbuf_expand()
+	strbuf_addbuf_percentquote(sb, &sb3);
+	strbuf_add_percentencode(sb, "foo", STRBUF_ENCODE_SLASH);
+	strbuf_fread(sb, 0, stdin);
+	strbuf_read(sb, fd, 0);
+	strbuf_read_once(sb, fd, 0);
+	strbuf_write(sb, stderr);
+	strbuf_readlink(sb, "/dev/null", 0);
+	strbuf_getcwd(sb);
+	strbuf_getwholeline(sb, stderr, '\n');
+	strbuf_appendwholeline(sb, stderr, '\n');
+	strbuf_getline(sb, stderr);
+	strbuf_getline_lf(sb, stderr);
+	strbuf_getline_nul(sb, stderr);
+	strbuf_getwholeline_fd(sb, fd, '\n');
+	strbuf_read_file(sb, "/dev/null", 0);
+	strbuf_add_lines(sb, "foo", "bar", 0);
+	strbuf_addstr_xml_quoted(sb, "foo");
+	strbuf_addstr_urlencode(sb, "foo", allow_unencoded_fn);
+	strbuf_humanise_bytes(sb, 42);
+	strbuf_humanise_rate(sb, 42);
+	printf_ln("%s", sb);
+	fprintf_ln(stderr, "%s", sb);
+	xstrdup_tolower("foo");
+	xstrdup_toupper("foo");
+	// xstrvfmt() called by xstrfmt()
+	xstrfmt("%s", "foo");
+	// strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
+	// 	     int tz_offset, int suppress_tz_name)
+	// strbuf_stripspace(struct strbuf *sb, char comment_line_char)
+	// strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
+	// strbuf_strip_file_from_path(struct strbuf *sb)
+}
+
+static void error_builtin(const char *err, va_list params) {}
+static void warn_builtin(const char *err, va_list params) {}
+
+static report_fn error_routine = error_builtin;
+static report_fn warn_routine = warn_builtin;
+
+void usage_funcs(void) {
+	fprintf(stderr, "calling usage functions\n");
+	// Functions that call exit() are commented out
+
+	// usage()
+	// usagef()
+	// die()
+	// die_errno();
+	error("foo");
+	error_errno("foo");
+	die_message("foo");
+	die_message_errno("foo");
+	warning("foo");
+	warning_errno("foo");
+
+	// set_die_routine();
+	get_die_message_routine();
+	set_error_routine(error_builtin);
+	get_error_routine();
+	set_warn_routine(warn_builtin);
+	get_warn_routine();
+	// set_die_is_recursing_routine();
+}
+
+void wrapper_funcs(void) {
+	void *ptr = xmalloc(1);
+	int fd = open("/dev/null", O_RDONLY);
+	struct strbuf sb = STRBUF_INIT;
+	int mode = 0444;
+	char host[PATH_MAX], path[PATH_MAX], path1[PATH_MAX];
+	xsnprintf(path, sizeof(path), "out-XXXXXX");
+	xsnprintf(path1, sizeof(path1), "out-XXXXXX");
+	int tmp;
+
+	fprintf(stderr, "calling wrapper functions\n");
+
+	xstrdup("foo");
+	xmalloc(1);
+	xmallocz(1);
+	xmallocz_gently(1);
+	xmemdupz("foo", 3);
+	xstrndup("foo", 3);
+	xrealloc(ptr, 2);
+	xcalloc(1, 1);
+	xsetenv("foo", "bar", 0);
+	xopen("/dev/null", O_RDONLY);
+	xread(fd, &sb, 1);
+	xwrite(fd, &sb, 1);
+	xpread(fd, &sb, 1, 0);
+	xdup(fd);
+	xfopen("/dev/null", "r");
+	xfdopen(fd, "r");
+	tmp = xmkstemp(path);
+	close(tmp);
+	unlink(path);
+	tmp = xmkstemp_mode(path1, mode);
+	close(tmp);
+	unlink(path1);
+	xgetcwd();
+	fopen_for_writing(path);
+	fopen_or_warn(path, "r");
+	xstrncmpz("foo", "bar", 3);
+	// xsnprintf() called above
+	xgethostname(host, 3);
+	tmp = git_mkstemps_mode(path, 1, mode);
+	close(tmp);
+	unlink(path);
+	tmp = git_mkstemp_mode(path, mode);
+	close(tmp);
+	unlink(path);
+	read_in_full(fd, &sb, 1);
+	write_in_full(fd, &sb, 1);
+	pread_in_full(fd, &sb, 1, 0);
+}
+
+int main() {
+	abspath_funcs();
+	hex_ll_funcs();
+	parse_funcs();
+	strbuf_funcs();
+	usage_funcs();
+	wrapper_funcs();
+	fprintf(stderr, "all git-std-lib functions finished calling\n");
+	return 0;
+}
-- 
2.41.0.640.ga95def55d0-goog

