From: larsxschneider@gmail.com
Subject: [PATCH v4 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Mon, 15 Feb 2016 11:17:46 +0100
Message-ID: <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com,
	Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 11:18:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVGEE-0003TV-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 11:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbcBOKR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 05:17:59 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36333 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbcBOKRy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 05:17:54 -0500
Received: by mail-wm0-f48.google.com with SMTP id g62so50943887wme.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNsXbdII9ShxT0vPHKGq18gAPwxZApGFCqGo8KJzv8M=;
        b=TUj1rTH5evwGjEA7Lyvttvy6WrkWSrJBmpnR6XZySpgjmSVFWrPRr9Um8wzUaG0cUc
         vsafPMFJ9ddSGJYyUoPvkyp5773Ee7+vEl4r+gtUnqQ5jLbVE49wBYOdiBNqQoIG6zQb
         aDbG9ZlV083RXxZzg2QITxmanHoPV6RL9jNQmWYrFyMZ8ebhithBwDZK7sQThv3eZ0zH
         JqZStQOaw1Yjfcz+cFDQsRBJIvhdhuJnwBkrBbCJMGSwU9yTIn7BzxSDd+VSTXMAyotL
         nMgVqFzZ2Gzqgrb9aqf5h7XYrcfJExIKvVXmywAl45C3Svnj/tI5vSbO7WSYfTZ61txI
         hvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNsXbdII9ShxT0vPHKGq18gAPwxZApGFCqGo8KJzv8M=;
        b=i/sY6Y6eKtYwPNK9dlcm2l+AI+doxxt255zu/qgceDKieZU5GO91c/+j4Cb2pjcwHM
         s7tJ0LdTMNN2WNHyyEDd/opTTAx5PNZJMDuoRNtQ9Wi3HwQNj8sKI7mU4Mbk4yU5we98
         /vh+vdqcCeIgK/gaTAG5B6lYjYqn92gEg8vlevW6rjNZ7iZATUBRRjRWav33cRRHiRWK
         xnRwg+oan78GEXOYXwQRwwdwf+CPAjHpYsg7X0D5Z/o9jagDgBCa4D6QaQRzoO7/3i2s
         DeVbUbe0hK3O0qtvRBW1aRj7uL2SQAzWpRs1P8oqVQ213QJtrNJAEqTvgKvJZAmseu5g
         vk3Q==
X-Gm-Message-State: AG10YORgr1rY2fMIQOmEYgmDnBAiljWOSDptYch5QZmN2J5mYIOgzjzZi9qxfwybAisVOQ==
X-Received: by 10.194.61.135 with SMTP id p7mr17866769wjr.64.1455531472947;
        Mon, 15 Feb 2016 02:17:52 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB477C.dip0.t-ipconnect.de. [93.219.71.124])
        by smtp.gmail.com with ESMTPSA id i5sm24494120wja.23.2016.02.15.02.17.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 Feb 2016 02:17:52 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286198>

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
 builtin/config.c             |  33 ++++++++++
 t/t1300-repo-config.sh       | 153 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 2608ca7..6374997 100644
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
index adc7727..7bad0c0 100644
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
 
