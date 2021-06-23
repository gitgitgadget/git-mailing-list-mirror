Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3875C49EA4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE8961003
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFWRvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhFWRvD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:51:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D17AC0617AD
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o22so1255806wms.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WP0SpSQpK/xA2p0TRJu51An1uZnT2JXo4D6SajqElD8=;
        b=QKQDmYb4Ha44NI2UDR4IVLdEixGa+n3xvUwpqjq+0YjwHV94T52/xxfg7wMuSkY+as
         a2QHueZA/TC8InhFmXJ850LgnKfaWYsHPDGziTXy+ThkZAYgW2wPF4TdOOjqdbd6EZA7
         F/vrKWjpZ7e9yoHqzbSUN5l49v2Z6ZQMH/s0zzVFe9pRdB1NIrbBi/0ItZ0UFEzrOPM2
         zwp7mTP1vAmc8OSffDNo2MNcwRxxp9o1Ri3i/Wc1w89Bq7+9KYex2kh1rh5Wa4hLcvXa
         9poipptTCOOfsAbZZ9UIF5VyoIgd79ccAof2h1kQ/IHWVg+mH+TeLeZyUTH97Ea9UGiO
         xAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WP0SpSQpK/xA2p0TRJu51An1uZnT2JXo4D6SajqElD8=;
        b=sPk5HheqZpzi8zFsbk1wrFiF57xfYNJWrqlj6EgIVUpBj7EPWdHSST10qlti91QF9h
         XbizRkveI1kofjH2MEhsJ1vuZ+SvLNSiOxaN/6lKpEHPgNnZNWLfUHTkniuaa3nFGxwp
         6ib/nihntp6Zctmx1sCCf55yrD+w4VgWgEK+2tnJspMeghOcwl4ITJnbHPXcK0CBqoPk
         H0d5dPDosUrQ6cxVN4QFDQohxlEkpwUs8eKtbOgx60vamLhkSz2qKMMKi23yyMcBUNFV
         xlH3+Ti+EP1oci+IH/5esHoTINVRCbcphL2ozYvwutTBeBG85AIba48CiyIowCPvs2Pz
         3myQ==
X-Gm-Message-State: AOAM533U/j1gnv1AkQQdYcPVtN9kQAkZVU73r84rPoJVrmkcpf6WdB/N
        TDDg9f37EV90tDS9KSF9x0/EeHoH6d8jYw==
X-Google-Smtp-Source: ABdhPJzEVq7deReNRrFlvAc1FA3L2pql1r/gwSEdDT3rhuLQXUEyCumWbzwNqEnTLznM367DOCCv+A==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr1092170wml.64.1624470518629;
        Wed, 23 Jun 2021 10:48:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/25] progress.[ch]: move the "struct progress" to the header
Date:   Wed, 23 Jun 2021 19:48:13 +0200
Message-Id: <patch-13.25-f2e84e3a3f2-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the definition of the "struct progress" to the progress.h
header. Even though its contents are meant to be "private" this
pattern has resulted in forward declarations of it in various places,
as other functions have a need to pass it around.

Let's just define it in the header instead. It's part of our own
internal code, so we're not at much risk of someone tweaking the
internal fields manually. While doing that rename the "TP_IDX_MAX"
macro to the more clearly namespaced "PROGRESS_THROUGHPUT_IDX_MAX".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h             |  1 -
 csum-file.h         |  2 --
 pack.h              |  1 -
 parallel-checkout.h |  1 -
 progress.c          | 29 +----------------------------
 progress.h          | 28 +++++++++++++++++++++++++++-
 reachable.h         |  1 -
 7 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/cache.h b/cache.h
index ba04ff8bd36..7e03a181f68 100644
--- a/cache.h
+++ b/cache.h
@@ -308,7 +308,6 @@ static inline unsigned int canon_mode(unsigned int mode)
 
 struct split_index;
 struct untracked_cache;
