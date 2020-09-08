Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F0C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4524207DE
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RkRbufaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgIHTuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731236AbgIHTsw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:48:52 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E65C061786
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 12:48:49 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b142so217547pfb.9
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 12:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=a1xcHiPif6Jjk6UDgCvbltph9+bTMGsks5MA1oj2l6Q=;
        b=RkRbufaB0pOJN/hgXWpQyqaQy12LIlpeZ4MhODmaYASck4XywN+6BWlf8RCUntjOOT
         ABIC+g5NRuM1rKJQuOuc/ebsLLa5bNSBVb2l6PVvKRYtctoTbVyVvcgaIuYZvlcllm2l
         IHrfh6Add2APjtuuaxbQOYqn5JwuQqGIP86v0LGwFWQlKbP8aID2MJ2NPahvYHivnlaP
         Pkc1ZdmgcNmic2D4y7bGy1n/zuSGj5LBTV/D3JUJyN12LGei6fNOmte85A6y6fszEzE3
         81l4QzFQPR7VrJk1vrT24uyMDAZ+vt9Zpm6YktQ5u1QIImWcQRAQugHmX9klSIOd3o6l
         rtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a1xcHiPif6Jjk6UDgCvbltph9+bTMGsks5MA1oj2l6Q=;
        b=dQmlojwB4aaHPj8XSFAuW3OY99f+wIVWLo5Ht1NxlMM2JQb5byPRewB4kB3v1DLLbS
         yo+4sLUpJvTHyeTaBl87kZQmW81A+X498l0rOXQvFp5HuHUTTFtoJLnPETjjQpGyU/Ga
         5pDuDg/W9Hj0H696Frs4lpzpPzqkK6atHQ+Wi23c0fpbWAweTgmLVYAnU8FRIq/X1TMS
         HQ0XbiUx2HuL0TlX22SH43CchLLMQlmzmQVVdU+11yTK4EUbz3IiQiOixqbMQS8UUe4P
         f3zLdcxSrfVY5KgwSv3py1611nl5FaKHuwrR3ROmn+YLfDMda9HnkRhsnJPg2TdOxlJI
         oLdw==
X-Gm-Message-State: AOAM531A+Xdcj+waskuGEocr9jE0GAjKsRcZrw3KT1KTAG+suvt5b+PT
        ZIdvFp678YqhcWaGoW/mS1XbSGRa/CViHmCgY0aWCueSnH8Yxub+2NnguBBJd345OnWcz7+NyvO
        NpRznCsO2Lc06PAB1ZKcuDL+KsgjdeksLuw/k5o0lq7d5MRiJbxVKnbKG45LuYRZDPu46yjt26B
        Mr
X-Google-Smtp-Source: ABdhPJxS42KuUvONXoBLFe/7eByld3mANBVa0Es2pgaXpQNF0p+yrXbIw0I2tlGceiX3K1C+gio4wjb9EPwacT37jyni
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:8817:: with SMTP id
 s23mr401870pjn.158.1599594528754; Tue, 08 Sep 2020 12:48:48 -0700 (PDT)
Date:   Tue,  8 Sep 2020 12:48:32 -0700
In-Reply-To: <cover.1599594441.git.jonathantanmy@google.com>
Message-Id: <c12f3a78de4aae8ba4bb031d764a345adcb1627d.1599594441.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com> <cover.1599594441.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 4/7] index-pack: remove redundant child field
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is refactoring 1 of 2 to simplify struct base_data.

In index-pack, each thread maintains a doubly-linked list of the delta
chain that it is currently processing (the "base" and "child" pointers
in struct base_data). When a thread exceeds the delta base cache limit
and needs to reclaim memory, it uses the "child" pointers to traverse
the lineage, reclaiming the memory of the eldest delta bases first.

A subsequent patch will perform memory reclaiming in a different way and
will thus no longer need the "child" pointer. Because the "child"
pointer is redundant even now, remove it so that the aforementioned
subsequent patch will be clearer. In the meantime, reclaim memory in the
reverse order of the "base" pointers.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c7b4aef4e4..c8db464557 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -34,7 +34,6 @@ struct object_stat {
 
 struct base_data {
 	struct base_data *base;
-	struct base_data *child;
 	struct object_entry *obj;
 	void *data;
 	unsigned long size;
@@ -44,7 +43,6 @@ struct base_data {
 
 struct thread_local {
 	pthread_t thread;
-	struct base_data *base_cache;
 	size_t base_cache_used;
 	int pack_fd;
 };
@@ -380,27 +378,37 @@ static void free_base_data(struct base_data *c)
 	}
 }
 
-static void prune_base_data(struct base_data *retain)
+static void prune_base_data(struct base_data *youngest_child)
 {
 	struct base_data *b;
 	struct thread_local *data = get_thread_data();
-	for (b = data->base_cache;
-	     data->base_cache_used > delta_base_cache_limit && b;
-	     b = b->child) {
-		if (b->data && b != retain)
-			free_base_data(b);
+	struct base_data **ancestry = NULL;
+	size_t nr = 0, alloc = 0;
+	ssize_t i;
+
+	if (data->base_cache_used <= delta_base_cache_limit)
+		return;
+
+	/*
+	 * Free all ancestors of youngest_child until we have enough space,
+	 * starting with the oldest. (We cannot free youngest_child itself.)
+	 */
+	for (b = youngest_child->base; b != NULL; b = b->base) {
+		ALLOC_GROW(ancestry, nr + 1, alloc);
+		ancestry[nr++] = b;
 	}
+	for (i = nr - 1;
+	     i >= 0 && data->base_cache_used > delta_base_cache_limit;
+	     i--) {
+		if (ancestry[i]->data)
+			free_base_data(ancestry[i]);
+	}
+	free(ancestry);
 }
 
 static void link_base_data(struct base_data *base, struct base_data *c)
 {
-	if (base)
-		base->child = c;
-	else
-		get_thread_data()->base_cache = c;
-
 	c->base = base;
-	c->child = NULL;
 	if (c->data)
 		get_thread_data()->base_cache_used += c->size;
 	prune_base_data(c);
@@ -408,11 +416,6 @@ static void link_base_data(struct base_data *base, struct base_data *c)
 
 static void unlink_base_data(struct base_data *c)
 {
-	struct base_data *base = c->base;
-	if (base)
-		base->child = NULL;
-	else
-		get_thread_data()->base_cache = NULL;
 	free_base_data(c);
 }
 
-- 
2.28.0.526.ge36021eeef-goog

