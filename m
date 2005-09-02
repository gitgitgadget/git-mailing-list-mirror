From: Peter Hagervall <hager@cs.umu.se>
Subject: [PATCH] Possible cleanups for local-pull.c
Date: Fri, 2 Sep 2005 14:17:10 +0200
Message-ID: <20050902121710.GA671@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 14:19:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBAUF-0005DK-HS
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 14:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVIBMRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 08:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVIBMRg
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 08:17:36 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:65438 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1751195AbVIBMRf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 08:17:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 3B2B42DDA;
	Fri,  2 Sep 2005 14:17:29 +0200 (MEST)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 25005-01-2; Fri,  2 Sep 2005 14:17:10 +0200 (MEST)
Received: from peppar.cs.umu.se (peppar.cs.umu.se [130.239.40.13])
	by mail.cs.umu.se (Postfix) with ESMTP id D81A12DC8;
	Fri,  2 Sep 2005 14:17:10 +0200 (MEST)
Received: by peppar.cs.umu.se (Postfix, from userid 12006)
	id D300C2742; Fri,  2 Sep 2005 14:17:10 +0200 (MEST)
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8022>

Hi. This patch contains the following possible cleanups:

 * Make some needlessly global functions in local-pull.c static
 * Change 'char *' to 'const char *' where appropriate

Signed-off-by: Peter Hagervall <hager@cs.umu.se>

---

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -327,7 +327,7 @@ extern int get_ack(int fd, unsigned char
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
-extern struct packed_git *parse_pack_index_file(unsigned char *sha1, 
+extern struct packed_git *parse_pack_index_file(const unsigned char *sha1,
 						char *idx_path);
 
 extern void prepare_packed_git(void);
diff --git a/local-pull.c b/local-pull.c
--- a/local-pull.c
+++ b/local-pull.c
@@ -17,7 +17,7 @@ void prefetch(unsigned char *sha1)
 
 static struct packed_git *packs = NULL;
 
-void setup_index(unsigned char *sha1)
+static void setup_index(unsigned char *sha1)
 {
 	struct packed_git *new_pack;
 	char filename[PATH_MAX];
@@ -30,7 +30,7 @@ void setup_index(unsigned char *sha1)
 	packs = new_pack;
 }
 
-int setup_indices()
+static int setup_indices(void)
 {
 	DIR *dir;
 	struct dirent *de;
@@ -49,7 +49,7 @@ int setup_indices()
 	return 0;
 }
 
-int copy_file(const char *source, const char *dest, const char *hex)
+static int copy_file(const char *source, const char *dest, const char *hex)
 {
 	if (use_link) {
 		if (!link(source, dest)) {
@@ -97,7 +97,7 @@ int copy_file(const char *source, const 
 	return -1;
 }
 
-int fetch_pack(unsigned char *sha1)
+static int fetch_pack(const unsigned char *sha1)
 {
 	struct packed_git *target;
 	char filename[PATH_MAX];
@@ -125,7 +125,7 @@ int fetch_pack(unsigned char *sha1)
 	return 0;
 }
 
-int fetch_file(unsigned char *sha1)
+static int fetch_file(const unsigned char *sha1)
 {
 	static int object_name_start = -1;
 	static char filename[PATH_MAX];
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -487,7 +487,7 @@ struct packed_git *parse_pack_index(unsi
 	return parse_pack_index_file(sha1, path);
 }
 
-struct packed_git *parse_pack_index_file(unsigned char *sha1, char *idx_path)
+struct packed_git *parse_pack_index_file(const unsigned char *sha1, char *idx_path)
 {
 	struct packed_git *p;
 	nsigned long idx_size;
