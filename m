From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 14/16] index-helper: autorun mode
Date: Tue, 12 Apr 2016 20:33:07 -0400
Message-ID: <1460507589-25525-15-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:34:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8ks-0002sP-Lo
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758946AbcDMAdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 20:33:43 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32902 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758927AbcDMAdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:37 -0400
Received: by mail-qk0-f180.google.com with SMTP id n63so2389456qkf.0
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Wpcz7GHY77oIoUzp3yheLaRehvuEiqWiq7O1dqVjTM=;
        b=eb8Dgzd+Ur1x3M0h9kw1KCplsYkDGUYw/mkYDNUr+98dJHxHxkkKjcNhEO42CgYKSO
         m+zCcUDFlW0JYN11VxvY3ebZjXt4C+9A4aaUPY+koxofNtM+/+WUy/Ro0/GeKgxJKdMr
         bDhOTMebUxDkpDVzKItd4bnCmzplwUOVQJb7BrUEL2Dd0ZdDqioxHkV/Vp6xxGRf74Tp
         /fcQmJ1vWKJgBCsPvSjFzNIyQVlvQ7val2IUf4skN2urGIpmRKePjrsjfvX447KezcDU
         vE7pheRApaGULVtGgOS7hniqO1o8GZNi6XGwvyNLucd+Ra4+/6h7WwPqcmNIxFHpZnlu
         26EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Wpcz7GHY77oIoUzp3yheLaRehvuEiqWiq7O1dqVjTM=;
        b=G84ZIMDRs/laGOIA92pZOemv0zFqmjy0XUDdum+fRX8l0P3chkRIo6sq6FhH6pa+kc
         HtTFpau/t9dp/SRorNJxvjJ3vT1zEw3PxnjK7L1zD89dbWKoTMagAsXQ0zDSamYNl5yO
         41ao9EdcEOsPD+ghdnCPiP/FoXbUIDWM9fgSDrZ3ACYYOJZCl2vAP7Uymd+0WaaV4L9Y
         eWfV0rBw6KM+4aBBl02ONmHhuSPtfa71BJf6M8URyzm7rYi9g38Jm9/6DF+1cy3VOZ+o
         OdwuxS+Z1YshcUPktwKyBGE0+TzFsbRzL8Ln5SKzpB8o/FI+jURU8h3kR1WMxhSxLWK9
         7Mdw==
X-Gm-Message-State: AOPr4FWx3h9B0sHntYJWy1vWBLOqEjYhtsrO9bdomDsyhXutV0OAklOxWt+jvVzJSUEIyA==
X-Received: by 10.55.17.102 with SMTP id b99mr7223260qkh.86.1460507616578;
        Tue, 12 Apr 2016 17:33:36 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291349>

Soon, we'll want to automatically start index-helper, so we need
a mode that silently exits if it can't start up (either because
it's not in a git dir, or because another one is already running).

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 29 +++++++++++++++++++++++------
 t/t7900-index-helper.sh |  8 ++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/index-helper.c b/index-helper.c
index dcb2041..3374263 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -449,8 +449,9 @@ static void request_kill(void)
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
@@ -459,6 +460,7 @@ int main(int argc, char **argv)
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
+		OPT_BOOL(0, "autorun", &autorun, "this is an automatic run of git index-helper, so certain errors can be solved by silently exiting"),
 		OPT_END()
 	};
 
@@ -468,7 +470,14 @@ int main(int argc, char **argv)
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
@@ -482,10 +491,18 @@ int main(int argc, char **argv)
 
 	/* check that no other copy is running */
 	fd = connect_to_index_helper();
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
index 32ef6f7..eeca483 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -41,4 +41,12 @@ test_expect_success 'index-helper will not start if already running' '
 	grep "Already running" err
 '
 
+test_expect_success 'index-helper is quiet with --autorun' '
+	test_when_finished "git index-helper --kill" &&
+	git index-helper --kill &&
+	git index-helper --detach &&
+	test -L .git/index-helper.path &&
+	git index-helper --autorun
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
