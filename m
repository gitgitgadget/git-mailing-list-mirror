From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/5] ls-remote: introduce symrefs argument
Date: Mon, 18 Jan 2016 17:57:13 +0100
Message-ID: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 17:57:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLD7B-0003N4-GY
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 17:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965AbcARQ5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 11:57:11 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35143 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775AbcARQ5G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 11:57:06 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so10520724wmz.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1rBVWbMPVviiK/Fmj0Tj7VvkVIDrdJumRd26bOlFeMM=;
        b=vTexlw3yVnv6Q9tHR9tHuXE7Mg7jsnv4GpXf0NjJul/kcL9Byg2t93VZBk5XxfKruz
         4fsuILl6zfhJ65JZ0+feKiqzZ8qCWQULPz/l9ypOAU/+Pzv562DVUh/O231rfthSzhm+
         rsXBaf0WubrLo0ojK4i43lA3dm3iBOudW+8GM8dKAhFmE4hj7utgG7468yoZDhkFYK/F
         8F2z2meisPL4CK+CXKCWVG/K5D/y8wdKvrbMJu+9fx8jmp83Mxsx4WDN2v6uKluKr9Sb
         ldMi7QVURqELqI8lcDGWzmYtS9CE9KlpfA28FFUf6saLgPUSXXAAxeJQEC+dFJG+nqa8
         ySSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1rBVWbMPVviiK/Fmj0Tj7VvkVIDrdJumRd26bOlFeMM=;
        b=kPsKmbO7D+iYuRRVQk+uiELfiR+yh1n8VArfftZv0EwfSfzhtJjd9IQvdwMw6dGaUn
         rr5FXrcWhmipweANzOlLTYeepq+54+K5FxOsNsPWLI37vCw+pOhSSaJKbKZD+i90AyrM
         nxFFZjvUPjKCtd0EL0XsnegynEh+eaW1hHsCDh5lVtd1zk4UfLcWJf/dYgU1lX6pvNpj
         JpW8uJ8DVBx0phWOHiVUUZtYzvNZDZyWmYJQ2PcdpVId+jV3rQHt+TKQjxdBtcQ5bHC8
         MQopS5QPLDFnQpsCmIdF98sCbMSfXxfZxxZOfAETKXaX/fdGuvqhZWvsHDHDuLIEB7N7
         2P8Q==
X-Gm-Message-State: ALoCoQmYRpeqLvtFdjJeF7XAxejhqSCkY1jGSBoXw8nxift+ZvBq82YUIIJzuwhIOdbHVeATHZImDNVYmLW5tcdHMGZKIL5lCw==
X-Received: by 10.194.86.71 with SMTP id n7mr25059813wjz.107.1453136225404;
        Mon, 18 Jan 2016 08:57:05 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id 17sm16597070wmy.15.2016.01.18.08.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 08:57:02 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.gd0a78e9.dirty
In-Reply-To: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284294>

The previous round is at $gmane/284248.  Thanks to Peff an Junio for
comments on the previous round.

Changes from the previous round:
 - added patch documenting the --refs option
 - addressed peffs comments on the parse-option patch
 - the symrefs format now uses only ref: as an indicator for a symref
 - symrefs are now shown in addition to the other refs, instead of
   replacing them in the output.
 - symrefs are now filtered by the same rules as other refs.

Interdiff below:

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5b606dd..9356df2 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -9,7 +9,7 @@ git-ls-remote - List references in a remote repository
 SYNOPSIS
 --------
 [verse]
-'git ls-remote' [--heads] [--tags]  [--upload-pack=<exec>]
+'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
 	      [-q | --quiet] [--exit-code] [--get-url]
 	      [--symrefs] [<repository> [<refs>...]]
 
@@ -30,6 +30,10 @@ OPTIONS
 	both, references stored in refs/heads and refs/tags are
 	displayed.
 
+--refs::
+	Do not show peeled tags or pseudo-refs like HEAD or MERGE_HEAD
+	in the output.
+
 -q::
 --quiet::
 	Do not print remote URL to stderr.
@@ -52,9 +56,7 @@ OPTIONS
 	exit without talking to the remote.
 
 --symrefs::
