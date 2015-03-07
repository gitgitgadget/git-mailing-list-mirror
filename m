From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 06/10] bulk-checkin.c: convert to use struct object_id
Date: Sat,  7 Mar 2015 23:24:01 +0000
Message-ID: <1425770645-628957-7-git-send-email-sandals@crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 00:24:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUO5I-0001mM-AG
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbbCGXYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:24:34 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49837 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752955AbbCGXYR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 18:24:17 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0493C28092;
	Sat,  7 Mar 2015 23:24:17 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265017>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bulk-checkin.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 0c4b8a7..e50f60e 100644
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
+		sha1close(state->f, oid.sha1, CSUM_FSYNC);
 	} else {
-		int fd = sha1close(state->f, sha1, 0);
-		fixup_pack_header_footer(fd, sha1, state->pack_tmp_name,
-					 state->nr_written, sha1,
+		int fd = sha1close(state->f, oid.sha1, 0);
+		fixup_pack_header_footer(fd, oid.sha1, state->pack_tmp_name,
+					 state->nr_written, oid.sha1,
 					 state->offset);
 		close(fd);
 	}
@@ -48,7 +48,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
 	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
-			    &state->pack_idx_opts, sha1);
+			    &state->pack_idx_opts, oid.sha1);
 	for (i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
-- 
2.2.1.209.g41e5f3a
