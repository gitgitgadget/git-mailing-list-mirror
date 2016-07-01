Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4418B1FE4E
	for <e@80x24.org>; Fri,  1 Jul 2016 06:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbcGAGHI (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 02:07:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:38742 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752254AbcGAGHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 02:07:04 -0400
Received: (qmail 24208 invoked by uid 102); 1 Jul 2016 06:07:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:07:06 -0400
Received: (qmail 13635 invoked by uid 107); 1 Jul 2016 06:07:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:07:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 02:07:01 -0400
Date:	Fri, 1 Jul 2016 02:07:01 -0400
From:	Jeff King <peff@peff.net>
To:	"dmh@ucar.edu" <dmh@ucar.edu>
Cc:	git@vger.kernel.org
Subject: [PATCH 5/5] common-main: call git_setup_gettext()
Message-ID: <20160701060701.GE4593@sigill.intra.peff.net>
References: <20160701055532.GA4488@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160701055532.GA4488@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This should be part of every program, as otherwise users do
not get translated error messages. However, some external
commands forgot to do so (e.g., git-credential-store). This
fixes them, and eliminates the repeated code in programs
that did remember to use it.

Signed-off-by: Jeff King <peff@peff.net>
---
 common-main.c  | 2 ++
 daemon.c       | 2 --
 fast-import.c  | 2 --
 git.c          | 2 --
 http-backend.c | 2 --
 http-fetch.c   | 2 --
 http-push.c    | 2 --
 imap-send.c    | 2 --
 remote-curl.c  | 2 --
 shell.c        | 2 --
 show-index.c   | 2 --
 upload-pack.c  | 2 --
 12 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/common-main.c b/common-main.c
index 20e55ef..3be5ad1 100644
--- a/common-main.c
+++ b/common-main.c
@@ -37,6 +37,8 @@ int main(int argc, char **av)
 	 */
 	sanitize_stdfds();
 
+	git_setup_gettext();
+
 	argv[0] = git_extract_argv0_path(argv[0]);
 
 	restore_sigpipe_to_default();
diff --git a/daemon.c b/daemon.c
index 8646f33..e647254 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1201,8 +1201,6 @@ int cmd_main(int argc, const char **argv)
 	struct credentials *cred = NULL;
 	int i;
 
-	git_setup_gettext();
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		const char *v;
diff --git a/fast-import.c b/fast-import.c
index f12cd00..bf53ac9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3448,8 +3448,6 @@ int cmd_main(int argc, const char **argv)
 {
 	unsigned int i;
 
-	git_setup_gettext();
-
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(fast_import_usage);
 
diff --git a/git.c b/git.c
index ccb24fd..0f1937f 100644
--- a/git.c
+++ b/git.c
@@ -618,8 +618,6 @@ int cmd_main(int argc, const char **argv)
 	if (!cmd)
 		cmd = "git-help";
 
-	git_setup_gettext();
-
 	trace_command_performance(argv);
 
 	/*
diff --git a/http-backend.c b/http-backend.c
index 5375cbc..0d59499 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -640,8 +640,6 @@ int cmd_main(int argc, const char **argv)
 	char *cmd_arg = NULL;
 	int i;
 
-	git_setup_gettext();
-
 	set_die_routine(die_webcgi);
 	set_die_is_recursing_routine(die_webcgi_recursing);
 
diff --git a/http-fetch.c b/http-fetch.c
index 244cd0d..3b556d6 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -22,8 +22,6 @@ int cmd_main(int argc, const char **argv)
 	int get_verbosely = 0;
 	int get_recover = 0;
 
-	git_setup_gettext();
-
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
 			get_tree = 1;
diff --git a/http-push.c b/http-push.c
index 3a5fecf..dacada9 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1709,8 +1709,6 @@ int cmd_main(int argc, const char **argv)
 	int new_refs;
 	struct ref *ref, *local_refs;
 
-	git_setup_gettext();
-
 	repo = xcalloc(1, sizeof(*repo));
 
 	argv++;
diff --git a/imap-send.c b/imap-send.c
index 125b218..9cbe27f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1500,8 +1500,6 @@ int cmd_main(int argc, const char **argv)
 	int total;
 	int nongit_ok;
 
-	git_setup_gettext();
-
 	setup_git_directory_gently(&nongit_ok);
 	git_imap_config();
 
diff --git a/remote-curl.c b/remote-curl.c
index d39f4cf..6b83b77 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -989,8 +989,6 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	int nongit;
 
-	git_setup_gettext();
-
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
 		error("remote-curl: usage: git remote-curl <remote> [<url>]");
diff --git a/shell.c b/shell.c
index 5e70acb..464ee1a 100644
--- a/shell.c
+++ b/shell.c
@@ -145,8 +145,6 @@ int cmd_main(int argc, const char **argv)
 	struct commands *cmd;
 	int count;
 
-	git_setup_gettext();
-
 	/*
 	 * Special hack to pretend to be a CVS server
 	 */
diff --git a/show-index.c b/show-index.c
index 575f9c5..1ead41e 100644
--- a/show-index.c
+++ b/show-index.c
@@ -11,8 +11,6 @@ int cmd_main(int argc, const char **argv)
 	unsigned int version;
 	static unsigned int top_index[256];
 
-	git_setup_gettext();
-
 	if (argc != 1)
 		usage(show_index_usage);
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
diff --git a/upload-pack.c b/upload-pack.c
index 681fd2f..8769b1b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -836,8 +836,6 @@ int cmd_main(int argc, const char **argv)
 		OPT_END()
 	};
 
-	git_setup_gettext();
-
 	packet_trace_identity("upload-pack");
 	check_replace_refs = 0;
 
-- 
2.9.0.317.g65b4e7c
