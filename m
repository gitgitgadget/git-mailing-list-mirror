Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BEBC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28047611CE
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbhDSLk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbhDSLis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FC5C061345
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j5so32695167wrn.4
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E76LQXCKw4KxDx25d6R15l1VwwuEDMehXlDku5ZMhAY=;
        b=GL2+GVNK+jz9OTH4DclmSZrTXRH7glARuF+sy0Tjk6TzxbpyPCnjMxeQdLfnyh+knx
         f53d+Yw7yiTheUMJgr7zp/KKDAYpWKSwsDC848YMmeYPIu3CBnpMSW7mhtSkcw3wtXHT
         sY63/ziwSKOQS4ZOT0DuHx989pt2EvFdxVqIpBrIeIStv4Uf3JX6A9PKHgD8bWN/KKk0
         E/C1TU19yJEeIWnlljbzEh25xF8LSpqJix2IjD+NYUWAvgms605fo/AAb3LFg4ZmguLm
         Z/0Xyut564E7Glk6lW0kwLHTjFa3WmSMQz3+PI6+8yfaXe0wCgXkL/OLlJu1q/rrjoXj
         eOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E76LQXCKw4KxDx25d6R15l1VwwuEDMehXlDku5ZMhAY=;
        b=CEOddLpMRrxYXOkC9Mcb71NN060lHEIgBhdgutJvyOWzAYPb6UOmLK+fNow0AYlVlN
         OAd9bGDoSgXiiuIvSqdvC9iBk7CchTnjHcpj+/odl3uvb4fJ401S6R77l8BGCjjQqJWO
         r8e37TE7yEfg4Xmf5g1HweH69bLuYleDOn6gB1dHyltwAkvheVp/PFDoA8OpmobZeesc
         ImK3nr5ziaRaswbeM30VpBc2NBdP3gqVGHwghE0M+HwZYjdzB3zvFbGbdTT7U2B2+RN1
         qhgQ+ZGd6NKwA3aoi34APnJygsyd7j4zBs2h2aVaYJ4/NhATV/LM9Fzr8gGVlVBIeXe0
         j9cg==
X-Gm-Message-State: AOAM531EXzBixX0A0L7BTU8Yzo6StvAlmldmJMYe3sqobrawNWJbdruF
        NsJ/fQIQXQjfN2EARhKZFb6vCvO0hQk=
X-Google-Smtp-Source: ABdhPJyBHpT28J43RogAPmpu4byyOysJoGvSCtl+UkG9E5JmmnAP9BYD9VCjkMLn63YZyFJh2IFsAw==
X-Received: by 2002:a05:6000:186d:: with SMTP id d13mr13995465wri.199.1618832289525;
        Mon, 19 Apr 2021 04:38:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm3106430wrn.81.2021.04.19.04.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:09 -0700 (PDT)
Message-Id: <afca8f8f6a2905c4864c9b8b6baf6a546de310e8.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:43 +0000
Subject: [PATCH v7 15/28] reftable: generic interface to tables
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                     |   3 +
 reftable/generic.c           | 169 +++++++++++++++++++++++++++++++++++
 reftable/generic.h           |  32 +++++++
 reftable/reftable-generic.h  |  47 ++++++++++
 reftable/reftable-iterator.h |  39 ++++++++
 reftable/reftable.c          | 115 ++++++++++++++++++++++++
 6 files changed, 405 insertions(+)
 create mode 100644 reftable/generic.c
 create mode 100644 reftable/generic.h
 create mode 100644 reftable/reftable-generic.h
 create mode 100644 reftable/reftable-iterator.h
 create mode 100644 reftable/reftable.c

