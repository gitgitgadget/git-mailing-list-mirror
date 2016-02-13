From: larsxschneider@gmail.com
Subject: [PATCH v3 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Sat, 13 Feb 2016 15:24:16 +0100
Message-ID: <1455373456-64691-4-git-send-email-larsxschneider@gmail.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 15:25:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUb8I-0007rJ-Az
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 15:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbcBMOZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 09:25:04 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35570 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcBMOYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 09:24:24 -0500
Received: by mail-wm0-f67.google.com with SMTP id g62so7719914wme.2
        for <git@vger.kernel.org>; Sat, 13 Feb 2016 06:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G6L/oakI2Xi+lrriIEP3R809pd0F8CEFBDbsctpN6tI=;
        b=q9T/cRBWdgaZiZEEw6zhlv5pDhzamx8THpNa2rQtkMTRdtiTr7Zdk26mTs907Eio2Y
         xPxnmWTagA0SJjY8JC6PkcJUNa2R4vWELRsuSKV40ZtVT6AQ+hoTDc+eb5bE9zHwY/hv
         WnvzqwNunh1nuRy/CCbgJS47hN3KpL6f2M5IZOAByfJy51USpJM6v81eqd1ea/tUG4yC
         WRZoP2kku+ctG96LitDAjjPR9KYm4qFkfEDDSMBWXsnQUPxd2cY10ejkUrvDWNY5ItgD
         dxc3fP32TLHRq29b/OKMBY25LfVyRUSCk9PTGQa5DMgqsov7MPtalPuN+w58A6b1XSaQ
         hE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G6L/oakI2Xi+lrriIEP3R809pd0F8CEFBDbsctpN6tI=;
        b=VvGpatMBp1foHMq8CXIx85AsUbaYOGgTdxwRgy733GtxlqVt+WLQsOr2HDb2SRXr5F
         eod84kR6iFsSbT0VmArjluiEnaxW63YV9LOE+UO8Ry3CVnLoUWpy7eTSBhqabp6wVYBh
         Si1KL/S0UZRAsADmq6/UU89NHyo4DFQQXSIVGYPxNydDr9Pqo/y8XXQYs36E3udzxcvL
         Qrdwi8spX9mEDupRh/5Pj75cb8Py6wjm3WuS6lL2/jO8sJd6oUG7iWMzc9ffnptu5vXz
         syLz/zogyCaEd3/JTMs3obhvgtO2lE3W5liCL7XOYuitd6hSA6JRN+lQUerqnuSe1+z3
         FIKQ==
X-Gm-Message-State: AG10YOT0outaVYeTJQcAJy+dpXnQQnKrfL5nVKvotuqikVz5WIRJJV4jiMRPqYqXi2TN3g==
X-Received: by 10.28.175.139 with SMTP id y133mr3083081wme.45.1455373463549;
        Sat, 13 Feb 2016 06:24:23 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB53AE.dip0.t-ipconnect.de. [93.219.83.174])
        by smtp.gmail.com with ESMTPSA id os7sm16754763wjc.18.2016.02.13.06.24.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 06:24:22 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286112>

From: Lars Schneider <larsxschneider@gmail.com>

If config values are queried using 'git config' (e.g. via --get,
--get-all, --get-regexp, or --list flag) then it is sometimes hard to
find the configuration file where the values were defined.

Teach 'git config' the '--show-origin' option to print the source
configuration file for every printed value.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-config.txt |  15 +++--
 builtin/config.c             |  35 ++++++++++++
 cache.h                      |   1 +
 config.c                     |   6 ++
 t/t1300-repo-config.sh       | 128 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 180 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 59b1c95..2bf4d4e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,18 +9,18 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [type] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
 'git config' [<file-option>] [type] --add name value
 'git config' [<file-option>] [type] --replace-all name value [value_regex]
-'git config' [<file-option>] [type] [-z|--null] --get name [value_regex]
-'git config' [<file-option>] [type] [-z|--null] --get-all name [value_regex]
-'git config' [<file-option>] [type] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [type] [--show-origin] [-z|--null] --get name [value_regex]
+'git config' [<file-option>] [type] [--show-origin] [-z|--null] --get-all name [value_regex]
+'git config' [<file-option>] [type] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
 'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name URL
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
-'git config' [<file-option>] [-z|--null] [--name-only] -l | --list
+'git config' [<file-option>] [--show-origin] [-z|--null] [--name-only] -l | --list
 'git config' [<file-option>] --get-color name [default]
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
 'git config' [<file-option>] -e | --edit
@@ -194,6 +194,11 @@ See also <<FILES>>.
 	Output only the names of config variables for `--list` or
 	`--get-regexp`.
 
+--show-origin::
+	Augment the output of all queried config options with the
+	origin type (file, stdin, blob, cmdline) and the actual origin
+	(config file path, ref, or blob id if applicable).
+
 --get-colorbool name [stdout-is-tty]::
 
 	Find the color setting for `name` (e.g. `color.diff`) and output
diff --git a/builtin/config.c b/builtin/config.c
index adc7727..302b265 100644
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
+static int show_origin;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -81,6 +83,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes, N_("respect include directives on lookup")),
+	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, stdin, blob, cmdline)")),
 	OPT_END(),
 };
 
