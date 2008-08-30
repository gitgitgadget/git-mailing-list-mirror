From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] merge-recursive: fix subtree merge
Date: Sat, 30 Aug 2008 17:42:09 +0200
Message-ID: <1220110929-6803-1-git-send-email-vmiklos@frugalware.org>
References: <1219674357-31000-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 17:42:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZSb7-0000xR-Qg
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 17:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbYH3Pli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 11:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbYH3Pli
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 11:41:38 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:39313 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbYH3Plh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 11:41:37 -0400
Received: from vmobile.example.net (dsl5401C962.pool.t-online.hu [84.1.201.98])
	by yugo.frugalware.org (Postfix) with ESMTP id CA8A11DDC5B;
	Sat, 30 Aug 2008 17:41:35 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 2858284CA; Sat, 30 Aug 2008 17:42:10 +0200 (CEST)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <1219674357-31000-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94381>

We should decide if we do a subtree merge based on the merge_options
struct, not based on the global variable, which should not even exist
at all.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Mon, Aug 25, 2008 at 04:25:57PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> It also takes care of subtree merge, output buffering, verbosity, and
> rename limits - these were global variables till now in
> merge-recursive.c.

Actually subtree_merge was not used from the struct merge_options, here
is the fix.

 merge-recursive.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3a38cc6..457ad84 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -20,8 +20,6 @@
 #include "attr.h"
 #include "merge-recursive.h"
 
-static int subtree_merge;
-
 static struct tree *shift_tree_object(struct tree *one, struct tree *two)
 {
 	unsigned char shifted[20];
@@ -1152,7 +1150,7 @@ int merge_trees(struct merge_options *o,
 {
 	int code, clean;
 
-	if (subtree_merge) {
+	if (o->subtree_merge) {
 		merge = shift_tree_object(head, merge);
 		common = shift_tree_object(head, common);
 	}
-- 
1.6.0
