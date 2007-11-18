From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin-commit: run commit-msg hook with correct message file
Date: Sun, 18 Nov 2007 12:30:13 -0800
Message-ID: <7v1wanuwiy.fsf_-_@gitster.siamese.dyndns.org>
References: <1195405834-1469-1-git-send-email-pkufranky@gmail.com>
	<7vejenuy4i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: krh@redhat.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 21:30:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itqn1-0004ST-Uo
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 21:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbXKRUaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 15:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbXKRUaW
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 15:30:22 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39611 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbXKRUaV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 15:30:21 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 578722F0;
	Sun, 18 Nov 2007 15:30:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DB403972BE;
	Sun, 18 Nov 2007 15:30:37 -0500 (EST)
In-Reply-To: <7vejenuy4i.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 18 Nov 2007 11:55:41 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65389>

It should run with $GIT_DIR/COMMIT_EDITMSG, not just COMMIT_EDITMSG.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Other things I noticed that are still broken:

   - "git commit -v" does not give you the diff in the message
     template for your final review;

   - message_is_empty() is bogus.  It does run stripspace() but
     does not strip out the diff "git commit -v" would produce
     before doing its comparison;

 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 058cd32..439fcc2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -753,7 +753,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		rollback_index_files();
 		die("could not read commit message\n");
 	}
-	if (run_hook(index_file, "commit-msg", commit_editmsg)) {
+	if (run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
 		rollback_index_files();
 		exit(1);
 	}
-- 
1.5.3.5.1815.g9445b
