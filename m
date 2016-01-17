From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/4] ls-remote: use parse-options api
Date: Sun, 17 Jan 2016 12:04:01 +0100
Message-ID: <1453028643-13978-4-git-send-email-t.gummerer@gmail.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Jan 17 12:03:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKl7k-00054T-C4
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 12:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbcAQLDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 06:03:54 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35202 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbcAQLDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 06:03:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id 123so3885574wmz.2
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 03:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HPhz6EpheWxuEjVSX31+1d1Y9apJrFPBlbEZhJRLKlY=;
        b=JA6adpO6HUX/eDt8uVFtfo2hh7WVu9vQ81EZz2NJYVIfctcnjuoxMmyEI7E29+MKRb
         d5WMnEfsXZot7O1Sv+CxnI8dm/KAVued28p2CzEEoR/PhNSGg3QtvyplrFIqbfA7FA30
         upXgD3RiXPVf59Ik4C3csysbjWSKyje3TJ9PwIq+fLOjdpmGtCM2YXaB+8fCKzkGVez+
         x6ZD23TiMweV9wQT4x22ZWb2YVAwImBsKCmKPPdoLHXCVwipbR7OJf6uNEDKOqElhxpM
         OroynF0cCJxp7VEq1iZcZFR31xudsxfo8O4vRoArmh8PK42r/cLZalHRq2CEMTJTwnn4
         bdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HPhz6EpheWxuEjVSX31+1d1Y9apJrFPBlbEZhJRLKlY=;
        b=PWKirpMS1EWF8iGiKHYJn3b64aKqUD/TkJUBDmDI+u9R0eewte/Mv1AO8oniOPdgTu
         TCzforeOa65IpcD+F8QL41KjtEqXuHPekGbHgNX+h2IfzqYuYVlBEVHO8H0ygggAnLM+
         Q/cIMhfwK2ZRhuoI12l2kmnsmrNwx4H3WPDxYTOSvUqrsEqS3w1SbbNq8p7SdAoDiIzH
         AcxnWerrxtlU307mnYK/WVBewft/qQ6FNR4v7Kd8v+He+PdLnCQP1PrBVQviZ9Lfrw8U
         EBDoMD4t+z6ei77RiN7DjDgQs5bHDjc7ftzAk7dgpsOPGRpAWG6pnC7RKa2KuZATB843
         w+3A==
X-Gm-Message-State: ALoCoQmTQ9fEGuWUe2aFt9Y2yUwzOKDeAHoHNR7l2wnh2kuhPZE58iYLfWpukZmkTJYA5fze/zrlc88xcuByD8Sa/RTfdAsdDA==
X-Received: by 10.195.18.100 with SMTP id gl4mr18187503wjd.177.1453028631117;
        Sun, 17 Jan 2016 03:03:51 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id h8sm1899451wjw.6.2016.01.17.03.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 03:03:49 -0800 (PST)
X-Mailer: git-send-email 2.7.0.14.g2b6d3d6
In-Reply-To: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284249>

Currently ls-remote uses a hand rolled parser for the its command line
arguments.  Use the parse-options api instead of the hand rolled parser
to simplify the code and make it easier to add new arguments.  In
addition this improves the help message.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/ls-remote.c | 83 +++++++++++++++++++----------------------------------
 1 file changed, 30 insertions(+), 53 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index fa65a84..6ee7b0e 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -3,9 +3,11 @@
 #include "transport.h"
 #include "remote.h"
 
-static const char ls_remote_usage[] =
-"git ls-remote [--heads] [--tags]  [--upload-pack=<exec>]\n"
-"                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]";
+static const char * const ls_remote_usage[] = {
+	N_("git ls-remote [--heads] [--tags]  [--upload-pack=<exec>]\n"
+	   "                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]"),
+	NULL
+};
 
 /*
  * Is there one among the list of patterns that match the tail part
@@ -30,12 +32,12 @@ static int tail_match(const char **pattern, const char *path)
 
 int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	const char *dest = NULL;
 	unsigned flags = 0;
 	int get_url = 0;
 	int quiet = 0;
 	int status = 0;
+	int tags = 0, heads = 0, refs = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
 
@@ -43,59 +45,34 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct transport *transport;
 	const struct ref *ref;
 
-	if (argc == 2 && !strcmp("-h", argv[1]))
-		usage(ls_remote_usage);
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("do not print remote URL")),
+		OPT_STRING(0, "upload-pack", &uploadpack, N_("exec"),
+			   N_("path of git-upload-pack on the remote host")),
+		OPT_STRING(0, "exec", &uploadpack, N_("exec"),
+			   N_("path of git-upload-pack on the remote host")),
+		OPT_SET_INT('t', "tags", &tags, N_("limit to tags"), REF_TAGS),
+		OPT_SET_INT('h', "heads", &heads, N_("limit to heads"), REF_HEADS),
+		OPT_SET_INT(0, "refs", &refs, N_("no magic fake tag refs"), REF_NORMAL),
+		OPT_SET_INT(0, "get-url", &get_url,
+			    N_("take url.<base>.insteadOf into account"), 1),
+		OPT_SET_INT(0, "exit-code", &status,
+			    N_("exit with exit code 2 if no matching refs are found"), 2),
+		OPT_END()
+	};
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	flags = tags | heads | refs;
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
2.7.0.14.g2b6d3d6
