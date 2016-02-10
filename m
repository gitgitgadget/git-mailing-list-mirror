From: larsxschneider@gmail.com
Subject: [PATCH v2] config: add '--sources' option to print the source of a config value
Date: Wed, 10 Feb 2016 11:13:18 +0100
Message-ID: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
Cc: sschuberth@gmail.com, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 11:13:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTRmA-0007ci-7K
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 11:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757474AbcBJKN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 05:13:28 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35862 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbcBJKNW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 05:13:22 -0500
Received: by mail-wm0-f51.google.com with SMTP id p63so20857200wmp.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 02:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Edxlmobz/dgYxcyEF2mtXH3kuggjKNsq4lhsWpIjpXw=;
        b=ysqkIA0mRGcUdbESX2jv+8d+sGNB9IViQ+xLo9+zv26lkKNiMgKSmrXxXB8vnIiXvf
         Jks9pJwMzhdBk9U1Q/3Cnn+yB8G7zO+1qiW81rlON3GD2KRwPNOxLaw9a6xFR4L7Q8g6
         4UuDepLRug0f+viXJgV8mf8T/f8ru9c0xI9SvBDbRH0lbC8NNXzwUMerhxdsp+O8+h5j
         lE7JcjCZbLAFHqANrwdyeVdk7CxrrIpsxd2fMNT2XgkSoXINP7xMk8uh4pCjAD3cBN5J
         YdOLXzkYwUrNr1d6QS00axdYp44Mfbwa6VoVIS6fUAgbVB8lkYdRgnIZ56625IYYE47a
         MUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Edxlmobz/dgYxcyEF2mtXH3kuggjKNsq4lhsWpIjpXw=;
        b=UZlLUPducT/x6pBxtjUl99Ft2uTGqM5KzwwQ+diNUVWYskTlZu50LmFso4wYgE/ZAX
         xlsw98pLun0HrZI09886QDUQjaZyuiAeGxZ7WzJr8wfpeUuHV19XA/8tfZ3D1athqhlS
         ciouuyCo9hxPhT1AI/dyh8EKha/DzGB/MgT4m8bvNg7/+M/qSX0DXvGBBSO39BxcXTwL
         7DIDP0oVGzZDWEri1tJrNn/Dr8Z29BJuU+nxE/dF5gRli89A39cwwZAAN+LQAyZUTVaV
         8ztwp7xpqLCN4H+kICVqLXUPfJ5GE54DuMtbQIQulkUP5wY4cgZtX6OlgmXf0Eolg7OM
         pOBA==
X-Gm-Message-State: AG10YORQOTzkOozGpCT8YZsGzGOPsLlj4X8yaG8lEcoQIVpPxhXJv7iAX5u9f5Q9dCvdXw==
X-Received: by 10.28.226.6 with SMTP id z6mr9646325wmg.44.1455099201184;
        Wed, 10 Feb 2016 02:13:21 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB42B7.dip0.t-ipconnect.de. [93.219.66.183])
        by smtp.gmail.com with ESMTPSA id yz5sm2214531wjc.36.2016.02.10.02.13.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Feb 2016 02:13:20 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285894>

From: Lars Schneider <larsxschneider@gmail.com>

If config values are queried using 'git config' (e.g. via '--list' flag
or the '--get*' flags) then it is sometimes hard to find the
configuration file where the values were defined.

Teach 'git config' the '--sources' option to print the source
configuration file for every printed value.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

diff to v1:

* add documention
* produce a consistent (tab-delimited) format that can be parsed
* adhere declaration-after-statement style
* prefix every source line with the source type (file, stdin, blob, cmd)
* add relative path test case
* add blob ref test case
* add "git config --local" test case (Note: I think I found a bug there that I
  plan to fix/investigate in a seperate patch. Is it ok to leave the TODO?)
* add a test case to check funny character escapes (file name with tabs)

Sebastian suggested "--show-origin" as a better option name over "--sources".
I still believe "--sources" might be slightly better as I fear that users could
somehow related "origin" to "remote" kind of configs. However, I am happy to
change that if a majority prefers "--show-origin".

Thanks to Peff and Sebastian for the review,
Lars

 Documentation/git-config.txt |  15 ++++--
 builtin/config.c             |  66 ++++++++++++++++++++++++++
 cache.h                      |   1 +
 config.c                     |   9 +++-
 t/t1300-repo-config.sh       | 109 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 194 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 2608ca7..8c4969f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,18 +9,18 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [type] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [type] [--sources] [-z|--null] name [value [value_regex]]
 'git config' [<file-option>] [type] --add name value
 'git config' [<file-option>] [type] --replace-all name value [value_regex]
