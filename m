Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4812AE784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjJBCko (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJBCkn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:40:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A2FA7
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:41 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fb78e297bso459760539f.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214441; x=1696819241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bBvs7TmTv1cZQ6idsEoGl4pr/Ceq6rO09b32kcUBoA=;
        b=cDeuT86x7svWrYywr2ZEV3HUrNm0LZ7Xh4FWnOcv8q9kGN5/pytdEr3QrK4841vRaR
         UjzwE6HuUyJgSpoNA2ts9MAOMiGj2dZAueFMW2h+j8MNoESfYj+t5dnPKigQL0lDcxZz
         BIWQJQrztLdrO9UQS5HaSAUINxJ8b0oTKZtfsoYc3ys6Z8vUS69gn96wGmLp4+Bdr/9U
         gHNBIHYsbFGnx7SsJw55htwjgnc1N8ZILxTXc0bxwp8cOJ3R2iOfCUNYLlLbv50CYNXC
         XLywIfXlioRSZAXAnotoaCCgTs6KN4JmgGxJDT2av/wpYAnfhSHtoQXGn9BPiZHZbbxR
         EROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214441; x=1696819241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bBvs7TmTv1cZQ6idsEoGl4pr/Ceq6rO09b32kcUBoA=;
        b=A2245FV8drSPBG7ygkAT2vVNUrV6i74rjo+sA8duFBZUsD8aM6tI+zMRcIGX+WXONP
         UCXrofPdAfXaij9LOVtMw00cKzAL2au1T5hYqGEIVvFVuZBaNaN02XR/9uSguW8rPrra
         efi2yX6lvIvQpZqAEUeyT7CG4EyczCgA/J0Z9oCyfZAkGIWymN6DerxCSkMw9Sfln5wk
         UoWzE+DHd5rjPNq3mS3ZlLDkVEPMx7CJXHWM1eYtJ1E/5Xydw0WutBLHCGWOUB73HGAT
         p/2RXKXDXgLXW2HKvxi2VBZXP0zAxLHXHl8j3KriLzfnKP2SDeMDo9Mr9jvIfsNl+v0U
         inFw==
X-Gm-Message-State: AOJu0YxyeJ6fiWr5TBS0dUFspp7RASl3LNgUsvDaF/A3qlT8n5odzscS
        Q4vtL3gFBc7xAwtVRRPurbM=
X-Google-Smtp-Source: AGHT+IGfFgc3Y05d1ydru92uqd4h/vIqckns3iJq3DqjLcBMc44aJtfuLDIJ2xAtE3ktcWHPgwlUFw==
X-Received: by 2002:a6b:e30d:0:b0:792:96e5:962 with SMTP id u13-20020a6be30d000000b0079296e50962mr10931833ioc.6.1696214440870;
        Sun, 01 Oct 2023 19:40:40 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:40 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 01/30] object-file-convert: stubs for converting from one object format to another
Date:   Sun,  1 Oct 2023 21:40:05 -0500
Message-Id: <20231002024034.2611-1-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Two basic functions are provided:
- convert_object_file Takes an object file it's type and hash algorithm
  and converts it into the equivalent object file that would
  have been generated with hash algorithm "to".

  For blob objects there is no conversation to be done and it is an
  error to use this function on them.

  For commit, tree, and tag objects embedded oids are replaced by the
  oids of the objects they refer to with those objects and their
  object ids reencoded in with the hash algorithm "to".  Signatures
  are rearranged so that they remain valid after the object has
  been reencoded.

- repo_oid_to_algop which takes an oid that refers to an object file
  and returns the oid of the equivalent object file generated
  with the target hash algorithm.

The pair of files object-file-convert.c and object-file-convert.h are
introduced to hold as much of this logic as possible to keep this
conversion logic cleanly separated from everything else and in the
hopes that someday the code will be clean enough git can support
compiling out support for sha1 and the various conversion functions.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Makefile              |  1 +
 object-file-convert.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 object-file-convert.h | 24 ++++++++++++++++++
 3 files changed, 82 insertions(+)
 create mode 100644 object-file-convert.c
 create mode 100644 object-file-convert.h

diff --git a/Makefile b/Makefile
index 577630936535..f7e824f25cda 100644
--- a/Makefile
+++ b/Makefile
@@ -1073,6 +1073,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += notes.o
+LIB_OBJS += object-file-convert.o
 LIB_OBJS += object-file.o
 LIB_OBJS += object-name.o
 LIB_OBJS += object.o
diff --git a/object-file-convert.c b/object-file-convert.c
new file mode 100644
index 000000000000..4777aba83636
--- /dev/null
+++ b/object-file-convert.c
@@ -0,0 +1,57 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "strbuf.h"
+#include "repository.h"
+#include "hash-ll.h"
+#include "object.h"
+#include "object-file-convert.h"
+
+int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
+		      const struct git_hash_algo *to, struct object_id *dest)
+{
+	/*
+	 * If the source algorithm is not set, then we're using the
+	 * default hash algorithm for that object.
+	 */
+	const struct git_hash_algo *from =
+		src->algo ? &hash_algos[src->algo] : repo->hash_algo;
+
+	if (from == to) {
+		if (src != dest)
+			oidcpy(dest, src);
+		return 0;
+	}
+	return -1;
+}
+
+int convert_object_file(struct strbuf *outbuf,
+			const struct git_hash_algo *from,
+			const struct git_hash_algo *to,
+			const void *buf, size_t len,
+			enum object_type type,
+			int gentle)
+{
+	int ret;
+
+	/* Don't call this function when no conversion is necessary */
+	if ((from == to) || (type == OBJ_BLOB))
+		BUG("Refusing noop object file conversion");
+
+	switch (type) {
+	case OBJ_COMMIT:
+	case OBJ_TREE:
+	case OBJ_TAG:
+	default:
+		/* Not implemented yet, so fail. */
+		ret = -1;
+		break;
+	}
+	if (!ret)
+		return 0;
+	if (gentle) {
+		strbuf_release(outbuf);
+		return ret;
+	}
+	die(_("Failed to convert object from %s to %s"),
+		from->name, to->name);
+}
diff --git a/object-file-convert.h b/object-file-convert.h
new file mode 100644
index 000000000000..a4f802aa8eea
--- /dev/null
+++ b/object-file-convert.h
@@ -0,0 +1,24 @@
+#ifndef OBJECT_CONVERT_H
+#define OBJECT_CONVERT_H
+
+struct repository;
+struct object_id;
+struct git_hash_algo;
+struct strbuf;
+#include "object.h"
+
+int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
+		      const struct git_hash_algo *to, struct object_id *dest);
+
+/*
+ * Convert an object file from one hash algorithm to another algorithm.
+ * Return -1 on failure, 0 on success.
+ */
+int convert_object_file(struct strbuf *outbuf,
+			const struct git_hash_algo *from,
+			const struct git_hash_algo *to,
+			const void *buf, size_t len,
+			enum object_type type,
+			int gentle);
+
+#endif /* OBJECT_CONVERT_H */
-- 
2.41.0

