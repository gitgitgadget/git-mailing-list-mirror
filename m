From: =?utf-8?q?Peter=20Valdemar=20M=C3=B8rch?= 
	<4ux6as402@sneakemail.com>
Subject: [PATCH v2 1/2] Teach git log --check to return an appropriate exit code
Date: Mon, 11 Aug 2008 08:46:24 +0200
Message-ID: <1218437185-6178-2-git-send-email-4ux6as402@sneakemail.com>
References: <1218265054-19220-1-git-send-email-4ux6as402@sneakemail.com>
 <1218437185-6178-1-git-send-email-4ux6as402@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 08:47:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSRBy-0003bD-T4
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 08:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbYHKGqp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 02:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbYHKGqo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 02:46:44 -0400
Received: from morch.com ([193.58.255.207]:34050 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbYHKGql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 02:46:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by morch.com (Postfix) with ESMTP id 8D6D327F0
	for <git@vger.kernel.org>; Mon, 11 Aug 2008 08:49:19 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc2.5.g3452.dirty
In-Reply-To: <1218437185-6178-1-git-send-email-4ux6as402@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91919>

=46rom: Peter Valdemar M=C3=B8rch <peter@morch.com>


Signed-off-by: Peter Valdemar M=C3=B8rch <peter@morch.com>
---
 builtin-log.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index f4975cf..ae71540 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -217,6 +217,11 @@ static int cmd_log_walk(struct rev_info *rev)
 	if (rev->early_output)
 		finish_early_output(rev);
=20
+	/*
+	 * For --check, the exit code is based on CHECK_FAILED being
+	 * accumulated in rev->diffopt, so be careful to retain that state
+	 * information if replacing rev->diffopt in this loop
+	 */
 	while ((commit =3D get_revision(rev)) !=3D NULL) {
 		log_tree_commit(rev, commit);
 		if (!rev->reflog_info) {
@@ -227,6 +232,10 @@ static int cmd_log_walk(struct rev_info *rev)
 		free_commit_list(commit->parents);
 		commit->parents =3D NULL;
 	}
+	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
+	    DIFF_OPT_TST(&rev->diffopt, CHECK_FAILED)) {
+		return 02;
+	}
 	return 0;
 }
=20
--=20
1.6.0.rc2.5.g3452.dirty
