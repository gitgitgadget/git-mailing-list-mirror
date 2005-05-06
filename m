From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not initialize sha1_file_directory by hand.
Date: Fri, 06 May 2005 16:32:28 -0700
Message-ID: <7vsm10aq2b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 01:30:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUCGz-0004Py-Jl
	for gcvg-git@gmane.org; Sat, 07 May 2005 01:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVEFXgR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 19:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVEFXgA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 19:36:00 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60856 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261318AbVEFXce (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 19:32:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050506233229.VDQM8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 May 2005 19:32:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Some commands initialize sha1_file_directory by hand.  There is no
need to do so; sha1_file.c knows how to handle it.

The next patch will remove the variable altogether.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 ls-tree.c    |    3 ---
 read-cache.c |    5 -----
 tar-tree.c   |    5 -----
 3 files changed, 13 deletions(-)

--- a/ls-tree.c
+++ b/ls-tree.c
@@ -104,9 +104,6 @@ int main(int argc, char **argv)
 		usage(ls_tree_usage);
 	if (get_sha1(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
-	sha1_file_directory = getenv(DB_ENVIRONMENT);
-	if (!sha1_file_directory)
-		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
 	if (list(sha1) < 0)
 		die("list failed");
 	return 0;
--- a/read-cache.c
+++ b/read-cache.c
@@ -193,11 +193,6 @@ int read_cache(void)
 	if (active_cache)
 		return error("more than one cachefile");
 	errno = ENOENT;
-	sha1_file_directory = getenv(DB_ENVIRONMENT);
-	if (!sha1_file_directory)
-		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
-	if (access(sha1_file_directory, X_OK) < 0)
-		return error("no access to SHA1 file directory");
 	fd = open(get_index_file(), O_RDONLY);
 	if (fd < 0)
 		return (errno == ENOENT) ? 0 : error("open failed");
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -418,10 +418,6 @@ int main(int argc, char **argv)
 		usage(tar_tree_usage);
 	}
 
-	sha1_file_directory = getenv(DB_ENVIRONMENT);
-	if (!sha1_file_directory)
-		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
-
 	buffer = read_object_with_reference(sha1, "commit", &size, commit_sha1);
 	if (buffer) {
 		write_global_extended_header(commit_sha1);
----------------------------------------------------------------

