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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F8C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9347A6120D
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFWRvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhFWRu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC90C061767
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l12so2857619wrt.3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgD67N1mz80Lf+cjGQrGDdRDo+07xWN2evot80h4VJ8=;
        b=OjwEQpnlCYyJv1l7gzalupa2rjPN1Q72H6dwiCjie9P79pOCzciazoki6ZVkDdUein
         VP8GjOOVn/mCw/RJnjdQHhL1ZiVoxv22jCw0OXWfpj1p0g3yqiAhKHU2VHingfkWB57/
         yPN3lq9T4yRBQ3JbIc7jqYUK2T4wT3cnq/YNPSAJkRbacp0On3sd3YaLvZVyHd0PoypS
         1zDUk8ZtJ+bt5G/mrYFJ2/J4XYWuwoJlXgId4aujzpdiCpUngsSnmDmleTlsnu0Uwhoj
         bfhWVsyxlGdyY7hX5Sb+6D78HoYxXPQR0LBfObbC3Wwhz08qnIee43gXoinucOqtpCwY
         zT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PgD67N1mz80Lf+cjGQrGDdRDo+07xWN2evot80h4VJ8=;
        b=NOS8skOle33Rmis6IQAeAH6eKoCpqdh5c8cHNGMukpjtPeb8BVxcI08EDa4QkSoh4Y
         +CHNjZTwepyhJToYtP743HFg778AqAxzPN0ngPa2D4aFWCOZCZpsAwQU71IF+CGE8wpe
         gDuZWQ2a1mqrOTbzhC9XS2t2qCSc6tdCSDr90SnL/7XsAY8NznYvOTaJDoP63LSXPoBU
         TodWtd8oiOFTlcPLAhe5kGdP90zuuYTgZ0Gex6o/4N11hAHMQTSW/vMzLtS57N8SUPtn
         CokXRCYJIqC1vVWsLRlJpZ2IE76fiQFEJ861GCdLNVeTlWj5EJeNHWP4KflqGqefMLAo
         +wyQ==
X-Gm-Message-State: AOAM532rgKNsp5hYXRpBSEiyAJ1mo5pif2b3BPEgoPH24Vfiagq0gDyv
        I30GlIs7+JED5X5GtfLGrcgz8OFBEiCS7A==
X-Google-Smtp-Source: ABdhPJx3TKDjRGSFTJ3aAyKVl0us28wPNDtdtXfQtpSyVzV3SZ/S9QE3B9qIO/p2Py1WvLQZy6hTQA==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr1476183wrt.132.1624470516395;
        Wed, 23 Jun 2021 10:48:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/25] progress.c: remove the "sparse" mode nano-optimization
Date:   Wed, 23 Jun 2021 19:48:10 +0200
Message-Id: <patch-10.25-66e4909580b-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Revert the code added in 9d81ecb52b5 (progress: add sparse mode to
force 100% complete message, 2019-03-21) for the "sparse" progress
mode, and change its only user added in 430efb8a74b (midx: add
progress indicators in multi-pack-index verify, 2019-03-21) to use the
normal non-sparse progress.c API instead.

The reason for checking the SPARSE_PROGRESS_INTERVAL for every 2^12
objects is to improve performance. It does that, but only in an
isolated and artificial benchmark. In the case of the
"verify_midx_file" user we're in a loop doing various other OID/object
work, the cost of calling display_progress() is entirely lost in the
noise.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 midx.c     | 26 +++++++-------------------
 progress.c | 38 +++-----------------------------------
 2 files changed, 10 insertions(+), 54 deletions(-)

diff --git a/midx.c b/midx.c
index 21d6a05e887..d80e68998b8 100644
--- a/midx.c
+++ b/midx.c
@@ -1186,18 +1186,6 @@ static int compare_pair_pos_vs_id(const void *_a, const void *_b)
 	return b->pack_int_id - a->pack_int_id;
 }
 
