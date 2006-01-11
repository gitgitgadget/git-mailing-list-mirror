From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 2/2] git-describe: Ignore argument ordering.
Date: Wed, 11 Jan 2006 21:42:36 +0100 (CET)
Message-ID: <20060111204236.247D45BEC1@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 11 21:42:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewmnq-0007qA-QV
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 21:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWAKUmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 15:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWAKUmi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 15:42:38 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:48800 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964842AbWAKUmh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 15:42:37 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 51FF36BD09
	for <git@vger.kernel.org>; Wed, 11 Jan 2006 21:42:36 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 247D45BEC1; Wed, 11 Jan 2006 21:42:36 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14514>

Use the simple stacking code to do so.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 describe.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

9d03987889b62405be7b3fe09fb5dfa81245af00
diff --git a/describe.c b/describe.c
index fda4102..bd4b591 100644
--- a/describe.c
+++ b/describe.c
@@ -141,10 +141,12 @@ static void describe(const char *ref)
 
 int main(int argc, char **argv)
 {
-	int i, desc = 0;
+	int i;
+	struct stack *st = NULL;
+	const char *arg;
 
 	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+		arg = argv[i];
 
 		if (!strcmp(arg, "--all")) {
 			all = 1;
@@ -160,12 +162,15 @@ int main(int argc, char **argv)
 				abbrev = DEFAULT_ABBREV;
 			continue;
 		}
-		describe(arg);
-		desc++;
+
+		st = stack_push(st, arg);
 	}
 
-	if (!desc)
+	if (!st)
 		describe("HEAD");
 
+	while ((arg = stack_pull(st)))
+		describe(arg);
+
 	return 0;
 }
-- 
1.1.0
