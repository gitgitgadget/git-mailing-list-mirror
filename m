Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1831A208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbdHRWVr (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:47 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33938 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbdHRWU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:59 -0400
Received: by mail-pg0-f51.google.com with SMTP id n4so8534631pgn.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CkOK4zZTP3iCg9dNrZbjPSxK/rzKCWCmcckhSFCtswI=;
        b=ehFYEs4PBaMXm26Pja2yPWGfUSsVNRtPcx6uPJ0meiYe1Q0akDVDuUe+EUDNqZyQTm
         44aOYPnEWjRLz0UYsJJ1UOJonsj+AL47aDJU+jA+D3BEjL6Cx2Zb/M8K69N6QygecVE0
         7p15yh5BS/u2Ex5+6zLmHI1KgyHbqkz+gJuvq5LSO+u+K6aItDef4u17imA6tyZM1wh1
         GvQecTvwlkye4d6k9GQ5Xo7zwXw7v0WMIuD9lAaMZQX/+T3DNd4GxaS2rhTaGiSvZtpG
         ijt3P0qdnV2+cFCwE6nG7+EEJA6Ky0dpK+MTcdjcTDOXC338bnmSLFxDRT28srOeCqCy
         x+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CkOK4zZTP3iCg9dNrZbjPSxK/rzKCWCmcckhSFCtswI=;
        b=Q99tLaULLFFie+oaYsmcTS9lv/KY14amCFLvKeVpK/sGzfoLpl18HzozH/ooWq41lc
         0P7GiY/YaPMsnxzkN+exvFhMcfE6GL3TKdEyshrH5Odr6i6ahuqzknT3JoceC3vJuNpw
         4fLU0rp73J1D4qGz8dHogCL+kMSxWvXr7KQEfwdXqW1loStf9COdkNTdw/PIWXwEgs4/
         m5kzpEEzoF5LVAsopIkR0J9PdOWvjsl5vXeg7sDVF2g7i3LgQuvfC36GAFzX0q/He99r
         pjolSb9yhdP9och8pQHHjkW4i5LT0dMcRapDWNpZ2FyOow/LHLRYkVYKgikq2KCe9iOD
         uFFA==
X-Gm-Message-State: AHYfb5hMQDfxdwpMj51FnamzgxkX402dJVJH6moPmxoCayGBuXZxnq/c
        QUOhOphwmHSpoasZkGgNbg==
X-Received: by 10.84.198.1 with SMTP id o1mr11196861pld.33.1503094858553;
        Fri, 18 Aug 2017 15:20:58 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:58 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 12/23] pack: move unpack_object_header_buffer()
Date:   Fri, 18 Aug 2017 15:20:27 -0700
Message-Id: <111244f75a7df738c4e782269b7d35952f94546b.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  1 -
 packfile.c  | 25 +++++++++++++++++++++++++
 packfile.h  |  2 ++
 sha1_file.c | 25 -------------------------
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index 63765d481..75cc0c497 100644
--- a/cache.h
+++ b/cache.h
@@ -1669,7 +1669,6 @@ extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *)
 
 extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
diff --git a/packfile.c b/packfile.c
index 9cf462856..43b708812 100644
--- a/packfile.c
+++ b/packfile.c
@@ -884,3 +884,28 @@ void reprepare_packed_git(void)
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
diff --git a/packfile.h b/packfile.h
index 1cfda1d00..9f36e0112 100644
--- a/packfile.h
+++ b/packfile.h
@@ -62,6 +62,8 @@ extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
+extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+
 extern void release_pack_memory(size_t);
 
 extern int open_packed_git(struct packed_git *p);
diff --git a/sha1_file.c b/sha1_file.c
index 51bb4d1db..b999957b0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -914,31 +914,6 @@ void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
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
2.14.1.480.gb18f417b89-goog

