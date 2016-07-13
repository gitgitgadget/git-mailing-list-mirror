Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 649FF20196
	for <e@80x24.org>; Wed, 13 Jul 2016 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbcGMPou (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:44:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34143 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbcGMPot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:44:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id a10so3970518lfb.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:44:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwQlhJgWrbB1QUzknvRg932I5rKaZWsJO0zCMOu6vpo=;
        b=I8sDubUj/sIy+xpRCObjlf8d6ehJzjPB45ae3DCE+hIqlGJLZmKeu+rHNUqGfBjC5x
         TTxCZU7p+23edzUqio1R7wGZxwfNb5ArcgatlTp7zJButSEvFJLpwI+UQdD+qsqDNp51
         Wqq9mP62Mr+qGPCyJstz9kkyCKjLIOfZPj0RQgVtJWN8oga2oxcTcYh1yBEEdoW9x7rB
         6lDQRqafyKeqaWmrZwPGHUhoJMIjDG6QRstnC7eH8lF2D/Y+gOMTUL7NxAamck4Y66sI
         4XaRPksQ0mVLjghUbBpPNeh0mbPkAp26bSbd2qAIEoE4Z6jBsBZHBojmxN3XoadwTTCP
         UdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwQlhJgWrbB1QUzknvRg932I5rKaZWsJO0zCMOu6vpo=;
        b=fnPIx5qYEzCgJDJa5v6MivQXxttu6MJmtYeWPUgqpK+hb25GQx/OZAqIF4uGX7AZJm
         TMwtFPfxSvdPbyiTXDhrGDVRSJit66AsVicu+/1C6bNrJ31EV+LffU0FEwaernVsgbN4
         SSZnFcqR4/lXSa5fJcOndvKoakFlN0llWFaxXVuaWIhnimgttXBb4mbtBiHiX1gskLiH
         djYtbX3C7aGtZb6oLJcGx1EYLDBI/LJTXhfxUTGplJCHOgtBsagJ7kub1WlUCHi1z75X
         OuT+eXla8Pg0EjOiB3/f4a0aSB3Qsl72UqZwgCadLAuJ3vEyeen4X5xvrrH6df2EIj3e
         jVqw==
X-Gm-Message-State: ALyK8tIBy9fAzDRid1qHsPRXIwqseSoeGAZeh9gOdT2WQUyKKs7k85n8pBwa3WmEiJl3LQ==
X-Received: by 10.25.2.195 with SMTP id 186mr5042079lfc.36.1468424661014;
        Wed, 13 Jul 2016 08:44:21 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 90sm2575484lfw.30.2016.07.13.08.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jul 2016 08:44:20 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, michelbach94@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 7/7] fsck: use streaming interface for large blobs in pack
Date:	Wed, 13 Jul 2016 17:44:04 +0200
Message-Id: <20160713154404.22909-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.564.gb2f7278
In-Reply-To: <20160713154404.22909-1-pclouds@gmail.com>
References: <20160705170558.10906-1-pclouds@gmail.com>
 <20160713154404.22909-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For blobs, we want to make sure the on-disk data is not corrupted
(i.e. can be inflated and produce the expected SHA-1). Blob content is
opaque, there's nothing else inside to check for.

For really large blobs, we may want to avoid unpacking the entire blob
in memory, just to check whether it produces the same SHA-1. On 32-bit
systems, we may not have enough virtual address space for such memory
allocation. And even on 64-bit where it's not a problem, allocating a
lot more memory could result in kicking other parts of systems to swap
file, generating lots of I/O and slowing everything down.

For this particular operation, not unpacking the blob and letting
check_sha1_signature, which supports streaming interface, do the job
is sufficient. check_sha1_signature() is not shown in the diff,
unfortunately. But if will be called when "data_valid && !data" is
false.

We will call the callback function "fn" with NULL as "data". The only
callback of this function is fsck_obj_buffer(), which does not touch
"data" at all if it's a blob.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsck.c   |  4 ++++
 pack-check.c     | 23 +++++++++++++++++++++--
 pack.h           |  1 +
 t/t1050-large.sh |  7 +++----
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 55eac75..b08bc8b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -356,6 +356,10 @@ static int fsck_sha1(const unsigned char *sha1)
 static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 			   unsigned long size, void *buffer, int *eaten)
 {
+	/*
+	 * Note, buffer may be NULL if type is OBJ_BLOB. See
+	 * verify_packfile(), data_valid variable for details.
+	 */
 	struct object *obj;
 	obj = parse_object_buffer(sha1, type, size, buffer, eaten);
 	if (!obj) {
diff --git a/pack-check.c b/pack-check.c
index 1da89a4..d123846 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -105,6 +105,8 @@ static int verify_packfile(struct packed_git *p,
 		void *data;
 		enum object_type type;
 		unsigned long size;
+		off_t curpos;
+		int data_valid;
 
 		if (p->index_version > 1) {
 			off_t offset = entries[i].offset;
@@ -116,8 +118,25 @@ static int verify_packfile(struct packed_git *p,
 					    sha1_to_hex(entries[i].sha1),
 					    p->pack_name, (uintmax_t)offset);
 		}
-		data = unpack_entry(p, entries[i].offset, &type, &size);
-		if (!data)
+
+		curpos = entries[i].offset;
+		type = unpack_object_header(p, w_curs, &curpos, &size);
+		unuse_pack(w_curs);
+
+		if (type == OBJ_BLOB && big_file_threshold <= size) {
+			/*
+			 * Let check_sha1_signature() check it with
+			 * the streaming interface; no point slurping
+			 * the data in-core only to discard.
+			 */
+			data = NULL;
+			data_valid = 0;
+		} else {
+			data = unpack_entry(p, entries[i].offset, &type, &size);
+			data_valid = 1;
+		}
+
+		if (data_valid && !data)
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    sha1_to_hex(entries[i].sha1), p->pack_name,
 				    (uintmax_t)entries[i].offset);
diff --git a/pack.h b/pack.h
index 3223f5a..0e77429 100644
--- a/pack.h
+++ b/pack.h
@@ -74,6 +74,7 @@ struct pack_idx_entry {
 
 
 struct progress;
+/* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const unsigned char*, enum object_type, unsigned long, void*, int*);
 
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index f9f3d13..096dbff 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -177,10 +177,9 @@ test_expect_success 'zip achiving, deflate' '
 	git archive --format=zip HEAD >/dev/null
 '
 
-test_expect_success 'fsck' '
-	test_must_fail git fsck 2>err &&
-	n=$(grep "error: attempting to allocate .* over limit" err | wc -l) &&
-	test "$n" -gt 1
+test_expect_success 'fsck large blobs' '
+	git fsck 2>err &&
+	test_must_be_empty err
 '
 
 test_done
-- 
2.9.1.564.gb2f7278

