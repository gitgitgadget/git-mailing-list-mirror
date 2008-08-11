From: =?utf-8?q?Peter=20Valdemar=20M=C3=B8rch?= 
	<4ux6as402@sneakemail.com>
Subject: [PATCH v2 2/2] Teach git log --exit-code to return an appropriate exit code
Date: Mon, 11 Aug 2008 08:46:25 +0200
Message-ID: <1218437185-6178-3-git-send-email-4ux6as402@sneakemail.com>
References: <1218265054-19220-1-git-send-email-4ux6as402@sneakemail.com>
 <1218437185-6178-1-git-send-email-4ux6as402@sneakemail.com>
 <1218437185-6178-2-git-send-email-4ux6as402@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 08:47:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSRBx-0003bD-In
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 08:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbYHKGql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 02:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbYHKGql
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 02:46:41 -0400
Received: from morch.com ([193.58.255.207]:34051 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbYHKGql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 02:46:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by morch.com (Postfix) with ESMTP id EB50A2858
	for <git@vger.kernel.org>; Mon, 11 Aug 2008 08:49:19 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc2.5.g3452.dirty
In-Reply-To: <1218437185-6178-2-git-send-email-4ux6as402@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91920>

=46rom: Peter Valdemar M=C3=B8rch <peter@morch.com>


Signed-off-by: Peter Valdemar M=C3=B8rch <peter@morch.com>
---
 builtin-log.c |    8 ++++----
 log-tree.c    |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index ae71540..3a79574 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -218,9 +218,9 @@ static int cmd_log_walk(struct rev_info *rev)
 		finish_early_output(rev);
=20
 	/*
-	 * For --check, the exit code is based on CHECK_FAILED being
-	 * accumulated in rev->diffopt, so be careful to retain that state
-	 * information if replacing rev->diffopt in this loop
+	 * For --check and --exit-code, the exit code is based on CHECK_FAILE=
D
+	 * and HAS_CHANGES being accumulated in rev->diffopt, so be careful t=
o
+	 * retain that state information if replacing rev->diffopt in this lo=
op
 	 */
 	while ((commit =3D get_revision(rev)) !=3D NULL) {
 		log_tree_commit(rev, commit);
@@ -236,7 +236,7 @@ static int cmd_log_walk(struct rev_info *rev)
 	    DIFF_OPT_TST(&rev->diffopt, CHECK_FAILED)) {
 		return 02;
 	}
-	return 0;
+	return diff_result_code(&rev->diffopt, 0);
 }
=20
 static int git_log_config(const char *var, const char *value, void *cb=
)
diff --git a/log-tree.c b/log-tree.c
index bd8b9e4..30cd5bb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -432,7 +432,7 @@ static int log_tree_diff(struct rev_info *opt, stru=
ct commit *commit, struct log
 	struct commit_list *parents;
 	unsigned const char *sha1 =3D commit->object.sha1;
=20
-	if (!opt->diff)
+	if (!opt->diff && !DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS))
 		return 0;
=20
 	/* Root commit? */
--=20
1.6.0.rc2.5.g3452.dirty
