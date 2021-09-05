Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC231C4332F
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51ED60F90
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhIEXws (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 19:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhIEXwr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 19:52:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2B5C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 16:51:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n14-20020a05600c3b8e00b002f8bd2f8ab6so406899wms.5
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 16:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u7Sh4RLFgZpb/PEvnkzFvuVfowghuBsscb1kvOHawd8=;
        b=KZnTiyksqeYBggyy4iweZ+NqaJSIrOR1xjCuDQ4P98zTbY9TvByuapQTd8mDchIlCi
         S7uNuRIenHtrpF6OvCMDs9Skp53yYcCdMlG6GiOxnyxhFmeqgftBz7HIihCanOPm/lgf
         o5ppKcEEYYC9724Dh/teg7xSEKcyztOaZDapQA29DyOGukE1kYtQAf4Qi0lbZNPqq4gh
         Ys/DRKYIh2IKmXLDW1tJzseS2KY2POGgqPUQUVi0j53Y0ROp6x0pGvMyjVDkNgYCLxYz
         jDQvCfgECSomsxnlg2GVj8h7UAFKJXdgjO2st9t+qOTkHfthDZa/zKGjRkhJTDD8vhl9
         c5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u7Sh4RLFgZpb/PEvnkzFvuVfowghuBsscb1kvOHawd8=;
        b=UST3qaXsPacWbHkAPm5iSraqP5K3yMA8CYAnSWKpwMVWVQaqbgtyG1nE4duSxUpHlS
         HOqvQbpzYWpJz9GbNZpcUBPsO4L4QL0bqQ1cOX2rl3hVwDyz6B0PapzLCo1Ufzwt3kCm
         w2cnOJ8z72dEd2B1C1EOEQOebc61gntCWva1l2OyabyKs3UpXjuS/ImQFb5T3jOfHLio
         d4KKcZMU3kCEm7368L6dorO1fMrLr5mft2ldQzBgIVE14nbKIrB6tnxoGu2m9CMhzaGT
         GBIEI0vTJpwvsq0OYjQe8Dv0LVMl7jiF8I4/55btlWbsQdRn4K4Grm5uKU2Ll3O5XZF4
         j3Ig==
X-Gm-Message-State: AOAM530hT//lMHnW/QAgpOG9bxAqAmHhWsMbe32ZJkfHu1mSXpkPNvSX
        LCb7vtHlMBb4w+pjYr/xsYOBoNMb+c0=
X-Google-Smtp-Source: ABdhPJy8PAOazhCmrx6lcNhmptPctLvdQiNv6fHhUpsYqKA/9EEJO+VU/T52Fb3ofzxE1HX051A3dg==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr8819642wmb.59.1630885902678;
        Sun, 05 Sep 2021 16:51:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm7449785wrb.36.2021.09.05.16.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 16:51:42 -0700 (PDT)
Message-Id: <8e0d11ea53a080e8212768f370fb8f05eaded312.1630885899.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
References: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
From:   "Andrew Olsen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Sep 2021 23:51:38 +0000
Subject: [PATCH 3/4] Sample list-object-filter extensions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrew Olsen <andrew232@gmail.com>,
        Andrew Olsen <andrew.olsen@koordinates.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrew Olsen <andrew.olsen@koordinates.com>

Basic filter extension example which filters to a random subset of
blobs, and another example which shows how to do the same in C++ and
how to link in another library required by a filter extension.
Documentation changes follow.

Signed-off-by: Andrew Olsen <andrew.olsen@koordinates.com>
---
 contrib/filter-extensions/rand/.gitignore     |   2 +
 contrib/filter-extensions/rand/Makefile       |  28 +++++
 contrib/filter-extensions/rand/rand.c         | 103 ++++++++++++++++++
 contrib/filter-extensions/rand_cpp/.gitignore |   2 +
 contrib/filter-extensions/rand_cpp/Makefile   |  34 ++++++
 .../rand_cpp/adapter_functions.c              |   6 +
 .../rand_cpp/adapter_functions.h              |  10 ++
 contrib/filter-extensions/rand_cpp/rand.cpp   | 103 ++++++++++++++++++
 8 files changed, 288 insertions(+)
 create mode 100644 contrib/filter-extensions/rand/.gitignore
 create mode 100644 contrib/filter-extensions/rand/Makefile
 create mode 100644 contrib/filter-extensions/rand/rand.c
 create mode 100644 contrib/filter-extensions/rand_cpp/.gitignore
 create mode 100644 contrib/filter-extensions/rand_cpp/Makefile
 create mode 100644 contrib/filter-extensions/rand_cpp/adapter_functions.c
 create mode 100644 contrib/filter-extensions/rand_cpp/adapter_functions.h
 create mode 100644 contrib/filter-extensions/rand_cpp/rand.cpp

diff --git a/contrib/filter-extensions/rand/.gitignore b/contrib/filter-extensions/rand/.gitignore
new file mode 100644
index 00000000000..9eca6c88cf2
--- /dev/null
+++ b/contrib/filter-extensions/rand/.gitignore
@@ -0,0 +1,2 @@
+*.a
+*.o
diff --git a/contrib/filter-extensions/rand/Makefile b/contrib/filter-extensions/rand/Makefile
new file mode 100644
index 00000000000..267221ee952
--- /dev/null
+++ b/contrib/filter-extensions/rand/Makefile
@@ -0,0 +1,28 @@
+# Run this via `FILTER_EXTENSIONS=contrib/filter-extensions/rand/rand.a make`
+# from the main git directory. That way we inherit useful variables.
+
+ifneq ($(findstring s,$(MAKEFLAGS)),s)
+ifndef V
+	QUIET_CC       = @echo '   ' CC $@;
+	QUIET_AR       = @echo '   ' AR $@;
+endif
+endif
+
+FILTER_STATIC_LIB = rand.a
+
+all: $(FILTER_STATIC_LIB)
+ifeq ($(MAKELEVEL),0)
+	$(error "Run via parent git make")
+endif
+	@:
+
+$(FILTER_STATIC_LIB): rand.o
+	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
+
+rand.o: rand.c
+	$(QUIET_CC)$(CC) -c $(ALL_CFLAGS) $<
+
+clean:
+	$(RM) $(FILTER_STATIC_LIB) rand.o
+
+.PHONY: all clean
diff --git a/contrib/filter-extensions/rand/rand.c b/contrib/filter-extensions/rand/rand.c
new file mode 100644
index 00000000000..af153709345
--- /dev/null
+++ b/contrib/filter-extensions/rand/rand.c
@@ -0,0 +1,103 @@
+#include "../../../git-compat-util.h"
+#include "../../../list-objects-filter-extensions.h"
+#include "../../../object.h"
+#include "../../../hash.h"
+#include "../../../trace.h"
+
+
+static struct trace_key trace_filter = TRACE_KEY_INIT(FILTER);
+
+struct rand_context {
+	int percentageMatch;
+	int matchCount;
+	int blobCount;
+	int treeCount;
+	uint64_t started_at;
+};
+
+static int rand_init(
+	const struct repository *r,
+	const char *filter_arg,
+	void **context)
+{
+	struct rand_context *ctx = calloc(1, sizeof(struct rand_context));
+
+	ctx->percentageMatch = atoi(filter_arg);
+	if (ctx->percentageMatch > 100 || ctx->percentageMatch < 0) {
+	fprintf(stderr, "filter-rand: warning: invalid match %%: %s\n",
+		filter_arg);
+	ctx->percentageMatch = 1;  // default 1%
+	}
+	fprintf(stderr, "filter-rand: matching %d%%\n", ctx->percentageMatch);
+	ctx->started_at = getnanotime();
+	(*context) = ctx;
+
+	return 0;
+}
+
+static enum list_objects_filter_result rand_filter_object(
+	const struct repository *r,
+	const enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	enum list_objects_filter_omit *omit,
+	void *context)
+{
+	struct rand_context *ctx = (struct rand_context*)(context);
+
+	if ((ctx->blobCount + ctx->treeCount + 1) % 100000 == 0) {
+		fprintf(stderr, "filter-rand: %d...\n",
+			(ctx->blobCount + ctx->treeCount + 1));
+	}
+
+	switch (filter_situation) {
+	default:
+		die("filter-rand: unknown filter_situation: %d", filter_situation);
+
+	case LOFS_BEGIN_TREE:
+		ctx->treeCount++;
+		/* always include all tree objects */
+		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
+	case LOFS_END_TREE:
+		return LOFR_ZERO;
+
+	case LOFS_BLOB:
+		ctx->blobCount++;
+
+		if ((rand() % 100) < ctx->percentageMatch) {
+			ctx->matchCount++;
+			trace_printf_key(&trace_filter,
+				"match: %s %s\n",
+				oid_to_hex(&obj->oid),
+				pathname
+			);
+			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+		} else {
+			*omit = LOFO_OMIT;
+			return LOFR_MARK_SEEN; /* hard omit */
+		}
+	}
+}
+
+static void rand_free(const struct repository *r, void *context)
+{
+	struct rand_context *ctx = (struct rand_context*)(context);
+	double elapsed = (getnanotime() - ctx->started_at)/1E9;
+	int count = ctx->blobCount + ctx->treeCount;
+
+	fprintf(stderr, "filter-rand: done: count=%d (blob=%d tree=%d) "
+		"matched=%d elapsed=%fs rate=%0.1f/s average=%0.1fus\n",
+		count, ctx->blobCount, ctx->treeCount, ctx->matchCount,
+		elapsed, count/elapsed, elapsed/count*1E6);
+
+	free(ctx);
+}
+
+const struct filter_extension filter_extension_rand = {
+	"rand",
+	&rand_init,
+	&rand_filter_object,
+	&rand_free,
+};
diff --git a/contrib/filter-extensions/rand_cpp/.gitignore b/contrib/filter-extensions/rand_cpp/.gitignore
new file mode 100644
index 00000000000..9eca6c88cf2
--- /dev/null
+++ b/contrib/filter-extensions/rand_cpp/.gitignore
@@ -0,0 +1,2 @@
+*.a
+*.o
diff --git a/contrib/filter-extensions/rand_cpp/Makefile b/contrib/filter-extensions/rand_cpp/Makefile
new file mode 100644
index 00000000000..278121e3d5a
--- /dev/null
+++ b/contrib/filter-extensions/rand_cpp/Makefile
@@ -0,0 +1,34 @@
+# Run this via `FILTER_EXTENSIONS=contrib/filter-extensions/rand_cpp/rand_cpp.a make`
+# from the main git directory. That way we inherit useful variables.
+
+ifneq ($(findstring s,$(MAKEFLAGS)),s)
+ifndef V
+	QUIET_CC       = @echo '   ' CC $@;
+	QUIET_CXX       = @echo '   ' CXX $@;
+	QUIET_AR       = @echo '   ' AR $@;
+endif
+endif
+
+FILTER_STATIC_LIB = rand_cpp.a
+
+ALL_CXXFLAGS += -std=c++11
+
+all: $(FILTER_STATIC_LIB)
+ifeq ($(MAKELEVEL),0)
+	$(error "Run via parent git make")
+endif
+	@:
+
+$(FILTER_STATIC_LIB): rand.o adapter_functions.o
+	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
+
+rand.o: rand.cpp
+	$(QUIET_CXX)$(CXX) -c $(ALL_CFLAGS) $(ALL_CXXFLAGS) $<
+
+adapter_functions.o: adapter_functions.c
+	$(QUIET_CC)$(CC) -c $(ALL_CFLAGS) $<
+
+clean:
+	$(RM) $(FILTER_STATIC_LIB) rand.o
+
+.PHONY: all clean
diff --git a/contrib/filter-extensions/rand_cpp/adapter_functions.c b/contrib/filter-extensions/rand_cpp/adapter_functions.c
new file mode 100644
index 00000000000..0d9d2a2aa96
--- /dev/null
+++ b/contrib/filter-extensions/rand_cpp/adapter_functions.c
@@ -0,0 +1,6 @@
+#include "../../../git-compat-util.h"
+#include "../../../object.h"
+
+char *obj_to_hex_oid(struct object *obj) {
+    return oid_to_hex(&obj->oid);
+}
diff --git a/contrib/filter-extensions/rand_cpp/adapter_functions.h b/contrib/filter-extensions/rand_cpp/adapter_functions.h
new file mode 100644
index 00000000000..1150c21a258
--- /dev/null
+++ b/contrib/filter-extensions/rand_cpp/adapter_functions.h
@@ -0,0 +1,10 @@
+#ifndef RAND_CPP_ADAPTER_FUNCTIONS_H
+#define RAND_CPP_ADAPTER_FUNCTIONS_H
+
+struct object;
+
+uint64_t getnanotime(void);
+
+char *obj_to_hex_oid(struct object *obj);
+
+#endif /* RAND_CPP_ADAPTER_FUNCTIONS_H */
diff --git a/contrib/filter-extensions/rand_cpp/rand.cpp b/contrib/filter-extensions/rand_cpp/rand.cpp
new file mode 100644
index 00000000000..cb608d14ed9
--- /dev/null
+++ b/contrib/filter-extensions/rand_cpp/rand.cpp
@@ -0,0 +1,103 @@
+#include <iomanip>
+#include <iostream>
+#include <sstream>
+
+#include <time.h>
+
+extern "C" {
+	#include "../../../list-objects-filter-extensions.h"
+	#include "adapter_functions.h"
+}
+
+namespace {
+
+struct rand_context {
+	int percentageMatch = 0;
+	int matchCount = 0;
+	int blobCount = 0;
+	int treeCount = 0;
+	uint64_t started_at = 0;
+};
+
+static int rand_init(
+	const struct repository *r,
+	const char *filter_arg,
+	void **context)
+{
+	struct rand_context *ctx = new rand_context();
+
+	ctx->percentageMatch = atoi(filter_arg);
+	if (ctx->percentageMatch > 100 || ctx->percentageMatch < 0) {
+		std::cerr << "filter-rand-cpp: warning: invalid match %: " << filter_arg << "\n";
+		ctx->percentageMatch = 1;  // default 1%
+	}
+	std::cerr << "filter-rand-cpp: matching " << ctx->percentageMatch << "%\n";
+	ctx->started_at = getnanotime();
+
+	return 0;
+}
+
+enum list_objects_filter_result rand_filter_object(
+	const struct repository *r,
+	const enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	enum list_objects_filter_omit *omit,
+	void *context)
+{
+	struct rand_context *ctx = static_cast<struct rand_context*>(context);
+
+	if ((ctx->blobCount + ctx->treeCount + 1) % 100000 == 0) {
+		std::cerr << "filter-rand-cpp: " << (ctx->blobCount + ctx->treeCount + 1) << "...\n";
+	}
+	switch (filter_situation) {
+	default:
+		std::cerr << "filter-rand-cpp: unknown filter_situation: " << filter_situation << "\n";
+		abort();
+
+	case LOFS_BEGIN_TREE:
+		ctx->treeCount++;
+		/* always include all tree objects */
+		return static_cast<list_objects_filter_result>(LOFR_MARK_SEEN | LOFR_DO_SHOW);
+
+	case LOFS_END_TREE:
+		return LOFR_ZERO;
+
+	case LOFS_BLOB:
+		ctx->blobCount++;
+
+		if ((rand() % 100) < ctx->percentageMatch) {
+			ctx->matchCount++;
+			std::cout << "match: " << obj_to_hex_oid(obj) << pathname << "\n";
+			return static_cast<list_objects_filter_result>(LOFR_MARK_SEEN | LOFR_DO_SHOW);
+		} else {
+			*omit = LOFO_OMIT;
+			return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
+		}
+	}
+}
+
+void rand_free(const struct repository *r, void *context) {
+	struct rand_context *ctx = static_cast<struct rand_context*>(context);
+	double elapsed = (getnanotime() - ctx->started_at)/1E9;
+	int count = ctx->blobCount + ctx->treeCount;
+
+	std::cerr << "filter-rand-cpp: done: count=" << count
+		<< " (blob=" << ctx->blobCount << " tree=" << ctx->treeCount << ")"
+		<< " matched=" << ctx->matchCount
+		<< " elapsed=" << elapsed << "s"
+		<< " rate=" << count/elapsed << "/s"
+		<< " average=" << elapsed/count*1E6 << "us\n";
+
+	delete ctx;
+}
+
+} // namespace
+
+extern const struct filter_extension filter_extension_rand_cpp = {
+	"rand_cpp",
+	&rand_init,
+	&rand_filter_object,
+	&rand_free,
+};
-- 
gitgitgadget

