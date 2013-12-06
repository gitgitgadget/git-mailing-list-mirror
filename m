From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH v2] diff: Add diff.orderfile configuration variable
Date: Fri,  6 Dec 2013 01:48:28 -0500
Message-ID: <1386312508-7421-1-git-send-email-naesten@gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Samuel Bronson <naesten@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 06 07:49:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VopDx-0005UR-5A
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 07:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab3LFGtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 01:49:13 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:47337 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab3LFGtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 01:49:12 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so318535qab.16
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 22:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H2nCaqqLvIu07ExlkV759dKW8x9JRaHsw/S/0O/hOcM=;
        b=yBvsNVp1jfTz8iWUdQE3cxFiCIAc9J7BhqW+ejAHudDz0IHWSkKNiFSEAv+G/9nZS+
         xplA2+5zq7svO68K2F5H1ykF+o+KE+bryT6Vd9TvSqDJQK+TYFY0r/E5GGwT9RoPZXVp
         7OyNG3togsb2j1Ry0mUWSBwKj+ohZrJ8UF6xnwjZFNjcVo6qHPoe+zvOV4dT49vJwr0r
         5SWHMnQvOxout/l69IV1oGrGg/60WoBIf8WvAulU5efNprbdCdQxJhLgh3fFHTTQxxP8
         Hr+CayZ27gF3ga6bD1siJr3gJIju2NKWhOyxmJx/XV6Z2wTClf/qdp4dQBw0MUvrEbJs
         k2DA==
X-Received: by 10.224.96.129 with SMTP id h1mr3647852qan.14.1386312551792;
        Thu, 05 Dec 2013 22:49:11 -0800 (PST)
Received: from hydrogen ([2001:0:53aa:64c:1cf3:6154:3053:8476])
        by mx.google.com with ESMTPSA id g10sm40093396qaf.9.2013.12.05.22.49.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 22:49:11 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VopDp-0001xw-DF; Fri, 06 Dec 2013 01:49:09 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238924>

From: Anders Waldenborg <anders@0x63.nu>

diff.orderfile acts as a default for the -O command line option.

[sb: fixed testcases & revised docs based on Jonathan Nieder's suggestions]

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
*I* even verified that the tests do fail properly when the feature is
sabotaged.

 Documentation/diff-config.txt  |  5 +++
 Documentation/diff-options.txt |  2 ++
 diff.c                         |  5 +++
 t/t4056-diff-order.sh          | 79 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100755 t/t4056-diff-order.sh

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 223b931..f07b451 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -98,6 +98,11 @@ diff.mnemonicprefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
 
+diff.orderfile::
+	File indicating how to order files within a diff, using
+	one shell glob pattern per line.
+	Can be overridden by the '-O' option to linkgit:git-diff[1].
+
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the 'git diff' option '-l'.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index bbed2cd..1af5a5e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -432,6 +432,8 @@ endif::git-format-patch[]
 -O<orderfile>::
 	Output the patch in the order specified in the
 	<orderfile>, which has one shell glob pattern per line.
+	This overrides the `diff.orderfile' configuration variable
+	((see linkgit:git-config[1]).
 
 ifndef::git-format-patch[]
 -R::
diff --git a/diff.c b/diff.c
index e34bf97..a92b570 100644
--- a/diff.c
+++ b/diff.c
@@ -30,6 +30,7 @@ static int diff_use_color_default = -1;
 static int diff_context_default = 3;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
+static const char *diff_order_file_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
@@ -201,6 +202,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!strcmp(var, "diff.wordregex"))
 		return git_config_string(&diff_word_regex_cfg, var, value);
+	if (!strcmp(var, "diff.orderfile"))
+		return git_config_string(&diff_order_file_cfg, var, value);
 
 	if (!strcmp(var, "diff.ignoresubmodules"))
 		handle_ignore_submodules_arg(&default_diff_options, value);
@@ -3207,6 +3210,8 @@ void diff_setup(struct diff_options *options)
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
 
+	options->orderfile = diff_order_file_cfg;
+
 	if (diff_no_prefix) {
 		options->a_prefix = options->b_prefix = "";
 	} else if (!diff_mnemonic_prefix) {
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
new file mode 100755
index 0000000..a756b34
--- /dev/null
+++ b/t/t4056-diff-order.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='diff order'
+
+. ./test-lib.sh
+
+create_files () {
+	echo "$1" >a.h &&
+	echo "$1" >b.c &&
+	echo "$1" >c/Makefile &&
+	echo "$1" >d.txt &&
+	git add a.h b.c c/Makefile d.txt &&
+	git commit -m"$1"
+	return $?
+}
+
+test_expect_success "setup" '
+	mkdir c &&
+	create_files 1 &&
+	create_files 2
+'
+
+cat >order_file_1 <<EOF
+*Makefile
+*.txt
+*.h
+*
+EOF
+cat >order_file_2 <<EOF
+*Makefile
+*.h
+*.c
+*
+EOF
+
+cat >expect_diff_headers_none <<EOF
+diff --git a/a.h b/a.h
+diff --git a/b.c b/b.c
+diff --git a/c/Makefile b/c/Makefile
+diff --git a/d.txt b/d.txt
+EOF
+
+cat >expect_diff_headers_1 <<EOF
+diff --git a/c/Makefile b/c/Makefile
+diff --git a/d.txt b/d.txt
+diff --git a/a.h b/a.h
+diff --git a/b.c b/b.c
+EOF
+
+cat >expect_diff_headers_2 <<EOF
+diff --git a/c/Makefile b/c/Makefile
+diff --git a/a.h b/a.h
+diff --git a/b.c b/b.c
+diff --git a/d.txt b/d.txt
+EOF
+
+test_expect_success "no order (=tree object order)" '
+	git diff HEAD^..HEAD >patch &&
+	grep ^diff patch >actual_diff_headers &&
+	test_cmp expect_diff_headers_none actual_diff_headers
+'
+
+for i in 1 2; do
+	test_expect_success "orderfile using option ($i)" "
+	git diff -Oorder_file_$i HEAD^..HEAD >patch &&
+	grep ^diff patch >actual_diff_headers &&
+	test_cmp expect_diff_headers_$i actual_diff_headers
+"
+done
+
+for i in 1 2; do
+	test_expect_success "orderfile using config ($i)" "
+	git -c diff.orderfile=order_file_$i diff HEAD^..HEAD >patch &&
+	grep ^diff patch >actual_diff_headers &&
+	test_cmp expect_diff_headers_$i actual_diff_headers
+"
+done
+
+test_done
-- 
1.8.4.3
