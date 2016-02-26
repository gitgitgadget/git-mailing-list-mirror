From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 08/16] bisect: use commit instead of commit list as arguments when appropriate
Date: Fri, 26 Feb 2016 03:04:34 +0100
Message-ID: <1456452282-10325-9-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:05:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7n3-0007NX-GA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbcBZCFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:05:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:64397 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbcBZCFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:47 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0Lhwt0-1aCNsL3g4g-00n83K; Fri, 26 Feb 2016 03:05:44
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:ImE+6JEwN14gd1SxWBYBF4+y068CG8RQXKzGJBWvLfYjC2p3OMk
 /MlJb/ktR2ejypvMq8mz90XOWXSxmsftgCvbcjVDtisKXkQTvXJYYL0waZZ3WdHKHZwsomU
 UAryMxYIGaM6yi1mWc+Gc0D7h3HqVGp6sQWeIbT5jL6i7rWoYEaQVxvRInYAeBZk5aBGplj
 eYg71XNw+OTDyUBch7Ogw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UwGmwAmGf1g=:tULr6eZcvfxfYFsVbxDk/q
 qRjU4eGJiBX5J5FKbXuRobZ+VchrakNt7s4mT10P2IlcKf/dLFsmbPTu8mXtJMwMYvWEHw6zO
 2Vh4MKdKbDHCx92qygvV9e02c0RkRKuW6sE2RYKDDvKAtQ2lerlNtLDsDoJpXGDH5bPH0wVzY
 wo7pRb0IY0lfWOQk3d5zLacazmA9ie/tJNHh0s4K4d2H9HNsZn4H0R178RTL73j94fzwyubg/
 AgSwnf8SuyDL7zwnAJceO6V+ZUIaGsMLwOvKOnAfK4udkcCxZUUtzTX6AjhkEXluoY+11Swze
 lQPR594a/CAgFPzWGeptNmuiJ5X+Ozl6J71B4pNII7s41S+Np8zqrCWdmAcZs/SQjStzYRH9Z
 yj2jjpK06Uu/eKL8uw0xJWNU5Lw/5jy8w9wPEn0piLupPvEFCsWfKP1Xro6WqJHcebkyOT/X8
 NS7f4mHQYMRQrNylp0w9snGu+9ImdFtYhwpk7FlOTLFwo+cAavZNsqaW1ylJ6smv7eKSNlIHd
 seP83t0baPMHfCIc6a1gHakHqfhJdzP/FaYu2XuBf6R+R28bVTsI7rHfaOEgaXf/08aMpT5ZW
 ydY86VQiYg4IUtZiiqAmSMvWynjRBDsiCjD1hcbd6NtXvrjVkyfbvjoZsxY7BRs5gRsmnU81j
 L062sZVu9Fdr8r+kJPwqmpjKSjpgEvmvJ+DjIgeFTwl/4kO4WmfDGJiqxMsEy6eor8oi4QPzv
 MQJtG7/5r+WcFEAQC26siifbuevSVRJLDAn01UUaHB6xCyENQ+sdQYV1wKM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287517>

It makes no sense that the argument for count_distance() and
halfway() is a commit list when only its first commit is relevant.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

This is just some kind of minor code cleanup.
The typical "while at it", you know it, I guess.

 bisect.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6df13b0..76f2445 100644
--- a/bisect.c
+++ b/bisect.c
@@ -38,11 +38,11 @@ static inline struct node_data *node_data(struct commit *elem)
 	return (struct node_data *)elem->util;
 }
 
-static int count_distance(struct commit_list *entry)
+static int count_distance(struct commit *entry)
 {
 	int nr = 0;
 	struct commit_list *todo = NULL;
-	commit_list_append(entry->item, &todo);
+	commit_list_append(entry, &todo);
 	marker++;
 
 	while (todo) {
@@ -77,18 +77,18 @@ static int count_interesting_parents(struct commit *commit)
 	return count;
 }
 
-static inline int halfway(struct commit_list *p, int nr)
+static inline int halfway(struct commit *commit, int nr)
 {
 	/*
 	 * Don't short-cut something we are not going to return!
 	 */
-	if (p->item->object.flags & TREESAME)
+	if (commit->object.flags & TREESAME)
 		return 0;
 	/*
 	 * 2 and 3 are halfway of 5.
 	 * 3 is halfway of 6 but 2 and 4 are not.
 	 */
-	switch (2 * node_data(p->item)->weight - nr) {
+	switch (2 * node_data(commit)->weight - nr) {
 	case -1: case 0: case 1:
 		return 1;
 	default:
@@ -280,10 +280,10 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	for (p = list; p; p = p->next) {
 		if (!(p->item->object.flags & UNINTERESTING)
 		 && (node_data(p->item)->weight == -2)) {
-			node_data(p->item)->weight = count_distance(p);
+			node_data(p->item)->weight = count_distance(p->item);
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p, nr))
+			if (!find_all && halfway(p->item, nr))
 				return p;
 			counted++;
 		}
@@ -321,7 +321,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			}
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p, nr))
+			if (!find_all && halfway(p->item, nr))
 				return p;
 		}
 	}
-- 
2.7.1.354.gd492730.dirty