-'git config' [<file-option>] [type] [-z|--null] --get name [value_regex]
-'git config' [<file-option>] [type] [-z|--null] --get-all name [value_regex]
-'git config' [<file-option>] [type] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [type] [--sources] [-z|--null] --get name [value_regex]
+'git config' [<file-option>] [type] [--sources] [-z|--null] --get-all name [value_regex]
+'git config' [<file-option>] [type] [--sources] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name URL
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
-'git config' [<file-option>] [-z|--null] [--name-only] -l | --list
+'git config' [<file-option>] [--sources] [-z|--null] [--name-only] -l | --list
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
 'git config' [<file-option>] -e | --edit
@@ -194,6 +194,11 @@ See also <<FILES>>.
 	Output only the names of config variables for `--list` or
 	`--get-regexp`.

+--sources::
+	Augment the output of all queried config options with the
+	source type (file, stdin, blob, cmd) and the actual source
+	(config file path, ref, or blob id if applicable).
+
 --get-colorbool name [stdout-is-tty]::

 	Find the color setting for `name` (e.g. `color.diff`) and output
diff --git a/builtin/config.c b/builtin/config.c
index adc7727..78f3344 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -3,6 +3,7 @@
 #include "color.h"
 #include "parse-options.h"
 #include "urlmatch.h"
+#include "quote.h"

 static const char *const builtin_config_usage[] = {
 	N_("git config [<options>]"),
@@ -27,6 +28,7 @@ static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
 static int end_null;
 static int respect_includes = -1;
+static int show_sources;

 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -81,6 +83,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes, N_("respect include directives on lookup")),
+	OPT_BOOL(0, "sources", &show_sources, N_("show source filenames of config")),
 	OPT_END(),
 };

@@ -91,8 +94,58 @@ static void check_argc(int argc, int min, int max) {
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }

+/* output to either fp or buf; only one should be non-NULL */
+static void show_config_source(struct strbuf *buf, FILE *fp)
+{
+	char term = '\t';
+	char *prefix;
+	const char *fn = current_config_filename();
+
+	if (end_null)
+		term = '\0';
+
+	if (fn) {
+		if (given_config_source.use_stdin)
+			prefix = "stdin";
+		else if (given_config_source.blob)
+			prefix = "blob";
+		else
+			prefix = "file";
+	} else {
+		fn = "";
+		prefix = "cmd";
+	}
+
+	if (fp)
+		fprintf(fp, "%s", prefix);
+	else {
+		strbuf_addstr(buf, prefix);
+	}
+
+	if (fp)
+		fputc(term, fp);
+	else
+		strbuf_addch(buf, term);
+
+	if (!end_null)
+		quote_c_style(fn, buf, fp, 0);
+	else {
+		if (fp)
+			fprintf(fp, "%s", fn);
+		else
+			strbuf_addstr(buf, fn);
+	}
+
+	if (fp)
+		fputc(term, fp);
+	else
+		strbuf_addch(buf, term);
+}
+
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
+	if (show_sources)
+		show_config_source(NULL, stdout);
 	if (!omit_values && value_)
 		printf("%s%c%s%c", key_, delim, value_, term);
 	else
