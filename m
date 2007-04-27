From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 5/5] builtin-log.c: Use for_each_revision() helper
Date: Fri, 27 Apr 2007 14:00:12 -0300
Message-ID: <11776932121665-git-send-email-lcapitulino@mandriva.com.br>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org,
	"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Apr 27 19:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhTp8-0001j2-Q2
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 19:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbXD0RBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 13:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756205AbXD0RBL
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 13:01:11 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:47044 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbXD0RAb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 13:00:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 9445A181B1;
	Fri, 27 Apr 2007 14:00:29 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id bS1zzjclFb3Z; Fri, 27 Apr 2007 14:00:22 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 5D8CA181BB;
	Fri, 27 Apr 2007 14:00:13 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id C0CFD68B58C; Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.372.g4342
In-Reply-To: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45730>

From: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
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
1.5.1.1.372.g4342
