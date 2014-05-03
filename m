From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 6/9] bulk-checkin.c: convert to use struct object_id
Date: Sat,  3 May 2014 20:12:19 +0000
Message-ID: <1399147942-165308-7-git-send-email-sandals@crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 22:12:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggIe-0004K5-VO
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbaECUMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:12:32 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47532 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753296AbaECUMa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:12:30 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9BB4228087
	for <git@vger.kernel.org>; Sat,  3 May 2014 20:12:29 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248053>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bulk-checkin.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 98e651c..92c7b5e 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -23,7 +23,7 @@ static struct bulk_checkin_state {
 
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
-	unsigned char sha1[20];
+	struct object_id sha1;
 	struct strbuf packname = STRBUF_INIT;
 	int i;
 
@@ -35,11 +35,11 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
-		sha1close(state->f, sha1, CSUM_FSYNC);
+		sha1close(state->f, sha1.oid, CSUM_FSYNC);
 	} else {
-		int fd = sha1close(state->f, sha1, 0);
-		fixup_pack_header_footer(fd, sha1, state->pack_tmp_name,
-					 state->nr_written, sha1,
+		int fd = sha1close(state->f, sha1.oid, 0);
+		fixup_pack_header_footer(fd, sha1.oid, state->pack_tmp_name,
+					 state->nr_written, sha1.oid,
 					 state->offset);
 		close(fd);
 	}
@@ -47,7 +47,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
 	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
-			    &state->pack_idx_opts, sha1);
+			    &state->pack_idx_opts, sha1.oid);
 	for (i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
-- 
2.0.0.rc0
