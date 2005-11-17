From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] Add .git/version (Take 2)
Date: Thu, 17 Nov 2005 22:18:21 +0300
Message-ID: <20051117191821.GC5745@igloo.ds.co.ug>
References: <11322339372137-git-send-email-matlads@dsmagic.com> <200511171644.48438.Josef.Weidendorfer@gmx.de> <437CB0CA.6070306@op5.se> <200511171741.23147.Josef.Weidendorfer@gmx.de> <20051117190848.GA5745@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 17 20:24:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpHg-0001ey-Lc
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVKQTSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVKQTSx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:18:53 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:63237 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S964815AbVKQTSw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:18:52 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 01FE05160
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 22:20:30 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.54)
	id 1EcpH3-0001lQ-87
	for git@vger.kernel.org; Thu, 17 Nov 2005 22:18:21 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051117190848.GA5745@igloo.ds.co.ug>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12138>


Currently the version number can be considered version 1, so this patch
just sets it to that. This patch supercedes my earlier attempt that
erroneously used the git version number as the repo format version.

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 init-db.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

applies-to: d1bb16b919a119cca6ee001f755f83251a2c2964
31e78e387d708da5e09f40436d5fdc9e9ec5e16c
diff --git a/init-db.c b/init-db.c
index bd88291..e403dac 100644
--- a/init-db.c
+++ b/init-db.c
@@ -9,6 +9,8 @@
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates/"
 #endif
 
+#define REPO_VERSION 1
+
 static void safe_create_dir(const char *dir)
 {
 	if (mkdir(dir, 0777) < 0) {
@@ -19,6 +21,17 @@ static void safe_create_dir(const char *
 	}
 }
 
+static void record_repo_version(const char *path)
+{
+	FILE *verfile = fopen(path, "w");
+	if (!verfile)
+		die ("Can not write to %s?", path);
+	
+	fprintf(verfile, "%d\n", REPO_VERSION);
+	
+	fclose(verfile);
+}
+
 static int copy_file(const char *dst, const char *src, int mode)
 {
 	int fdi, fdo, status;
@@ -212,6 +225,10 @@ static void create_default_files(const c
 				fprintf(stderr, "Ignoring file modes\n");
 		}
 	}
+
+	/* record the version of the git repo */
+	strcpy(path + len, "version");
+	record_repo_version(path);
 }
 
 static const char init_db_usage[] =
---
0.99.9.GIT

-- 
Due to a shortage of devoted followers, the production of great leaders has been discontinued.
