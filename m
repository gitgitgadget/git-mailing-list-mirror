X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] merge-recursive: make empty tree a known object
Date: Sun, 10 Dec 2006 00:56:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612100055390.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 9 Dec 2006 23:56:15 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061207101707.GA19139@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33851>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtC3C-0001FA-46 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 00:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758154AbWLIX4J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 18:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759851AbWLIX4J
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 18:56:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:60344 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1758154AbWLIX4H
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 18:56:07 -0500
Received: (qmail invoked by alias); 09 Dec 2006 23:56:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp018) with SMTP; 10 Dec 2006 00:56:06 +0100
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org


To use it in diff_tree_sha1(), a tree has to be hashed in the
global object collection. This actually moves the empty tree (if
it is needed) into the global object hash.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 merge-recursive.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6e13b8e..280f23c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1220,9 +1220,10 @@ static int merge(struct commit *h1,
 		/* if there is no common ancestor, make an empty tree */
 		struct tree *tree = xcalloc(1, sizeof(struct tree));
 
+		hash_sha1_file(NULL, 0, tree_type, tree->object.sha1);
+		created_object(tree->object.sha1, &tree->object);
 		tree->object.parsed = 1;
 		tree->object.type = OBJ_TREE;
-		hash_sha1_file(NULL, 0, tree_type, tree->object.sha1);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
-- 
1.4.4.2.g0f32-dirty

