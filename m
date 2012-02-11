From: mhagger@alum.mit.edu
Subject: [PATCH 4/7] fetch-pack.c: inline insert_alternate_refs()
Date: Sat, 11 Feb 2012 07:20:58 +0100
Message-ID: <1328941261-29746-5-git-send-email-mhagger@alum.mit.edu>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 07:21:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw6LI-0001zu-C1
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 07:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864Ab2BKGVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 01:21:41 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50478 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2BKGVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 01:21:24 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED675.dip.t-dialin.net [84.190.214.117])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B6L6CE019131;
	Sat, 11 Feb 2012 07:21:16 +0100
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190492>

From: Michael Haggerty <mhagger@alum.mit.edu>

The logic of the (single) caller is clearer without encapsulating this
one line in a function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9bd2096..dbe9acb 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -256,11 +256,6 @@ static void insert_one_alternate_ref(const struct ref *ref, void *unused)
 	rev_list_insert_ref(NULL, ref->old_sha1, 0, NULL);
 }
 
-static void insert_alternate_refs(void)
-{
-	for_each_alternate_ref(insert_one_alternate_ref, NULL);
-}
-
 #define INITIAL_FLUSH 16
 #define PIPESAFE_FLUSH 32
 #define LARGE_FLUSH 1024
@@ -295,7 +290,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 	marked = 1;
 
 	for_each_ref(rev_list_insert_ref, NULL);
-	insert_alternate_refs();
+	for_each_alternate_ref(insert_one_alternate_ref, NULL);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
-- 
1.7.9
