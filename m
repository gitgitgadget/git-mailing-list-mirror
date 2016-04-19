From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 14/15] index-helper: autorun mode
Date: Tue, 19 Apr 2016 19:28:08 -0400
Message-ID: <1461108489-29376-15-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4f-0008QM-HZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbcDSX2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:28:49 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35851 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbcDSX2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:32 -0400
Received: by mail-qk0-f169.google.com with SMTP id x7so9647857qkd.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gt858CaAwq+UknbPkMrU1rv+a6JN6jb6udmawyGLh2s=;
        b=XahWy+lpIYLl7VIrnnLOE1Xq0TD3FxVejmqTGT1rBr+ZOUS67AMQHmijdoca8FrKRq
         dkN3vJQ8U3qoYQxRlknFadxP38CchO1AGKyn1OW72llPrwmdAufsDUBReX7X6NL6Dwxg
         8SuBDs5BCMLU4XD+9IHP5OEy6rxQn1oZxnkkbbggp1bWCw6sVUd9Xr4FYRwfSRTPod8v
         Z8Frm3Xp+l53ztEVWDjqgeS3ZN3h5xSr+ZRD4DYRIUKEqXs1M9kz9PbJvsM/DR8R1ZCa
         vYwFomtdPG6+ly4gLytV7PPzHmcwqm1EhqsxVH+UmZog/QN1EX8KVt6Lis1qUhoAifJ/
         thew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gt858CaAwq+UknbPkMrU1rv+a6JN6jb6udmawyGLh2s=;
        b=EoNGf1DryNuobQefMVOK6R3JerSMeNUl23WGmf4UDtbNILP20mehSxQyIQAiXYkhl3
         sGXvFZSZovpXgpbofKEpnjIL9D9EI0KT0E73ZNEHgYCXyvJR8q9doQGlOVscIb8LA7fC
         TnmPQDUTGPAqJ7PPjWZGEurddmT95WqmTjeOyo8oF3XPvo7cZutmrfjbHXK5Uvl8G8Ie
         qUAz++3NRjvvWDiK+ztkTFriPTgZyfZGTytJTZ3IvARWTIQY2TTyWDkDNl7jUMyoxyzZ
         4F0dHyepVM4wOD/un3vtV67H5z5MBfVbx3l3XPpMPO8DvJOdJZpKt+VhmPy1JfVsAiJ8
         bWeg==
X-Gm-Message-State: AOPr4FXz7WfkovdoOYc6axpSjvGtvsUWb7vua1XG/1mzDN4fyzVnq9Bx9zVlzVDOQv7/5g==
X-Received: by 10.55.3.8 with SMTP id 8mr7398261qkd.12.1461108511289;
        Tue, 19 Apr 2016 16:28:31 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291965>

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
index 7d80638..91d7a36 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -40,6 +40,10 @@ OPTIONS
 --kill::
 	Kill any running index-helper and clean up the socket
 
+--autorun::
+	If index-helper is not already running, start it.  Else, do
+	nothing.
+
 NOTES
 -----
 
diff --git a/index-helper.c b/index-helper.c
index 8fcb76e..3d884da 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -381,8 +381,9 @@ static void request_kill(void)
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
@@ -391,6 +392,7 @@ int main(int argc, char **argv)
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
+		OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -400,7 +402,14 @@ int main(int argc, char **argv)
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
@@ -414,10 +423,18 @@ int main(int argc, char **argv)
 
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
