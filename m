Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E8AE784A9
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjJBClV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjJBClN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C2911B
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:55 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fd60f40ebso60583739f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214454; x=1696819254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kiMuJR1HWDeYcrEqgyukg8c+vv+20BE/y5lrSGyOzc=;
        b=hqI+EkHl6MU/910Phgthn+fFSLXlhmeQr2rUSkswgLI1zMvtZOejZiXePEAT4jV8Hk
         qFUyGnQC4DD8TVP+bs4AsTlynxMwjToad3rZa7bmZ3fMMy3v48UwBtGijm1EYnQGPMhw
         7NDvV49bt1371O0L0Q8hQ+/A74//In8wi2vnb7HfkkX4zZKYGT+Z6mKqdLX9Y7lO0qtv
         VJzkCvr4zTqSZzagZ20Q/Kd1ynqr3ZnnPReFzTBexYsvrbKp3PRrjW16Qdcv1Aa7phWr
         bV6lcFfsUSD0jEmHtJhY4gbbfshSykSgTEYZAHC7hEJXde0JoFN3S97Sx3FB2jcTeiRB
         qMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214454; x=1696819254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kiMuJR1HWDeYcrEqgyukg8c+vv+20BE/y5lrSGyOzc=;
        b=pTVWhvlwajIsWi3AlHzXLaNk0f1oADzrgOuoVFAc6Fcmp01XQL2hBHR6+BxYcQ4nAA
         euJMdu9trS+wPnaS76G6nIOvkncvErKGkJ+M0BZHUNpRncefHmoc8W4psJZK3BtJN/Ob
         ZuBzfdiJJGyzuCf74AsnYLRNdU+wG7aI1WmQKCUASjMUC4yaADh/G5SvTp6r4FDfz7cn
         qrermRlv0hjls+mOr8lsGCBgCNfP7rV0y7GgVT2xGjhOmXLb0BMN1IGWAC4jqJ/H08DV
         qR9DE6mwH85R0Ko3ub7RuKCHO8EIFpDuRgF20cPyJ78kZffj0Ywey3AhFfd83wHxltLb
         xn+Q==
X-Gm-Message-State: AOJu0YweomE050OMHB4lX7EtjBXmn+kvNi3JkT5mEodUiqWcxhCgG7BE
        bCjPSGyGnOaMEgpvkOryqOTctImU1noB8g==
X-Google-Smtp-Source: AGHT+IHSAnYDQOxoTJj8svwXvzGU7z3LwCjSF4UbN+5MtzI3Slv0syq/D4nEotb8asvJtWtwa2scAA==
X-Received: by 2002:a05:6602:1853:b0:787:8cf:fe82 with SMTP id d19-20020a056602185300b0078708cffe82mr8184374ioi.8.1696214454273;
        Sun, 01 Oct 2023 19:40:54 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:53 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 17/30] object-file-convert: don't leak when converting tag objects
Date:   Sun,  1 Oct 2023 21:40:21 -0500
Message-Id: <20231002024034.2611-17-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Upon close examination I discovered that while brian's code to convert
tag objects was functionally correct, it leaked memory.

Rearrange the code so that all error checking happens before any
memory is allocated.

Add code to release the temporary strbufs the code uses.

The code pretty much assumes the tag object ends with a newline,
so add an explict test to verify that is the case.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 object-file-convert.c | 45 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 089b68442de8..79e8e211ff95 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -90,44 +90,49 @@ static int convert_tag_object(struct strbuf *out,
 			      const struct git_hash_algo *to,
 			      const char *buffer, size_t size)
 {
-	struct strbuf payload = STRBUF_INIT, temp = STRBUF_INIT, oursig = STRBUF_INIT, othersig = STRBUF_INIT;
+	struct strbuf payload = STRBUF_INIT, oursig = STRBUF_INIT, othersig = STRBUF_INIT;
+	const int entry_len = from->hexsz + 7;
 	size_t payload_size;
 	struct object_id oid, mapped_oid;
 	const char *p;
 
-	/* Add some slop for longer signature header in the new algorithm. */
-	strbuf_grow(out, size + 7);
+	/* Consume the object line */
+	if ((entry_len >= size) ||
+	    memcmp(buffer, "object ", 7) || buffer[entry_len] != '\n')
+		return error("bogus tag object");
+	if (parse_oid_hex_algop(buffer + 7, &oid, &p, from) < 0)
+		return error("bad tag object ID");
+	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+		return error("unable to map tree %s in tag object",
+			     oid_to_hex(&oid));
+	size -= ((p + 1) - buffer);
+	buffer = p + 1;
 
 	/* Is there a signature for our algorithm? */
 	payload_size = parse_signed_buffer(buffer, size);
-	strbuf_add(&payload, buffer, payload_size);
 	if (payload_size != size) {
 		/* Yes, there is. */
 		strbuf_add(&oursig, buffer + payload_size, size - payload_size);
 	}
-	/* Now, is there a signature for the other algorithm? */
-	if (parse_buffer_signed_by_header(payload.buf, payload.len, &temp, &othersig, to)) {
-		/* Yes, there is. */
-		strbuf_swap(&payload, &temp);
-		strbuf_release(&temp);
-	}
 
+	/* Now, is there a signature for the other algorithm? */
+	parse_buffer_signed_by_header(buffer, payload_size, &payload, &othersig, to);
 	/*
 	 * Our payload is now in payload and we may have up to two signatrures
 	 * in oursig and othersig.
 	 */
-	if (strncmp(payload.buf, "object ", 7) || payload.buf[from->hexsz + 7] != '\n')
-		return error("bogus tag object");
-	if (parse_oid_hex_algop(payload.buf + 7, &oid, &p, from) < 0)
-		return error("bad tag object ID");
-	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
-		return error("unable to map tree %s in tag object",
-			     oid_to_hex(&oid));
-	strbuf_addf(out, "object %s", oid_to_hex(&mapped_oid));
-	strbuf_add(out, p, payload.len - (p - payload.buf));
-	strbuf_addbuf(out, &othersig);
+
+	/* Add some slop for longer signature header in the new algorithm. */
+	strbuf_grow(out, (7 + to->hexsz + 1) + size + 7);
+	strbuf_addf(out, "object %s\n", oid_to_hex(&mapped_oid));
+	strbuf_addbuf(out, &payload);
 	if (oursig.len)
 		add_header_signature(out, &oursig, from);
+	strbuf_addbuf(out, &othersig);
+
+	strbuf_release(&payload);
+	strbuf_release(&othersig);
+	strbuf_release(&oursig);
 	return 0;
 }
 
-- 
2.41.0

