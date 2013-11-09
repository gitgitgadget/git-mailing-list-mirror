From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/86] daemon: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:05:58 +0100
Message-ID: <20131109070720.18178.19274.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2i2-0005uf-Bg
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397Ab3KIHLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:38 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36269 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932942Ab3KIHIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:22 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 510B596;
	Sat,  9 Nov 2013 08:08:21 +0100 (CET)
X-git-sha1: eca833cf9896fc405f682924fe3df1b5aac9e58c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237541>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 daemon.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/daemon.c b/daemon.c
index 34916c5..4b23800 100644
--- a/daemon.c
+++ b/daemon.c
@@ -235,7 +235,7 @@ static int service_enabled;
 
 static int git_daemon_config(const char *var, const char *value, void *cb)
 {
-	if (!prefixcmp(var, "daemon.") &&
+	if (has_prefix(var, "daemon.") &&
 	    !strcmp(var + 7, service_looking_at->config_name)) {
 		service_enabled = git_config_bool(var, value);
 		return 0;
@@ -633,7 +633,7 @@ static int execute(void)
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
 		int namelen = strlen(s->name);
-		if (!prefixcmp(line, "git-") &&
+		if (has_prefix(line, "git-") &&
 		    !strncmp(s->name, line + 4, namelen) &&
 		    line[namelen + 4] == ' ') {
 			/*
@@ -1165,11 +1165,11 @@ int main(int argc, char **argv)
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
-		if (!prefixcmp(arg, "--listen=")) {
+		if (has_prefix(arg, "--listen=")) {
 			string_list_append(&listen_addr, xstrdup_tolower(arg + 9));
 			continue;
 		}
-		if (!prefixcmp(arg, "--port=")) {
+		if (has_prefix(arg, "--port=")) {
 			char *end;
 			unsigned long n;
 			n = strtoul(arg+7, &end, 0);
@@ -1199,19 +1199,19 @@ int main(int argc, char **argv)
 			export_all_trees = 1;
 			continue;
 		}
-		if (!prefixcmp(arg, "--access-hook=")) {
+		if (has_prefix(arg, "--access-hook=")) {
 			access_hook = arg + 14;
 			continue;
 		}
-		if (!prefixcmp(arg, "--timeout=")) {
+		if (has_prefix(arg, "--timeout=")) {
 			timeout = atoi(arg+10);
 			continue;
 		}
-		if (!prefixcmp(arg, "--init-timeout=")) {
+		if (has_prefix(arg, "--init-timeout=")) {
 			init_timeout = atoi(arg+15);
 			continue;
 		}
-		if (!prefixcmp(arg, "--max-connections=")) {
+		if (has_prefix(arg, "--max-connections=")) {
 			max_connections = atoi(arg+18);
 			if (max_connections < 0)
 				max_connections = 0;	        /* unlimited */
@@ -1221,7 +1221,7 @@ int main(int argc, char **argv)
 			strict_paths = 1;
 			continue;
 		}
-		if (!prefixcmp(arg, "--base-path=")) {
+		if (has_prefix(arg, "--base-path=")) {
 			base_path = arg+12;
 			continue;
 		}
@@ -1229,7 +1229,7 @@ int main(int argc, char **argv)
 			base_path_relaxed = 1;
 			continue;
 		}
-		if (!prefixcmp(arg, "--interpolated-path=")) {
+		if (has_prefix(arg, "--interpolated-path=")) {
 			interpolated_path = arg+20;
 			continue;
 		}
@@ -1241,11 +1241,11 @@ int main(int argc, char **argv)
 			user_path = "";
 			continue;
 		}
-		if (!prefixcmp(arg, "--user-path=")) {
+		if (has_prefix(arg, "--user-path=")) {
 			user_path = arg + 12;
 			continue;
 		}
-		if (!prefixcmp(arg, "--pid-file=")) {
+		if (has_prefix(arg, "--pid-file=")) {
 			pid_file = arg + 11;
 			continue;
 		}
@@ -1254,35 +1254,35 @@ int main(int argc, char **argv)
 			log_syslog = 1;
 			continue;
 		}
-		if (!prefixcmp(arg, "--user=")) {
+		if (has_prefix(arg, "--user=")) {
 			user_name = arg + 7;
 			continue;
 		}
-		if (!prefixcmp(arg, "--group=")) {
+		if (has_prefix(arg, "--group=")) {
 			group_name = arg + 8;
 			continue;
 		}
-		if (!prefixcmp(arg, "--enable=")) {
+		if (has_prefix(arg, "--enable=")) {
 			enable_service(arg + 9, 1);
 			continue;
 		}
-		if (!prefixcmp(arg, "--disable=")) {
+		if (has_prefix(arg, "--disable=")) {
 			enable_service(arg + 10, 0);
 			continue;
 		}
-		if (!prefixcmp(arg, "--allow-override=")) {
+		if (has_prefix(arg, "--allow-override=")) {
 			make_service_overridable(arg + 17, 1);
 			continue;
 		}
-		if (!prefixcmp(arg, "--forbid-override=")) {
+		if (has_prefix(arg, "--forbid-override=")) {
 			make_service_overridable(arg + 18, 0);
 			continue;
 		}
-		if (!prefixcmp(arg, "--informative-errors")) {
+		if (has_prefix(arg, "--informative-errors")) {
 			informative_errors = 1;
 			continue;
 		}
-		if (!prefixcmp(arg, "--no-informative-errors")) {
+		if (has_prefix(arg, "--no-informative-errors")) {
 			informative_errors = 0;
 			continue;
 		}
-- 
1.8.4.1.566.geca833c
