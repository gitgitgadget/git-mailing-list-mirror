From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix linking for not-so-clever linkers.
Date: Mon, 10 Jul 2006 13:40:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607101340080.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jul 10 13:40:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzu8C-00021D-Kx
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 13:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWGJLkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 07:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWGJLkq
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 07:40:46 -0400
Received: from mail.gmx.de ([213.165.64.21]:44224 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964886AbWGJLkp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 07:40:45 -0400
Received: (qmail invoked by alias); 10 Jul 2006 11:40:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp022) with SMTP; 10 Jul 2006 13:40:44 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23609>


On one of my systems, the linker is not intelligent enough to link with
pager.o (in libgit.a) when only the variable pager_in_use is needed. The
consequence is that the linker complains about an undefined variable. So,
put the variable into environment.o, where it is linked always.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 environment.c |    1 +
 pager.c       |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index 43823ff..97d42b1 100644
--- a/environment.c
+++ b/environment.c
@@ -21,6 +21,7 @@ char git_commit_encoding[MAX_ENCODING_LE
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace = NULL;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
+int pager_in_use;
 
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
 	*git_graft_file;
diff --git a/pager.c b/pager.c
index bb14e99..280f57f 100644
--- a/pager.c
+++ b/pager.c
@@ -5,8 +5,6 @@ #include "cache.h"
  * something different on Windows, for example.
  */
 
-int pager_in_use;
-
 static void run_pager(const char *pager)
 {
 	execlp(pager, pager, NULL);
-- 
1.4.1.g6e33b-dirty
