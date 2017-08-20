Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C8420899
	for <e@80x24.org>; Sun, 20 Aug 2017 20:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbdHTUJr (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 16:09:47 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38276 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753257AbdHTUJm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 16:09:42 -0400
Received: by mail-lf0-f66.google.com with SMTP id y15so9171790lfd.5
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fRXcEqZLMhSrcWwdA+2ebX7f1kQrI/JvD2qlHSnEyao=;
        b=fMmQ+SpEHRsVFqW8IukwvtznplJQy0h8JXp6rNv6UOwU8Ux6bzDEGP7AFI3g3G+VJX
         ePt2a6TEg9q7BsEnpSbkc1+jn0kJ+w2ykNt4WQkEe8T2On9y7IJr1nww3gZRdLvsgDwS
         H6r/aLonrO7aXwMUO7CTwpdVTxnmJ1VmP885Ki8P5nvzMYGY9Od0yq0Z3f9VLtt3mtSQ
         /mDbKbOyetYUeyO/+ZewSBalOqNTszWq1Jp82AvpushC3lyBfXEdTnM+7FjSjCuYE4xZ
         9ZD1gLyfhNgLojkLVe9l+MpJ8abedcxqwj+ZOKse4mgE45QD/0pLZBfwpBW3QuQbF1Xz
         6CRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=fRXcEqZLMhSrcWwdA+2ebX7f1kQrI/JvD2qlHSnEyao=;
        b=kuG0GUfiRktzvrTv1hHn9d5v6zDIZjbonim9uELq5Is0umEwgmv4PKuK43IaBp1s7U
         BsViES8SgsOxmh/+bgJP/OpCTzDdCt+3sA2vANF62ADl7C2BFQtW9G3oyv7BIzZ+BssK
         uO0RPMnkXwd+ZeK7bjlMmsOmoaCVk3O1zR01gTwidm3jtGehpU8GtbRjn+kG6UEFTvv3
         Qi6dk9+nbnns58d7rwNMtoGl0Z1u07v4kVHwTnsjZ2EhtS0kq+kttcIrnC/bpFTcpHJg
         ysTOpttoQktqKETdQZHhWX1TJwGS+Rp7HHlXUCbGnqLiYHMwtmzEl1Bt/sRpYL2j36rM
         4MPw==
X-Gm-Message-State: AHYfb5ht9T1uqSf9iyr9P19ztQEs+2t1hDl+7wlu4weycA5p1i0EdtEd
        Q0vc66OyNK0Y/hYj0NA=
X-Received: by 10.46.84.21 with SMTP id i21mr5429469ljb.150.1503259781216;
        Sun, 20 Aug 2017 13:09:41 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id a64sm928869lfl.36.2017.08.20.13.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2017 13:09:40 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 5/6] sha1_file: convert hash_sha1_file_literally to struct object_id
Date:   Sun, 20 Aug 2017 22:09:30 +0200
Message-Id: <0cbcf737983cd0a76269010f6a9028a03c8cac1d.1503258223.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503258223.git.patryk.obara@gmail.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all remaining callers as well.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 builtin/hash-object.c | 2 +-
 cache.h               | 2 +-
 sha1_file.c           | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 8a58ce0..c532ff9 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -24,7 +24,7 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
 	if (strbuf_read(&buf, fd, 4096) < 0)
 		ret = -1;
 	else
-		ret = hash_sha1_file_literally(buf.buf, buf.len, type, oid->hash, flags);
+		ret = hash_sha1_file_literally(buf.buf, buf.len, type, oid, flags);
 	strbuf_release(&buf);
 	return ret;
 }
diff --git a/cache.h b/cache.h
index eaf3603..237adb5 100644
--- a/cache.h
+++ b/cache.h
@@ -1199,7 +1199,7 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
-extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, unsigned char *sha1, unsigned flags);
+extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern int git_open_cloexec(const char *name, int flags);
diff --git a/sha1_file.c b/sha1_file.c
index 11995e5..3e2ef4e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3437,7 +3437,7 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 }
 
 int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type,
-			     unsigned char *sha1, unsigned flags)
+                             struct object_id *oid, unsigned flags)
 {
 	char *header;
 	int hdrlen, status = 0;
@@ -3445,13 +3445,13 @@ int hash_sha1_file_literally(const void *buf, unsigned long len, const char *typ
 	/* type string, SP, %lu of the length plus NUL must fit this */
 	hdrlen = strlen(type) + 32;
 	header = xmalloc(hdrlen);
-	write_sha1_file_prepare(buf, len, type, sha1, header, &hdrlen);
+	write_sha1_file_prepare(buf, len, type, oid->hash, header, &hdrlen);
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
-	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
+	if (freshen_packed_object(oid->hash) || freshen_loose_object(oid->hash))
 		goto cleanup;
-	status = write_loose_object(sha1, header, hdrlen, buf, len, 0);
+	status = write_loose_object(oid->hash, header, hdrlen, buf, len, 0);
 
 cleanup:
 	free(header);
-- 
2.9.5

