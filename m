From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/23] Extract a function collect_all_attrs()
Date: Thu,  4 Aug 2011 06:36:20 +0200
Message-ID: <1312432593-9841-11-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:38:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QophI-0005jp-3U
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab1HDEhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39653 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab1HDEhB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:01 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHo029203;
	Thu, 4 Aug 2011 06:36:58 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178692>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 7f0f390..bc589f0 100644
--- a/attr.c
+++ b/attr.c
@@ -713,20 +713,31 @@ static int macroexpand_one(int attr_nr, int rem)
 	return rem;
 }
 
-int git_checkattr(const char *path, int num, struct git_attr_check *check)
+/*
+ * Collect all attributes for path into the array pointed to by
+ * check_all_attr.
+ */
+static void collect_all_attrs(const char *path)
 {
 	struct attr_stack *stk;
-	int pathlen, i, rem;
+	int i, pathlen, rem;
 
 	bootstrap_attr_stack();
+	prepare_attr_stack(path);
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
 	pathlen = strlen(path);
-	prepare_attr_stack(path);
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
 		rem = fill(path, pathlen, stk, rem);
+}
+
+int git_checkattr(const char *path, int num, struct git_attr_check *check)
+{
+	int i;
+
+	collect_all_attrs(path);
 
 	for (i = 0; i < num; i++) {
 		const char *value = check_all_attr[check[i].attr->attr_nr].value;
-- 
1.7.6.8.gd2879
