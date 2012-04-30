From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6a/5] archive-zip: remove uncompressed_size
Date: Tue, 01 May 2012 00:12:07 +0200
Message-ID: <4F9F0E37.6040406@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 00:12:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOypL-0006G4-Ur
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757139Ab2D3WMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 18:12:10 -0400
Received: from india601.server4you.de ([85.25.151.105]:57799 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033Ab2D3WMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:12:09 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 649BA2F805D;
	Tue,  1 May 2012 00:12:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196618>

We only need size and compressed_size.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 716cc42..400ba38 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -129,7 +129,6 @@ static int write_zip_entry(struct archiver_args *args,
 	struct zip_dir_header dirent;
 	unsigned long attr2;
 	unsigned long compressed_size;
-	unsigned long uncompressed_size;
 	unsigned long crc;
 	unsigned long direntsize;
 	int method;
@@ -149,7 +148,7 @@ static int write_zip_entry(struct archiver_args *args,
 		method = 0;
 		attr2 = 16;
 		out = NULL;
-		uncompressed_size = 0;
+		size = 0;
 		compressed_size = 0;
 		buffer = NULL;
 		size = 0;
@@ -166,7 +165,6 @@ static int write_zip_entry(struct archiver_args *args,
 			method = 8;
 		crc = crc32(crc, buffer, size);
 		out = buffer;
-		uncompressed_size = size;
 		compressed_size = size;
 	} else {
 		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
@@ -204,7 +202,7 @@ static int write_zip_entry(struct archiver_args *args,
 	copy_le16(dirent.mdate, zip_date);
 	copy_le32(dirent.crc32, crc);
 	copy_le32(dirent.compressed_size, compressed_size);
-	copy_le32(dirent.size, uncompressed_size);
+	copy_le32(dirent.size, size);
 	copy_le16(dirent.filename_length, pathlen);
 	copy_le16(dirent.extra_length, 0);
 	copy_le16(dirent.comment_length, 0);
@@ -226,7 +224,7 @@ static int write_zip_entry(struct archiver_args *args,
 	copy_le16(header.mdate, zip_date);
 	copy_le32(header.crc32, crc);
 	copy_le32(header.compressed_size, compressed_size);
-	copy_le32(header.size, uncompressed_size);
+	copy_le32(header.size, size);
 	copy_le16(header.filename_length, pathlen);
 	copy_le16(header.extra_length, 0);
 	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
-- 
1.7.10
