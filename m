From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 06/10] bulk-checkin.c: convert to use struct object_id
Date: Fri, 13 Mar 2015 23:39:32 +0000
Message-ID: <1426289976-568060-7-git-send-email-sandals@crustytoothpaste.net>
References: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 00:40:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWZBn-0008Qk-Ro
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 00:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064AbbCMXkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 19:40:15 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50136 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754762AbbCMXkM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2015 19:40:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C88092808F;
	Fri, 13 Mar 2015 23:40:11 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426289976-568060-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265426>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bulk-checkin.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 0c4b8a7..c80e503 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -24,7 +24,7 @@ static struct bulk_checkin_state {
 
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct strbuf packname = STRBUF_INIT;
 	int i;
 
@@ -36,11 +36,11 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
-		sha1close(state->f, sha1, CSUM_FSYNC);
+		sha1close(state->f, oid.hash, CSUM_FSYNC);
 	} else {
-		int fd = sha1close(state->f, sha1, 0);
-		fixup_pack_header_footer(fd, sha1, state->pack_tmp_name,
-					 state->nr_written, sha1,
+		int fd = sha1close(state->f, oid.hash, 0);
+		fixup_pack_header_footer(fd, oid.hash, state->pack_tmp_name,
+					 state->nr_written, oid.hash,
 					 state->offset);
 		close(fd);
 	}
@@ -48,7 +48,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
 	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
-			    &state->pack_idx_opts, sha1);
+			    &state->pack_idx_opts, oid.hash);
 	for (i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
-- 
2.2.1.209.g41e5f3a
