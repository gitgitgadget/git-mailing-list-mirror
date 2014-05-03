From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 4/9] zip: use GIT_OID_HEXSZ for trailers
Date: Sat,  3 May 2014 20:12:17 +0000
Message-ID: <1399147942-165308-5-git-send-email-sandals@crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 22:12:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggIT-0002kw-H7
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbaECUMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:12:30 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47530 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753296AbaECUM3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:12:29 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 76B2C28087
	for <git@vger.kernel.org>; Sat,  3 May 2014 20:12:28 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248048>

The object.h header is included in archive.h for this constant.  It will be
used by other parts of the archiving code in the future.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive-zip.c | 4 ++--
 archive.h     | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 4bde019..5b9fe42 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -427,12 +427,12 @@ static void write_zip_trailer(const unsigned char *sha1)
 	copy_le16(trailer.entries, zip_dir_entries);
 	copy_le32(trailer.size, zip_dir_offset);
 	copy_le32(trailer.offset, zip_offset);
-	copy_le16(trailer.comment_length, sha1 ? 40 : 0);
+	copy_le16(trailer.comment_length, sha1 ? GIT_OID_HEXSZ : 0);
 
 	write_or_die(1, zip_dir, zip_dir_offset);
 	write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
 	if (sha1)
-		write_or_die(1, sha1_to_hex(sha1), 40);
+		write_or_die(1, sha1_to_hex(sha1), GIT_OID_HEXSZ);
 }
 
 static void dos_time(time_t *time, int *dos_date, int *dos_time)
diff --git a/archive.h b/archive.h
index 4a791e1..fd21408 100644
--- a/archive.h
+++ b/archive.h
@@ -2,6 +2,7 @@
 #define ARCHIVE_H
 
 #include "pathspec.h"
+#include "object.h"
 
 struct archiver_args {
 	const char *base;
-- 
2.0.0.rc0
