From: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
Subject: [PATCH 5/5] builtin-log.c: Use for_each_revision() helper
Date: Thu, 26 Apr 2007 16:46:40 -0300
Message-ID: <11776168013249-git-send-email-lcapitulino@mandriva.com.br>
References: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org,
	Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 26 21:47:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh9w9-0000ZF-Ur
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973AbXDZTq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754971AbXDZTq6
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:46:58 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:45848 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970AbXDZTq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 15:46:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 0591017D44;
	Thu, 26 Apr 2007 16:46:54 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id TC6AWLA5vpHf; Thu, 26 Apr 2007 16:46:49 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 3D4D017D55;
	Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id 2440568B58B; Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.320.g1cf2
In-Reply-To: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45646>

Signed-off-by: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
---
 builtin-log.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 38bf52f..705050a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -79,8 +79,7 @@ static int cmd_log_walk(struct rev_info *rev)
 {
 	struct commit *commit;
 
-	prepare_revision_walk(rev);
-	while ((commit = get_revision(rev)) != NULL) {
+	for_each_revision(commit, rev) {
 		log_tree_commit(rev, commit);
 		if (!rev->reflog_info) {
 			/* we allow cycles in reflog ancestry */
@@ -390,9 +389,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
 	o2->flags ^= UNINTERESTING;
 	add_pending_object(&check_rev, o1, "o1");
 	add_pending_object(&check_rev, o2, "o2");
-	prepare_revision_walk(&check_rev);
 
-	while ((commit = get_revision(&check_rev)) != NULL) {
+	for_each_revision(commit, &check_rev) {
 		/* ignore merges */
 		if (commit->parents && commit->parents->next)
 			continue;
@@ -578,8 +576,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!use_stdout)
 		realstdout = fdopen(dup(1), "w");
 
-	prepare_revision_walk(&rev);
-	while ((commit = get_revision(&rev)) != NULL) {
+	for_each_revision(commit, &rev) {
 		/* ignore merges */
 		if (commit->parents && commit->parents->next)
 			continue;
@@ -716,8 +713,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		die("Unknown commit %s", limit);
 
 	/* reverse the list of commits */
-	prepare_revision_walk(&revs);
-	while ((commit = get_revision(&revs)) != NULL) {
+	for_each_revision(commit, &revs) {
 		/* ignore merges */
 		if (commit->parents && commit->parents->next)
 			continue;
-- 
1.5.1.1.320.g1cf2
