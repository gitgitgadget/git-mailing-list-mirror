From: Samuel Bronson <naesten@gmail.com>
Subject: [RFC v3 3/3] diff: Add diff.orderfile configuration variable
Date: Sat, 14 Dec 2013 17:18:41 -0500
Message-ID: <1387059521-23616-4-git-send-email-naesten@gmail.com>
References: <1387059521-23616-1-git-send-email-naesten@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 23:19:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrxYp-0002dB-WE
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 23:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308Ab3LNWTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 17:19:43 -0500
Received: from mail-qe0-f50.google.com ([209.85.128.50]:59489 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab3LNWTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 17:19:43 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so2878626qec.9
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 14:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kDC1uD7PDHhNgqURGoavcVn3xJar2worGOZi5MrTAgs=;
        b=Llf/OuDWLRYAUts+CaBV/iaZ4NU/rpTV3oCx7ezRvtG4R2OLsz5XUhOKUkBl/2Jdta
         cOtJ6WkQe7F/ZJnqtSq3w9rWaJkGNHCTg9zGUrw5+vPqToiZXthgAcnQN5r3RIKgoN79
         XrxbeUKKbN85SgeRwtx1thcHzVykDCrmLjbNooKigX91WAsaSHyrQfrLHcC1eZ8hXWO2
         AVop6Tr2vFxE3RaQiYgproSXE9pm+9H9+Z2icMD3geWaw/bC7hpWIW6yAPZx3sX3Zh2K
         shqw+rrDGbrFrwOf5V7IsJ1VhDcDj0Lx/OR5xFwtuh7XH7dPlOZqOH3ifkZl15/QkHlH
         zRqA==
X-Received: by 10.49.106.1 with SMTP id gq1mr18814307qeb.12.1387059582541;
        Sat, 14 Dec 2013 14:19:42 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id f19sm24576904qaq.12.2013.12.14.14.19.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 14:19:42 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VrxYj-00069y-2L; Sat, 14 Dec 2013 17:19:41 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1387059521-23616-1-git-send-email-naesten@gmail.com>
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239320>

diff.orderfile acts as a default for the -O command line option.

[sb: split up aw's original patch; reworked tests and docs]

[FIXME: Relative paths should presumably be interpreted relative to
repository root; how should this be accomplished?]

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 Documentation/diff-config.txt  |  5 +++++
 Documentation/diff-options.txt |  3 +++
 diff.c                         |  5 +++++
 t/t4056-diff-order.sh          | 10 ++++++++++
 4 files changed, 23 insertions(+)

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
index bbed2cd..9b37b2a 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -432,6 +432,9 @@ endif::git-format-patch[]
 -O<orderfile>::
 	Output the patch in the order specified in the
 	<orderfile>, which has one shell glob pattern per line.
+	This overrides the `diff.orderfile` configuration variable
+	(see linkgit:git-config[1]).  To cancel `diff.orderfile`,
+	use `-O/dev/null`.
 
 ifndef::git-format-patch[]
 -R::
diff --git a/diff.c b/diff.c
index 3950e01..b336aef 100644
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
index eb471e7..50689d1 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -90,6 +90,16 @@ do
 	git diff -O order_fifo --name-only HEAD^..HEAD >actual &&
 	test_cmp expect_$i actual
 '
+
+	test_expect_success "orderfile using config ($i)" '
+	git -c diff.orderfile=order_file_$i diff --name-only HEAD^..HEAD >actual &&
+	test_cmp expect_$i actual
+'
+
+	test_expect_success "cancelling configured orderfile ($i)" '
+	git -c diff.orderfile=order_file_$i diff -O/dev/null --name-only HEAD^..HEAD >actual &&
+	test_cmp expect_none actual
+'
 done
 
 test_done
-- 
1.8.4.3