@@ -91,8 +94,30 @@ static void check_argc(int argc, int min, int max) {
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
 
+static void show_config_origin(struct strbuf *buf)
+{
+	const char term = end_null ? '\0' : '\t';
+	const char *type;
+	const char *name;
+
+	current_config_type_name(&type, &name);
+	strbuf_addstr(buf, type);
+	strbuf_addch(buf, ':');
+	if (end_null)
+		strbuf_addstr(buf, name);
+	else
+		quote_c_style(name, buf, NULL, 0);
+	strbuf_addch(buf, term);
+}
+
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
+	if (show_origin) {
+       struct strbuf buf = STRBUF_INIT;
+       show_config_origin(&buf);
+       fwrite(buf.buf, 1, buf.len, stdout);
+       strbuf_release(&buf);
+	}
 	if (!omit_values && value_)
 		printf("%s%c%s%c", key_, delim, value_, term);
 	else
@@ -108,6 +133,8 @@ struct strbuf_list {
 
 static int format_config(struct strbuf *buf, const char *key_, const char *value_)
 {
+	if (show_origin)
+		show_config_origin(buf);
 	if (show_keys)
 		strbuf_addstr(buf, key_);
 	if (!omit_values) {
@@ -538,6 +565,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		error("--name-only is only applicable to --list or --get-regexp");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
+
+	if (show_origin && !(actions &
+		(ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST))) {
+		error("--show-origin is only applicable to --get, --get-all, "
+			  "--get-regexp, and --list.");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
diff --git a/cache.h b/cache.h
index c63fcc1..3d1eb86 100644
--- a/cache.h
+++ b/cache.h
@@ -1525,6 +1525,7 @@ extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
 extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
+extern void current_config_type_name(const char **type, const char **name);
 
 struct config_include_data {
 	int depth;
diff --git a/config.c b/config.c
index 6a5942f..0603d4b 100644
--- a/config.c
+++ b/config.c
@@ -2388,3 +2388,9 @@ int parse_config_key(const char *var,
 
 	return 0;
 }
+
+void current_config_type_name(const char **type, const char **name)
+{
+	*type = cf && cf->type ? cf->type : "cmdline";
+	*name = cf && cf->name ? cf->name : "";
+}
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 7abdfcb..112f7c8 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1207,4 +1207,132 @@ test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
 '
 
+test_expect_success '--show-origin' '
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
+	test_config_global user.global "true" &&
+	test_config_global user.override "global" &&
+	test_config_global include.path "$INCLUDE_DIR"/absolute.include &&
+	test_config include.path ../include/relative.include &&
+	test_config user.local "true" &&
+	test_config user.override "local" &&
+
+	cat >expect <<-EOF &&
+		file:$HOME/.gitconfig	user.global=true
+		file:$HOME/.gitconfig	user.override=global
+		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
+		file:$INCLUDE_DIR/absolute.include	user.absolute=include
+		file:.git/config	include.path=../include/relative.include
+		file:.git/../include/relative.include	user.relative=include
+		file:.git/config	user.local=true
+		file:.git/config	user.override=local
+		cmdline:	user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --show-origin >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		file:$HOME/.gitconfigQuser.global
+		trueQfile:$HOME/.gitconfigQuser.override
+		globalQfile:$HOME/.gitconfigQinclude.path
+		$INCLUDE_DIR/absolute.includeQfile:$INCLUDE_DIR/absolute.includeQuser.absolute
+		includeQfile:.git/configQinclude.path
+		../include/relative.includeQfile:.git/../include/relative.includeQuser.relative
+		includeQfile:.git/configQuser.local
+		trueQfile:.git/configQuser.override
+		localQcmdline:Quser.cmdline
+		trueQ
+	EOF
+	git -c user.cmdline=true config --null --list --show-origin | nul_to_q >output &&
+	echo >>output &&
+	test_cmp expect output &&
+
+	cat >expect <<-\EOF &&
+		file:.git/config	include.path=../include/relative.include
+		file:.git/config	user.local=true
+		file:.git/config	user.override=local
+	EOF
+	git config --local --list --show-origin >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		file:$HOME/.gitconfig	user.global true
+		file:.git/config	user.local true
+	EOF
+	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-\EOF &&
+		file:.git/config	local
+	EOF
+	git config --show-origin user.override >output &&
+	test_cmp expect output
+'
+
+CUSTOM_CONFIG_FILE="file\twith\ttabs.conf" &&
+cat >"$CUSTOM_CONFIG_FILE" <<-\EOF &&
+	[user]
+		custom = true
+EOF
+
+test_expect_success '--show-origin escape special file name characters' '
+	cat >expect <<-\EOF &&
+		file:"file\\twith\\ttabs.conf"	user.custom=true
+	EOF
+	git config --file "$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-origin stdin' '
+	cat >expect <<-\EOF &&
+		stdin:	user.custom=true
+	EOF
+	git config --file - --show-origin --list <"$CUSTOM_CONFIG_FILE" >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-origin stdin with file include' '
+	INCLUDE_DIR="$HOME/include" &&
+	mkdir -p "$INCLUDE_DIR" &&
+	cat >"$INCLUDE_DIR"/stdin.include <<-EOF &&
+		[user]
+			stdin = include
+	EOF
+	cat >expect <<-EOF &&
+		file:$INCLUDE_DIR/stdin.include	include
+	EOF
+	echo "[include]path=\"$INCLUDE_DIR\"/stdin.include" \
+		| git config --show-origin --includes --file - user.stdin >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-origin blob' '
+	cat >expect <<-\EOF &&
+		blob:a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08	user.custom=true
+	EOF
+	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
+	git config --blob=$blob --show-origin --list >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-origin blob ref' '
+	cat >expect <<-\EOF &&
+		blob:"master:file\\twith\\ttabs.conf"	user.custom=true
+	EOF
+	git add "$CUSTOM_CONFIG_FILE" &&
+	git commit -m "new config file" &&
+	git config --blob=master:"$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
2.5.1
