From: larsxschneider@gmail.com
Subject: [PATCH v1] config: add '--sources' option to print the source of a config value
Date: Fri,  5 Feb 2016 09:42:30 +0100
Message-ID: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 09:43:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRbyo-00067x-KK
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 09:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbcBEImf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 03:42:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34825 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcBEIme (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 03:42:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id g62so1939023wme.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 00:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+AHAtkratICrbXDOCtJumW/EZ0xkuVyRYsG1C72apNA=;
        b=NaC5I0kl9aifGN4ZPLULCqcl/XAvMb+1AwsNumrEt0WVp9pdYVr5Mx1ss/rMWR1mwo
         x2nBUrRdw0oYbKsRyKWr0DX+EaYyP3ymPKjeKhdYquhSyko0EVD5gFR3Rdwy4WoT2cFI
         Mev1/bprlMU/Jxuf++W3ifPoJtRVBtEs0TdKcs2D9H76qm1Qu1aet7xHp5cUfXMoH2jA
         1vCINSIr73MJtLoE5U7FPWOLQ9NQG3pNhsjsoTh8UNl2FMLM69R6uz11bAqAfq7af2pS
         sTH7Z0PIcitKQHMKamSNeKFGKe/E3eH6+PB+xBUdS3kJW2tSMsssXDJqv8LYE8KYYn4E
         GtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+AHAtkratICrbXDOCtJumW/EZ0xkuVyRYsG1C72apNA=;
        b=ko6ROXAsaJcfSJDm1hrhHV5H+svMeO8tee/lphwnyXbw5zW58U2ETZ0+UDL8Kqrj8g
         FdfeSJPUYU6FcKcNCTyrvCeuNquKQxBKHJoq4hVuFOncoAF6teLgdyeUajn1bt93i/TI
         jJNmTB3gK4uAQlxUCKNj7CsIep4N8sUu8cJzOSzCm/OK2qC9lKGCdrfwD0d7On9vwKPa
         XtKYTbW+RkSKQM3h/CVimzBVYFuxDHOVC2s2KDhyiFsPT/DKNgHnAQBVmosN6ZoR1wUk
         I3lXgZJWEjklQoHSs63WArjCzykL0L9wnKuRquejo13P+6zfyoxgpAXWXi62PsLEMBB8
         RAtg==
X-Gm-Message-State: AG10YORJ4jldgU4ORAYYsFZhU4AtnG22cNKajzBZqUBrhQOt49KsV6KUgyjAo4Yw0fOwmw==
X-Received: by 10.28.223.67 with SMTP id w64mr36289161wmg.28.1454661753270;
        Fri, 05 Feb 2016 00:42:33 -0800 (PST)
Received: from slxBook3.fritz.box (p508BACEA.dip0.t-ipconnect.de. [80.139.172.234])
        by smtp.gmail.com with ESMTPSA id az10sm14867639wjc.28.2016.02.05.00.42.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Feb 2016 00:42:32 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285553>

From: Lars Schneider <larsxschneider@gmail.com>

If config values are queried using 'git config' (e.g. via '--list' flag
or the '--get*' flags) then it is sometimes hard to find the
configuration file where the values were defined.

Teach 'git config' the '--sources' option to print the source
configuration file for every printed value.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 builtin/config.c       | 42 ++++++++++++++++++++++++++++++++
 cache.h                |  1 +
 config.c               |  7 ++++++
 t/t1300-repo-config.sh | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index adc7727..f5dc79c 100644
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
 
@@ -91,8 +94,34 @@ static void check_argc(int argc, int min, int max) {
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
 
+/* output to either fp or buf; only one should be non-NULL */
+static void show_config_source(struct strbuf *buf, FILE *fp)
+{
+	const char *fn = current_config_filename();
+	if (!fn)
+		return;
+
+	char term = '\t';
+	if (!end_null)
+		quote_c_style(fn, buf, fp, 0);
+	else {
+		term = '\0';
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
@@ -108,6 +137,8 @@ struct strbuf_list {
 
 static int format_config(struct strbuf *buf, const char *key_, const char *value_)
 {
+	if (show_sources)
+		show_config_source(buf, NULL);
 	if (show_keys)
 		strbuf_addstr(buf, key_);
 	if (!omit_values) {
@@ -538,6 +569,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		error("--name-only is only applicable to --list or --get-regexp");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
+
+	const int is_query_action = actions & (
+		ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST|
+		ACTION_GET_COLOR|ACTION_GET_COLORBOOL|ACTION_GET_URLMATCH
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
index 86a5eb2..b437002 100644
--- a/config.c
+++ b/config.c
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
index 52678e7..2444d8a 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1201,4 +1201,69 @@ test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
 '
 
+test_expect_success '--sources' '
+	>.git/config &&
+	>"$HOME"/.gitconfig &&
+	INCLUDE_DIR="$HOME/include" &&
+	mkdir -p "$INCLUDE_DIR" &&
+	cat >"$INCLUDE_DIR"/include.conf <<-EOF &&
+		[user]
+			include = true
+	EOF
+	cat >"$HOME"/file.conf <<-EOF &&
+		[user]
+			custom = true
+	EOF
+	test_config_global user.global "true" &&
+	test_config_global user.override "global" &&
+	test_config_global include.path "$INCLUDE_DIR"/include.conf &&
+	test_config user.local "true" &&
+	test_config user.override "local" &&
+
+	cat >expect <<-EOF &&
+		$HOME/.gitconfig	user.global=true
+		$HOME/.gitconfig	user.override=global
+		$HOME/.gitconfig	include.path=$INCLUDE_DIR/include.conf
+		$INCLUDE_DIR/include.conf	user.include=true
+		.git/config	user.local=true
+		.git/config	user.override=local
+		user.cmdline=true
+	EOF
+	git -c user.cmdline=true config --list --sources >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		$HOME/.gitconfigQuser.global
+		trueQ$HOME/.gitconfigQuser.override
+		globalQ$HOME/.gitconfigQinclude.path
+		$INCLUDE_DIR/include.confQ$INCLUDE_DIR/include.confQuser.include
+		trueQ.git/configQuser.local
+		trueQ.git/configQuser.override
+		localQuser.cmdline
+		trueQ
+	EOF
+	git -c user.cmdline=true config --null --list --sources | nul_to_q >output &&
+	echo >>output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		.git/config	local
+	EOF
+	git config --sources user.override >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		$HOME/file.conf	user.custom=true
+	EOF
+	git config --file "$HOME"/file.conf --sources --list >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+		a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08	user.custom=true
+	EOF
+	blob=$(git hash-object -w "$HOME"/file.conf) &&
+	git config --blob=$blob --sources --list >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
2.5.1
