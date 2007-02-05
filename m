From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Rename get_ident() to fmt_ident() and make it available to outside
Date: Sun, 04 Feb 2007 19:00:40 -0800
Message-ID: <7vtzy1pauf.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net>
	<7vps8qtgbm.fsf@assigned-by-dhcp.cox.net>
	<20070204185144.GB24368@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702041111010.8424@woody.linux-foundation.org>
	<20070204205858.GE12943@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, Theodore Tso <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 04:00:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDu63-0001Jo-Vc
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 04:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbXBEDAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 22:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbXBEDAm
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 22:00:42 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:41051 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752664AbXBEDAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 22:00:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205030040.SJFZ1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 22:00:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Kf0g1W00D1kojtg0000000; Sun, 04 Feb 2007 22:00:40 -0500
In-Reply-To: <20070204205858.GE12943@thunk.org> (Theodore Tso's message of
	"Sun, 4 Feb 2007 15:58:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38721>

This makes the functionality of ident.c::get_ident() available to
other callers.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This by itself is totally uninteresting, but the second one
   depends on it.

 cache.h |    1 +
 ident.c |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 201704b..38a9bc0 100644
--- a/cache.h
+++ b/cache.h
@@ -321,6 +321,7 @@ unsigned long approxidate(const char *);
 
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
+extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
 
 struct checkout {
 	const char *base_dir;
diff --git a/ident.c b/ident.c
index a6fc7b5..bb03bdd 100644
--- a/ident.c
+++ b/ident.c
@@ -185,8 +185,8 @@ static const char *env_hint =
 "Add --global to set your account\'s default\n"
 "\n";
 
-static const char *get_ident(const char *name, const char *email,
-			     const char *date_str, int error_on_no_name)
+const char *fmt_ident(const char *name, const char *email,
+		      const char *date_str, int error_on_no_name)
 {
 	static char buffer[1000];
 	char date[50];
@@ -233,7 +233,7 @@ static const char *get_ident(const char *name, const char *email,
 
 const char *git_author_info(int error_on_no_name)
 {
-	return get_ident(getenv("GIT_AUTHOR_NAME"),
+	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
 			 getenv("GIT_AUTHOR_DATE"),
 			 error_on_no_name);
@@ -241,7 +241,7 @@ const char *git_author_info(int error_on_no_name)
 
 const char *git_committer_info(int error_on_no_name)
 {
-	return get_ident(getenv("GIT_COMMITTER_NAME"),
+	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
 			 error_on_no_name);
-- 
1.5.0.rc3.40.g1f7d
