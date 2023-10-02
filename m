Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601CEE784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjJBClT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjJBClB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:01 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D098106
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:54 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fa2dbd793so514412039f.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214453; x=1696819253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6Dj1s4v7nOhcXIwavrd7RvfOcT4mCe2pnrFxKbopgY=;
        b=dGKJopLXzAgawtfe/WbfMUJDO0AF/A77FcRRBvxO57IrRKj4rfJsnVnn4+jOGiIRPL
         Vcn+c416zyLEd39HKsrFGxYhKfIfFHxrTli7uKthOizBKNUTPSLXgWqoIQCTO67RYIBn
         KGLf6vdHH6JlGL2v8W9Ng6on2+N7xXer0QwsN3c9on1E/FGYhAyGkQfbK8npJYdEju4N
         aVg6pJsOkyDKN0sEhzPKyd8Zc8BZ6jndzoIXjtjrBUpfB1Iu8m1Ub9yCcbrp+B5/uw8B
         IqPJlyhklhUw5P69FmGEoLl3IM8ieGGDZLZPP1QtznK5MoKMkcSVxFPeVmdOz+xuFZx0
         SmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214453; x=1696819253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6Dj1s4v7nOhcXIwavrd7RvfOcT4mCe2pnrFxKbopgY=;
        b=CxDwWr5xIsGh9AnGPuvYMnCCsMtjL0TmYHJbpOktJ3Xpu/tmpa1OFxeJWZ2B7HEIHL
         goNlRbsVm2KRcKTYjWcR6Jk1yuShI8ANo3JGmWBZpV29HONVZTlJBwZBPSVEUXHJowM/
         OBKhd7s3u/G+dakuDNVokU8BDAxI0Wwv0dfqMi5RPQLwEsUIaH39ffCnYdd/+TDgjtfs
         taIB0UWJjbiTHPRILsFWWOev2z7T+MOvmpd+NY6FtQzmmZfMoyVw3sf+nJhKIBeKCqez
         /QbETe7EDtTSR8gg0gbPXYf3emLjMpFCnKxmbqZrhVAMuL2ADLu0q5J0PqykXlu+lRlE
         pVBQ==
X-Gm-Message-State: AOJu0Yx7rgX32eT+2krMDGQ/FHEWZR/72FpIQxpwboLeCcO57C/Dop/0
        MC0+Tf/PbkK2xJXZVfGKkAo=
X-Google-Smtp-Source: AGHT+IHx1W18fdnTYWWkDw+HLOZIkq7RSQzIKnRjQnOboCp3WlfZOC9jvIBUR2MTyebtxwrnQfDLvQ==
X-Received: by 2002:a6b:e005:0:b0:794:eaef:f43e with SMTP id z5-20020a6be005000000b00794eaeff43emr11436089iog.1.1696214453390;
        Sun, 01 Oct 2023 19:40:53 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:53 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 16/30] object-file-convert: convert tag objects when writing
Date:   Sun,  1 Oct 2023 21:40:20 -0500
Message-Id: <20231002024034.2611-16-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

When writing a tag object in a repository with both SHA-1 and SHA-256,
we'll need to convert our commit objects so that we can write the hash
values for both into the repository.  To do so, let's add a function to
convert tag objects.

Note that signatures for tag objects in the current algorithm trail the
message, and those for the alternate algorithm are in headers.
Therefore, we parse the tag object for both a trailing signature and a
header and then, when writing the other format, swap the two around.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 object-file-convert.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 70b80fb61e54..089b68442de8 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -7,6 +7,8 @@
 #include "hash.h"
 #include "object.h"
 #include "loose.h"
+#include "commit.h"
+#include "gpg-interface.h"
 #include "object-file-convert.h"
 
 int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
@@ -83,6 +85,52 @@ static int convert_tree_object(struct strbuf *out,
 	return 0;
 }
 
+static int convert_tag_object(struct strbuf *out,
+			      const struct git_hash_algo *from,
+			      const struct git_hash_algo *to,
+			      const char *buffer, size_t size)
+{
+	struct strbuf payload = STRBUF_INIT, temp = STRBUF_INIT, oursig = STRBUF_INIT, othersig = STRBUF_INIT;
+	size_t payload_size;
+	struct object_id oid, mapped_oid;
+	const char *p;
+
+	/* Add some slop for longer signature header in the new algorithm. */
+	strbuf_grow(out, size + 7);
+
+	/* Is there a signature for our algorithm? */
+	payload_size = parse_signed_buffer(buffer, size);
+	strbuf_add(&payload, buffer, payload_size);
+	if (payload_size != size) {
+		/* Yes, there is. */
+		strbuf_add(&oursig, buffer + payload_size, size - payload_size);
+	}
+	/* Now, is there a signature for the other algorithm? */
+	if (parse_buffer_signed_by_header(payload.buf, payload.len, &temp, &othersig, to)) {
+		/* Yes, there is. */
+		strbuf_swap(&payload, &temp);
+		strbuf_release(&temp);
+	}
+
+	/*
+	 * Our payload is now in payload and we may have up to two signatrures
+	 * in oursig and othersig.
+	 */
+	if (strncmp(payload.buf, "object ", 7) || payload.buf[from->hexsz + 7] != '\n')
+		return error("bogus tag object");
+	if (parse_oid_hex_algop(payload.buf + 7, &oid, &p, from) < 0)
+		return error("bad tag object ID");
+	if (repo_oid_to_algop(the_repository, &oid, to, &mapped_oid))
+		return error("unable to map tree %s in tag object",
+			     oid_to_hex(&oid));
+	strbuf_addf(out, "object %s", oid_to_hex(&mapped_oid));
+	strbuf_add(out, p, payload.len - (p - payload.buf));
+	strbuf_addbuf(out, &othersig);
+	if (oursig.len)
+		add_header_signature(out, &oursig, from);
+	return 0;
+}
+
 int convert_object_file(struct strbuf *outbuf,
 			const struct git_hash_algo *from,
 			const struct git_hash_algo *to,
@@ -100,8 +148,10 @@ int convert_object_file(struct strbuf *outbuf,
 	case OBJ_TREE:
 		ret = convert_tree_object(outbuf, from, to, buf, len);
 		break;
-	case OBJ_COMMIT:
 	case OBJ_TAG:
+		ret = convert_tag_object(outbuf, from, to, buf, len);
+		break;
+	case OBJ_COMMIT:
 	default:
 		/* Not implemented yet, so fail. */
 		ret = -1;
-- 
2.41.0

