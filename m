From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 4/5] ls-remote: use parse-options api
Date: Mon, 18 Jan 2016 17:57:17 +0100
Message-ID: <1453136238-19448-5-git-send-email-t.gummerer@gmail.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 17:57:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLD7M-0003S4-Aa
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 17:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953AbcARQ5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 11:57:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34389 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825AbcARQ5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 11:57:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so17778025wmb.1
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 08:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5BC9K8R8nrYHBUcfo9VhfGK5XkYfVSGvNYAwQomN3lg=;
        b=eKl9J9PRcZqNSE1bqdrFrwRRR//TU4k9I7KTh9Wd1qsIg/RSz6nr6YkDqsYQn3ZPwc
         DWpjAduZWP4InpKboy/RgZFJcT+Yx1/C76fUBNX/ndgn/bugW6tT7ooC28Sv03VXEwbU
         saya7eoOlYmGTXIq+I6saKNQQwHw3uuiTKMBg0staE0YBOy48xeBGf10y/eyI46Q/SgM
         s916m1O8mKs/fyYUT1gVOHKRN7Y4FdySntpauPPo4Wnw2fIAuLIShQlHb/tTQZ4PiwGM
         +DQMOuPFq4K8/Yv+gvGHLFM0otuPBxji7m2OtO6p81VlzQhTTHttprPaDKN9OuoXdSL/
         U3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5BC9K8R8nrYHBUcfo9VhfGK5XkYfVSGvNYAwQomN3lg=;
        b=EHfircLKgiO+1xK3RNEw8vIgx7p+0fMMn0HlWuN9NX51ieXoJne40FKKr6lsC44lF5
         mU4BEknHX/zBpGx61eENOlL4+rWu49gEC1/6b3yFePxVuBkEaw0edrygbE8gyHai2cJg
         OslG0X5hHT0grVlLt9H4IvZZ1eZY0v+FgiwXKO7wjCiKeHilSaVZApee8inXk6NqFpN4
         b2RZR5lfkR1AI606fgdAkWD9k3O8A75GbFsc78Z8nRhTW9Tl7rYgGYMcrbd+9Xzbc5IZ
         qmOKUdUtVDODEHuPURpSRGXbCmDqW5N43c4iU04TKq7+dmAtdBc4+wcd0vwVMz1nvykH
         Mg3A==
X-Gm-Message-State: AG10YOR4MXewkJ8w4yJf9GWdNp7bbN+mHOtKIs4G1/FNrn+drxboFGUjvZVHb2KSLtP6bw==
X-Received: by 10.194.173.65 with SMTP id bi1mr15267246wjc.110.1453136234765;
        Mon, 18 Jan 2016 08:57:14 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id ft4sm24673423wjb.37.2016.01.18.08.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 08:57:13 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.gd0a78e9.dirty
In-Reply-To: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284299>

Currently ls-remote uses a hand rolled parser for the its command line
arguments.  Use the parse-options api instead of the hand rolled parser
to simplify the code and make it easier to add new arguments.  In
addition this improves the help message.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/ls-remote.c | 82 +++++++++++++++++++----------------------------------
 1 file changed, 29 insertions(+), 53 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index db21e52..3a20378 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -3,9 +3,11 @@
 #include "transport.h"
 #include "remote.h"
 
-static const char ls_remote_usage[] =
-"git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
-"                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]";
+static const char * const ls_remote_usage[] = {
+	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
+	   "                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]"),
+	NULL
+};
 
 /*
  * Is there one among the list of patterns that match the tail part
@@ -30,7 +32,6 @@ static int tail_match(const char **pattern, const char *path)
 
 int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	const char *dest = NULL;
 	unsigned flags = 0;
 	int get_url = 0;
@@ -43,59 +44,34 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct transport *transport;
 	const struct ref *ref;
 
-	if (argc == 2 && !strcmp("-h", argv[1]))
-		usage(ls_remote_usage);
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("do not print remote URL")),
+		OPT_STRING(0, "upload-pack", &uploadpack, N_("exec"),
+			   N_("path of git-upload-pack on the remote host")),
+		{ OPTION_STRING, 0, "exec", &uploadpack, N_("exec"),
+			   N_("path of git-upload-pack on the remote host"),
+			   PARSE_OPT_HIDDEN },
+		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
+		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
+		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
+		OPT_BOOL(0, "get-url", &get_url,
+			 N_("take url.<base>.insteadOf into account")),
+		OPT_SET_INT(0, "exit-code", &status,
+			    N_("exit with exit code 2 if no matching refs are found"), 2),
+		OPT_END()
+	};
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	dest = argv[0];
 
-		if (*arg == '-') {
-			if (starts_with(arg, "--upload-pack=")) {
-				uploadpack = arg + 14;
-				continue;
-			}
-			if (starts_with(arg, "--exec=")) {
-				uploadpack = arg + 7;
-				continue;
-			}
-			if (!strcmp("--tags", arg) || !strcmp("-t", arg)) {
-				flags |= REF_TAGS;
-				continue;
-			}
-			if (!strcmp("--heads", arg) || !strcmp("-h", arg)) {
-				flags |= REF_HEADS;
-				continue;
-			}
-			if (!strcmp("--refs", arg)) {
-				flags |= REF_NORMAL;
-				continue;
-			}
-			if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
-				quiet = 1;
-				continue;
-			}
-			if (!strcmp("--get-url", arg)) {
-				get_url = 1;
-				continue;
-			}
-			if (!strcmp("--exit-code", arg)) {
-				/* return this code if no refs are reported */
-				status = 2;
-				continue;
-			}
-			usage(ls_remote_usage);
-		}
-		dest = arg;
-		i++;
-		break;
+	if (argc > 1) {
+		int i;
+		pattern = xcalloc(argc, sizeof(const char *));
+		for (i = 1; i < argc; i++)
+			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
 	}
 
-	if (argv[i]) {
-		int j;
-		pattern = xcalloc(argc - i + 1, sizeof(const char *));
-		for (j = i; j < argc; j++)
-			pattern[j - i] = xstrfmt("*/%s", argv[j]);
-	}
 	remote = remote_get(dest);
 	if (!remote) {
 		if (dest)
-- 
2.7.0.30.gd0a78e9.dirty
