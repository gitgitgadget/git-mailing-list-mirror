From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH v4 3/3] diff: Add diff.orderfile configuration variable
Date: Mon, 16 Dec 2013 15:09:46 -0500
Message-ID: <1387224586-10169-4-git-send-email-naesten@gmail.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 16 21:10:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VseUm-0005mq-I4
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 21:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab3LPUKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 15:10:22 -0500
Received: from mail-qc0-f182.google.com ([209.85.216.182]:50398 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab3LPUKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 15:10:16 -0500
Received: by mail-qc0-f182.google.com with SMTP id e16so4170106qcx.27
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 12:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zga00Wee1C+zmSGRrwVz9yKLs5MBg4XCquo6EQNZKjg=;
        b=LzoWyqVnv1E3V4eYpB1R2OPdgKbFgEIRPm0F2D28uZ98Cn9D0bkBhIOUpAYuCsESYH
         3rxOv/fVldyhtD6/39tCDWq8ZArtov8vlvsSIUyKmVXKe4/HVLXcqnsA/ZOKorE5ub+d
         x1/dB7Fw/Bx72N16aWjAIFa78UJ4vmYPCdQlXImQJ0ep4cMATrsvAN3vVrrWvxcU/ZTc
         DmEQY0P/5rE/hohk5tcg6SUrBhVfdsCXIVlGQvfFRt35baYPh8bh1OYoZXhkKiYVWwsA
         iW0rea1N3lSPV7YK3CB2x/klFuJdut3N+ln/aD/0GEohddhGP2HAlG+NGMhpaRnnP8AR
         mUKQ==
X-Received: by 10.229.219.5 with SMTP id hs5mr14589633qcb.9.1387224615582;
        Mon, 16 Dec 2013 12:10:15 -0800 (PST)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPSA id f19sm48383236qaq.12.2013.12.16.12.10.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Dec 2013 12:10:14 -0800 (PST)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1VseUX-0002f0-Q9; Mon, 16 Dec 2013 15:10:13 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1387224586-10169-1-git-send-email-naesten@gmail.com>
In-Reply-To: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239361>

diff.orderfile acts as a default for the -O command line option.

[sb: split up aw's original patch; reworked tests and docs,
treat option as pathname]

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
index 3950e01..0099b99 100644
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
+		return git_config_pathname(&diff_order_file_cfg, var, value);
 
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
