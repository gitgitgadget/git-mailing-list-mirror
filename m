From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 16/19] index-helper: autorun mode
Date: Wed, 27 Apr 2016 16:04:38 -0400
Message-ID: <1461787481-877-17-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:05:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avViS-0003LV-7v
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbcD0UFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:05:39 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34444 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbcD0UF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:29 -0400
Received: by mail-qg0-f54.google.com with SMTP id 90so6215309qgz.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DCTCuLORtgUQd7MnY+g8FlinqmkMhIi5hH94p01Ac1M=;
        b=xp8F1QFxe3XOtmFM25/GXDeYIVN+EM3Gf+7yDpwQe26IXrF6Nh4qmHysH+GTKOFqlX
         KxpyHoTjDuozdgPXbhv/FmFZE6/+XcxQnZa2OUTLOfmRffFI806xKtJuzj/8XZ8lDobd
         ZbMYukq+Dp8vLn4hOZ4rURTuVP+Rzt7tffWlhq45Q0I9z+fgl/Tfxs+uUt3hVH1KqcRG
         oiwiIdfF26HFdJQpceiPBWiaKV4w1AIIwuOSm9oYUseuFsxSYE0S9M7UOYNowkbgphsG
         zwCXN9hpBf58X8oeBdUMeOc182XvDWoles8aFiDb8yXtV+oz+62DT40HTQ+EfB1kE4nW
         u5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DCTCuLORtgUQd7MnY+g8FlinqmkMhIi5hH94p01Ac1M=;
        b=nM86nZ99t515YBY3Uq6ERQgwWTRLZ4utsiQ6UzQlrWDbyN9y1xx5cBcxJCt8JQVqL4
         GAKMVJ0TTnudx5sH+ZIMqTsexLyxmb+9H1yPxQfNBWxDV9zSEE30PpaA++d4KoBHZmzt
         dJwx1nKTWcyhroOr15qKErG7ZLTY8JcaSX1oomiuWUCs8Ym6prs8+BAoKz6hpKPPXqFs
         1T4Hn0Y6RTSu5fb1XME+D3Dy/BYu5Aiu4hkCBzq/3ykEj9G7MSxH8BtJi5iIcsxGjKpj
         NvYUAOrToz+iUFRF6coXjXA85GJ+wRvuwdM5MeYF8c57HUjR/UJXn/cQLEjKV2Sp0oi8
         MJFQ==
X-Gm-Message-State: AOPr4FUlAqKnJzpJ37orJnnVam8umeGnwyeeu1QrLlPoNMeRuFN4brEKUiRd3u8uFuPLSQ==
X-Received: by 10.140.128.80 with SMTP id 77mr11014711qha.0.1461787528299;
        Wed, 27 Apr 2016 13:05:28 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292795>

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
index d68afd7..94766ec 100644
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
index 092c814..334ed4b 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -432,8 +432,9 @@ static void request_kill(void)
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
@@ -442,6 +443,7 @@ int main(int argc, char **argv)
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
+		OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -451,7 +453,14 @@ int main(int argc, char **argv)
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
@@ -465,10 +474,18 @@ int main(int argc, char **argv)
 
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
