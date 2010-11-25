From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 17/18] revert: add remaining instructions in todo file
Date: Thu, 25 Nov 2010 22:20:48 +0100
Message-ID: <20101125212050.5188.28783.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:56:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIi-0007NM-6V
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905Ab0KZFzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:55:46 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48091 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab0KZFzp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:55:45 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 68EC1A6163;
	Fri, 26 Nov 2010 06:55:38 +0100 (CET)
X-git-sha1: e4ee70798b1e2df8c319eae8564cfd1d9884c4a6 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162196>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ca65b92..b51f7ab 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -483,14 +483,19 @@ static void get_todo_content(struct strbuf *buf, struct commit_list *list,
 }
 
 static void create_todo_file(const char *filepath, int append,
-			     struct commit_list *list, const char *line_prefix,
-			     struct args_info *info)
+			     struct commit_list *list, struct parsed_insn *insn,
+			     const char *line_prefix, struct args_info *info)
 {
 	int fd, flags;
 	struct strbuf buf = STRBUF_INIT;
 
 	get_todo_content(&buf, list, line_prefix, info);
 
+	if (insn) {
+		while ((insn = insn->next))
+			strbuf_addbuf(&buf, &insn->orig);
+	}
+
 	flags = O_WRONLY | O_CREAT | (append ? O_APPEND : O_TRUNC);
 	fd = open(filepath, flags, 0666);
 	if (fd < 0)
@@ -926,9 +931,9 @@ static int save_todo_and_done(int res, struct args_info *infos,
 				  SEQ_PATH);
 		if (commit)
 			commit_list_insert(commit, &todo_list);
-		create_todo_file(TODO_FILE, 0, todo_list, "", infos);
+		create_todo_file(TODO_FILE, 0, todo_list, NULL, "", infos);
 		*done_list = reverse_commit_list(*done_list);
-		create_todo_file(DONE_FILE, 0, *done_list, "", infos);
+		create_todo_file(DONE_FILE, 0, *done_list, NULL, "", infos);
 	}
 	return res;
 }
-- 
1.7.3.2.504.g59d466
