From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 04/40] Windows: Use the Windows style PATH separator ';'.
Date: Wed, 27 Feb 2008 19:54:27 +0100
Message-ID: <1204138503-6126-5-git-send-email-johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 19:56:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JURRV-0000Km-1W
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbYB0SzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbYB0SzJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:55:09 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:40419 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbYB0SzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:55:06 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id C1063974D9;
	Wed, 27 Feb 2008 19:55:04 +0100 (CET)
X-Mailer: git-send-email 1.5.4.1.126.ge5a7d
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75245>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Documentation/git.txt |    6 +++---
 exec_cmd.c            |    4 ++++
 sha1_file.c           |    4 ++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d57bed6..b2a5b60 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -382,9 +382,9 @@ git so take care if using Cogito etc.
 'GIT_ALTERNATE_OBJECT_DIRECTORIES'::
 	Due to the immutable nature of git objects, old objects can be
 	archived into shared, read-only directories. This variable
-	specifies a ":" separated list of git object directories which
-	can be used to search for git objects. New objects will not be
-	written to these directories.
+	specifies a ":" separated (on Windows ";" separated) list
+	of git object directories which can be used to search for git
+	objects. New objects will not be written to these directories.
 
 'GIT_DIR'::
 	If the 'GIT_DIR' environment variable is set then it
diff --git a/exec_cmd.c b/exec_cmd.c
index e189cac..343545d 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -37,7 +37,11 @@ static void add_path(struct strbuf *out, const char *path)
 		else
 			strbuf_addstr(out, make_absolute_path(path));
 
+#ifdef __MINGW32__
+		strbuf_addch(out, ';');
+#else
 		strbuf_addch(out, ':');
+#endif
 	}
 }
 
diff --git a/sha1_file.c b/sha1_file.c
index 1ddb96b..453bc43 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -389,7 +389,11 @@ void prepare_alt_odb(void)
 	if (!alt) alt = "";
 
 	alt_odb_tail = &alt_odb_list;
+#ifdef __MINGW32__
+	link_alt_odb_entries(alt, alt + strlen(alt), ';', NULL, 0);
+#else
 	link_alt_odb_entries(alt, alt + strlen(alt), ':', NULL, 0);
+#endif
 
 	read_info_alternates(get_object_directory(), 0);
 }
-- 
1.5.4.1.126.ge5a7d
