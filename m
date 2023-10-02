Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0687DE784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbjJBCk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjJBCkv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:40:51 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B25E3
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79fa416b7ffso519952239f.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214447; x=1696819247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt5KEv9KVtgQEbQQg9gC/QBXXLffLz2k9RehcgzxHR8=;
        b=XkUlqTYJTwypwybwm2GSJ895fYSCifPLCrRUK0/6/n3yAVtDtSqMZq5PU6UVIHuPpu
         xw0Fu0YrWNlpX3/JxEAHTLUa+ibnSM8RFUAAc++96b9l4/S+jl3GT9+rfUQX1Oj6IAQI
         HfJ2oyAdCGyKnqgvNvtBEP2HbRnso7121dCU9J87t50GCncarkyFrvcb+9Rkll4Zc/Pj
         z0EFtFkOKa6m0ulLJpXIpvnkq8qUv1jtP4qUhM8M4lP7kVYYlIciWHqAFVddx52VRg3z
         mDo7zlvoQBtucvlWZFIxyr3z1Pzp/PGG1tzYXKsNBZ+D+vXsW1gmH1B1xfbH+LwBe5Zp
         2m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214447; x=1696819247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt5KEv9KVtgQEbQQg9gC/QBXXLffLz2k9RehcgzxHR8=;
        b=Mdu3/nYhdc1pAChpxDMYfSrdzPWbbiCgvRzuOzm+3TfXsuxa/eQt8asA089+WIXyUI
         Z/6EMWlTylkdV+TZTGtrnbmA6lQOJgAzcx6OXg6lE2pGSc+zYigvpCk/GRyVQ21R5mF/
         nJnoIbtiLfoa/yjIx3Azgtz2iE8WAtg/dSmWtOpvhfrY6+iAzEK2fRGWiE4HinbFki2E
         +LNmN3bBjrffDXlSSA2qqeHVOetXXRDa/oegdHK46dRcttwUlr8ciEi641ZoRZWh/Pht
         Ui55loy1Y9/h9lC5rpD+MhGVQgdtH4FbB53WqByCuoIt5sy9/eNev4jp0RgBmMqgfR4g
         ViDw==
X-Gm-Message-State: AOJu0Yx5ZUkDVDnKlBfQoDoKFaWLAqHAtfRS9A+mN0dHOJjezoHgQnGj
        3SSHcE68c94qM8uLO8Etbo0=
X-Google-Smtp-Source: AGHT+IEAUz9L+2YaVdcjE8wC3JlKClYb+PmL3chWUcqlFuZdNWE6lcdbpEA1TfipbxFYdAxVpkcdcw==
X-Received: by 2002:a6b:6618:0:b0:790:a010:4c42 with SMTP id a24-20020a6b6618000000b00790a0104c42mr10485046ioc.13.1696214446716;
        Sun, 01 Oct 2023 19:40:46 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:46 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 08/30] object-file: add a compat_oid_in parameter to write_object_file_flags
Date:   Sun,  1 Oct 2023 21:40:12 -0500
Message-Id: <20231002024034.2611-8-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
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
index 4e55f475b3b4..820810a5f4b3 100644
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

