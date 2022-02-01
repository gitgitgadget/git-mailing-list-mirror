Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E872BC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 14:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiBAOx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239501AbiBAOxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 09:53:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE13C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 06:53:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e8so32616670wrc.0
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOSYKHe2bixbR2/YPhWafApg2uOKVw0OfCGyhgqjn5o=;
        b=Ba918+ZlF4mhw30SCmHDeQV/GdqniXx85EghkLno9VYPjkLF/VvCVRq3bNvn5WxtVV
         kDpRBP9NTCIyuACpPN1bqg4X7/zHajG1li7r0+qpPovaqZQmqZvqAGdp9P9BiQGIv7fr
         I+KwWbQ1mkjm34Q48RLBTlYl6IbmCPqQn4tmq3FD3YP649XOzvkhNmXUhN1kEvAGnULN
         J+p6wZr12sA9hjHvjtCAfqGcy/y9e9eByRvlWFjY4j23IqJoEfk53TbizXY/EY+S6PqN
         ozouIOqZwAWf3xvC8NNdgLIOre1J909ZhFdI6IvvdtE/OuoWzKSTEutjoUh80S38Lq1u
         T6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOSYKHe2bixbR2/YPhWafApg2uOKVw0OfCGyhgqjn5o=;
        b=k5XsiCc/4y5/HSK2Cg2XwcsycMz3gOkjPcW/XiO8J8z7T3t+JH2CnO8JZS+Djv3iCy
         I172NJmaWHJd0PB5UWfA35MlBmiX967H9cm1uMZXWB7ysjvFaljaMie2vPPPPwPZTiS9
         3qFDarLncYGzZp3DZGhlSPD8VQRQBHIMf3j2Y1Sz7iErxTnysc0NrTA3nfeRzShlBLUG
         e5OI1p0nsTN8fPfv/D5J5s9CF/O99f8xdKVvPpM16c38M5yuMMvA3fHhe6XhFr8gClZ8
         wJeLNtKnWoAgoPK8rQgNvm2HHM+w6xITKCcArrnBEcQKG9Ug6xQu7aLPGm0Mkdpe1fS8
         JwHQ==
X-Gm-Message-State: AOAM532uC8qCUghwVI2CgsOcjT03TiII4zYV418kFPkEHDBzM7AS2+E8
        1mVb8p5lseQzbUDlIAB6vm3SIMb438s8lQ==
X-Google-Smtp-Source: ABdhPJwsnbH09kyfAOfnrq/v8iXq02p9KmgcwH+pkpOGuvzQcojiLA84as34RWEdiD8IoZL8Z1YD/w==
X-Received: by 2002:adf:d1c6:: with SMTP id b6mr9527093wrd.669.1643727203202;
        Tue, 01 Feb 2022 06:53:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg17sm2492054wmb.2.2022.02.01.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:53:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] object-file API: replace some use of check_object_signature()
Date:   Tue,  1 Feb 2022 15:53:08 +0100
Message-Id: <patch-06.10-2a065bf23da-20220201T144803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
In-Reply-To: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "hash_object_file_literally()" function to go with the existing
"hash_object_file()" function. This is currently a wrapper for its
sibling, but this change will allow us to change it to take an "enum
object_type" in a subsequent commit.

The only caller that wanted to pass a custom type to
"check_object_signature()" was the "git fsck" via its
"read_loose_object()", which is being changed here.

There was an existing hash_object_file_literally() which I'm renaming
to "hash_write_object_file_literally()", that function is only used
for "hash-object --literally". That renaming is being done because it
would be confusing to have a "hash_object_file_literally()" and a
"hash_object_file()" that do very different things.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/hash-object.c |  4 ++--
 object-file.c         | 18 +++++++++++++-----
 object-store.h        |  6 +++---
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index c7b3ad74c60..624e9e677fb 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -25,8 +25,8 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
 	if (strbuf_read(&buf, fd, 4096) < 0)
 		ret = -1;
 	else
-		ret = hash_object_file_literally(buf.buf, buf.len, type, oid,
-						 flags);
+		ret = hash_write_object_file_literally(buf.buf, buf.len, type, oid,
+						       flags);
 	strbuf_release(&buf);
 	return ret;
 }
diff --git a/object-file.c b/object-file.c
index 27d10112960..9fc959fa05d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1862,6 +1862,13 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
+static void hash_object_file_literally(const struct git_hash_algo *algo, const void *buf,
+				       unsigned long len, const char *type,
+				       struct object_id *oid)
+{
+	hash_object_file(algo, buf, len, type, oid);
+}
+
 int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
 			   unsigned long len, enum object_type type,
 			   const struct object_id *oid,
@@ -2043,9 +2050,9 @@ int write_object_file_flags(const void *buf, unsigned long len,
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
 }
 
-int hash_object_file_literally(const void *buf, unsigned long len,
-			       const char *type, struct object_id *oid,
-			       unsigned flags)
+int hash_write_object_file_literally(const void *buf, unsigned long len,
+				     const char *type, struct object_id *oid,
+				     unsigned flags)
 {
 	char *header;
 	int hdrlen, status = 0;
@@ -2630,9 +2637,10 @@ int read_loose_object(const char *path,
 			git_inflate_end(&stream);
 			goto out;
 		}
-		if (check_object_signature(the_repository, expected_oid,
+		hash_object_file_literally(the_repository->hash_algo,
 					   *contents, *size,
-					   oi->type_name->buf, real_oid))
+					   oi->type_name->buf, real_oid);
+		if (!oideq(expected_oid, real_oid))
 			goto out;
 	}
 
diff --git a/object-store.h b/object-store.h
index 95907062682..2ddc20b3304 100644
--- a/object-store.h
+++ b/object-store.h
@@ -272,9 +272,9 @@ static inline int write_object_file(const void *buf, unsigned long len,
 	return write_object_file_flags(buf, len, type, oid, 0);
 }
 
-int hash_object_file_literally(const void *buf, unsigned long len,
-			       const char *type, struct object_id *oid,
-			       unsigned flags);
+int hash_write_object_file_literally(const void *buf, unsigned long len,
+				     const char *type, struct object_id *oid,
+				     unsigned flags);
 
 /*
  * Add an object file to the in-memory object store, without writing it
-- 
2.35.0.913.g12b4baa2536

