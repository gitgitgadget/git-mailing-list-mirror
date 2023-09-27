Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277BEE82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjI0T4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjI0T4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:08 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EDB10E
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fe87cd74eso115130639f.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844562; x=1696449362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxSownEw2GFkZ4s2nCmQWhrw2EH8D8Q1mcAw7DgyobA=;
        b=mo1KVCBFifmnL0i4C5b9H0vGR7ZP/+krIkxDzzB2fRP195XLvKEZkfgSsf0dHYV85z
         cjKsdN7UQn2P9LqOgQ/8PXknXxEP7JQjwIeauC9hRXkTayWHAiZj5E1UJC/wSWm+NxSI
         f+0s+8z34PxmSQDkUapzPgOHvTzwGPRm51nzhjJ0jh7yaGZLHI+Vf+WrLFqQ64F1lu0S
         jeaRwXboiLO7PkilmDk9T23vbwUP5uvz53xGCRbq1JyrWYq2gQaHUrIY9z/qbwIz32lj
         J6fK7GthcQPP2fnr6Sq07d0ofulXWDe0Ou32LlisGl7KvQjpgn1eTQe/ZBf4eDRWFljf
         ETaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844562; x=1696449362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxSownEw2GFkZ4s2nCmQWhrw2EH8D8Q1mcAw7DgyobA=;
        b=CfW22o7EbbcyVYEByU7eOvzvtBzLvCgnKXEkFPwtIPoU4VvA45HpHnrrifNC1tr44C
         F2CctI4PpnIdOmu6lmRWwLZk6FYdcNMO9mqFKzKxpgVmVp9eviVS5OlvR80hHg1DhAbS
         +C2zicqu339oj7KTHfXvdTpdoZChRj+oxfpDkEjjqMKxNaZy1YXfMR/Vyhu2xTY8XkzS
         qScSzpJKKmZf4bVZJnIGUnDq+Xoeed6BaSZ/dYfo6Cqt7T5cq4lejNrNxGfI3z9URtYf
         ulPDoumwSvqUhvJ3avAOx4gOZ/mAS2siJihNn4GV38/LdWW2K7AEZQH0Mjt5yQx1gUQv
         L5LQ==
X-Gm-Message-State: AOJu0YyJBc646Th+Eklt/c/l3ME5qz2R27O0vj8fdQlMHzj0DDkzuwxc
        iZIKLkpEJfeHixfQ3JWf5W4=
X-Google-Smtp-Source: AGHT+IG4rywSWRMygJ5YmDaNpqHxWkild2bQhAJsJ7bfFt2NpZWbtQRRWMLj/VajUEXa+BxNG3HOUA==
X-Received: by 2002:a6b:dc0c:0:b0:791:2db5:c779 with SMTP id s12-20020a6bdc0c000000b007912db5c779mr3499970ioc.10.1695844562528;
        Wed, 27 Sep 2023 12:56:02 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:02 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH 16/30] object-file-convert: convert tag objects when writing
Date:   Wed, 27 Sep 2023 14:55:23 -0500
Message-Id: <20230927195537.1682-16-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
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
index a9e7a208a707..777ae5b58036 100644
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

