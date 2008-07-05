From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH 1/5] builtin-commit.c: Use 'git_config_string' to get 'commit.template'
Date: Sat,  5 Jul 2008 01:24:40 -0400
Message-ID: <fd5cae53021281c920ba48efef82dc8a8d3c7fe1.1215234749.git.whee@smaertness.net>
References: <cover.1215234749.git.whee@smaertness.net>
Cc: gitster@pobox.com, Brian Hetro <whee@smaertness.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 07:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF0Hf-0003MG-5H
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 07:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbYGEFZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 01:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbYGEFZH
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 01:25:07 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:2512 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbYGEFZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 01:25:01 -0400
Received: by yw-out-2324.google.com with SMTP id 9so646406ywe.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 22:24:54 -0700 (PDT)
Received: by 10.150.212.14 with SMTP id k14mr3315170ybg.139.1215235494718;
        Fri, 04 Jul 2008 22:24:54 -0700 (PDT)
Received: from localhost.localdomain ( [74.69.33.95])
        by mx.google.com with ESMTPS id 34sm1794628yxm.0.2008.07.04.22.24.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jul 2008 22:24:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.1.204.g699135
In-Reply-To: <cover.1215234749.git.whee@smaertness.net>
In-Reply-To: <cover.1215234749.git.whee@smaertness.net>
References: <cover.1215234749.git.whee@smaertness.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87434>

Signed-off-by: Brian Hetro <whee@smaertness.net>
---
 builtin-commit.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e3ad38b..745c11e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -45,7 +45,8 @@ static enum {
 	COMMIT_PARTIAL,
 } commit_style;
 
-static char *logfile, *force_author, *template_file;
+static char *logfile, *force_author;
+static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
@@ -877,12 +878,8 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 int git_commit_config(const char *k, const char *v, void *cb)
 {
-	if (!strcmp(k, "commit.template")) {
-		if (!v)
-			return config_error_nonbool(v);
-		template_file = xstrdup(v);
-		return 0;
-	}
+	if (!strcmp(k, "commit.template"))
+		return git_config_string(&template_file, k, v);
 
 	return git_status_config(k, v, cb);
 }
-- 
1.5.6.1.204.g699135
