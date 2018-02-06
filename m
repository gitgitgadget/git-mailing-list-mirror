Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371A41F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeBFAT5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:19:57 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45953 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbeBFATz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:19:55 -0500
Received: by mail-pg0-f67.google.com with SMTP id m136so146265pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TwXGlte8XCmMPo5skjTPs9DdsDrGDChrmWOKGNKS/0A=;
        b=gSdvWwCphs162h3Zsaz7CfoDY4OODdZh6cvah3uzd+ZjgyGVSmDwGufrVdriqvTxtg
         xoNW57CGHZBpSb007BO99K+5ct7jswj35ujJVrwa1iWjiUr9WG8FtbWS5Gi/cueRXiIM
         VA5uglEHJVkik97KiVBnnL6gukgl8Mbed9a+JEGQWex5nblKnc47D8x6T993ej+I/CX7
         5eOUKUK8xSNEXbfLdkeIYaStIU43jktCsbkMo64ybhvvdtKvP9V4ytpygBAXg8ivrlUX
         kK7f1YHWwp8AFukhRpLSnqv9hLgyBMCK06A1twqGRid7tXBVJeP8d8UXKQb8l/2/q1B+
         GWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TwXGlte8XCmMPo5skjTPs9DdsDrGDChrmWOKGNKS/0A=;
        b=ixHNcY8uzwDYmyigHN1ca79su8aN0n1wzudPY2YUX98YJHnoTUYNUpcOAkutFPqaZl
         lkMelX1HP4/0SLbHIujJW7EOz2Dnpg+ZOqvQExVpKRr+ePBr5hCeAqCZ89YtE0xokfKG
         GMbTEcvPRedLwTOW0UpvFguyVvZizztJPpn/FSoNb+siKGVNAXg+FJ7pu27ayOXkWi2H
         Nz67ox2g80vRDIVeQ2df7K2HaYIVytaOo/oPdC0/nbFNgnXyUN07OV4wKX1ASyaRNPfK
         ylw0xaiOENeXI5rSY5s8c131V690mtEIDZQO0T07jf07sSPGKSMvq5IPeT9nZ54bt4uI
         XhfA==
X-Gm-Message-State: APf1xPCSGWMbvqnU02G/9c0BmGB3ImkyzLHxEPHTwY3pLA/CfY+YEGkT
        X6z5As5WVUdTqfgSjrXysvCC8yGk99E=
X-Google-Smtp-Source: AH8x225UkN3mxsC9gc1kQEcezipKAoVo3rq1WMcT96c/vk0rhFWEDCA5OIa6JADR8hM6H5bohkqYww==
X-Received: by 10.99.116.19 with SMTP id p19mr438557pgc.49.1517876394604;
        Mon, 05 Feb 2018 16:19:54 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r27sm18792146pfj.75.2018.02.05.16.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:19:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 112/194] object-store: add repository argument to read_sha1_file_extended
Date:   Mon,  5 Feb 2018 16:16:27 -0800
Message-Id: <20180206001749.218943-14-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of read_sha1_file_extended
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 contrib/coccinelle/object_store.cocci | 10 ++++++++++
 object-store.h                        |  5 +++--
 sha1_file.c                           |  2 +-
 streaming.c                           |  3 ++-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/coccinelle/object_store.cocci b/contrib/coccinelle/object_store.cocci
index 6e6e5454da..915dd176dd 100644
--- a/contrib/coccinelle/object_store.cocci
+++ b/contrib/coccinelle/object_store.cocci
@@ -15,3 +15,13 @@ expression H;
  check_sha1_signature(
 +the_repository,
  E, F, G, H)
+
+@@
+expression E;
+expression F;
+expression G;
+expression H;
+@@
+ read_sha1_file_extended(
++the_repository,
+ E, F, G, H)
diff --git a/object-store.h b/object-store.h
index 178268a048..d6462cd9f1 100644
--- a/object-store.h
+++ b/object-store.h
@@ -82,12 +82,13 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-extern void *read_sha1_file_extended(const unsigned char *sha1,
+#define read_sha1_file_extended(r, s, t, sz, l) read_sha1_file_extended_##r(s, t, sz, l)
+extern void *read_sha1_file_extended_the_repository(const unsigned char *sha1,
 				     enum object_type *type,
 				     unsigned long *size, int lookup_replace);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
-	return read_sha1_file_extended(sha1, type, size, 1);
+	return read_sha1_file_extended(the_repository, sha1, type, size, 1);
 }
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
diff --git a/sha1_file.c b/sha1_file.c
index e62595e3e2..2d9a794654 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1357,7 +1357,7 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
  * deal with them should arrange to call read_object() and give error
  * messages themselves.
  */
-void *read_sha1_file_extended(const unsigned char *sha1,
+void *read_sha1_file_extended_the_repository(const unsigned char *sha1,
 			      enum object_type *type,
 			      unsigned long *size,
 			      int lookup_replace)
diff --git a/streaming.c b/streaming.c
index bc3c4811ca..f0ff5e7245 100644
--- a/streaming.c
+++ b/streaming.c
@@ -490,7 +490,8 @@ static struct stream_vtbl incore_vtbl = {
 
 static open_method_decl(incore)
 {
-	st->u.incore.buf = read_sha1_file_extended(sha1, type, &st->size, 0);
+	st->u.incore.buf = read_sha1_file_extended(the_repository, sha1,
+						   type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
 	st->vtbl = &incore_vtbl;
 
-- 
2.15.1.433.g936d1b9894.dirty

