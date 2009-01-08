From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH 2/2] Use is_pseudo_dir_name everywhere
Date: Fri,  9 Jan 2009 02:24:23 +0300
Message-ID: <1231457063-29186-3-git-send-email-aspotashev@gmail.com>
References: <1231457063-29186-1-git-send-email-aspotashev@gmail.com>
 <1231457063-29186-2-git-send-email-aspotashev@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 00:33:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL4My-0008Mn-N1
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 00:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbZAHXb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 18:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbZAHXbZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 18:31:25 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:61962 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbZAHXbX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 18:31:23 -0500
Received: by bwz14 with SMTP id 14so28198525bwz.13
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 15:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cw4QjfpiLtFwXkHBboQu4twrq0tV4nnbmx3UcG8yFPw=;
        b=jx+4t+o6a9O+oY3QRc/HBtAh7hkA8HEQcULEgFI5lpvAZShfyX1Ijt44BcUf/la+hS
         K5ciuWTVFHzQlBlcIXY7JCG4KXE1ixJm7mGbkuu8O3r0ZjRRo+2YXwBmip5uJ9c4jLwX
         omdhCkafh61pl44AJrWnMIxrEum/y1c5vDUOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K4fIM9n0d/gdspQx4K19R8q20zLxgVLF2PT60bB4p6p/fahB3pH52Cazm1RDP6D0o6
         1421shGs8VpTKev6DR3VJM7XzunjPqq9n6UDpQ1lz4FEnmu9yFJLS/xXmOPzC+IYbNEC
         fI7T6Qt1hdsvEu8kWu5BEjP77pqat2JG1Ag/g=
Received: by 10.223.126.203 with SMTP id d11mr18079675fas.8.1231457051812;
        Thu, 08 Jan 2009 15:24:11 -0800 (PST)
Received: from localhost.localdomain (ppp91-77-14-152.pppoe.mtu-net.ru [91.77.14.152])
        by mx.google.com with ESMTPS id p17sm45302243fka.30.2009.01.08.15.24.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jan 2009 15:24:11 -0800 (PST)
X-Mailer: git-send-email 1.6.1.77.g84c9
In-Reply-To: <1231457063-29186-2-git-send-email-aspotashev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104967>

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 builtin-count-objects.c |    5 ++---
 builtin-fsck.c          |   14 ++++----------
 builtin-prune.c         |   14 ++++----------
 builtin-rerere.c        |   11 +++++------
 dir.c                   |   12 ++++--------
 entry.c                 |    5 ++---
 remote.c                |    6 ++----
 transport.c             |    4 +---
 8 files changed, 24 insertions(+), 47 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index ab35b65..492a173 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -5,6 +5,7 @@
  */
 
 #include "cache.h"
+#include "dir.h"
 #include "builtin.h"
 #include "parse-options.h"
 
@@ -21,9 +22,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 		const char *cp;
 		int bad = 0;
 
