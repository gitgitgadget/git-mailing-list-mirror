Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39129CCA48A
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiGYUes (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiGYUen (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:34:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563C2251F
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z13so17568669wro.13
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5e3esZlfRS33aCkQSz7epEvmqoy81/tkXXzjsqBAWFA=;
        b=Sm6MMtJ6J1Jug2oUkEFZRqIUgzGbgpI/SfOZR7zfd+3U+yFA8OjEmqivEv5AhAV+IV
         MQj6wAa84W3LHIM0NveKyVgWVYcvdhdSbCZ7UBaUvKprW7wpQwvwek6yjnHI+kkww+ka
         j48DWl5eMr/1fu6mF+lyvMFy7Ka/4zLACUYRjtcFgDbZu1CCpEPKHmBujcsUPHAnz0Jl
         5m52Ywar3MAKOyXU/OSaZMzNpmlcj2CyoSerEfMEVWs8AXPQj+2JOFAqfPJmX3yxXTfJ
         mODKhslJfGkz9Xhq1euGT3i2QdQlfCT1Ri4phztTzghkHV95Zz35fZsgvqp0YH9iCF9E
         u7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5e3esZlfRS33aCkQSz7epEvmqoy81/tkXXzjsqBAWFA=;
        b=3uoXgiyxfxtbtb+RRchsD/gMtnwHPe30nXhNHysFl6qj8K51zN2Uxbc/eDZTEA13xg
         k0nX8CuFk5TE7s+ZdVOVuEDKcXu9kpI8PUQm6I6GlwjaGoqCukGjnbX+QXR6IfQBM4N/
         98pruzLiyUfoYuwBIMtW3f9T+HRyU0Vh97ovqX9sUradDSQOLKFWUclyYi7M7sC3PTnu
         50lzXvU6LhdMhGWLBT37evQsG7ZNbVZHw9BWJcTVo9TEKqBCWgHqcRW1D3cvUBRhk9/C
         bc3f5xhqAm9kJijvOwL+2gUO3Uxt3J7Sft2aU8w56Sd+lDuoxzaFHP6oVsf4OTpp7AMY
         VDEw==
X-Gm-Message-State: AJIora/kER/ohRcIcLoOoSX2LpiHy/hCAGx1iNZP7r09vYOMWFDtGINq
        rISuV2s3+zickoyGOZk30o86oOKXJHk=
X-Google-Smtp-Source: AGRyM1sVLpJ0Uc6L9zNGYAgLevQ6zGlnURVO6ZUHfHUBLexyTditW0qagTEDL36Bp7iIB+9f897LUQ==
X-Received: by 2002:adf:ee4b:0:b0:21e:8e1a:8f3c with SMTP id w11-20020adfee4b000000b0021e8e1a8f3cmr3119469wro.346.1658781280835;
        Mon, 25 Jul 2022 13:34:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c22c900b003a3270735besm15459002wmg.28.2022.07.25.13.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:34:40 -0700 (PDT)
Message-Id: <7d3159f0d9a29a04b5856982f787f4eddfb91b53.1658781277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jul 2022 20:34:34 +0000
Subject: [PATCH 2/5] bundle-uri: create basic file-copy logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Before implementing a way to fetch bundles into a repository, create the
basic logic. Assume that the URI is actually a file path. Future logic
will make this more careful to other protocols.

For now, we also only succeed if the content at the URI is a bundle
file, not a bundle list. Bundle lists will be implemented in a future
change.

Note that the discovery of a temporary filename is slightly racy because
the odb_mkstemp() relies on the temporary file not existing. With the
current implementation being limited to file copies, we could replace
the copy_file() with copy_fd(). The tricky part comes in future changes
that send the filename to 'git remote-https' and its 'get' capability.
At that point, we need the file descriptor closed _and_ the file
unlinked. If we were to keep the file descriptor open for the sake of
normal file copies, then we would pollute the rest of the code for
little benefit. This is especially the case because we expect that most
bundle URI use will be based on HTTPS instead of file copies.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Makefile     |   1 +
 bundle-uri.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++
 bundle-uri.h |  14 +++++++
 3 files changed, 119 insertions(+)
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h

diff --git a/Makefile b/Makefile
index 1624471badc..7d5f48069ea 100644
--- a/Makefile
+++ b/Makefile
@@ -906,6 +906,7 @@ LIB_OBJS += blob.o
 LIB_OBJS += bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
+LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
 LIB_OBJS += cbtree.o
diff --git a/bundle-uri.c b/bundle-uri.c
new file mode 100644
index 00000000000..b35babc36aa
--- /dev/null
+++ b/bundle-uri.c
@@ -0,0 +1,104 @@
+#include "cache.h"
+#include "bundle-uri.h"
+#include "bundle.h"
+#include "object-store.h"
+#include "refs.h"
+#include "run-command.h"
+
+static int find_temp_filename(struct strbuf *name)
+{
+	int fd;
+	/*
+	 * Find a temporary filename that is available. This is briefly
+	 * racy, but unlikely to collide.
+	 */
+	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
+	if (fd < 0) {
+		warning(_("failed to create temporary file"));
+		return -1;
+	}
+
+	close(fd);
+	unlink(name->buf);
+	return 0;
+}
+
+static int copy_uri_to_file(const char *file, const char *uri)
+{
+	/* File-based URIs only for now. */
+	return copy_file(file, uri, 0);
+}
+
+static int unbundle_from_file(struct repository *r, const char *file)
+{
+	int result = 0;
+	int bundle_fd;
+	struct bundle_header header = BUNDLE_HEADER_INIT;
+	struct string_list_item *refname;
+	struct strbuf bundle_ref = STRBUF_INIT;
+	size_t bundle_prefix_len;
+
+	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
+		return 1;
+
+	if ((result = unbundle(r, &header, bundle_fd, NULL)))
+		return 1;
+
+	/*
+	 * Convert all refs/heads/ from the bundle into refs/bundles/
+	 * in the local repository.
+	 */
+	strbuf_addstr(&bundle_ref, "refs/bundles/");
+	bundle_prefix_len = bundle_ref.len;
+
+	for_each_string_list_item(refname, &header.references) {
+		struct object_id *oid = refname->util;
+		struct object_id old_oid;
+		const char *branch_name;
+		int has_old;
+
+		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
+			continue;
+
+		strbuf_setlen(&bundle_ref, bundle_prefix_len);
+		strbuf_addstr(&bundle_ref, branch_name);
+
+		has_old = !read_ref(bundle_ref.buf, &old_oid);
+		update_ref("fetched bundle", bundle_ref.buf, oid,
+			   has_old ? &old_oid : NULL,
+			   REF_SKIP_OID_VERIFICATION,
+			   UPDATE_REFS_MSG_ON_ERR);
+	}
+
+	bundle_header_release(&header);
+	return result;
+}
+
+int fetch_bundle_uri(struct repository *r, const char *uri)
+{
+	int result = 0;
+	struct strbuf filename = STRBUF_INIT;
+
+	if ((result = find_temp_filename(&filename)))
+		goto cleanup;
+
+	if ((result = copy_uri_to_file(filename.buf, uri))) {
+		warning(_("failed to download bundle from URI '%s'"), uri);
+		goto cleanup;
+	}
+
+	if ((result = !is_bundle(filename.buf, 0))) {
+		warning(_("file at URI '%s' is not a bundle"), uri);
+		goto cleanup;
+	}
+
+	if ((result = unbundle_from_file(r, filename.buf))) {
+		warning(_("failed to unbundle bundle from URI '%s'"), uri);
+		goto cleanup;
+	}
+
+cleanup:
+	unlink(filename.buf);
+	strbuf_release(&filename);
+	return result;
+}
diff --git a/bundle-uri.h b/bundle-uri.h
new file mode 100644
index 00000000000..8a152f1ef14
--- /dev/null
+++ b/bundle-uri.h
@@ -0,0 +1,14 @@
+#ifndef BUNDLE_URI_H
+#define BUNDLE_URI_H
+
+struct repository;
+
+/**
+ * Fetch data from the given 'uri' and unbundle the bundle data found
+ * based on that information.
+ *
+ * Returns non-zero if no bundle information is found at the given 'uri'.
+ */
+int fetch_bundle_uri(struct repository *r, const char *uri);
+
+#endif
-- 
gitgitgadget