-/*
- * Limit calls to display_progress() for performance reasons.
- * The interval here was arbitrarily chosen.
- */
-#define SPARSE_PROGRESS_INTERVAL (1 << 12)
-#define midx_display_sparse_progress(progress, n) \
-	do { \
-		uint64_t _n = (n); \
-		if ((_n & (SPARSE_PROGRESS_INTERVAL - 1)) == 0) \
-			display_progress(progress, _n); \
-	} while (0)
-
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags)
 {
 	struct pair_pos_vs_id *pairs = NULL;
@@ -1248,8 +1236,8 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	}
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
-						 m->num_objects - 1);
+		progress = start_progress(_("Verifying OID order in multi-pack-index"),
+					  m->num_objects - 1);
 	for (i = 0; i < m->num_objects - 1; i++) {
 		struct object_id oid1, oid2;
 
@@ -1260,7 +1248,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 			midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
 				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
 
-		midx_display_sparse_progress(progress, i + 1);
+		display_progress(progress, i + 1);
 	}
 	stop_progress(&progress);
 
@@ -1277,14 +1265,14 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	}
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_sparse_progress(_("Sorting objects by packfile"),
-						 m->num_objects);
+		progress = start_progress(_("Sorting objects by packfile"),
+					  m->num_objects);
 	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
 	stop_progress(&progress);
 
 	if (flags & MIDX_PROGRESS)
-		progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
+		progress = start_progress(_("Verifying object offsets"), m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		struct pack_entry e;
@@ -1318,7 +1306,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
 				    pairs[i].pos, oid_to_hex(&oid), m_offset, p_offset);
 
-		midx_display_sparse_progress(progress, i + 1);
+		display_progress(progress, i + 1);
 	}
 	stop_progress(&progress);
 
diff --git a/progress.c b/progress.c
index 1ab7d19deb8..912edd4c818 100644
--- a/progress.c
+++ b/progress.c
@@ -37,7 +37,6 @@ struct progress {
 	uint64_t total;
 	unsigned last_percent;
 	unsigned delay;
-	unsigned sparse;
 	struct throughput *throughput;
 	uint64_t start_ns;
 	struct strbuf counters_sb;
@@ -256,7 +255,7 @@ static void clear_progress_signal(void)
 }
 
 static struct progress *start_progress_delay(const char *title, uint64_t total,
-					     unsigned delay, unsigned sparse)
+					     unsigned delay)
 {
 	struct progress *progress = xmalloc(sizeof(*progress));
 	progress->title = title;
@@ -264,7 +263,6 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->last_value = -1;
 	progress->last_percent = -1;
 	progress->delay = delay;
-	progress->sparse = sparse;
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
 	strbuf_init(&progress->counters_sb, 0);
@@ -287,40 +285,12 @@ static int get_default_delay(void)
 
 struct progress *start_delayed_progress(const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, get_default_delay(), 0);
+	return start_progress_delay(title, total, get_default_delay());
 }
 
 struct progress *start_progress(const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, 0, 0);
-}
-
-/*
- * Here "sparse" means that the caller might use some sampling criteria to
- * decide when to call display_progress() rather than calling it for every
- * integer value in[0 .. total).  In particular, the caller might not call
- * display_progress() for the last value in the range.
- *
- * When "sparse" is set, stop_progress() will automatically force the done
- * message to show 100%.
- */
-struct progress *start_sparse_progress(const char *title, uint64_t total)
-{
-	return start_progress_delay(title, total, 0, 1);
-}
-
-struct progress *start_delayed_sparse_progress(const char *title,
-					       uint64_t total)
-{
-	return start_progress_delay(title, total, get_default_delay(), 1);
-}
-
-static void finish_if_sparse(struct progress *progress)
-{
-	if (progress &&
-	    progress->sparse &&
-	    progress->last_value != progress->total)
-		display_progress(progress, progress->total);
+	return start_progress_delay(title, total, 0);
 }
 
 void stop_progress(struct progress **p_progress)
@@ -328,8 +298,6 @@ void stop_progress(struct progress **p_progress)
 	if (!p_progress)
 		BUG("don't provide NULL to stop_progress");
 
-	finish_if_sparse(*p_progress);
-
 	if (*p_progress) {
 		struct progress *progress = *p_progress;
 		trace2_data_intmax("progress", the_repository, "total_objects",
-- 
2.32.0.599.g3967b4fa4ac

