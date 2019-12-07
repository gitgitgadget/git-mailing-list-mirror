Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1CDC2BBE2
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 12:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA3E21835
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 12:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hRxVhsxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLGMUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 07:20:40 -0500
Received: from mout.web.de ([212.227.17.12]:60383 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfLGMUk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 07:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575721234;
        bh=uxEv8yDrEjD3Ns5eJACVnIjCY1HZMwk69srS/1o8Gzo=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=hRxVhsxn/m5mKadzpkJDZ/5Ceii1P3gNQ8j6fjrGytuawhn8xoUknyWUiIO0a4pCi
         B6jpCJaeNzeIuhupismZX5oJPlEqdSRjN+sprnsuZJDlt6RTIq3a8G/uhap5aIsCLn
         49dVVMxjRb4ZrXwR/VakoKJXCrmtLXAfc294IVO8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFLB2-1iaHp81Sz6-00EJpR; Sat, 07
 Dec 2019 13:20:34 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] archive-zip: use enum for compression method
Message-ID: <9acdf2e0-6a65-df73-1e43-0a9e1631f138@web.de>
Date:   Sat, 7 Dec 2019 13:20:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VJZX1UqyrH50Q6gbbg5m7y3BuY2vKYGTBfQSN4McGQrQ3l3Sua+
 FykxfOCQclR2EQSJMOf5hbM7ATdS40Fx5qJN05dFHpOjXAnCigURRGdLJ5rQfdcLEH2pJ/n
 UuAoGmZJ8x/RgVtQkXiPOje4N9W0GFedVC8YhAtc8tRgI/8G5+u2jyk08t3GjnrVjIYfe8B
 MAqPtJsdvQ7weCyNHiEwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BCbHKQmsUMA=:wlMIhkwYWHy9Kvwj0bMcCu
 jNLAP/CmZKmu/OhnpxJD56L0K8kM/8nTF0A15m5zbFjE1BHg3r+JBbmn4x0RV5BObIdiM3LC0
 LeI6a6MUCQ+5yDbTtKtqBgsZXhxc/3kDpRdvIHH3Rw6AMEPCDvcxiFfKfIFhoFrfAHW6sGAAc
 brCkw6pB+P1pxnUg9cFylvIETorQjPHlffbFTbmBItPaR4iubGZjJaU2RtLl4ed9OPRylbTDj
 cE+INZD1JW1l146s+FR8q4+IYZthDL3iVS3b8Ou0n57qo5Jj9T8OoxztSZF4Xi+aApbhoivn3
 Zpi4pCcnOK967OvW67aOWdMoumEVIqAY7R7bOVMaxtlARUINVab8QRRugbgZ0JZ2jgx/dKwNL
 curpla3AMPC4tGhMNTiBNZ8JJOQKxhhTnB0CKHjBsmjaiYO3fPbjf0m07ea8dsOXC2i/MNLXI
 kaZgbIXRs+meiqtNLwtC+XCiFxl4XHvd86hxVJOIv3ITap3ZpKMHyn7E9WCHDbZXA0zh7BLjX
 FmeRlFqUo28Yf9f78ruDijoMcdxxt+W9HsMorkhVfLjAondM4R8xC/OxmlpEhSv3XfW2K7O99
 tVHFKhYVGI7EdreF3jEvt/dpMNKK9ns/Ch0G0FoRET+YYtO5T2aidIfxuCsgFUCzMLZVtmj4S
 MuoaFTy7S7YiIUKS/Q38h7e3qFp4OWnXY5tLFKschKi0XRiGTGgIc+rIUctfQ0DLEIKf2R0D/
 Nuchrnszz+SrdxUaOXK7N7dPwU/+SQJPhA+vD5LL8C4618MmPSQofDGauO6TYSaB63XsPNBlM
 GbSMoAQLKH34o92VElPvmVUGXe8blGS76eWjgKeO6bJ6ae4Ug2PVbFz74d4HdGl6yK8i9H76x
 uYRx4I2RvufE+ALRxKeinOyu28jZxdHm4eTesFpdY9n+6CZ+ts5dUTAGwyvI7pEOab/mJ0dVS
 KgmQJ82UlkXLzuS0gd0p0S63hZHxN6RFPu+7hVaMCotvIQQ8RlD+4zf7Ht3RxP6WpatWuknF5
 KBRl4S5wh6qWt34WipchfcLStPWtlhRIsxct10pCFe0KIxpXal/iFRP3E9Z22MzYiqVNOafqI
 U7cMtFMqQghGRoJShgm3NHdtKeMpKyxg+oZ2nEZiGHnbJeq7QhrjbsmAIZ5i19sLa3rhj1h0E
 UXGVlzQhlrg18zHRKDesLASjBDNxaKY9D5hpoX+P7XxYBNjAh2wz1BHw573fU6K06P6vCWeIh
 5Z0+jNeWbVSJ3SRErxsTB/zJXCGs9N7vGM5+7yw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an enumeration to assign names to the magic values that determine