-	Show the symrefs on the server.  Shows only the symrefs by
-	default, and can be combined with --tags and --heads to show
-	refs/heads and refs/tags as well.
+	Show the symrefs in addition to the other refs.
 
 <repository>::
 	The "remote" repository to query.  This parameter can be
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index f33ada9..ea73d53 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -4,7 +4,7 @@
 #include "remote.h"
 
 static const char * const ls_remote_usage[] = {
-	N_("git ls-remote [--heads] [--tags]  [--upload-pack=<exec>]\n"
+	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
 	   "                     [-q | --quiet] [--exit-code] [--get-url]\n"
 	   "                     [--symrefs] [<repository> [<refs>...]]"),
 	NULL
@@ -38,7 +38,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int get_url = 0;
 	int quiet = 0;
 	int status = 0;
-	int tags = 0, heads = 0, refs = 0;
 	int symrefs = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
@@ -51,13 +50,14 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("do not print remote URL")),
 		OPT_STRING(0, "upload-pack", &uploadpack, N_("exec"),
 			   N_("path of git-upload-pack on the remote host")),
-		OPT_STRING(0, "exec", &uploadpack, N_("exec"),
-			   N_("path of git-upload-pack on the remote host")),
-		OPT_SET_INT('t', "tags", &tags, N_("limit to tags"), REF_TAGS),
-		OPT_SET_INT('h', "heads", &heads, N_("limit to heads"), REF_HEADS),
-		OPT_SET_INT(0, "refs", &refs, N_("no magic fake tag refs"), REF_NORMAL),
-		OPT_SET_INT(0, "get-url", &get_url,
-			    N_("take url.<base>.insteadOf into account"), 1),
+		{ OPTION_STRING, 0, "exec", &uploadpack, N_("exec"),
+			   N_("path of git-upload-pack on the remote host"),
+			   PARSE_OPT_HIDDEN },
+		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
+		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
+		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
+		OPT_BOOL(0, "get-url", &get_url,
+			 N_("take url.<base>.insteadOf into account")),
 		OPT_SET_INT(0, "exit-code", &status,
 			    N_("exit with exit code 2 if no matching refs are found"), 2),
 		OPT_BOOL(0, "symrefs", &symrefs, N_("show symrefs")),
@@ -66,7 +66,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	flags = tags | heads | refs;
 	dest = argv[0];
 
 	if (argc > 1) {
@@ -101,15 +100,13 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
 	for ( ; ref; ref = ref->next) {
-		if (symrefs && ref->symref)
-			printf("symref: %s	%s\n", ref->symref, ref->name);
-		if (symrefs && !flags)
-			continue;
 		if (!check_ref_type(ref, flags))
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
-		printf("%s	%s\n", oid_to_hex(&ref->old_oid), ref->name);
+		if (symrefs && ref->symref)
+			printf("ref: %s\t%s\n", ref->symref, ref->name);
+		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
 		status = 0; /* we found something */
 	}
 	return status;
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 68a1429..3edbc9e 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -165,21 +165,23 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 
 test_expect_success 'ls-remote --symrefs' '
 	cat >expect <<-EOF &&
-	symref: refs/heads/master	HEAD
+	ref: refs/heads/master	HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
 	EOF
 	git ls-remote --symrefs >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'ls-remote with symrefs and refs combined' '
+test_expect_success 'ls-remote with filtered symrefs' '
 	cat >expect <<-EOF &&
-	symref: refs/heads/master	HEAD
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	ref: refs/heads/master	HEAD
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
 	EOF
-	git ls-remote --symrefs --refs >actual &&
+	git ls-remote --symrefs . HEAD >actual &&
 	test_cmp expect actual
 '
 
Thomas Gummerer (5):
  ls-remote: document --quiet option
  ls-remote: document --refs option
  ls-remote: fix synopsis
  ls-remote: use parse-options api
  ls-remote: add support for showing symrefs

 Documentation/git-ls-remote.txt | 16 +++++++-
 builtin/ls-remote.c             | 89 ++++++++++++++++-------------------------
 t/t5512-ls-remote.sh            | 22 ++++++++++
 3 files changed, 71 insertions(+), 56 deletions(-)

-- 
2.7.0.30.gd0a78e9.dirty
