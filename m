From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 4/5] ls-remote: use parse-options api
Date: Tue, 19 Jan 2016 00:20:49 +0100
Message-ID: <1453159250-21298-5-git-send-email-t.gummerer@gmail.com>
References: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 00:21:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLJ72-0006mm-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 00:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbcARXVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 18:21:24 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36113 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773AbcARXUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 18:20:50 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so19481161wmf.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 15:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xHlfeffemAHfrmQeeed8kVxM6Y+QOQuw2OxzX1vHg6E=;
        b=bhyxsDaa95ZXQ37BRHcGEOjPT7z6VrclIa9hEqRgpBwYGHuTp3aDmtQI4AKUyMaoVw
         0LunqRtbKE83RN6BjAS0nefCPGtBx+dW8JTSXQwnIk69rGIKHbjAaJaqw2Feb3/jonCF
         n0APlK7Xw1yyw7xwkJKC8V2zmDgx6zj9ZHeLVCZX5eVhi3hJtGNyXOZPpFx4vob90/cN
         aX0IJCV/MsR5xfQpFnF9ATdtpiaO33YN0Or2wUsoMEu0ZtU9xUGvEc7NolQdpB+LcGO7
         r89XujOvipQAAE2aD+eW9orkxunbd//DSMXJVo4ecOnqls0Lw3v9eDLdZUtSu0Fv4v4t
         jZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xHlfeffemAHfrmQeeed8kVxM6Y+QOQuw2OxzX1vHg6E=;
        b=iiBZxghksA8lHpOk9R3FKIXwVJrCWVi99DOzlKwfoG95wpSxvfW3hHuyPI+BRgJiav
         XXPLHhLBId2zmL8XdFaXulPI7OHyOIpt1SY7IVgb3QwTMxBOB2+QCw2hidpazGvDojU1
         fle30rZQ98VhRGY2hxWeua+lxlqubzabWrp/oEA6Hu899/0PflkVKmXKASVTfj+bObBL
         Afz64SzjBAyofASPxb8osRPb/HZB/LqFSQCk45IyRWEbxGRfVyTUqi2pj70kV4O/LxQ5
         Qj3NMkp9gFx1usmWwNiKa5g5iYIUX3v1PbEI8A3CJRVAveIGwVIDhKyHFJsyNaPSaN3F
         ITBw==
X-Gm-Message-State: ALoCoQmPq/MYIbRIUR94sbm2i6oRSgqbDuybtDpc+WxnARMa2WQUDK09SC+P77qSPgL6gmi31sVOB6jwU4fIgRP/WKoAC55FnA==
X-Received: by 10.194.105.99 with SMTP id gl3mr25690922wjb.90.1453159248800;
        Mon, 18 Jan 2016 15:20:48 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id y8sm17700980wmg.9.2016.01.18.15.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 15:20:47 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.g56a8654.dirty
In-Reply-To: <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284339>

Currently ls-remote uses a hand rolled parser for its command line
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
2.7.0.30.g56a8654.dirty