@@ -108,6 +161,8 @@ struct strbuf_list {

 static int format_config(struct strbuf *buf, const char *key_, const char *value_)
 {
+	if (show_sources)
+		show_config_source(buf, NULL);
 	if (show_keys)
 		strbuf_addstr(buf, key_);
 	if (!omit_values) {
@@ -451,6 +506,7 @@ static char *default_user_config(void)
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
+	int is_query_action = 0;
 	char *value;

 	given_config_source.file = getenv(CONFIG_ENVIRONMENT);
@@ -538,6 +594,16 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		error("--name-only is only applicable to --list or --get-regexp");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
+
+	is_query_action = actions & (
+		ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST
+	);
+
+	if (show_sources && !is_query_action) {
+		error("--sources is only applicable to --list or --get-* actions");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
diff --git a/cache.h b/cache.h
index c63fcc1..c5111ea 100644
--- a/cache.h
+++ b/cache.h
@@ -1525,6 +1525,7 @@ extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);

 extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
+extern const char *current_config_filename(void);

 struct config_include_data {
 	int depth;
diff --git a/config.c b/config.c
index 86a5eb2..204e6b7 100644
--- a/config.c
+++ b/config.c
@@ -1078,7 +1078,7 @@ static int do_config_from_file(config_fn_t fn,

 static int git_config_from_stdin(config_fn_t fn, void *data)
 {
-	return do_config_from_file(fn, "<stdin>", NULL, stdin, data);
+	return do_config_from_file(fn, "", NULL, stdin, data);
 }

 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
@@ -2385,3 +2385,10 @@ int parse_config_key(const char *var,

 	return 0;
 }
+
+const char *current_config_filename(void)
+{
+	if (cf && cf->name)
+		return cf->name;
+	return NULL;
+}
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 52678e7..d69974e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1201,4 +1201,113 @@ test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
 '

+test_expect_success '--sources' '
+	>.git/config &&
+	>"$HOME"/.gitconfig &&
+	INCLUDE_DIR="$HOME/include" &&
+	mkdir -p "$INCLUDE_DIR" &&
+	cat >"$INCLUDE_DIR"/absolute.include <<-EOF &&
+		[user]
+			absolute = include
+	EOF
+	cat >"$INCLUDE_DIR"/relative.include <<-EOF &&
+		[user]
+			relative = include
+	EOF
+	CUSTOM_CONFIG_FILE="file\twith\ttabs.conf" &&
+	cat >"$CUSTOM_CONFIG_FILE" <<-EOF &&
+		[user]
+			custom = true
+	EOF
+	test_config_global user.global "true" &&
+	test_config_global user.override "global" &&
+	test_config_global include.path "$INCLUDE_DIR"/absolute.include &&
+	test_config include.path ../include/relative.include &&
+	test_config user.local "true" &&
+	test_config user.override "local" &&
+
+	cat >expect <<-EOF &&
+		file	$HOME/.gitconfig	user.global=true
+		file	$HOME/.gitconfig	user.override=global
+		file	$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
+		file	$INCLUDE_DIR/absolute.include	user.absolute=include
+		file	.git/config	include.path=../include/relative.include
+		file	.git/../include/relative.include	user.relative=include
+		file	.git/config	user.local=true
+		file	.git/config	user.override=local
+		cmd		user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --sources >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		fileQ$HOME/.gitconfigQuser.global
+		trueQfileQ$HOME/.gitconfigQuser.override
+		globalQfileQ$HOME/.gitconfigQinclude.path
+		$INCLUDE_DIR/absolute.includeQfileQ$INCLUDE_DIR/absolute.includeQuser.absolute
+		includeQfileQ.git/configQinclude.path
+		../include/relative.includeQfileQ.git/../include/relative.includeQuser.relative
+		includeQfileQ.git/configQuser.local
+		trueQfileQ.git/configQuser.override
+		localQcmdQQuser.cmdline
+		trueQ
+	EOF
+	git -c user.cmdline=true config --null --list --sources | nul_to_q >output &&
+	echo >>output &&
+	test_cmp expect output &&
+
+	# TODO:
+	# The locally included config value is not printed below. I think
+	# this is a bug.
+	# "file	.git/../include/relative.include	user.relative=include"
+	#
+	cat >expect <<-EOF &&
+		file	.git/config	include.path=../include/relative.include
+		file	.git/config	user.local=true
+		file	.git/config	user.override=local
+		EOF
+	git config --local --list --sources >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		file	$HOME/.gitconfig	user.global true
+		file	.git/config	user.local true
+	EOF
+	git config --sources --get-regexp "user\.[g|l].*" >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		file	.git/config	local
+	EOF
+	git config --sources user.override >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		file	"file\\\twith\\\ttabs.conf"	user.custom=true
+	EOF
+	git config --file "$CUSTOM_CONFIG_FILE" --sources --list >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		stdin		user.custom=true
+	EOF
+	git config --file - --sources --list <"$CUSTOM_CONFIG_FILE" >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		blob	a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08	user.custom=true
+	EOF
+	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
+	git config --blob=$blob --sources --list >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		blob	"master:file\\\twith\\\ttabs.conf"	user.custom=true
+	EOF
+	git add "$CUSTOM_CONFIG_FILE" &&
+	git commit -m "blubb" &&
+	git config --blob=master:"$CUSTOM_CONFIG_FILE" --sources --list >output &&
+	test_cmp expect output
+'
+
 test_done
--
2.5.1
