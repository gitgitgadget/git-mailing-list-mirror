From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH 3/6] Make get_git_dir take a flag that makes it re-read the env. variables
Date: Tue, 22 Nov 2005 03:28:12 +0300
Message-ID: <11326192923683-git-send-email-matlads@dsmagic.com>
References: <11326192921291-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 01:29:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeM1V-0006BT-RX
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 01:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVKVA2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVKVA2e
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 19:28:34 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:2308 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S964796AbVKVA2d
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 19:28:33 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 4DA355281; Tue, 22 Nov 2005 03:30:08 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.54)
	id 1EeM17-0006Fi-0T; Tue, 22 Nov 2005 03:28:13 +0300
In-Reply-To: <11326192921291-git-send-email-matlads@dsmagic.com>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12507>

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 cache.h       |    2 +-
 environment.c |    4 ++--
 path.c        |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

applies-to: 0748fd804fbe155503235e2c36d812fc3ef641a0
e3973791e841440ad92d91340fd954b5a58101c7
diff --git a/cache.h b/cache.h
index 54c283d..a455373 100644
--- a/cache.h
+++ b/cache.h
@@ -138,7 +138,7 @@ extern unsigned int active_nr, active_al
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 
-extern char *get_git_dir(void);
+extern char *get_git_dir(int recheck_env);
 extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
 extern char *get_index_file(void);
diff --git a/environment.c b/environment.c
index 3f19473..6a961ca 100644
--- a/environment.c
+++ b/environment.c
@@ -39,9 +39,9 @@ static void setup_git_env(void)
 		git_graft_file = strdup(git_path("info/grafts"));
 }
 
-char *get_git_dir(void)
+char *get_git_dir(int recheck_env)
 {
-	if (!git_dir)
+	if (!git_dir || recheck_env)
 		setup_git_env();
 	return git_dir;
 }
diff --git a/path.c b/path.c
index 4d88947..e322dc0 100644
--- a/path.c
+++ b/path.c
@@ -42,7 +42,7 @@ char *mkpath(const char *fmt, ...)
 
 char *git_path(const char *fmt, ...)
 {
-	const char *git_dir = get_git_dir();
+	const char *git_dir = get_git_dir(0);
 	va_list args;
 	unsigned len;
 
---
0.99.9.GIT
