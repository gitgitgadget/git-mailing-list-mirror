Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D89C207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 17:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1173394AbdDXRaz (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 13:30:55 -0400
Received: from mout.web.de ([212.227.15.14]:56304 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1173588AbdDXRaw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 13:30:52 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0ML8F7-1d2ywF07Bx-000Ltm; Mon, 24
 Apr 2017 19:30:50 +0200
Subject: [PATCH v3 2/5] archive-zip: use strbuf for ZIP directory
To:     Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <949f19e6-0414-9abc-9754-064d7e58c169@web.de>
Date:   Mon, 24 Apr 2017 19:30:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Xi9YUkF7FFcn+8aQa4C7tuvzah0+vFa793ayC8Gu9CKPDTPPnwo
 jVAPunaeXsdwIZM63U/fVsAmvro9HqCTtOXaN2dGXrAgu1vLtXO6cBZCyj87L+iEslE8UNg
 DJegT0uLJQrl0ztjULFYHbAIwSxoJAeqcH/yx9Fu+F5AJOB6JDHCzrEDJSTtElpntKVOB+S
 v6t6skugudDEiagqzbiAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lGVjH3X5jxU=:QrJmngKkA/lXuPRjAUcyQ4
 r1lPgdVHKUpmnmvlljWpBeS8JNl+3/Pj4KjFX7h5H9/8rJ3jVyDk6rXickY3l+fcEgq23sUMi
 gsaY5irhwrVy55KFDKnrpvcIx/Y4XhcpeyeCsN2nGSQQmmDo+Tj704hWsAGs/gqKTtR1EbA89
 N4PwRzu4VegIM91sfzI+UDR2+lNFdEtvBANe+JSGX9Mo1/MEhIS/lydT5ex0cCakSYvMpu+3M
 s3J3GXV12DdhTDgYKY87oJu1Cc2jktJEVxBPhKH8HAQqdX1ct/otkH7WC+gZl5HsXbIg5K91u
 XOzi+tzMzucCkALVfZMI4EEafjxRCVgGCUgqXxfpIvzR2fPW1pFnx9o6TOSkyAwNa555Ri8EM
 utkUeeZQ71bbQMcJHtsVM6yA8qSjyMXP3DX0R/xB6zYPTezrjfZ4B8nnvHGFF+ht7AbUF3/9P
 DcdK+hw5DQpnV9e++zO2GJ19T4Lzu+AJNraSCRWkZs8ycEsJKPRmQP4UCq2AsYSpY8p9m4/9R
 kWJHn6OTe1Y+Y5fiAlA/SuVnzRJn3Anwv0n2gAnTkbq3O9pbzd3PRzvaAgwzvZe5Enwax0yXw
 n2RKQAdm27GATYcsWY6eS4UDXhzehYHBO4mrPEEYgnBFVUiYlxv+WlejJgu9uA5+MCWcVwzza
 iYAryy3+aq+vy4PVgOkycWifINeWy6dPt8zDM4iK4xsr42z2RoA4w7UXZb3I9m7HeQfUhQLBf
 SQH6pOQU3OU3EBD31P6W6iOEmDm+wy0Xf++T9qb3OfIwrWbSoNtXuUViY+kcvSY6ntbUbzUd6
 HzfBM2P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the ZIP central director, which is written after all archive
entries, in a strbuf instead of a custom-managed buffer.  It contains
binary data, so we can't (and don't want to) use the full range of
strbuf functions and we don't need the terminating NUL, but the result
is shorter and simpler code.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive-zip.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index b429a8d974..a6fac59602 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -11,16 +11,14 @@
 static int zip_date;
 static int zip_time;
 
-static unsigned char *zip_dir;
-static unsigned int zip_dir_size;
+/* We only care about the "buf" part here. */
+static struct strbuf zip_dir;
 
 static unsigned int zip_offset;
-static unsigned int zip_dir_offset;
 static uint64_t zip_dir_entries;
 
 static unsigned int max_creator_version;
 
-#define ZIP_DIRECTORY_MIN_SIZE	(1024 * 1024)
 #define ZIP_STREAM	(1 <<  3)
 #define ZIP_UTF8	(1 << 11)
 
@@ -268,7 +266,6 @@ static int write_zip_entry(struct archiver_args *args,
 	unsigned long attr2;
 	unsigned long compressed_size;
 	unsigned long crc;
-	unsigned long direntsize;
 	int method;
 	unsigned char *out;
 	void *deflated = NULL;
@@ -356,13 +353,6 @@ static int write_zip_entry(struct archiver_args *args,
 	extra.flags[0] = 1;	/* just mtime */
 	copy_le32(extra.mtime, args->time);
 
-	/* make sure we have enough free space in the dictionary */
-	direntsize = ZIP_DIR_HEADER_SIZE + pathlen + ZIP_EXTRA_MTIME_SIZE;
-	while (zip_dir_size < zip_dir_offset + direntsize) {
-		zip_dir_size += ZIP_DIRECTORY_MIN_SIZE;
-		zip_dir = xrealloc(zip_dir, zip_dir_size);
-	}
-
 	copy_le32(dirent.magic, 0x02014b50);
 	copy_le16(dirent.creator_version, creator_version);
 	copy_le16(dirent.version, 10);
@@ -486,12 +476,9 @@ static int write_zip_entry(struct archiver_args *args,
 
 	copy_le16(dirent.attr1, !is_binary);
 
-	memcpy(zip_dir + zip_dir_offset, &dirent, ZIP_DIR_HEADER_SIZE);
-	zip_dir_offset += ZIP_DIR_HEADER_SIZE;
-	memcpy(zip_dir + zip_dir_offset, path, pathlen);
-	zip_dir_offset += pathlen;
-	memcpy(zip_dir + zip_dir_offset, &extra, ZIP_EXTRA_MTIME_SIZE);
-	zip_dir_offset += ZIP_EXTRA_MTIME_SIZE;
+	strbuf_add(&zip_dir, &dirent, ZIP_DIR_HEADER_SIZE);
+	strbuf_add(&zip_dir, path, pathlen);
+	strbuf_add(&zip_dir, &extra, ZIP_EXTRA_MTIME_SIZE);
 	zip_dir_entries++;
 
 	return 0;
@@ -510,12 +497,12 @@ static void write_zip64_trailer(void)
 	copy_le32(trailer64.directory_start_disk, 0);
 	copy_le64(trailer64.entries_on_this_disk, zip_dir_entries);
 	copy_le64(trailer64.entries, zip_dir_entries);
-	copy_le64(trailer64.size, zip_dir_offset);
+	copy_le64(trailer64.size, zip_dir.len);
 	copy_le64(trailer64.offset, zip_offset);
 
 	copy_le32(locator64.magic, 0x07064b50);
 	copy_le32(locator64.disk, 0);
-	copy_le64(locator64.offset, zip_offset + zip_dir_offset);
+	copy_le64(locator64.offset, zip_offset + zip_dir.len);
 	copy_le32(locator64.number_of_disks, 1);
 
 	write_or_die(1, &trailer64, ZIP64_DIR_TRAILER_SIZE);
@@ -533,11 +520,11 @@ static void write_zip_trailer(const unsigned char *sha1)
 	copy_le16_clamp(trailer.entries_on_this_disk, zip_dir_entries,
 			&clamped);
 	copy_le16_clamp(trailer.entries, zip_dir_entries, &clamped);
-	copy_le32(trailer.size, zip_dir_offset);
+	copy_le32(trailer.size, zip_dir.len);
 	copy_le32(trailer.offset, zip_offset);
 	copy_le16(trailer.comment_length, sha1 ? GIT_SHA1_HEXSZ : 0);
 
-	write_or_die(1, zip_dir, zip_dir_offset);
+	write_or_die(1, zip_dir.buf, zip_dir.len);
 	if (clamped)
 		write_zip64_trailer();
 	write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
@@ -568,14 +555,13 @@ static int write_zip_archive(const struct archiver *ar,
 
 	dos_time(&args->time, &zip_date, &zip_time);
 
-	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
-	zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;
+	strbuf_init(&zip_dir, 0);
 
 	err = write_archive_entries(args, write_zip_entry);
 	if (!err)
 		write_zip_trailer(args->commit_sha1);
 
-	free(zip_dir);
+	strbuf_release(&zip_dir);
 
 	return err;
 }
-- 
2.12.2

