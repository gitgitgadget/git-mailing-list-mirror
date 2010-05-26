From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 082/104] fmt-merge-msg: add function to append shortlog only
Date: Wed, 26 May 2010 18:00:52 +1200
Message-ID: <1274853674-18521-82-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lg-0004ff-AS
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934016Ab0EZGGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:35 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49309 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933931Ab0EZGG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 0571533917;
	Wed, 26 May 2010 18:02:07 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rDfOecAq7yCL; Wed, 26 May 2010 18:01:57 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 45652338B4;
	Wed, 26 May 2010 18:01:35 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147758>

From: Tay Ray Chuan <rctay89@gmail.com>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin.h               |    1 +
 builtin/fmt-merge-msg.c |   13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin.h b/builtin.h
index 464588b..322901f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -16,6 +16,7 @@ extern const char *help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
+extern int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out);
 extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index d0160cb..48548cf 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -255,8 +255,8 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
 		strbuf_addf(out, " into %s\n", current_branch);
 }
 
-static int do_fmt_merge_msg(int merge_summary, struct strbuf *in,
-	struct strbuf *out) {
+static int do_fmt_merge_msg(int merge_title, int merge_summary,
+	struct strbuf *in, struct strbuf *out) {
 	int limit = 20, i = 0, pos = 0;
 	unsigned char head_sha1[20];
 	const char *current_branch;
@@ -285,7 +285,8 @@ static int do_fmt_merge_msg(int merge_summary, struct strbuf *in,
 	if (!srcs.nr)
 		return 0;
 
-	do_fmt_merge_msg_title(out, current_branch);
+	if (merge_title)
+		do_fmt_merge_msg_title(out, current_branch);
 
 	if (merge_summary) {
 		struct commit *head;
@@ -305,7 +306,11 @@ static int do_fmt_merge_msg(int merge_summary, struct strbuf *in,
 }
 
 int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
-	return do_fmt_merge_msg(merge_summary, in, out);
+	return do_fmt_merge_msg(1, merge_summary, in, out);
+}
+
+int fmt_merge_msg_shortlog(struct strbuf *in, struct strbuf *out) {
+	return do_fmt_merge_msg(0, 1, in, out);
 }
 
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
-- 
1.7.1.rc2.333.gb2668
