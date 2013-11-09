From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 57/86] builtin/fmt-merge-msg: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:06:50 +0100
Message-ID: <20131109070720.18178.90016.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fk-0003IA-8g
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933314Ab3KIHJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:21 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36371 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933295Ab3KIHIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:44 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id A84C059;
	Sat,  9 Nov 2013 08:08:43 +0100 (CET)
X-git-sha1: 21107069943aba0b1cc7009929eb57cb6bf7ac7d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237498>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fmt-merge-msg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 1c04070..09a55bf 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -109,7 +109,7 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 	if (len < 43 || line[40] != '\t')
 		return 1;
 
-	if (!prefixcmp(line + 41, "not-for-merge"))
+	if (has_prefix(line + 41, "not-for-merge"))
 		return 0;
 
 	if (line[41] != '\t')
@@ -155,16 +155,16 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 	if (pulling_head) {
 		origin = src;
 		src_data->head_status |= 1;
-	} else if (!prefixcmp(line, "branch ")) {
+	} else if (has_prefix(line, "branch ")) {
 		origin_data->is_local_branch = 1;
 		origin = line + 7;
 		string_list_append(&src_data->branch, origin);
 		src_data->head_status |= 2;
-	} else if (!prefixcmp(line, "tag ")) {
+	} else if (has_prefix(line, "tag ")) {
 		origin = line;
 		string_list_append(&src_data->tag, origin + 4);
 		src_data->head_status |= 2;
-	} else if (!prefixcmp(line, "remote-tracking branch ")) {
+	} else if (has_prefix(line, "remote-tracking branch ")) {
 		origin = line + strlen("remote-tracking branch ");
 		string_list_append(&src_data->r_branch, origin);
 		src_data->head_status |= 2;
@@ -605,7 +605,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		resolve_refdup("HEAD", head_sha1, 1, NULL);
 	if (!current_branch)
 		die("No current branch");
-	if (!prefixcmp(current_branch, "refs/heads/"))
+	if (has_prefix(current_branch, "refs/heads/"))
 		current_branch += 11;
 
 	find_merge_parents(&merge_parents, in, head_sha1);
-- 
1.8.4.1.566.geca833c
