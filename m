From: Matthew Daley <mattjd@gmail.com>
Subject: [PATCH] Fix sizeof usage in get_permutations
Date: Fri, 14 Dec 2012 02:36:30 +1300
Message-ID: <1355405790-20302-1-git-send-email-mattjd@gmail.com>
Cc: Matthew Daley <mattjd@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 14:35:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj8x8-0004j2-5Z
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 14:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab2LMNfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 08:35:37 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52851 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489Ab2LMNfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 08:35:36 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1576401pad.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 05:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=bb6DssxUCnnqnmvE2jf41MycG4VUPI5tkKh7e8DBuqU=;
        b=W1gyRXPwPOn618Cu2z4+ut7bx8nuKLIiAo3HIe2IdQ8WCbrQ9Msb7sry5dwFtlxK5T
         XXELiG2R5oh/9drSQtkQ+O+3b5Lbg0g0gOMJvrfWvO5s93dgAF/aZbxf44/hcs9l6RNB
         IUaBI3gWC+Wvo2D7X+VKy22fTqUjUutIk454WtG6/RbF1Vf4FTCqGQznm9LBiZv0bOke
         ltGv6fuMSv4GrkSEF27TaKCAtubOqYQY5G+VBR/OnNKJlQOgPivPj1n+M1l8uYgMMiSN
         T1lzd3LKuVtVw860YLW5PXt5EZyVe8sTT8Kxcf9RLQqMtYBMGCLt8ZwKQxgpfeihF0oy
         60JQ==
Received: by 10.66.77.38 with SMTP id p6mr6342463paw.47.1355405735977;
        Thu, 13 Dec 2012 05:35:35 -0800 (PST)
Received: from morphism.xen.prgmr.com (morphism.xen.prgmr.com. [71.19.145.114])
        by mx.google.com with ESMTPS id o11sm1054113pby.8.2012.12.13.05.35.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Dec 2012 05:35:34 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211453>

Currently it gets the size of an otherwise unrelated, unused variable
instead of the expected struct size.

Signed-off-by: Matthew Daley <mattjd@gmail.com>
---
 builtin/pack-redundant.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index f5c6afc..7544687 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -301,14 +301,14 @@ static void pll_free(struct pll *l)
  */
 static struct pll * get_permutations(struct pack_list *list, int n)
 {
-	struct pll *subset, *ret = NULL, *new_pll = NULL, *pll;
+	struct pll *subset, *ret = NULL, *new_pll = NULL;
 
 	if (list == NULL || pack_list_size(list) < n || n == 0)
 		return NULL;
 
 	if (n == 1) {
 		while (list) {
-			new_pll = xmalloc(sizeof(pll));
+			new_pll = xmalloc(sizeof(struct pll));
 			new_pll->pl = NULL;
 			pack_list_insert(&new_pll->pl, list);
 			new_pll->next = ret;
@@ -321,7 +321,7 @@ static struct pll * get_permutations(struct pack_list *list, int n)
 	while (list->next) {
 		subset = get_permutations(list->next, n - 1);
 		while (subset) {
-			new_pll = xmalloc(sizeof(pll));
+			new_pll = xmalloc(sizeof(struct pll));
 			new_pll->pl = subset->pl;
 			pack_list_insert(&new_pll->pl, list);
 			new_pll->next = ret;
-- 
1.7.10.4
