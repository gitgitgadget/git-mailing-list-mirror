Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CF520899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbdHIBYC (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:24:02 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36891 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdHIBXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:16 -0400
Received: by mail-pg0-f53.google.com with SMTP id y129so21570193pgy.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DP+6Q7nW6HfIcq/ycB4GyAJiGEdp61yqIoFhtwoB+tU=;
        b=E88IegcYhGZaBoE6DTEfISPKTXyPirjn4nnto71XUwqRyEys2iTJLldX+CvV09Oyr2
         MxM0yOym/2q6wlA16lnjy5DyJ8tU+Fc4aM5mZn9J1cYlOgEs35QGpOlZXeRU9vxH1NzD
         7j2u4dZ0liBBbP6wssFjNgP1muV2t6DC2a3nqJyVRH45JJlwr5qGsQsmkORBv3DkdbHG
         dJIEHxtZ+V9goGZ5bYp2TIhnNnhHdiChduB1cm/D9+DNNlEKw/gBmXAmSCFadrmi+X8a
         n5x+TWmSRa7wAs/apsKS2VSOZE07GsOchKm9nCEnO8h0/aPNzST/UoG4ly7N2SwY0lMM
         V5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DP+6Q7nW6HfIcq/ycB4GyAJiGEdp61yqIoFhtwoB+tU=;
        b=Yy2ze7pNMwYdpbuiFQVINkNv3bSkqSHsSGYtPUxFWrmJQoQzxScbyBvcqZA0RV3olD
         QCeDrOVtCjxQ2ISNmLVhSth/oWeB6Mhk/aMnnesl+PCKiH1SOqaAzjOdQJoF9PeYnV0m
         ljnkBcGu+zM0lCJdTx8PflV24tbbIlyDVydganQ1Ge4UEJzg6+dnEDB/O7zCokOwGtz+
         IMJBdfogo+3tzzc0riEvMUwAsdHbFzIdY05LOCNovoGBf15GgvxgCxPd6dWXVpBa+zFG
         TbvBZw1rrNgGfS48IG3Trp5nuDS9L5oDQoiIzqiwjS/+xuFBHGAca0/1TGnbFiVNPdNI
         grPQ==
X-Gm-Message-State: AHYfb5hG6fmMmHzMAREoAISkF/GVq78YmUjkeVuysNudYmBQAin9CUyX
        W8Gqh4KfuAXRDhe56GUaww==
X-Received: by 10.98.223.68 with SMTP id u65mr6334720pfg.98.1502241796054;
        Tue, 08 Aug 2017 18:23:16 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:15 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 12/25] pack: move unpack_object_header()
Date:   Tue,  8 Aug 2017 18:22:44 -0700
Message-Id: <4816035341b9c2df538f755763fc0f4d89dce1b9.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  1 -
 pack.h      |  2 ++
 packfile.c  | 25 +++++++++++++++++++++++++
 sha1_file.c | 25 -------------------------
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index f020dfade..9c70759a6 100644
--- a/cache.h
+++ b/cache.h
@@ -1661,7 +1661,6 @@ extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *)
 
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
diff --git a/pack.h b/pack.h
index cad5ed488..4a7f88a38 100644
--- a/pack.h
+++ b/pack.h
@@ -167,4 +167,6 @@ extern void reprepare_packed_git(void);
  */
 unsigned long approximate_object_count(void);
 
+extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+
 #endif
diff --git a/packfile.c b/packfile.c
index a517172f7..6e4f1c6e3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -883,3 +883,28 @@ void reprepare_packed_git(void)
 	prepare_packed_git_run_once = 0;
 	prepare_packed_git();
 }
+
+unsigned long unpack_object_header_buffer(const unsigned char *buf,
+		unsigned long len, enum object_type *type, unsigned long *sizep)
+{
+	unsigned shift;
+	unsigned long size, c;
+	unsigned long used = 0;
+
+	c = buf[used++];
+	*type = (c >> 4) & 7;
+	size = c & 15;
+	shift = 4;
+	while (c & 0x80) {
+		if (len <= used || bitsizeof(long) <= shift) {
+			error("bad object header");
+			size = used = 0;
+			break;
+		}
+		c = buf[used++];
+		size += (c & 0x7f) << shift;
+		shift += 7;
+	}
+	*sizep = size;
+	return used;
+}
diff --git a/sha1_file.c b/sha1_file.c
index bbce60f1c..1f4b4ba2c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -913,31 +913,6 @@ void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 	return map_sha1_file_1(NULL, sha1, size);
 }
 
-unsigned long unpack_object_header_buffer(const unsigned char *buf,
-		unsigned long len, enum object_type *type, unsigned long *sizep)
-{
-	unsigned shift;
-	unsigned long size, c;
-	unsigned long used = 0;
-
-	c = buf[used++];
-	*type = (c >> 4) & 7;
-	size = c & 15;
-	shift = 4;
-	while (c & 0x80) {
-		if (len <= used || bitsizeof(long) <= shift) {
-			error("bad object header");
-			size = used = 0;
-			break;
-		}
-		c = buf[used++];
-		size += (c & 0x7f) << shift;
-		shift += 7;
-	}
-	*sizep = size;
-	return used;
-}
-
 static int unpack_sha1_short_header(git_zstream *stream,
 				    unsigned char *map, unsigned long mapsize,
 				    void *buffer, unsigned long bufsiz)
-- 
2.14.0.434.g98096fd7a8-goog