-		if ((ent->d_name[0] == '.') &&
-		    (ent->d_name[1] == 0 ||
-		     ((ent->d_name[1] == '.') && (ent->d_name[2] == 0))))
+		if (is_pseudo_dir_name(ent->d_name))
 			continue;
 		for (cp = ent->d_name; *cp; cp++) {
 			int ch = *cp;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 297b2c4..291ca8e 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -10,6 +10,7 @@
 #include "tree-walk.h"
 #include "fsck.h"
 #include "parse-options.h"
+#include "dir.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -395,19 +396,12 @@ static void fsck_dir(int i, char *path)
 	while ((de = readdir(dir)) != NULL) {
 		char name[100];
 		unsigned char sha1[20];
-		int len = strlen(de->d_name);
 
-		switch (len) {
-		case 2:
-			if (de->d_name[1] != '.')
-				break;
-		case 1:
-			if (de->d_name[0] != '.')
-				break;
+		if (is_pseudo_dir_name(de->d_name))
 			continue;
-		case 38:
+		if (strlen(de->d_name) == 38) {
 			sprintf(name, "%02x", i);
-			memcpy(name+2, de->d_name, len+1);
+			memcpy(name+2, de->d_name, 39);
 			if (get_sha1_hex(name, sha1) < 0)
 				break;
 			add_sha1_list(sha1, DIRENT_SORT_HINT(de));
diff --git a/builtin-prune.c b/builtin-prune.c
index 7b4ec80..06b61ea 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -5,6 +5,7 @@
 #include "builtin.h"
 #include "reachable.h"
 #include "parse-options.h"
+#include "dir.h"
 
 static const char * const prune_usage[] = {
 	"git prune [-n] [-v] [--expire <time>] [--] [<head>...]",
@@ -61,19 +62,12 @@ static int prune_dir(int i, char *path)
 	while ((de = readdir(dir)) != NULL) {
 		char name[100];
 		unsigned char sha1[20];
-		int len = strlen(de->d_name);
 
-		switch (len) {
-		case 2:
-			if (de->d_name[1] != '.')
-				break;
-		case 1:
-			if (de->d_name[0] != '.')
-				break;
+		if (is_pseudo_dir_name(de->d_name))
 			continue;
-		case 38:
+		if (strlen(de->d_name) == 38) {
 			sprintf(name, "%02x", i);
-			memcpy(name+2, de->d_name, len+1);
+			memcpy(name+2, de->d_name, 39);
 			if (get_sha1_hex(name, sha1) < 0)
 				break;
 
diff --git a/builtin-rerere.c b/builtin-rerere.c
index d4dec6b..1ac5225 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "dir.h"
 #include "string-list.h"
 #include "rerere.h"
 #include "xdiff/xdiff.h"
@@ -59,17 +60,15 @@ static void garbage_collect(struct string_list *rr)
 	git_config(git_rerere_gc_config, NULL);
 	dir = opendir(git_path("rr-cache"));
 	while ((e = readdir(dir))) {
-		const char *name = e->d_name;
-		if (name[0] == '.' &&
-		    (name[1] == '\0' || (name[1] == '.' && name[2] == '\0')))
+		if (is_pseudo_dir_name (e->d_name))
 			continue;
-		then = rerere_created_at(name);
+		then = rerere_created_at(e->d_name);
 		if (!then)
 			continue;
-		cutoff = (has_resolution(name)
+		cutoff = (has_resolution(e->d_name)
 			  ? cutoff_resolve : cutoff_noresolve);
 		if (then < now - cutoff * 86400)
-			string_list_append(name, &to_remove);
+			string_list_append(e->d_name, &to_remove);
 	}
 	for (i = 0; i < to_remove.nr; i++)
 		unlink_rr_item(to_remove.items[i].string);
diff --git a/dir.c b/dir.c
index bd97e50..cdd3beb 100644
--- a/dir.c
+++ b/dir.c
@@ -585,10 +585,8 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			int len, dtype;
 			int exclude;
 
-			if ((de->d_name[0] == '.') &&
-			    (de->d_name[1] == 0 ||
-			     !strcmp(de->d_name + 1, ".") ||
-			     !strcmp(de->d_name + 1, "git")))
+			if (is_pseudo_dir_name(de->d_name) ||
+			     !strcmp(de->d_name, ".git"))
 				continue;
 			len = strlen(de->d_name);
 			/* Ignore overly long pathnames! */
@@ -812,10 +810,8 @@ int remove_dir_recursively(struct strbuf *path, int only_empty)
 	len = path->len;
 	while ((e = readdir(dir)) != NULL) {
 		struct stat st;
-		if ((e->d_name[0] == '.') &&
-		    ((e->d_name[1] == 0) ||
-		     ((e->d_name[1] == '.') && e->d_name[2] == 0)))
-			continue; /* "." and ".." */
+		if (is_pseudo_dir_name(e->d_name))
+			continue;
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
diff --git a/entry.c b/entry.c
index aa2ee46..9c6a9cf 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "dir.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -62,9 +63,7 @@ static void remove_subtree(const char *path)
 	*name++ = '/';
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st;
-		if ((de->d_name[0] == '.') &&
-		    ((de->d_name[1] == 0) ||
-		     ((de->d_name[1] == '.') && de->d_name[2] == 0)))
+		if (is_pseudo_dir_name(de->d_name))
 			continue;
 		strcpy(name, de->d_name);
 		if (lstat(pathbuf, &st))
diff --git a/remote.c b/remote.c
index 570e112..2fb5143 100644
--- a/remote.c
+++ b/remote.c
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
+#include "dir.h"
 
 static struct refspec s_tag_refspec = {
 	0,
@@ -634,10 +635,7 @@ static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 
 static int valid_remote_nick(const char *name)
 {
-	if (!name[0] || /* not empty */
-	    (name[0] == '.' && /* not "." */
-	     (!name[1] || /* not ".." */
-	      (name[1] == '.' && !name[2]))))
+	if (!name[0] || is_pseudo_dir_name(name))
 		return 0;
 	return !strchr(name, '/'); /* no slash */
 }
diff --git a/transport.c b/transport.c
index 56831c5..d4e3c25 100644
--- a/transport.c
+++ b/transport.c
@@ -50,9 +50,7 @@ static int read_loose_refs(struct strbuf *path, int name_offset,
 	memset (&list, 0, sizeof(list));
 
 	while ((de = readdir(dir))) {
-		if (de->d_name[0] == '.' && (de->d_name[1] == '\0' ||
-				(de->d_name[1] == '.' &&
-				 de->d_name[2] == '\0')))
+		if (is_pseudo_dir_name(de->d_name))
 			continue;
 		ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
 		list.entries[list.nr++] = xstrdup(de->d_name);
-- 
1.6.1.77.g84c9
