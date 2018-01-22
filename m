Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7D91F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeAVLFK (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:05:10 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46207 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeAVLFA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:05:00 -0500
Received: by mail-wm0-f66.google.com with SMTP id 143so15484372wma.5
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=09UBcZxKcosoHPD3uReQJufL0Hq5fDdpzmHnfyEyQHE=;
        b=mhf2OXxnIZU2CD5itmdE+ShgPqSJ0KrQeQjgDNZP+rPSQDwsV6RNKE7MyMMLG2BhT4
         +rPZ7LmwOpyiHNZV3DSoEyTt7h17f3BWcnj/OYdwk1Ugq626JAd0sRz0Pbf3oLmsfVjO
         qL1P3YstgMlZBDXfTbozXjC0DAizQmCJstWopls9eC74wRObcpcGpIseqGw5ChX14nQx
         zxv+Ece1JQilJtS81DEl52Hv27JfR26Ab9BsQ/Ws50+McF5dxG4vu//vj2tn4q+W82tB
         +oJ7zNY30SfbSAdtnutTPTtIKjkQ5kuGKPD6Ewr/b/0HDjLTRd+nja6sQssy83Eg8t/y
         JuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=09UBcZxKcosoHPD3uReQJufL0Hq5fDdpzmHnfyEyQHE=;
        b=iB/yJCI02Akhbk29gInkkzJHhHS/bdK+09FdoIaZ3wQ7lG9pYtmX8GRY6/p83EYzJ8
         j4/jMxYlf7lfen0rQQIsj2YzAALAbtO+AJBCOvZWdTEttS89s/mlCw8f8Sls1myLZo+h
         IoE6P+5j2b3hAgNHS9RcV2RqEKMe07pHevyNyO9IEjQgSamHgIyHFhbhlGqZ0VvT98DA
         W1xoeR9seWW4xriFpduR4VIC1NWGmovXjGA1wBaiiszLsw1ti2YSHCNcSaeCQrcQJXaf
         eHFqytGdgp9rw1z3fB4ji3ysctokzyspZB6FLRwmckAf4A7K8e+MuczYfvGl2byekWmb
         PiBg==
X-Gm-Message-State: AKwxytd5RcJhLyiVm1/kb47i3b7OiKUYHl2hrMC6rIs6haGAh6sBmmq/
        66IphQBKTPXz8YyEiF/B6BycIUs0
X-Google-Smtp-Source: AH8x226vvc5axivIfliOdUAwZQVxzJk09JZohnNSIbGSDc8gtU4eyg11xbDtJEFJlwdItZpcQM484A==
X-Received: by 10.80.185.37 with SMTP id m34mr7680607ede.214.1516619098446;
        Mon, 22 Jan 2018 03:04:58 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:57 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 13/14] sha1_file: convert write_loose_object to object_id
Date:   Mon, 22 Jan 2018 12:04:36 +0100
Message-Id: <20e13247611f128c58f1ce850e1a40a358d92e1a.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition and declaration of statis write_loose_object
function to struct object_id.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 sha1_file.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d9ee966d74..59238f5bea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1548,16 +1548,17 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
-static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
-			      const void *buf, unsigned long len, time_t mtime)
+static int write_loose_object(const struct object_id *oid, char *hdr,
+			      int hdrlen, const void *buf, unsigned long len,
+			      time_t mtime)
 {
 	int fd, ret;
 	unsigned char compressed[4096];
 	git_zstream stream;
 	git_SHA_CTX c;
-	unsigned char parano_sha1[20];
+	struct object_id parano_oid;
 	static struct strbuf tmp_file = STRBUF_INIT;
-	const char *filename = sha1_file_name(sha1);
+	const char *filename = sha1_file_name(oid->hash);
 
 	fd = create_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
@@ -1594,13 +1595,16 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	} while (ret == Z_OK);
 
 	if (ret != Z_STREAM_END)
-		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
+		die("unable to deflate new object %s (%d)", oid_to_hex(oid),
+		    ret);
 	ret = git_deflate_end_gently(&stream);
 	if (ret != Z_OK)
-		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
-	git_SHA1_Final(parano_sha1, &c);
-	if (hashcmp(sha1, parano_sha1) != 0)
-		die("confused by unstable object source data for %s", sha1_to_hex(sha1));
+		die("deflateEnd on object %s failed (%d)", oid_to_hex(oid),
+		    ret);
+	git_SHA1_Final(parano_oid.hash, &c);
+	if (oidcmp(oid, &parano_oid) != 0)
+		die("confused by unstable object source data for %s",
+		    oid_to_hex(oid));
 
 	close_sha1_file(fd);
 
@@ -1645,7 +1649,7 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
 	if (freshen_packed_object(oid->hash) || freshen_loose_object(oid->hash))
 		return 0;
-	return write_loose_object(oid->hash, hdr, hdrlen, buf, len, 0);
+	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
 }
 
 int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type,
@@ -1663,7 +1667,7 @@ int hash_sha1_file_literally(const void *buf, unsigned long len, const char *typ
 		goto cleanup;
 	if (freshen_packed_object(oid->hash) || freshen_loose_object(oid->hash))
 		goto cleanup;
-	status = write_loose_object(oid->hash, header, hdrlen, buf, len, 0);
+	status = write_loose_object(oid, header, hdrlen, buf, len, 0);
 
 cleanup:
 	free(header);
@@ -1685,7 +1689,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	if (!buf)
 		return error("cannot read sha1_file for %s", oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
-	ret = write_loose_object(oid->hash, hdr, hdrlen, buf, len, mtime);
+	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime);
 	free(buf);
 
 	return ret;
-- 
2.14.3

