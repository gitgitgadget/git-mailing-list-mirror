Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87573C4741F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D05B207FB
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcOxOYRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbgJAQLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbgJAQLL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 12:11:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45289C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 09:11:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id x23so3507819wmi.3
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=prcDUC8JV55zjJaV/rL/wm/pmkvP4WpTGOW4PGncbzE=;
        b=DcOxOYRnhWfF4GnrtMumHpqnH7Bvv0EB0dWwa0nVQog1nXmq4x4yq3eYx/hRo6K1fA
         cc91/T7W5sGLFfSh25YqtZ9w0O+zkUSUh0T39hoHR8/NRJuEKMedBWSlEgoA7ur9vTam
         i5JWueo27G9RIyzYhbCoKKMIhzQosdvnI1ocIPviY3A3CruKO175/JfRGaesKjruJOSP
         dqlMs723p8xT4PkkYUkchIVzJJNFq8s0BZf5KBX+5uvpfF/1TLq3XLHDzy52ImqyF1Ux
         R5Rfa9WcdGfy+exFd7IC5SZ+ii7O1bDwHrI3NQyZs2pFar2be5YvACR2rCez6kk8rgnQ
         hglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=prcDUC8JV55zjJaV/rL/wm/pmkvP4WpTGOW4PGncbzE=;
        b=cr70mOnViSkQv0n67SYIfg46LkVZ0xgkR0IcztopitwTk8uRGWvKdEL4uuBkWcpiVu
         kEprBNVloJmPylsLNDft4ms1uTzojxphDf3WTByP4aHaUq3oImRaDCV28lHugEhvFhaI
         SEb64G07o5v9vMKwCPGfEHs6SDb95trUJVqKl22l9nv0ti3Fn31F+hji1GZn2kfAsTbn
         u2HM/uBQpYzk6wgzIoIvfflDqlFVgpct5v2nhj6kszmlK8JS+w5+j7gP1xy0Qy6qP0Uy
         wGmHcoWAqvVxjK8ZUlDlR4CLYVxCzCo0eD0trYZBY97jSZd+Emf+mu+03j0xrt/H8aBt
         G+ZA==
X-Gm-Message-State: AOAM533hrSZ/J6xXjOzPapelhidYF+SrNNv2bh2b7fHmgDjgX/CdsRA6
        BBp1V/qFbUhvuGMtwyQP8C+1GChclA4=
X-Google-Smtp-Source: ABdhPJxKgSjksIj4vNk3F1J6J6qahsINf4l0sJtl6RlrHWgHvkdH3yx44XEdx92cuKjw6BcxfkXAeQ==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr789594wmb.22.1601568669667;
        Thu, 01 Oct 2020 09:11:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c25sm569121wml.31.2020.10.01.09.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 09:11:09 -0700 (PDT)
Message-Id: <b94c5f5c6120347fd97bcc2dcc187fc86a802dff.1601568663.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 16:10:54 +0000
Subject: [PATCH v2 04/13] reftable: add a barebones unittest framework
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/test_framework.c | 68 +++++++++++++++++++++++++++++++++++++++
 reftable/test_framework.h | 59 +++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h

diff --git a/reftable/test_framework.c b/reftable/test_framework.c
new file mode 100644
index 0000000000..8d718f2f06
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
+static struct test_case **test_cases;
+static int test_case_len;
+static int test_case_cap;
+
+static struct test_case *new_test_case(const char *name, void (*testfunc)(void))
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
+	test_cases = NULL;
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
index 0000000000..f0a208e880
--- /dev/null
+++ b/reftable/test_framework.h
@@ -0,0 +1,59 @@
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
+struct test_case *add_test_case(const char *name, void (*testfunc)(void));
+int test_main(int argc, const char *argv[]);
+
+void set_test_hash(uint8_t *p, int i);
+
+#endif
-- 
gitgitgadget

