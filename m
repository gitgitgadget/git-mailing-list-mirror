From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] bisect--helper: remove "--next-vars" option as it is now
	useless
Date: Tue, 21 Apr 2009 07:54:09 +0200
Message-ID: <20090421055411.4006.85356.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 07:57:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw8yr-0003GN-8U
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 07:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbZDUFzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 01:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbZDUFzk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 01:55:40 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:43971 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbZDUFzj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 01:55:39 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 64FF6818100;
	Tue, 21 Apr 2009 07:55:31 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 63F1C8180FB;
	Tue, 21 Apr 2009 07:55:29 +0200 (CEST)
X-git-sha1: 27b3d042ff7fec5987f18288aa3e9f3408e38018 
X-Mailer: git-mail-commits v0.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117093>

Because it has been replaced by "--next-exit".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c                 |   15 ---------------
 bisect.h                 |    1 -
 builtin-bisect--helper.c |   12 +++---------
 3 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/bisect.c b/bisect.c
index f6e1378..47ad58b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -554,21 +554,6 @@ static void bisect_common(struct rev_info *revs, const char *prefix,
 				       !!skipped_sha1_nr);
 }
 
-int bisect_next_vars(const char *prefix)
-{
-	struct rev_info revs;
-	struct rev_list_info info;
-	int reaches = 0, all = 0;
-
-	memset(&info, 0, sizeof(info));
-	info.revs = &revs;
-	info.bisect_show_flags = BISECT_SHOW_TRIED | BISECT_SHOW_STRINGED;
-
-	bisect_common(&revs, prefix, &reaches, &all);
-
-	return show_bisect_vars(&info, reaches, all);
-}
-
 static void exit_if_skipped_commits(struct commit_list *tried,
 				    const unsigned char *bad)
 {
diff --git a/bisect.h b/bisect.h
index 028eb85..908e362 100644
--- a/bisect.h
+++ b/bisect.h
@@ -28,7 +28,6 @@ struct rev_list_info {
 
 extern int show_bisect_vars(struct rev_list_info *info, int reaches, int all);
 
-extern int bisect_next_vars(const char *prefix);
 extern int bisect_next_exit(const char *prefix);
 
 extern int estimate_bisect_steps(int all);
diff --git a/builtin-bisect--helper.c b/builtin-bisect--helper.c
index cb86a9a..aca7018 100644
--- a/builtin-bisect--helper.c
+++ b/builtin-bisect--helper.c
@@ -4,18 +4,14 @@
 #include "bisect.h"
 
 static const char * const git_bisect_helper_usage[] = {
-	"git bisect--helper --next-vars",
 	"git bisect--helper --next-exit",
 	NULL
 };
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	int next_vars = 0;
 	int next_exit = 0;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "next-vars", &next_vars,
-			    "output next bisect step variables"),
 		OPT_BOOLEAN(0, "next-exit", &next_exit,
 			    "output bisect result and exit instuctions"),
 		OPT_END()
@@ -23,11 +19,9 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, git_bisect_helper_usage, 0);
 
-	if ((next_vars && next_exit) || (!next_vars && !next_exit))
+	if (!next_exit)
 		usage_with_options(git_bisect_helper_usage, options);
 
-	if (next_vars)
-		return bisect_next_vars(prefix);
-	else /* next-exit */
-		return bisect_next_exit(prefix);
+	/* next-exit */
+	return bisect_next_exit(prefix);
 }
-- 
1.6.2.2.537.g3b83b
