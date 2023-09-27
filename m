Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0863DE82CCD
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjI0T4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjI0T4R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:17 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59E61B4
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:03 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79f915e5b47so408199439f.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844563; x=1696449363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr09Tj5ObzgTI5Xr9c8J1b1KKj4wL/brqhu1La2Ynvo=;
        b=YmcvESqGC24LRhq0SYTn1jbpA81q7dWX9Igr3PbyMQRA7UMQLeviDynHVOUGnRjEkJ
         +tPErGdpb6Plx+pMMpZf1uP1Hp+OxqxhJgqyV0AIJ+H3fPSFaOHD4dnDTciG1e5Ve28H
         O81iNmG05Rt9JloFvHDXBw00e+nL/5bnJwsS+G4LpQ7SN7XS+/8NL9B0OpMixDGKmGbs
         apLf6/zC3jVEHx9KNz45eaIog2fVyoIT1lwzTdoxCpRO13JOhxYMtRIlVMirYp8vuPAS
         MWvKcPXpAzL2/Teq8MmFSyIUsTzKJJ88Ya60elT5snWVJAEN5uI3HHbjrPeTgjQgUYfN
         uy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844563; x=1696449363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gr09Tj5ObzgTI5Xr9c8J1b1KKj4wL/brqhu1La2Ynvo=;
        b=Pz0kBpo7nPDAJtx1JC+EO/xbwO1kWVBFKlDG+VCQPYdGRlxvIJrbd4LuYzj2Ww/Imh
         QMGuJ9InWWuRXczZ3pkNqj+vI0KQoLxauXIeaJmQVRNi/R+eB3RTLKJFcAgiKhg7Jvjm
         bKG79L7CwJTi8LBvrIJNrnMykYEciuL2DT2pxpOlUDY1V6jLRirk+NnVPBgwrZ/onu6L
         z6kNSrR+8IG9+CH2GyQLyx3d3BfWixvaJAxoBaPqqD/q8NI+Xg+z7cYHAOqyAGWImBle
         wYyfpxUZn1LMJYpIYfBV15phXP2miqRVolIsImBxilVe2W/NQ/AJkMz0i6AVW2QlW+G4
         ZfRg==
X-Gm-Message-State: AOJu0YzYFZs3EA+vYA1Xpmwc/zV0aMg/39NlPIO1TCQMBR88UV6MAlNi
        oxjnEDYRoHs003iGrvp2mo4=
X-Google-Smtp-Source: AGHT+IFt0BbfORI66Fs41244d3j2+XXr0kfajaWJO91AhSol9E7Jis2tFhjkrMEP/Jjw91SvI/XUhw==
X-Received: by 2002:a6b:d002:0:b0:792:9ace:f7ba with SMTP id x2-20020a6bd002000000b007929acef7bamr2691207ioa.11.1695844563203;
        Wed, 27 Sep 2023 12:56:03 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:02 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 17/30] object-file-convert: Don't leak when converting tag objects
Date:   Wed, 27 Sep 2023 14:55:24 -0500
Message-Id: <20230927195537.1682-17-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
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
index 777ae5b58036..822be9d0fdb8 100644
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