@@ -91,8 +94,28 @@ static void check_argc(int argc, int min, int max) {
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
 
+static void show_config_origin(struct strbuf *buf)
+{
+	const char term = end_null ? '\0' : '\t';
+
+	strbuf_addstr(buf, current_config_type());
+	strbuf_addch(buf, ':');
+	if (end_null)
+		strbuf_addstr(buf, current_config_name());
+	else
+		quote_c_style(current_config_name(), buf, NULL, 0);
+	strbuf_addch(buf, term);
+}
+
 static int show_all_config(const char *key_, const char *value_, void *cb)
 {
+	if (show_origin) {
+		struct strbuf buf = STRBUF_INIT;
+		show_config_origin(&buf);
+		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
+		fwrite(buf.buf, 1, buf.len, stdout);
+		strbuf_release(&buf);
+	}
 	if (!omit_values && value_)
 		printf("%s%c%s%c", key_, delim, value_, term);
 	else
@@ -108,6 +131,8 @@ struct strbuf_list {
 
 static int format_config(struct strbuf *buf, const char *key_, const char *value_)
 {
+	if (show_origin)
+		show_config_origin(buf);
 	if (show_keys)
 		strbuf_addstr(buf, key_);
 	if (!omit_values) {
@@ -538,6 +563,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 42ed5cc..4abbdf9 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1209,4 +1209,157 @@ test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
 '
 
+test_expect_success 'set up --show-origin tests' '
+	INCLUDE_DIR="$HOME/include" &&
+	mkdir -p "$INCLUDE_DIR" &&
+	cat >"$INCLUDE_DIR"/absolute.include <<-\EOF &&
+		[user]
+			absolute = include
+	EOF
+	cat >"$INCLUDE_DIR"/relative.include <<-\EOF &&
+		[user]
+			relative = include
+	EOF
+	cat >"$HOME"/.gitconfig <<-EOF &&
+		[user]
+			global = true
+			override = global
+		[include]
+			path = "$INCLUDE_DIR/absolute.include"
+	EOF
+	cat >.git/config <<-\EOF
+		[user]
+			local = true
+			override = local
+		[include]
+			path = ../include/relative.include
+	EOF
+'
+
+test_expect_success '--show-origin with --list' '
+	cat >expect <<-EOF &&
+		file:$HOME/.gitconfig	user.global=true
+		file:$HOME/.gitconfig	user.override=global
+		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
+		file:$INCLUDE_DIR/absolute.include	user.absolute=include
+		file:.git/config	user.local=true
+		file:.git/config	user.override=local
+		file:.git/config	include.path=../include/relative.include
+		file:.git/../include/relative.include	user.relative=include
+		cmdline:	user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --show-origin >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-origin with --list --null' '
+	cat >expect <<-EOF &&
+		file:$HOME/.gitconfigQuser.global
+		trueQfile:$HOME/.gitconfigQuser.override
+		globalQfile:$HOME/.gitconfigQinclude.path
+		$INCLUDE_DIR/absolute.includeQfile:$INCLUDE_DIR/absolute.includeQuser.absolute
+		includeQfile:.git/configQuser.local
+		trueQfile:.git/configQuser.override
+		localQfile:.git/configQinclude.path
+		../include/relative.includeQfile:.git/../include/relative.includeQuser.relative
+		includeQcmdline:Quser.cmdline
+		trueQ
+	EOF
+	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
+	nul_to_q <output.raw >output &&
+	# The here-doc above adds a newline that the --null output would not
+	# include. Add it here to make the two comparable.
+	echo >>output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-origin with single file' '
+	cat >expect <<-\EOF &&
+		file:.git/config	user.local=true
+		file:.git/config	user.override=local
+		file:.git/config	include.path=../include/relative.include
+	EOF
+	git config --local --list --show-origin >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-origin with --get-regexp' '
+	cat >expect <<-EOF &&
+		file:$HOME/.gitconfig	user.global true
+		file:.git/config	user.local true
+	EOF
+	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--show-origin getting a single key' '
+	cat >expect <<-\EOF &&
+		file:.git/config	local
+	EOF
+	git config --show-origin user.override >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'set up custom config file' '
+	CUSTOM_CONFIG_FILE=$(printf "file\twith\ttabs.conf") &&
+	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
+		[user]
+			custom = true
+	EOF
+'
+
+test_expect_success '--show-origin escape special file name characters' '
+	cat >expect <<-\EOF &&
+		file:"file\twith\ttabs.conf"	user.custom=true
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
+		blob:"master:file\twith\ttabs.conf"	user.custom=true
+	EOF
+	git add "$CUSTOM_CONFIG_FILE" &&
+	git commit -m "new config file" &&
+	git config --blob=master:"$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'tear down --show-origin tests' '
+	rm -rf "$INCLUDE_DIR" &&
+	>"$HOME"/.gitconfig &&
+	>.git/config
+'
+
 test_done
-- 
2.5.1
