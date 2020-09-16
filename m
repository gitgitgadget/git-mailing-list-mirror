Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08844C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB89220715
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Otinl67P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgIPTLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgIPTKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 15:10:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183EFC06178B
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z1so8045353wrt.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sqEF5Bkx+j3EkDuvP951Gp4kbx5z5ojmDXh+QKjUvbw=;
        b=Otinl67P6Mx1N4jcwEEiifzRUYsdhhe1P3tkkvk2zbYe+Q4moF3aCC8Uv5dqEMB7pU
         564E8dYUtXEvK6ansO0koZifmCp8GIN3mIiiSOw4J2C3ZlYM3kTM2gyeEzO3NYUrUIiJ
         PtBTjFTW+dw2bd5l3Ai40xwzDr7er2ZyRst2pQtPodb9Bx5tymHpseh1Mc0HTurl3qO/
         vIeRTFm3mK4w3I6MEwWVFAdwnnsKEK7F8RHCNiIH+HwPVIRkJsO9HXvZChnHjY2znTqR
         2gjZcorKwBinHb99jx2XECUp6e1ER4zkrukjFrVcsh7RAfaX1u30xTbg04yAvPk14r6u
         QA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sqEF5Bkx+j3EkDuvP951Gp4kbx5z5ojmDXh+QKjUvbw=;
        b=RLA1XzpSCkHdhxv8/DQi6wUgYKtTXUij67bcAHrMLocPT/dIVi9iJuMawl79Ga9+MZ
         YptePT0zIzrZ0H9q2brd1LLSgxSs+ARxCMEXlxP0FaQbkRWZmQFJjufaaDwjegO/yC3Y
         vfz4C4wTWpcJLmOH0IXmU4sJ1/QC2tZjrr/d7qHgLeSMsO2FV+eYcA7VFM+Uo5RpfNrM
         +E7F4JKvS1OLzABJLqQqyr3pMoqBNjH9lXTAc8GBpQ1aLTfichQsko00pIvlgUystE31
         QMjC7XWDi1FpSPeYzJDcZ4KyL8PgVJADK6Q0Grv9+wrMc43OwlFvfQm1tRYnzBBF0UvU
         8hGQ==
X-Gm-Message-State: AOAM531AbaXeofJMIJNH8684CaCUK+WdLioUiZ4VBd/HvwkH5xJqNG7e
        IRxKoSbTQxX7emDu6/j/6OOLDDaTlw0=
X-Google-Smtp-Source: ABdhPJwKut9cwRvWpkKUmoWhksqG6+zHFmukGvB9yNW36+/Vp9k/Puw2bnYZr7gZjJScwdZ9Gyrl4w==
X-Received: by 2002:adf:9027:: with SMTP id h36mr27893616wrh.259.1600283420588;
        Wed, 16 Sep 2020 12:10:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm33941813wrv.94.2020.09.16.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:10:20 -0700 (PDT)
Message-Id: <7bf59d491d75b72b4046661ec94c5e1d6a52047c.1600283416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 19:10:07 +0000
Subject: [PATCH 04/13] reftable: add a barebones unittest framework
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/test_framework.c | 68 +++++++++++++++++++++++++++++++++++++++
 reftable/test_framework.h | 60 ++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h

diff --git a/reftable/test_framework.c b/reftable/test_framework.c
new file mode 100644
index 0000000000..f304a2773a
--- /dev/null
+++ b/reftable/test_framework.c
@@ -0,0 +1,68 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "test_framework.h"
+
+#include "system.h"
+#include "basics.h"
+
+struct test_case **test_cases;
+int test_case_len;
+int test_case_cap;
+
+struct test_case *new_test_case(const char *name, void (*testfunc)(void))
+{
+	struct test_case *tc = reftable_malloc(sizeof(struct test_case));
+	tc->name = name;
+	tc->testfunc = testfunc;
+	return tc;
+}
+
+struct test_case *add_test_case(const char *name, void (*testfunc)(void))
+{
+	struct test_case *tc = new_test_case(name, testfunc);
+	if (test_case_len == test_case_cap) {
+		test_case_cap = 2 * test_case_cap + 1;
+		test_cases = reftable_realloc(
+			test_cases, sizeof(struct test_case) * test_case_cap);
+	}
+
+	test_cases[test_case_len++] = tc;
+	return tc;
+}
+
+int test_main(int argc, const char *argv[])
+{
+	const char *filter = NULL;
+	int i = 0;
+	if (argc > 1) {
+		filter = argv[1];
+	}
+
+	for (i = 0; i < test_case_len; i++) {
+		const char *name = test_cases[i]->name;
+		if (filter == NULL || strstr(name, filter) != NULL) {
+			printf("case %s\n", name);
+			test_cases[i]->testfunc();
+		} else {
+			printf("skip %s\n", name);
+		}
+
+		reftable_free(test_cases[i]);
+	}
+	reftable_free(test_cases);
+	test_cases = 0;
+	test_case_len = 0;
+	test_case_cap = 0;
+	return 0;
+}
+
+void set_test_hash(uint8_t *p, int i)
+{
+	memset(p, (uint8_t)i, hash_size(SHA1_ID));
+}
diff --git a/reftable/test_framework.h b/reftable/test_framework.h
new file mode 100644
index 0000000000..3c74d287aa
--- /dev/null
+++ b/reftable/test_framework.h
@@ -0,0 +1,60 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef TEST_FRAMEWORK_H
+#define TEST_FRAMEWORK_H
+
+#include "system.h"
+
+#ifdef NDEBUG
+#undef NDEBUG
+#endif
+
+#ifdef assert
+#undef assert
+#endif
+
+#define assert_err(c)                                                  \
+	if (c != 0) {                                                  \
+		fflush(stderr);                                        \
+		fflush(stdout);                                        \
+		fprintf(stderr, "%s: %d: error == %d (%s), want 0\n",  \
+			__FILE__, __LINE__, c, reftable_error_str(c)); \
+		abort();                                               \
+	}
+
+#define assert_streq(a, b)                                               \
+	if (strcmp(a, b)) {                                              \
+		fflush(stderr);                                          \
+		fflush(stdout);                                          \
+		fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, \
+			__LINE__, #a, a, #b, b);                         \
+		abort();                                                 \
+	}
+
+#define assert(c)                                                          \
+	if (!(c)) {                                                        \
+		fflush(stderr);                                            \
+		fflush(stdout);                                            \
+		fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
+			__LINE__, #c);                                     \
+		abort();                                                   \
+	}
+
+struct test_case {
+	const char *name;
+	void (*testfunc)(void);
+};
+
+struct test_case *new_test_case(const char *name, void (*testfunc)(void));
+struct test_case *add_test_case(const char *name, void (*testfunc)(void));
+int test_main(int argc, const char *argv[]);
+
+void set_test_hash(uint8_t *p, int i);
+
+#endif
-- 
gitgitgadget