-struct progress;
 struct pattern_list;
 
 struct index_state {
diff --git a/csum-file.h b/csum-file.h
index 3044bd19ab6..3de0de653e8 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -3,8 +3,6 @@
 
 #include "hash.h"
 
-struct progress;
-
 /* A SHA1-protected file */
 struct hashfile {
 	int fd;
diff --git a/pack.h b/pack.h
index fa139545262..8df04f4937a 100644
--- a/pack.h
+++ b/pack.h
@@ -77,7 +77,6 @@ struct pack_idx_entry {
 };
 
 
-struct progress;
 /* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
 
diff --git a/parallel-checkout.h b/parallel-checkout.h
index 80f539bcb77..193f76398d6 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -5,7 +5,6 @@
 
 struct cache_entry;
 struct checkout;
-struct progress;
 
 /****************************************************************
  * Users of parallel checkout
diff --git a/progress.c b/progress.c
index e1b50ef7882..aff9af9ee8b 100644
--- a/progress.c
+++ b/progress.c
@@ -17,33 +17,6 @@
 #include "utf8.h"
 #include "config.h"
 
-#define TP_IDX_MAX      8
-
-struct throughput {
-	off_t curr_total;
-	off_t prev_total;
-	uint64_t prev_ns;
-	unsigned int avg_bytes;
-	unsigned int avg_misecs;
-	unsigned int last_bytes[TP_IDX_MAX];
-	unsigned int last_misecs[TP_IDX_MAX];
-	unsigned int idx;
-	struct strbuf display;
-};
-
-struct progress {
-	const char *title;
-	uint64_t last_value;
-	uint64_t total;
-	unsigned last_percent;
-	unsigned delay;
-	struct throughput *throughput;
-	uint64_t start_ns;
-	struct strbuf counters_sb;
-	int title_len;
-	int split;
-};
-
 static volatile sig_atomic_t progress_update;
 static struct progress *global_progress;
 
@@ -194,7 +167,7 @@ void display_throughput(struct progress *progress, uint64_t total)
 	tp->avg_misecs -= tp->last_misecs[tp->idx];
 	tp->last_bytes[tp->idx] = count;
 	tp->last_misecs[tp->idx] = misecs;
-	tp->idx = (tp->idx + 1) % TP_IDX_MAX;
+	tp->idx = (tp->idx + 1) % PROGRESS_THROUGHPUT_IDX_MAX;
 
 	throughput_string(&tp->display, total, rate);
 	if (progress->last_value != -1 && progress_update)
diff --git a/progress.h b/progress.h
index f1913acf73f..4fb2b483d36 100644
--- a/progress.h
+++ b/progress.h
@@ -1,7 +1,33 @@
 #ifndef PROGRESS_H
 #define PROGRESS_H
+#include "strbuf.h"
 
-struct progress;
+#define PROGRESS_THROUGHPUT_IDX_MAX      8
+
+struct throughput {
+	off_t curr_total;
+	off_t prev_total;
+	uint64_t prev_ns;
+	unsigned int avg_bytes;
+	unsigned int avg_misecs;
+	unsigned int last_bytes[PROGRESS_THROUGHPUT_IDX_MAX];
+	unsigned int last_misecs[PROGRESS_THROUGHPUT_IDX_MAX];
+	unsigned int idx;
+	struct strbuf display;
+};
+
+struct progress {
+	const char *title;
+	uint64_t last_value;
+	uint64_t total;
+	unsigned last_percent;
+	unsigned delay;
+	struct throughput *throughput;
+	uint64_t start_ns;
+	struct strbuf counters_sb;
+	int title_len;
+	int split;
+};
 
 #ifdef GIT_TEST_PROGRESS_ONLY
 
diff --git a/reachable.h b/reachable.h
index 5df932ad8f5..7e1ddddbc63 100644
--- a/reachable.h
+++ b/reachable.h
@@ -1,7 +1,6 @@
 #ifndef REACHEABLE_H
 #define REACHEABLE_H
 
-struct progress;
 struct rev_info;
 
 int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
-- 
2.32.0.599.g3967b4fa4ac

