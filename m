From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH 5/6] Allow Specification of the conf file to read for git_config operations
Date: Tue, 22 Nov 2005 03:28:13 +0300
Message-ID: <11326192933767-git-send-email-matlads@dsmagic.com>
References: <11326192921291-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 01:30:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeM1o-0006Fp-Sz
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 01:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVKVA2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 19:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVKVA2k
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 19:28:40 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:2820 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S964795AbVKVA2j
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 19:28:39 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id E44255286; Tue, 22 Nov 2005 03:30:09 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.54)
	id 1EeM17-0006Fq-5X; Tue, 22 Nov 2005 03:28:13 +0300
In-Reply-To: <11326192921291-git-send-email-matlads@dsmagic.com>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12509>

This patch adds a git_config_from_file which allows us to specify the
config file to use for git_config operations.

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 cache.h  |    1 +
 config.c |   10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

applies-to: d6c3faa0566795b1c74e693ecc004439c116e6c6
39e4ab307abb445115f3c9ee0e09ed1812568247
diff --git a/cache.h b/cache.h
index a455373..48018ab 100644
--- a/cache.h
+++ b/cache.h
@@ -388,6 +388,7 @@ extern int gitfakemunmap(void *start, si
 
 typedef int (*config_fn_t)(const char *, const char *);
 extern int git_default_config(const char *, const char *);
+extern int git_config_from_file(const char *, config_fn_t fn);
 extern int git_config(config_fn_t fn);
 extern int git_config_int(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
diff --git a/config.c b/config.c
index 5d237c8..c5a5312 100644
--- a/config.c
+++ b/config.c
@@ -245,11 +245,10 @@ int git_default_config(const char *var, 
 	return 0;
 }
 
-int git_config(config_fn_t fn)
+int git_config_from_file(const char *confpath, config_fn_t fn)
 {
 	int ret;
-	FILE *f = fopen(git_path("config"), "r");
-
+	FILE *f = fopen(confpath, "r");
 	ret = -1;
 	if (f) {
 		config_file = f;
@@ -260,6 +259,11 @@ int git_config(config_fn_t fn)
 	return ret;
 }
 
+int git_config(config_fn_t fn)
+{
+	return git_config_from_file(git_path("config"), fn);
+}
+
 /*
  * Find all the stuff for git_config_set() below.
  */
---
0.99.9.GIT
