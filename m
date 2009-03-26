From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/10] rev-list: make "show_bisect_vars" non static
Date: Thu, 26 Mar 2009 05:55:35 +0100
Message-ID: <20090326055535.9b970cff.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:58:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmhfL-0003jA-Sb
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbZCZE4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbZCZE4h
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:56:37 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:46637 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbZCZE4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:56:36 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 1C3ECD48037;
	Thu, 26 Mar 2009 05:56:26 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with SMTP id 07E44D48065;
	Thu, 26 Mar 2009 05:56:23 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114729>

and declare it in "bisect.h" as we will use this function later.

While at it, rename its last argument "show_all" instead of
"bisect_find_all".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.h           |    2 ++
 builtin-rev-list.c |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/bisect.h b/bisect.h
index 60b2fe1..860a15c 100644
--- a/bisect.h
+++ b/bisect.h
@@ -5,4 +5,6 @@ extern struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all,
 					  int find_all);
 
+extern int show_bisect_vars(int reaches, int all, int show_all);
+
 #endif
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 74d22b4..c700c34 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -226,7 +226,7 @@ static int estimate_bisect_steps(int all)
 	return (e < 3 * x) ? n : n - 1;
 }
 
-static int show_bisect_vars(int reaches, int all, int bisect_find_all)
+int show_bisect_vars(int reaches, int all, int show_all)
 {
 	int cnt;
 	char hex[41];
@@ -246,9 +246,10 @@ static int show_bisect_vars(int reaches, int all, int bisect_find_all)
 	cnt = all - reaches;
 	if (cnt < reaches)
 		cnt = reaches;
+
 	strcpy(hex, sha1_to_hex(revs.commits->item->object.sha1));
 
-	if (bisect_find_all) {
+	if (show_all) {
 		traverse_commit_list(&revs, show_commit, show_object);
 		printf("------\n");
 	}
-- 
1.6.2.1.317.g3d804
