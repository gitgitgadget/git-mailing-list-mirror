Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129CCE82CCE
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjI0T4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjI0Tz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:55:58 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB63CC
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fce245bf6so234926339f.1
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844557; x=1696449357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifUaMY1sOh9/0SjHK+KXHM4A5XqXE/ubCaNK1KkvCYI=;
        b=HyBLyl9ffxGC3cXDAgRyphvZ6qAH2XS7We/AKUmyb4UchtWWC5s/M5akBxX5MsGc7W
         PUqmAJUGywJwdC0NsJh8mZ/cQf61Rlrf7mMsqhf745ywsJZBDs2EmvLpxoTSEp4kNba4
         ICuAK+qmtUrmfaaRax+xwSitg2J+ARWMxr/G64fKBWFAOhxEe8kGgOKrCNV6W3pStLEQ
         c6/3mDFuVy51bdhcEjhAAJK9+nekX6sVbz02lsiZrshvjSK5CBOkaAMR5IKBBmyrFUkk
         vTB9GP0eveJCDlH9QucF1pwe9obrpLpePDSdyIS2MvOnOCzp3kUoDFLY3TlDfHcZo3w9
         V4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844557; x=1696449357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifUaMY1sOh9/0SjHK+KXHM4A5XqXE/ubCaNK1KkvCYI=;
        b=SLZxrOxPpKgMV9JTUkUu4q7E0Dhc6lbPjGoMX3I6x9pVCyjkJeJyL7eipPhivc4MnY
         t+eQT5DqsfAVh7mz7PWyefHdlv8Xe2Uc7tvmVshLYt1gjdVYtFQ0ATvmhaFKXkbAswA7
         JRstb0Ur1+x58zX/zi4ae5+JhmsI0eY3yKfsw3GN3lXfWvKIRbGVBEAsjzftpBW2AZ3j
         YDNm+/9fIHny5Zztji1ClceKM6zW7Gho7XBjVEWELaSgtdZK4Lpl43NIRv+iJF/HUdgx
         4fzeklaHk7nn7OyoLQv162stivK27mLY3u5I9aKCfz0kHumZD5bF3bzXRXrl1VFksMBt
         LkPQ==
X-Gm-Message-State: AOJu0YxqNpohFT670bSUPClXisprpd9rywTJMRoRCREQUFqU7NfPQSzw
        7v5RbhrOH1IGWvZB51xwv/A=
X-Google-Smtp-Source: AGHT+IHU0aO3SA6xhsTKzmP1pHPUH/XoBeCqeJwiLxCyHoj4y39+B0ZKmbESboNOR+i+DK24BOZwig==
X-Received: by 2002:a6b:7a49:0:b0:79e:4abd:7be3 with SMTP id k9-20020a6b7a49000000b0079e4abd7be3mr3098403iop.15.1695844556878;
        Wed, 27 Sep 2023 12:55:56 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:56 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 08/30] object-file: Add a compat_oid_in parameter to write_object_file_flags
Date:   Wed, 27 Sep 2023 14:55:15 -0500
Message-Id: <20230927195537.1682-8-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

To create the proper signatures for commit objects both versions of
the commit object need to be generated and signed.  After that it is
a waste to throw away the work of generating the compatibility hash
so update write_object_file_flags to take a compatibility hash input
parameter that it can use to skip the work of generating the
compatability hash.

Update the places that don't generate the compatability hash to
pass NULL so it is easy to tell write_object_file_flags should
not attempt to use their compatability hash.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 cache-tree.c      | 2 +-
 object-file.c     | 6 ++++--
 object-store-ll.h | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 641427ed410a..ddc7d3d86959 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -448,7 +448,7 @@ static int update_one(struct cache_tree *it,
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &it->oid);
 	} else if (write_object_file_flags(buffer.buf, buffer.len, OBJ_TREE,
-					   &it->oid, flags & WRITE_TREE_SILENT
+					   &it->oid, NULL, flags & WRITE_TREE_SILENT
 					   ? HASH_SILENT : 0)) {
 		strbuf_release(&buffer);
 		return -1;
diff --git a/object-file.c b/object-file.c
index 4ad31f25c555..d66d11890696 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2235,7 +2235,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 
 int write_object_file_flags(const void *buf, unsigned long len,
 			    enum object_type type, struct object_id *oid,
-			    unsigned flags)
+			    struct object_id *compat_oid_in, unsigned flags)
 {
 	struct repository *repo = the_repository;
 	const struct git_hash_algo *algo = repo->hash_algo;
@@ -2246,7 +2246,9 @@ int write_object_file_flags(const void *buf, unsigned long len,
 
 	/* Generate compat_oid */
 	if (compat) {
-		if (type == OBJ_BLOB)
+		if (compat_oid_in)
+			oidcpy(&compat_oid, compat_oid_in);
+		else if (type == OBJ_BLOB)
 			hash_object_file(compat, buf, len, type, &compat_oid);
 		else {
 			struct strbuf converted = STRBUF_INIT;
diff --git a/object-store-ll.h b/object-store-ll.h
index bc76d6bec80d..c5f2bb2fc2fe 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -255,11 +255,11 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 
 int write_object_file_flags(const void *buf, unsigned long len,
 			    enum object_type type, struct object_id *oid,
-			    unsigned flags);
+			    struct object_id *comapt_oid_in, unsigned flags);
 static inline int write_object_file(const void *buf, unsigned long len,
 				    enum object_type type, struct object_id *oid)
 {
-	return write_object_file_flags(buf, len, type, oid, 0);
+	return write_object_file_flags(buf, len, type, oid, NULL, 0);
 }
 
 int write_object_file_literally(const void *buf, unsigned long len,
-- 
2.41.0

