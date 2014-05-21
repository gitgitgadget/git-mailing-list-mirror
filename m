From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v6] format-patch --signature-file <file>
Date: Tue, 20 May 2014 18:02:50 -0700
Message-ID: <1400634170-18266-2-git-send-email-jmmahler@gmail.com>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 03:03:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmuwE-0006aF-50
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 03:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbaEUBDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 21:03:18 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:45971 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaEUBDR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 21:03:17 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so844422pdj.1
        for <git@vger.kernel.org>; Tue, 20 May 2014 18:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6UJx6vUxfXjHQ6e8YrWJd1T7fnHN9lcd55v7OyCOdI4=;
        b=zOOBgDNmLuNcnlW+COpHPw4VQRV6iEyI7JiyKC+HeyTOXl4QBjwG3uVJLwychSUcqf
         1Q3TgBS3sRlFNWTj+QC8xCWwqL4T52m+kCR4A2U2KPstmznSPMsD51Dr8hWAd10plvDZ
         6qgXpobyjmuRKV/tyCja3rIuIYMCwHsSK5Z3pCAjYykb/9Rd9xpTFQIHr1IpH9iMOEJk
         A6MqE1duhfl8RcwEE8xY5xcOJca90TkANawaIFtBvC/kteIzFUPZ2qbg/J79DIQes6Y/
         Mgl58ZTFJJh86lkl1fnJkm5Pp17IRkzik6YmoCbIXPwRwqZGuht6A/cV1eMikbQwPvhk
         vyfA==
X-Received: by 10.69.12.33 with SMTP id en1mr13397797pbd.43.1400634196995;
        Tue, 20 May 2014 18:03:16 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id cj1sm97004071pac.40.2014.05.20.18.03.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 18:03:15 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 20 May 2014 18:03:13 -0700
X-Mailer: git-send-email 2.0.0.rc3.19.g20b0be9
In-Reply-To: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249772>

Added option that allows a signature file to be used with format-patch
so that signatures with newlines and other special characters can be
easily included.

  $ git format-patch --signature-file ~/.signature -1

The config variable format.signaturefile is also provided so that it
can be added by default.

  $ git config format.signaturefile ~/.signature

  $ git format-patch -1

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 Documentation/config.txt           |  4 ++++
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 16 ++++++++++++++++
 t/t4014-format-patch.sh            | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..140ed77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1114,6 +1114,10 @@ format.signature::
 	Set this variable to the empty string ("") to suppress
 	signature generation.
 
+format.signaturefile::
+	Works just like format.signature except the contents of the
+	file specified by this variable will be used as the signature.
+
 format.suffix::
 	The default for format-patch is to output files with the suffix
 	`.patch`. Use this variable to change that suffix (make sure to
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 5c0a4ab..c0fd470 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 		   [(--attach|--inline)[=<boundary>] | --no-attach]
 		   [-s | --signoff]
 		   [--signature=<signature> | --no-signature]
+		   [--signature-file=<file>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
@@ -233,6 +234,9 @@ configuration options in linkgit:git-notes[1] to use this workflow).
 	signature option is omitted the signature defaults to the Git version
 	number.
 
+--signature-file=<file>::
+	Works just like --signature except the signature is read from a file.
+
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..ab4718b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -673,6 +673,7 @@ static void add_header(const char *value)
 static int thread;
 static int do_signoff;
 static const char *signature = git_version_string;
+static const char *signature_file;
 static int config_cover_letter;
 
 enum {
@@ -742,6 +743,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.signature"))
 		return git_config_string(&signature, var, value);
+	if (!strcmp(var, "format.signaturefile"))
+		return git_config_pathname(&signature_file, var, value);
 	if (!strcmp(var, "format.coverletter")) {
 		if (value && !strcasecmp(value, "auto")) {
 			config_cover_letter = COVER_AUTO;
@@ -1230,6 +1233,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
+		OPT_FILENAME(0, "signature-file", &signature_file,
+				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_END()
 	};
@@ -1447,6 +1452,17 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			cover_letter = (config_cover_letter == COVER_ON);
 	}
 
+	if (signature_file) {
+		if (signature && signature != git_version_string)
+			die(_("cannot specify both signature and signature-file"));
+
+		struct strbuf buf = STRBUF_INIT;
+
+		if (strbuf_read_file(&buf, signature_file, 128) < 0)
+			die_errno(_("unable to read signature file '%s'"), signature_file);
+		signature = strbuf_detach(&buf, NULL);
+	}
+
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 9c80633..049493d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -762,6 +762,38 @@ test_expect_success 'format-patch --signature="" suppresses signatures' '
 	! grep "^-- \$" output
 '
 
+cat >expect <<-\EOF
+
+Test User <test.email@kernel.org>
+http://git.kernel.org/cgit/git/git.git
+
+git.kernel.org/?p=git/git.git;a=summary
+
+EOF
+
+test_expect_success 'format-patch --signature-file=file' '
+	git format-patch --stdout --signature-file=expect -1 >output &&
+	check_patch output &&
+	sed -n -e "/^-- $/,\$p" <output | sed -e "1 d" | sed -e "\$d" | sed -e "\$d" >output2 &&
+	test_cmp expect output2
+'
+
+test_expect_success 'format-patch with format.signaturefile config' '
+	test_config format.signaturefile expect &&
+	git format-patch --stdout -1 >output &&
+	check_patch output &&
+	sed -n -e "/^-- $/,\$p" <output | sed -e "1 d" | sed -e "\$d" | sed -e "\$d" >output2 &&
+	test_cmp expect output2
+'
+
+test_expect_success 'format-patch --signature and --signature-file die' '
+	test_must_fail git format-patch --stdout --signature="foo" --signature-file=expect -1 >output
+'
+
+test_expect_success 'format-patch --no-signature and --signature-file OK' '
+	git format-patch --stdout --no-signature --signature-file=expect -1
+'
+
 test_expect_success TTY 'format-patch --stdout paginates' '
 	rm -f pager_used &&
 	test_terminal env GIT_PAGER="wc >pager_used" git format-patch --stdout --all &&
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