diff --git a/Makefile b/Makefile
index f7954b362aeb..97b69ce8f080 100644
--- a/Makefile
+++ b/Makefile
@@ -2414,6 +2414,9 @@ REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/record.o
+REFTABLE_OBJS += reftable/refname.o
+REFTABLE_OBJS += reftable/generic.o
+REFTABLE_OBJS += reftable/stack.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 
diff --git a/reftable/generic.c b/reftable/generic.c
new file mode 100644
index 000000000000..7a8a738d8609
--- /dev/null
+++ b/reftable/generic.c
@@ -0,0 +1,169 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "basics.h"
+#include "record.h"
+#include "generic.h"
+#include "reftable-iterator.h"
+#include "reftable-generic.h"
+
+int reftable_table_seek_ref(struct reftable_table *tab,
+			    struct reftable_iterator *it, const char *name)
+{
+	struct reftable_ref_record ref = {
+		.refname = (char *)name,
+	};
+	struct reftable_record rec = { NULL };
+	reftable_record_from_ref(&rec, &ref);
+	return tab->ops->seek_record(tab->table_arg, it, &rec);
+}
+
+int reftable_table_seek_log(struct reftable_table *tab,
+			    struct reftable_iterator *it, const char *name)
+{
+	struct reftable_log_record log = {
+		.refname = (char *)name,
+		.update_index = ~((uint64_t)0),
+	};
+	struct reftable_record rec = { NULL };
+	reftable_record_from_log(&rec, &log);
+	return tab->ops->seek_record(tab->table_arg, it, &rec);
+}
+
+int reftable_table_read_ref(struct reftable_table *tab, const char *name,
+			    struct reftable_ref_record *ref)
+{
+	struct reftable_iterator it = { NULL };
+	int err = reftable_table_seek_ref(tab, &it, name);
+	if (err)
+		goto done;
+
+	err = reftable_iterator_next_ref(&it, ref);
+	if (err)
+		goto done;
+
+	if (strcmp(ref->refname, name) ||
+	    reftable_ref_record_is_deletion(ref)) {
+		reftable_ref_record_release(ref);
+		err = 1;
+		goto done;
+	}
+
+done:
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+int reftable_table_print(struct reftable_table *tab) {
+	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record ref = { NULL };
+	struct reftable_log_record log = { NULL };
+	uint32_t hash_id = reftable_table_hash_id(tab);
+	int err = reftable_table_seek_ref(tab, &it, "");
+	if (err < 0) {
+		return err;
+	}
+
+	while (1) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0) {
+			return err;
+		}
+		reftable_ref_record_print(&ref, hash_id);
+	}
+	reftable_iterator_destroy(&it);
+	reftable_ref_record_release(&ref);
+
+	err = reftable_table_seek_log(tab, &it, "");
+	if (err < 0) {
+		return err;
+	}
+	while (1) {
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0) {
+			return err;
+		}
+		reftable_log_record_print(&log, hash_id);
+	}
+	reftable_iterator_destroy(&it);
+	reftable_log_record_release(&log);
+	return 0;
+}
+
+uint64_t reftable_table_max_update_index(struct reftable_table *tab)
+{
+	return tab->ops->max_update_index(tab->table_arg);
+}
+
+uint64_t reftable_table_min_update_index(struct reftable_table *tab)
+{
+	return tab->ops->min_update_index(tab->table_arg);
+}
+
+uint32_t reftable_table_hash_id(struct reftable_table *tab)
+{
+	return tab->ops->hash_id(tab->table_arg);
+}
+
+void reftable_iterator_destroy(struct reftable_iterator *it)
+{
+	if (!it->ops) {
+		return;
+	}
+	it->ops->close(it->iter_arg);
+	it->ops = NULL;
+	FREE_AND_NULL(it->iter_arg);
+}
+
+int reftable_iterator_next_ref(struct reftable_iterator *it,
+			       struct reftable_ref_record *ref)
+{
+	struct reftable_record rec = { NULL };
+	reftable_record_from_ref(&rec, ref);
+	return iterator_next(it, &rec);
+}
+
+int reftable_iterator_next_log(struct reftable_iterator *it,
+			       struct reftable_log_record *log)
+{
+	struct reftable_record rec = { NULL };
+	reftable_record_from_log(&rec, log);
+	return iterator_next(it, &rec);
+}
+
+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
+{
+	return it->ops->next(it->iter_arg, rec);
+}
+
+static int empty_iterator_next(void *arg, struct reftable_record *rec)
+{
+	return 1;
+}
+
+static void empty_iterator_close(void *arg)
+{
+}
+
+static struct reftable_iterator_vtable empty_vtable = {
+	.next = &empty_iterator_next,
+	.close = &empty_iterator_close,
+};
+
+void iterator_set_empty(struct reftable_iterator *it)
+{
+	assert(!it->ops);
+	it->iter_arg = NULL;
+	it->ops = &empty_vtable;
+}
diff --git a/reftable/generic.h b/reftable/generic.h
new file mode 100644
index 000000000000..98886a06402d
--- /dev/null
+++ b/reftable/generic.h
@@ -0,0 +1,32 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef GENERIC_H
+#define GENERIC_H
+
+#include "record.h"
+#include "reftable-generic.h"
+
+/* generic interface to reftables */
+struct reftable_table_vtable {
+	int (*seek_record)(void *tab, struct reftable_iterator *it,
+			   struct reftable_record *);
+	uint32_t (*hash_id)(void *tab);
+	uint64_t (*min_update_index)(void *tab);
+	uint64_t (*max_update_index)(void *tab);
+};
+
+struct reftable_iterator_vtable {
+	int (*next)(void *iter_arg, struct reftable_record *rec);
+	void (*close)(void *iter_arg);
+};
+
+void iterator_set_empty(struct reftable_iterator *it);
+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec);
+
+#endif
diff --git a/reftable/reftable-generic.h b/reftable/reftable-generic.h
new file mode 100644
index 000000000000..d239751a7783
--- /dev/null
+++ b/reftable/reftable-generic.h
@@ -0,0 +1,47 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_GENERIC_H
+#define REFTABLE_GENERIC_H
+
+#include "reftable-iterator.h"
+
+struct reftable_table_vtable;
+
+/*
+ * Provides a unified API for reading tables, either merged tables, or single
+ * readers. */
+struct reftable_table {
+	struct reftable_table_vtable *ops;
+	void *table_arg;
+};
+
+int reftable_table_seek_log(struct reftable_table *tab,
+			    struct reftable_iterator *it, const char *name);
+
+int reftable_table_seek_ref(struct reftable_table *tab,
+			    struct reftable_iterator *it, const char *name);
+
+/* returns the hash ID from a generic reftable_table */
+uint32_t reftable_table_hash_id(struct reftable_table *tab);
+
+/* returns the max update_index covered by this table. */
+uint64_t reftable_table_max_update_index(struct reftable_table *tab);
+
+/* returns the min update_index covered by this table. */
+uint64_t reftable_table_min_update_index(struct reftable_table *tab);
+
+/* convenience function to read a single ref. Returns < 0 for error, 0
+   for success, and 1 if ref not found. */
+int reftable_table_read_ref(struct reftable_table *tab, const char *name,
+			    struct reftable_ref_record *ref);
+
+/* dump table contents onto stdout for debugging */
+int reftable_table_print(struct reftable_table *tab);
+
+#endif
diff --git a/reftable/reftable-iterator.h b/reftable/reftable-iterator.h
new file mode 100644
index 000000000000..d3eee7af3571
--- /dev/null
+++ b/reftable/reftable-iterator.h
@@ -0,0 +1,39 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_ITERATOR_H
+#define REFTABLE_ITERATOR_H
+
+#include "reftable-record.h"
+
+struct reftable_iterator_vtable;
+
+/* iterator is the generic interface for walking over data stored in a
+ * reftable.
+ */
+struct reftable_iterator {
+	struct reftable_iterator_vtable *ops;
+	void *iter_arg;
+};
+
+/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and > 0:
+ * end of iteration.
+ */
+int reftable_iterator_next_ref(struct reftable_iterator *it,
+			       struct reftable_ref_record *ref);
+
+/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
+ * end of iteration.
+ */
+int reftable_iterator_next_log(struct reftable_iterator *it,
+			       struct reftable_log_record *log);
+
+/* releases resources associated with an iterator. */
+void reftable_iterator_destroy(struct reftable_iterator *it);
+
+#endif
diff --git a/reftable/reftable.c b/reftable/reftable.c
new file mode 100644
index 000000000000..0e4607a7cd6c
--- /dev/null
+++ b/reftable/reftable.c
@@ -0,0 +1,115 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "basics.h"
+#include "record.h"
+#include "generic.h"
+#include "reftable-iterator.h"
+#include "reftable-generic.h"
+
+int reftable_table_seek_ref(struct reftable_table *tab,
+			    struct reftable_iterator *it, const char *name)
+{
+	struct reftable_ref_record ref = {
+		.refname = (char *)name,
+	};
+	struct reftable_record rec = { NULL };
+	reftable_record_from_ref(&rec, &ref);
+	return tab->ops->seek_record(tab->table_arg, it, &rec);
+}
+
+int reftable_table_read_ref(struct reftable_table *tab, const char *name,
+			    struct reftable_ref_record *ref)
+{
+	struct reftable_iterator it = { NULL };
+	int err = reftable_table_seek_ref(tab, &it, name);
+	if (err)
+		goto done;
+
+	err = reftable_iterator_next_ref(&it, ref);
+	if (err)
+		goto done;
+
+	if (strcmp(ref->refname, name) ||
+	    reftable_ref_record_is_deletion(ref)) {
+		reftable_ref_record_release(ref);
+		err = 1;
+		goto done;
+	}
+
+done:
+	reftable_iterator_destroy(&it);
+	return err;
+}
+
+uint64_t reftable_table_max_update_index(struct reftable_table *tab)
+{
+	return tab->ops->max_update_index(tab->table_arg);
+}
+
+uint64_t reftable_table_min_update_index(struct reftable_table *tab)
+{
+	return tab->ops->min_update_index(tab->table_arg);
+}
+
+uint32_t reftable_table_hash_id(struct reftable_table *tab)
+{
+	return tab->ops->hash_id(tab->table_arg);
+}
+
+void reftable_iterator_destroy(struct reftable_iterator *it)
+{
+	if (!it->ops) {
+		return;
+	}
+	it->ops->close(it->iter_arg);
+	it->ops = NULL;
+	FREE_AND_NULL(it->iter_arg);
+}
+
+int reftable_iterator_next_ref(struct reftable_iterator *it,
+			       struct reftable_ref_record *ref)
+{
+	struct reftable_record rec = { NULL };
+	reftable_record_from_ref(&rec, ref);
+	return iterator_next(it, &rec);
+}
+
+int reftable_iterator_next_log(struct reftable_iterator *it,
+			       struct reftable_log_record *log)
+{
+	struct reftable_record rec = { NULL };
+	reftable_record_from_log(&rec, log);
+	return iterator_next(it, &rec);
+}
+
+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
+{
+	return it->ops->next(it->iter_arg, rec);
+}
+
+static int empty_iterator_next(void *arg, struct reftable_record *rec)
+{
+	return 1;
+}
+
+static void empty_iterator_close(void *arg)
+{
+}
+
+static struct reftable_iterator_vtable empty_vtable = {
+	.next = &empty_iterator_next,
+	.close = &empty_iterator_close,
+};
+
+void iterator_set_empty(struct reftable_iterator *it)
+{
+	assert(!it->ops);
+	it->iter_arg = NULL;
+	it->ops = &empty_vtable;
+}
-- 
gitgitgadget

