From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/15] builtin/remote.c:update(): use struct argv_array
Date: Wed, 23 Oct 2013 17:50:47 +0200
Message-ID: <1382543448-2586-15-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:52:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0jW-0002Ig-OE
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab3JWPw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:52:27 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42202 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709Ab3JWPwX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:52:23 -0400
X-AuditID: 12074414-b7fb46d000002a4d-ce-5267f0b647ea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 20.E2.10829.6B0F7625; Wed, 23 Oct 2013 11:52:22 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLt7009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:52:19 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqLvtQ3qQwdkpghbTu1azWHRd6Way
	aOi9wmwx7+4uJotVt5YxW6yccYPR4vaK+cwWTzsrLea9eMFm8aOlh9mBy+Pv+w9MHpfWvWTy
	OPRnCrvHsxPtbB6XXn5n83jWu4fR4+IlZY8ZLa9ZPD5vkvM4cPkxWwBXFLdNUmJJWXBmep6+
	XQJ3xqLFzUwFnwQr2q4+Zm5gfM7XxcjBISFgIrFhH3MXIyeQKSZx4d56ti5GLg4hgcuMEg09
	WxkhnCtMEtP+b2EBqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCwwkVni+PRFYEXCAu4SW9e9Ayti
	EVCVuNgygR3E5hVwkVh25yMrxGY5iYffYkHCnEDhC8ens4LYQgLOEhMWTmWfwMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZI0IrsYDxyUu4QowAHoxIP74OWtCAh
	1sSy4srcQ4ySHExKorzswJAX4kvKT6nMSCzOiC8qzUktPsQowcGsJMK74y5QjjclsbIqtSgf
	JiXNwaIkzvttsbqfkEB6YklqdmpqQWoRTFaGg0NJgrfpPVCjYFFqempFWmZOCUKaiYMTRHCB
	bOAB2hADUshbXJCYW5yZDlF0ilFRSpx3P0hCACSRUZoHNwCWXl4xigP9I8w7G6SKB5ia4Lpf
	AQ1mAho8ZUkayOCSRISUVANjevaDe+X72wq4dpab1tsf817LKeo/P+CZ577wx+G35ni9fPRk
	glDYZ6Yv/9Z73lY7wzDBvuXp7Yd7Ge9+3ha7xurSgw7nto1LD646M+F94JronzwB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236519>

Use struct argv_array for calling the "git fetch" subprocesses.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index ecedd96..bffe2f9 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -6,6 +6,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
+#include "argv-array.h"
 
 static const char * const builtin_remote_usage[] = {
 	N_("git remote [-v | --verbose]"),
@@ -1376,36 +1377,36 @@ static int update(int argc, const char **argv)
 			 N_("prune remotes after fetching")),
 		OPT_END()
 	};
-	const char **fetch_argv;
-	int fetch_argc = 0;
+	struct argv_array fetch_argv = ARGV_ARRAY_INIT;
 	int default_defined = 0;
-
-	fetch_argv = xmalloc(sizeof(char *) * (argc+5));
+	int retval;
 
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_update_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 
-	fetch_argv[fetch_argc++] = "fetch";
+	argv_array_push(&fetch_argv, "fetch");
 
 	if (prune)
-		fetch_argv[fetch_argc++] = "--prune";
+		argv_array_push(&fetch_argv, "--prune");
 	if (verbose)
-		fetch_argv[fetch_argc++] = "-v";
-	fetch_argv[fetch_argc++] = "--multiple";
+		argv_array_push(&fetch_argv, "-v");
+	argv_array_push(&fetch_argv, "--multiple");
 	if (argc < 2)
-		fetch_argv[fetch_argc++] = "default";
+		argv_array_push(&fetch_argv, "default");
 	for (i = 1; i < argc; i++)
-		fetch_argv[fetch_argc++] = argv[i];
+		argv_array_push(&fetch_argv, argv[i]);
 
-	if (strcmp(fetch_argv[fetch_argc-1], "default") == 0) {
+	if (strcmp(fetch_argv.argv[fetch_argv.argc-1], "default") == 0) {
 		git_config(get_remote_default, &default_defined);
-		if (!default_defined)
-			fetch_argv[fetch_argc-1] = "--all";
+		if (!default_defined) {
+			argv_array_pop(&fetch_argv);
+			argv_array_push(&fetch_argv, "--all");
+		}
 	}
 
-	fetch_argv[fetch_argc] = NULL;
-
-	return run_command_v_opt(fetch_argv, RUN_GIT_CMD);
+	retval = run_command_v_opt(fetch_argv.argv, RUN_GIT_CMD);
+	argv_array_clear(&fetch_argv);
+	return retval;
 }
 
 static int remove_all_fetch_refspecs(const char *remote, const char *key)
-- 
1.8.4
