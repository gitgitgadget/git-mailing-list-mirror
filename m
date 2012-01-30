From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] merge: add instructions to the commit message when editing
Date: Mon, 30 Jan 2012 21:25:30 +0100
Message-ID: <0c9a880c7dca27520f957446c6b0e72e93609b03.1327954927.git.trast@student.ethz.ch>
References: <7vd3a1caxb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:25:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrxnG-0003F6-IP
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab2A3UZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:25:34 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:52074 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307Ab2A3UZd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:25:33 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Jan
 2012 21:25:30 +0100
Received: from thomas.inf.ethz.ch (80.219.158.96) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Jan
 2012 21:25:31 +0100
X-Mailer: git-send-email 1.7.9.350.ga960f
In-Reply-To: <7vd3a1caxb.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [80.219.158.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189417>

Before f824628 (merge: use editor by default in interactive sessions,
2012-01-10), git-merge only started an editor if the user explicitly
asked for it with --edit.  Thus it seemed unlikely that the user would
need extra guidance.

After f824628 the _normal_ thing is to start an editor.  Give at least
an indication of why we are doing it.

The sentence about justification is one of the few things about
standard git that are not agnostic to the workflow that the user
chose.  However, f824628 was proposed by Linus specifically to
discourage users from merging unrelated upstream progress into topic
branches.  So we may as well take another step in the same direction.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin/merge.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index bfb7547..ed628b8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -885,11 +885,22 @@ static void abort_commit(const char *err_msg)
 	exit(1);
 }
 
+static const char merge_editor_comment[] =
+N_("Please enter the commit message for your merge commit.  You should\n"
+"justify it especially if it merges an updated upstream into a topic\n"
+"branch.\n"
+"\n"
+"Lines starting with '#' will be ignored, and an empty message aborts\n"
+"the commit.\n");
+
 static void prepare_to_commit(void)
 {
 	struct strbuf msg = STRBUF_INIT;
+	const char *comment = _(merge_editor_comment);
 	strbuf_addbuf(&msg, &merge_msg);
 	strbuf_addch(&msg, '\n');
+	if (0 < option_edit)
+		strbuf_add_lines(&msg, "# ", comment, strlen(comment));
 	write_merge_msg(&msg);
 	run_hook(get_index_file(), "prepare-commit-msg",
 		 git_path("MERGE_MSG"), "merge", NULL, NULL);
-- 
1.7.9.350.ga960f
