From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] builtin-commit: fix summary output.
Date: Sun, 16 Dec 2007 15:11:59 -0800
Message-ID: <7vy7bugrpc.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712151507420.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 00:12:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J42f9-0006eB-Mp
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 00:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757695AbXLPXMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 18:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757604AbXLPXMZ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 18:12:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880AbXLPXMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 18:12:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CFDF43CD;
	Sun, 16 Dec 2007 18:12:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 302F543C7;
	Sun, 16 Dec 2007 18:12:17 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712151507420.5349@iabervon.org> (Daniel
	Barkalow's message of "Sat, 15 Dec 2007 15:29:18 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68501>

Because print_summary() forgot to call diff_setup_done() after futzing with
diff output options, it failed to activate recursive diff, which resulted in
an incorrect summary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This fixes the "5 files" problem you saw with your commit, which was
   totally bogus (it looked at "git diff-tree HEAD" output that was
   non-recursive, discarding the change of tree t/ itself).  Now it will
   show "7 files" in line with your "git show".

 builtin-commit.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 518ebe0..61770ef 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -662,6 +662,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.show_root_diff = 1;
 	rev.commit_format = get_commit_format("format:%h: %s");
 	rev.always_show_header = 0;
+	diff_setup_done(&rev.diffopt);
 
 	printf("Created %scommit ", initial_commit ? "initial " : "");
 
-- 
1.5.4.rc0.52.gb90ce
