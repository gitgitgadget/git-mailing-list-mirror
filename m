From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 16/19] index-helper: autorun mode
Date: Mon,  9 May 2016 16:48:46 -0400
Message-ID: <1462826929-7567-17-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:51:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7m-0004LM-IZ
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbcEIUth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:49:37 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36293 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbcEIUt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:26 -0400
Received: by mail-qg0-f42.google.com with SMTP id w36so95745023qge.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uqiTzTheVkJCbw9q4fwpmo5iQ74l1mhGKBqmj2I7EtQ=;
        b=A5Qi5NULmtOUtLCc7UL9JSvd6t9ml/T4+SIKxe8+ZA/n7XR1bOkfSeI8HlpNh16crg
         vZwXFzzaeuqLjevx/VFWofH4bke8Vym2tkQUxs3neeMw7pOyOwh86nlkKtA1dm4RJixX
         bfIGER90tXaelhf9jZ37Vu/lU1pHYukqmSApF9IKRwbuI22RnLJ6tIkoBip2yW++BL/e
         2kCpQOoMivEDo2+xrg28SfK5ZXsZfd1J7IqQvxn1MHj2f4V4V/dBHmKe5DvYv9s5mgPo
         b4n99vvlZffvSN2S4odlLkzwxxDANx1KsO+oHg7Zwu3IJZ3x4oOJhK906VwNGyocBvcO
         KFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uqiTzTheVkJCbw9q4fwpmo5iQ74l1mhGKBqmj2I7EtQ=;
        b=aHog5d17d+8cnGX6wVBX/BW3Bx3hRq56qYAuAWBm40UaFs1tZvUCsBDF2190UORnqC
         ZXX83mNYw/uKvQ2Gl8Kxv9t2TekkgZTxYIeznMxUdMj2v0pHteJugVa51Rbeccx5D1Wm
         vIENM8p383UjgYO+SMU6kHBJmuAeSoOib2kp++vNQtunj8BCLnRFAZ74I8Li7st3DgMo
         N3jCtECSi/p3f9eqFoEOkUzUCSDQMJUj8JA0R+F+gN6z954ttbVJgamoJiAfq3BhDh65
         1PeylZbCUFqRHHiTmqo1zOqccEj4SglCC2HxQ4QrEOWdV3TX3MCZCo8NLJUfh0eSH2pq
         AeFA==
X-Gm-Message-State: AOPr4FXBLN45m8inTupvhTkhp5XGaAO1k8vI3HLqf266a7wCuumha96As9BVgb9GWycyIQ==
X-Received: by 10.140.221.210 with SMTP id r201mr38556206qhb.16.1462826965305;
        Mon, 09 May 2016 13:49:25 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294065>

Soon, we'll want to automatically start index-helper, so we need
a mode that silently exits if it can't start up (either because
it's not in a git dir, or because another one is already running).

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  4 ++++
 index-helper.c                     | 29 +++++++++++++++++++++++------
 t/t7900-index-helper.sh            |  8 ++++++++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index addf694..0466296 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -43,6 +43,10 @@ OPTIONS
 --kill::
 	Kill any running index-helper and clean up the socket
 
+--autorun::
+	If index-helper is not already running, start it.  Else, do
+	nothing.
+
 NOTES
 -----
 
diff --git a/index-helper.c b/index-helper.c
index b275f6e..9743481 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -427,8 +427,9 @@ static void request_kill(void)
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds = 600, detach = 0, kill = 0;
+	int idle_in_seconds = 600, detach = 0, kill = 0, autorun = 0;
 	int fd;
+	int nongit;
 	struct strbuf socket_path = STRBUF_INIT;
 	struct option options[] = {
 		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
@@ -437,6 +438,7 @@ int main(int argc, char **argv)
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
+		OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -446,7 +448,14 @@ int main(int argc, char **argv)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage_text, options);
 
-	prefix = setup_git_directory();
+	prefix = setup_git_directory_gently(&nongit);
+	if (nongit) {
+		if (autorun)
+			exit(0);
+		else
+			die(_("not a git repository"));
+	}
+
 	if (parse_options(argc, (const char **)argv, prefix,
 			  options, usage_text, 0))
 		die(_("too many arguments"));
@@ -460,10 +469,18 @@ int main(int argc, char **argv)
 
 	/* check that no other copy is running */
 	fd = unix_stream_connect(git_path("index-helper.sock"));
-	if (fd > 0)
-		die(_("Already running"));
-	if (errno != ECONNREFUSED && errno != ENOENT)
-		die_errno(_("Unexpected error checking socket"));
+	if (fd > 0) {
+		if (autorun)
+			exit(0);
+		else
+			die(_("Already running"));
+	}
+	if (errno != ECONNREFUSED && errno != ENOENT) {
+		if (autorun)
+			return 0;
+		else
+			die_errno(_("Unexpected error checking socket"));
+	}
 
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 7159971..aa6e5fc 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -38,4 +38,12 @@ test_expect_success 'index-helper will not start if already running' '
 	grep "Already running" err
 '
 
+test_expect_success 'index-helper is quiet with --autorun' '
+	test_when_finished "git index-helper --kill" &&
+	git index-helper --kill &&
+	git index-helper --detach &&
+	test -S .git/index-helper.sock &&
+	git index-helper --autorun
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
