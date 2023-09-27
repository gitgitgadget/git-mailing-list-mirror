Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106E1E82CCD
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjI0T41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjI0T4H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:07 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C321B1
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:02 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79fe6da0049so125355839f.1
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844562; x=1696449362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2xlBxGjJYJSOp2/X8A6tuYZr6hMyLXPzax8OFExRmc=;
        b=GgKzAEr32YuKh+QzJn75RgYNf8wiBwoy3nbWWtnJ2c7OM/OnC350Y1Gr9BenCcPGJL
         oajMdLnpyZoz21IEiajSzD5K9wO9lTAP4pUh1i1P8oAteBNC6YnylmsrmQJ2hHXHGUuR
         ByM0SIOB6TOcnPuNN4MB4sCkU82hktDsV8xvEus45oHUwuCK07LMPLne1J4/ffSCpTgh
         V7Hs1WWwRuRAzpDSiXGOD5L8oQP+zrX/75L4w4hT49TL/NuJx6ev5rhTMGMjQ0omqrKn
         +niurg/ScLHGyfPcKfZ8+mBsb8eGCj+7V0e2qvoXzt1Rz4bqISXIp2Xqsv+nCNfUEYsF
         XbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844562; x=1696449362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2xlBxGjJYJSOp2/X8A6tuYZr6hMyLXPzax8OFExRmc=;
        b=Q1Y8y5jK+YZ7zWKS0qLgNgyxfMYLknMWv/uKcJtq+BhMXGprZU8PZ/t6kzynIl4N8f
         2XqAD55sR7WTh2WXwkJSpgiKzTEqC1NIZKWGG4eMYHUugAQDQCpsaAY7qlN8oM2bPGUT
         8O3no/lH0WrMTPGpEP+LjdEpYdzQyKAiKJkli/24I5p1EckcyPFhDQewMKsl7XcYQWbQ
         TbiryRZ3zTV2KGwQo+/alKNI2UC0v99709+l7NHk5bW50MkSYwlIwIll/qq4hEGfXye9
         Ou9k/4dc+jz640AbDphgLNou5f/cKoPVTXL7UKGN+Iidz0YTFyx4C1ZQU+ubhu+mHr4E
         d7hA==
X-Gm-Message-State: AOJu0YwTK/degxjhLJphdEcSoXfYaJ5vuGhFdinq+bHGQkAxuRtCIbF7
        7wbXZ07/ljWsiPiusPPqOl8=
X-Google-Smtp-Source: AGHT+IGEveuUAoMV796UogOJ50zCOP0FRN8LZ2GudBqVX3cHjhRlxURL+VHPYr2poyOQtQj+dBKt6A==
X-Received: by 2002:a05:6602:2566:b0:79f:d4e6:5175 with SMTP id dj6-20020a056602256600b0079fd4e65175mr3237439iob.16.1695844561892;
        Wed, 27 Sep 2023 12:56:01 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:01 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH 15/30] object-file-convert: add a function to convert trees between algorithms
Date:   Wed, 27 Sep 2023 14:55:22 -0500
Message-Id: <20230927195537.1682-15-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

In the future, we're going to want to provide SHA-256 repositories that
have compatibility support for SHA-1 as well.  In order to do so, we'll
need to be able to convert tree objects from SHA-256 to SHA-1 by writing
a tree with each SHA-256 object ID mapped to a SHA-1 object ID.

We implement a function, convert_tree_object, that takes an existing
tree buffer and writes it to a new strbuf, converting between
algorithms.  Let's make this function generic, because while we only
need it to convert from the main algorithm to the compatibility
algorithm now, we may need to do the other way around in the future,
such as for transport.

We avoid reusing the code in decode_tree_entry because that code
normalizes data, and we don't want that here.  We want to produce a
complete round trip of data, so if, for example, the old entry had a
wrongly zero-padded mode, we'd want to preserve that when converting to
ensure a stable hash value.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 object-file-convert.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index 4d62ed192bf0..a9e7a208a707 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -1,8 +1,10 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "strbuf.h"
+#include "hex.h"
 #include "repository.h"
 #include "hash-ll.h"
+#include "hash.h"
 #include "object.h"
 #include "loose.h"
 #include "object-file-convert.h"
@@ -36,6 +38,51 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 	return 0;
 }
 
+static int decode_tree_entry_raw(struct object_id *oid, const char **path,
+				 size_t *len, const struct git_hash_algo *algo,
+				 const char *buf, unsigned long size)
+{
+	uint16_t mode;
+	const unsigned hashsz = algo->rawsz;
+
+	if (size < hashsz + 3 || buf[size - (hashsz + 1)]) {
+		return -1;
+	}
+
+	*path = parse_mode(buf, &mode);
+	if (!*path || !**path)
+		return -1;
+	*len = strlen(*path) + 1;
+
+	oidread_algop(oid, (const unsigned char *)*path + *len, algo);
+	return 0;
+}
+
+static int convert_tree_object(struct strbuf *out,
+			       const struct git_hash_algo *from,
+			       const struct git_hash_algo *to,
+			       const char *buffer, size_t size)
+{
+	const char *p = buffer, *end = buffer + size;
+
+	while (p < end) {
+		struct object_id entry_oid, mapped_oid;
+		const char *path = NULL;
+		size_t pathlen;
+
+		if (decode_tree_entry_raw(&entry_oid, &path, &pathlen, from, p,
+					  end - p))
+			return error(_("failed to decode tree entry"));
+		if (repo_oid_to_algop(the_repository, &entry_oid, to, &mapped_oid))
+			return error(_("failed to map tree entry for %s"), oid_to_hex(&entry_oid));
+		strbuf_add(out, p, path - p);
+		strbuf_add(out, path, pathlen);
+		strbuf_add(out, mapped_oid.hash, to->rawsz);
+		p = path + pathlen + from->rawsz;
+	}
+	return 0;
+}
+
 int convert_object_file(struct strbuf *outbuf,
 			const struct git_hash_algo *from,
 			const struct git_hash_algo *to,
@@ -50,8 +97,10 @@ int convert_object_file(struct strbuf *outbuf,
 		die("Refusing noop object file conversion");
 
 	switch (type) {
-	case OBJ_COMMIT:
 	case OBJ_TREE:
+		ret = convert_tree_object(outbuf, from, to, buf, len);
+		break;
+	case OBJ_COMMIT:
 	case OBJ_TAG:
 	default:
 		/* Not implemented yet, so fail. */
-- 
2.41.0

