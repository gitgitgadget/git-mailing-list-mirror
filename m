Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829E7E82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjI0Tz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0Tzy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:55:54 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B27B10E
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:52 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-79fca042ec0so242141839f.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844551; x=1696449351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOgoZtsJ9EsnKCpmBsoG93+BKGzH8VZ6zQpfUKUiUoY=;
        b=jiSighZQGZl/BV4RzURYZccU920bXzxt2rbY1VlATydozAk77Xv0hj8Q8qBXxn0OAF
         rsE/QQIkArghIIW7WaEXTMfrFzCKxRnRY7VA6kiMzScybY8kIMtAozLRJQyqFH3cMTR9
         1efjnplSWLF6YBx1su6f6//bsZ5Y3izTFw0ufyPbBTxQe02nBCq7y5T2ppu3w4zuh2BB
         ZifU7Uw8reK68RO+Khol+DUclBIt6xU9H56nzQPpkUvA/Tb3BuonAYZrizMt/y9ilBo4
         rZhi2/mxM0gpi0K3npkazvmOl1253bCFMZUBx9cWYGMNFCPfOLov1aSCXlGMWmcsQNz2
         zLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844551; x=1696449351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOgoZtsJ9EsnKCpmBsoG93+BKGzH8VZ6zQpfUKUiUoY=;
        b=mxlNJZTV55bt9OCCIV/96mKxFZ92LQ25ZvI2FtW6DsDPWC6pOIA3BQlAubTnjU5yif
         xD3ufx9ZpLyhdKOO/p/2yhWl0SApwnSMtKlWwo2TlU4MD4uRvjnhHkxNvP/ygzSbqPZW
         lkxVwY3+GKA4eAC52EXEwB19nuWo3MtDbmgj+XA2yQUWLrNCrrO8p49/XEgztlq4QtaZ
         jqfrOcArR2t6cc6kgAWiiP63Z/D3BRJ3/+hYNiWls+Z0DggX8wLw6AnEMHWOJOIkfe4Q
         JZrnfkMiv0BoCg/NzkSkz9fHmMUz9Tv+azlafbvHVyHyYUlS+3pdF9E23YMcWthjNyEC
         iyjQ==
X-Gm-Message-State: AOJu0YyKpAfaVGJFO+kDvy8wH4gnpA8myKpL+k667eQ1XrtQYGUM8aAM
        aWUDsEqDWsOrqHMJ8pWYuSdLr58Mlo9k3g==
X-Google-Smtp-Source: AGHT+IFxTMT0GqSJOfsHhgvqMSeLWW0Ec8grjyLWQdMrtEXSFnXDi+uSD9wZkZbmJ/zwfXj2KFE9aw==
X-Received: by 2002:a6b:fd05:0:b0:79f:ce11:c1b0 with SMTP id c5-20020a6bfd05000000b0079fce11c1b0mr3376613ioi.6.1695844551344;
        Wed, 27 Sep 2023 12:55:51 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:50 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 01/30] object-file-convert: Stubs for converting from one object format to another
Date:   Wed, 27 Sep 2023 14:55:08 -0500
Message-Id: <20230927195537.1682-1-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
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

  For blob objects there is no converstion to be done and it is an
  error to use this function on them.

  For commit, tree, and tag objects embedded oids are replaced by the
  oids of the objects they refer to with those objects and their
  object ids reencoded in with the hash algorithm "to".  Signatures
  are rearranged so that they remain valid after the object has
  been reencoded.

- repo_oid_to_algop which takes an oid that refers to an object file
  and returns the oid of the equavalent object file generated
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
index 000000000000..ba3e18f6af44
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
+	 * If the source alogirthm is not set, then we're using the
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
+		die("Refusing noop object file conversion");
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

