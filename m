Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A29207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 17:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1173406AbdDXRbu (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 13:31:50 -0400
Received: from mout.web.de ([212.227.15.14]:50267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1173306AbdDXRbs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 13:31:48 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2qsI-1cASWd26Rq-00seZR; Mon, 24
 Apr 2017 19:31:45 +0200
Subject: [PATCH v3 3/5] archive-zip: write ZIP dir entry directly to strbuf
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
Message-ID: <dda8fd49-87af-057d-d929-3240f8fb3d37@web.de>
Date:   Mon, 24 Apr 2017 19:31:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:LDuomzEM3PVzvcwW4eSpvZFLxJSQ84Mch+zxy2ii0mw0TZHtbWn
 aN2sxbWeY/PCFmOeF673pVLSnk8vZuos+Msui9T40Yaa6Bm6NCmfVHi+hPjuKPlb2jiQRnA
 jVxwSAmQmRV/lEn2uL3yyNNJHgj1EUvKdIxUqiEWXd0zeqh8G7cQj+VGmV4jUHsfRrtEw1K
 N+cVRUrvE7Pf84DGD5Wbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YX03Kt/OwYE=:vPfBBmuhLkDO9brhN+/08W
 68wzvAQWEvZVSus6w4ZlEdApP6wkP+5f3guTpWCfDm23lULVjG8Po+ojMVYPQtx1Iju2klEI0
 20YUMQhBx2jBMTc+xjW3XImqgrEuBYV/v+/343U2MwJ5LlB3VYHV6mnO7+rQ61cg2Wuz4Q8YQ
 SuzrhHPHEaw7qkUp2PdeuL5Xw5OQNRyhnKobdj8s82lW4RaqbOSA/OM9ERNtcJ8OwUtu2DjxN
 7XGcJT2gtj3ZdIw5esRgkg92Qf7BKd7Srj5hilcRaInm2EwYmlV8Oj6Scn3+I5lUevU2Jd7S/
 wwpmwKJ3VCK2CY0G7bVkG7ph5hBb0r3bfK9sP+NBDjK/dxaWZLfbzsd48f3SgcV4flD4kKBzY
 5S6n3YOvh6Zzogv+dWzksXmanqK/MXYKsgkl2zTrMvpIcU0AP9o2nYr1nmWxnF8jvXUvDr3MX
 HPjJFleGvvMJhTLcMjunirOjPRNKdZKYMdThw77yAI2oWsPA8YK/K4/0IfSqXKySIBeP4+T6Y
 vEOJNHaN4bxJ8nlrK/NmVAqdeva0B7uIhD0U6pK/FfbhHPJRPsv+lzrwz3cUkR7r9a/kn1sAy
 BXWoIOckbu/SCbNe09b2Ea22pE+LO9ELnFiyNYvdlPt3cF7+v4aZ/8R9v2Zq2oYwMpsDp/UW4
 hZXbdPGsmnX7D6fW0z9aw6xca2dgzb8HOlSr+4r8f2+CrBkIPQ6zQ9pDh2W5VW+IQ6Fk6ygxU
 FOfeapIqExoQ1z86PZul8liHv0ao+aM12gp4l1wUqJtvNiZ6+Oawf/scAFLUd7paon+e5qDsz
 APB/wbE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Write all fields of the ZIP directory record for an archive entry
in the right order directly into the strbuf instead of taking a detour
through a struct.  Do that at end, when we have all necessary data like
checksum and compressed size.  The fields are documented just as well,
the code becomes shorter and we save an extra copy.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive-zip.c | 81 ++++++++++++++++++++---------------------------------------
 1 file changed, 27 insertions(+), 54 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index a6fac59602..2d52bb3ade 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -45,27 +45,6 @@ struct zip_data_desc {
 	unsigned char _end[1];
 };
 
-struct zip_dir_header {
-	unsigned char magic[4];
-	unsigned char creator_version[2];
-	unsigned char version[2];
-	unsigned char flags[2];
-	unsigned char compression_method[2];
-	unsigned char mtime[2];
-	unsigned char mdate[2];
-	unsigned char crc32[4];
-	unsigned char compressed_size[4];
-	unsigned char size[4];
-	unsigned char filename_length[2];
-	unsigned char extra_length[2];
-	unsigned char comment_length[2];
-	unsigned char disk[2];
-	unsigned char attr1[2];
-	unsigned char attr2[4];
-	unsigned char offset[4];
-	unsigned char _end[1];
-};
-
 struct zip_dir_trailer {
 	unsigned char magic[4];
 	unsigned char disk[2];
@@ -166,6 +145,15 @@ static void copy_le16_clamp(unsigned char *dest, uint64_t n, int *clamped)
 	copy_le16(dest, clamp_max(n, 0xffff, clamped));
 }
 
+static int strbuf_add_le(struct strbuf *sb, size_t size, uintmax_t n)
+{
+	while (size-- > 0) {
+		strbuf_addch(sb, n & 0xff);
+		n >>= 8;
+	}
+	return -!!n;
+}
+
 static void *zlib_deflate_raw(void *data, unsigned long size,
 			      int compression_level,
 			      unsigned long *compressed_size)
@@ -212,16 +200,6 @@ static void write_zip_data_desc(unsigned long size,
 	write_or_die(1, &trailer, ZIP_DATA_DESC_SIZE);
 }
 
-static void set_zip_dir_data_desc(struct zip_dir_header *header,
-				  unsigned long size,
-				  unsigned long compressed_size,
-				  unsigned long crc)
-{
-	copy_le32(header->crc32, crc);
-	copy_le32(header->compressed_size, compressed_size);
-	copy_le32(header->size, size);
-}
-
 static void set_zip_header_data_desc(struct zip_local_header *header,
 				     unsigned long size,
 				     unsigned long compressed_size,
@@ -261,7 +239,7 @@ static int write_zip_entry(struct archiver_args *args,
 			   unsigned int mode)
 {
 	struct zip_local_header header;
-	struct zip_dir_header dirent;
+	uintmax_t offset = zip_offset;
 	struct zip_extra_mtime extra;
 	unsigned long attr2;
 	unsigned long compressed_size;
@@ -353,21 +331,6 @@ static int write_zip_entry(struct archiver_args *args,
 	extra.flags[0] = 1;	/* just mtime */
 	copy_le32(extra.mtime, args->time);
 
-	copy_le32(dirent.magic, 0x02014b50);
-	copy_le16(dirent.creator_version, creator_version);
-	copy_le16(dirent.version, 10);
-	copy_le16(dirent.flags, flags);
-	copy_le16(dirent.compression_method, method);
-	copy_le16(dirent.mtime, zip_time);
-	copy_le16(dirent.mdate, zip_date);
-	set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
-	copy_le16(dirent.filename_length, pathlen);
-	copy_le16(dirent.extra_length, ZIP_EXTRA_MTIME_SIZE);
-	copy_le16(dirent.comment_length, 0);
-	copy_le16(dirent.disk, 0);
-	copy_le32(dirent.attr2, attr2);
-	copy_le32(dirent.offset, zip_offset);
-
 	copy_le32(header.magic, 0x04034b50);
 	copy_le16(header.version, 10);
 	copy_le16(header.flags, flags);
@@ -406,8 +369,6 @@ static int write_zip_entry(struct archiver_args *args,
 
 		write_zip_data_desc(size, compressed_size, crc);
 		zip_offset += ZIP_DATA_DESC_SIZE;
-
-		set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
 	} else if (stream && method == 8) {
 		unsigned char buf[STREAM_BUFFER_SIZE];
 		ssize_t readlen;
@@ -464,8 +425,6 @@ static int write_zip_entry(struct archiver_args *args,
 
 		write_zip_data_desc(size, compressed_size, crc);
 		zip_offset += ZIP_DATA_DESC_SIZE;
-
-		set_zip_dir_data_desc(&dirent, size, compressed_size, crc);
 	} else if (compressed_size > 0) {
 		write_or_die(1, out, compressed_size);
 		zip_offset += compressed_size;
@@ -474,9 +433,23 @@ static int write_zip_entry(struct archiver_args *args,
 	free(deflated);
 	free(buffer);
 
-	copy_le16(dirent.attr1, !is_binary);
-
-	strbuf_add(&zip_dir, &dirent, ZIP_DIR_HEADER_SIZE);
+	strbuf_add_le(&zip_dir, 4, 0x02014b50);	/* magic */
+	strbuf_add_le(&zip_dir, 2, creator_version);
+	strbuf_add_le(&zip_dir, 2, 10);		/* version */
+	strbuf_add_le(&zip_dir, 2, flags);
+	strbuf_add_le(&zip_dir, 2, method);
+	strbuf_add_le(&zip_dir, 2, zip_time);
+	strbuf_add_le(&zip_dir, 2, zip_date);
+	strbuf_add_le(&zip_dir, 4, crc);
+	strbuf_add_le(&zip_dir, 4, compressed_size);
+	strbuf_add_le(&zip_dir, 4, size);
+	strbuf_add_le(&zip_dir, 2, pathlen);
+	strbuf_add_le(&zip_dir, 2, ZIP_EXTRA_MTIME_SIZE);
+	strbuf_add_le(&zip_dir, 2, 0);		/* comment length */
+	strbuf_add_le(&zip_dir, 2, 0);		/* disk */
+	strbuf_add_le(&zip_dir, 2, !is_binary);
+	strbuf_add_le(&zip_dir, 4, attr2);
+	strbuf_add_le(&zip_dir, 4, offset);
 	strbuf_add(&zip_dir, path, pathlen);
 	strbuf_add(&zip_dir, &extra, ZIP_EXTRA_MTIME_SIZE);
 	zip_dir_entries++;
-- 
2.12.2

