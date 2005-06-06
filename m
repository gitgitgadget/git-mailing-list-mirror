From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-diff-cache: handle pathspec beginning with a dash
Date: Mon, 6 Jun 2005 23:27:00 +0200
Message-ID: <20050606212700.GA3498@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 06 23:24:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfP4K-0001Zm-7c
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 23:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVFFV1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 17:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVFFV1L
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 17:27:11 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:47041 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261639AbVFFV1B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 17:27:01 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 5D1A06E1750; Mon,  6 Jun 2005 23:26:17 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 274CF6E16F5
	for <git@vger.kernel.org>; Mon,  6 Jun 2005 23:26:17 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A271E61FE0; Mon,  6 Jun 2005 23:27:00 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Parse everything after '--' as tree name or pathspec.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 diff-cache.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -167,13 +167,14 @@ int main(int argc, const char **argv)
 	void *tree;
 	unsigned long size;
 	int ret;
+	int allow_options = 1;
 	int i;
 
 	read_cache();
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
-		if (*arg != '-') {
+		if (!allow_options || *arg != '-') {
 			if (tree_name) {
 				pathspec = argv + i;
 				break;
@@ -182,6 +183,10 @@ int main(int argc, const char **argv)
 			continue;
 		}
 			
+		if (!strcmp(arg, "--")) {
+			allow_options = 0;
+			continue;
+		}
 		if (!strcmp(arg, "-r")) {
 			/* We accept the -r flag just to look like git-diff-tree */
 			continue;
-- 
Jonas Fonseca
