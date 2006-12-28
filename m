From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 8/11] Move better_branch_name above get_ref in merge-recursive.
Date: Thu, 28 Dec 2006 02:35:20 -0500
Message-ID: <20061228073520.GH17867@spearce.org>
References: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 08:35:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzpnW-0000xI-FJ
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 08:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWL1Hf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 02:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWL1Hf2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 02:35:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45838 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964993AbWL1HfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 02:35:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzpmx-0007yL-OV; Thu, 28 Dec 2006 02:34:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0531520FB65; Thu, 28 Dec 2006 02:35:21 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <9847899e4ba836980dbfed6d0ea1c82f31f21456.1167290864.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35530>

To permit the get_ref function to use the static better_branch_name
function to generate a string on demand I'm moving it up earlier.
The actual logic was not affected in this change.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 merge-recursive.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ca4f19e..1c84ed7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1248,6 +1248,18 @@ static int merge(struct commit *h1,
 	return clean;
 }
 
+static const char *better_branch_name(const char *branch)
+{
+	static char githead_env[8 + 40 + 1];
+	char *name;
+
+	if (strlen(branch) != 40)
+		return branch;
+	sprintf(githead_env, "GITHEAD_%s", branch);
+	name = getenv(githead_env);
+	return name ? name : branch;
+}
+
 static struct commit *get_ref(const char *ref)
 {
 	unsigned char sha1[20];
@@ -1263,18 +1275,6 @@ static struct commit *get_ref(const char *ref)
 	return (struct commit *)object;
 }
 
-static const char *better_branch_name(const char *branch)
-{
-	static char githead_env[8 + 40 + 1];
-	char *name;
-
-	if (strlen(branch) != 40)
-		return branch;
-	sprintf(githead_env, "GITHEAD_%s", branch);
-	name = getenv(githead_env);
-	return name ? name : branch;
-}
-
 int main(int argc, char *argv[])
 {
 	static const char *bases[2];
-- 
1.4.4.3.gd2e4