the ZIP compression method to use.  Use those names to improve code
readability.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-zip.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 4d66b5be6e..095b66a480 100644
=2D-- a/archive-zip.c
+++ b/archive-zip.c
@@ -24,6 +24,11 @@ static unsigned int max_creator_version;
 #define ZIP_STREAM	(1 <<  3)
 #define ZIP_UTF8	(1 << 11)

+enum zip_method {
+	ZIP_METHOD_STORE =3D 0,
+	ZIP_METHOD_DEFLATE =3D 8
+};
+
 struct zip_local_header {
 	unsigned char magic[4];
 	unsigned char version[2];
@@ -291,7 +296,7 @@ static int write_zip_entry(struct archiver_args *args,
 	unsigned long attr2;
 	unsigned long compressed_size;
 	unsigned long crc;
-	int method;
+	enum zip_method method;
 	unsigned char *out;
 	void *deflated =3D NULL;
 	void *buffer;
@@ -320,7 +325,7 @@ static int write_zip_entry(struct archiver_args *args,
 	}

 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-		method =3D 0;
+		method =3D ZIP_METHOD_STORE;
 		attr2 =3D 16;
 		out =3D NULL;
 		size =3D 0;
@@ -330,13 +335,13 @@ static int write_zip_entry(struct archiver_args *arg=
s,
 		enum object_type type =3D oid_object_info(args->repo, oid,
 							&size);

-		method =3D 0;
+		method =3D ZIP_METHOD_STORE;
 		attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :
 			(mode & 0111) ? ((mode) << 16) : 0;
 		if (S_ISLNK(mode) || (mode & 0111))
 			creator_version =3D 0x0317;
 		if (S_ISREG(mode) && args->compression_level !=3D 0 && size > 0)
-			method =3D 8;
+			method =3D ZIP_METHOD_DEFLATE;

 		if (S_ISREG(mode) && type =3D=3D OBJ_BLOB && !args->convert &&
 		    size > big_file_threshold) {
@@ -358,7 +363,7 @@ static int write_zip_entry(struct archiver_args *args,
 						    buffer, size);
 			out =3D buffer;
 		}
-		compressed_size =3D (method =3D=3D 0) ? size : 0;
+		compressed_size =3D (method =3D=3D ZIP_METHOD_STORE) ? size : 0;
 	} else {
 		return error(_("unsupported file mode: 0%o (SHA1: %s)"), mode,
 				oid_to_hex(oid));
@@ -367,13 +372,13 @@ static int write_zip_entry(struct archiver_args *arg=
s,
 	if (creator_version > max_creator_version)
 		max_creator_version =3D creator_version;

-	if (buffer && method =3D=3D 8) {
+	if (buffer && method =3D=3D ZIP_METHOD_DEFLATE) {
 		out =3D deflated =3D zlib_deflate_raw(buffer, size,
 						  args->compression_level,
 						  &compressed_size);
 		if (!out || compressed_size >=3D size) {
 			out =3D buffer;
-			method =3D 0;
+			method =3D ZIP_METHOD_STORE;
 			compressed_size =3D size;
 		}
 	}
@@ -420,7 +425,7 @@ static int write_zip_entry(struct archiver_args *args,
 		zip_offset +=3D ZIP64_EXTRA_SIZE;
 	}

-	if (stream && method =3D=3D 0) {
+	if (stream && method =3D=3D ZIP_METHOD_STORE) {
 		unsigned char buf[STREAM_BUFFER_SIZE];
 		ssize_t readlen;

@@ -443,7 +448,7 @@ static int write_zip_entry(struct archiver_args *args,
 		zip_offset +=3D compressed_size;

 		write_zip_data_desc(size, compressed_size, crc);
-	} else if (stream && method =3D=3D 8) {
+	} else if (stream && method =3D=3D ZIP_METHOD_DEFLATE) {
 		unsigned char buf[STREAM_BUFFER_SIZE];
 		ssize_t readlen;
 		git_zstream zstream;
=2D-
2.24.0
