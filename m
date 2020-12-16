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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4B9C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDBB233F7
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgLPW2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgLPW2r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 17:28:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AAAC0617A7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:28:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r3so24699081wrt.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iFQ4VeH9xpZ2t9YdhG1ABFOxyB2gNT1XohB04jokrys=;
        b=vKUEn2z7JjOmFPUJbPMfRJUn0WhNInDOZfp8Y3V7/WP+rRhahi1ouY2gmo7YRfazcS
         QGjxjGOaA/PN4enbfqa12FLy/w+N04X6KLiRU1gLN140DVefltUi2p9G1bmFOvZeKfGS
         X85w/5l2a4dWB285oHJWAsCQ8G2oOJu2g+vDQXaZOJaldFzO4NitVpYTdJ3pHal2n5Uf
         mLKcSW3x1wiwl+O/Vs1Ql7VBmbg0Lo7y7hSapXBHkq1blkVz/xD0z6a80xHACcgqYODi
         YjMQDIw0+BCqiTiDik5cn7ioYkVcCVh7i9KsNU2BhQfnbmTdozJv9w871dTwG6mAa48A
         9Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iFQ4VeH9xpZ2t9YdhG1ABFOxyB2gNT1XohB04jokrys=;
        b=NNpgq5Yztj+pGN9AM1i0M/o6vJ1LX4DMmcdYrikwTCVjeRrlVizWZCHinUhnZdo8iu
         41k5Gsz50lUfSHmm+2PJyJW8lz9qRJdbDwTpNfSPAhK2QGIhtaXzac21ZF8VV/kGUnCZ
         +o+BD8P/eQAkOYvQWeLisGvk4oS4a7udraWkW0tiASHmz8i4kTf+euxTPzSb+tg64iQp
         UM975GpSq/KP+CmCmBySfqda5D4xdRF/7Ktu+czhO3iawDqKKtLj9GJ9KWLIuGNJvS6d
         VCsTh3L7WdaQ4xBDQ4AscQhuHlxx+4fRcd+ILCrShRhm4H9bnOHE71sAdhKo7CApUJhp
         SV7w==
X-Gm-Message-State: AOAM532sudRQkzzlF2eqPuAxrEVhWSYiFIbzV8Bi6306efTsXn2sKOx9
        5rl3OtDuYMRI4pykzTyhzeYsONSaiWw=
X-Google-Smtp-Source: ABdhPJxMKN61kLi/+QiMRo/v4KZ5q9MJp/uI3RD+lwpnIwDOx0Wcwkbx6evdydQhULc03/8jinJaCw==
X-Received: by 2002:adf:df08:: with SMTP id y8mr39614170wrl.278.1608157685941;
        Wed, 16 Dec 2020 14:28:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm4724365wmi.0.2020.12.16.14.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:28:05 -0800 (PST)
Message-Id: <949741932e512ea10e7b2a1e6036eab1c4a02b4c.1608157683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v5.git.1608157682.gitgitgadget@gmail.com>
References: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
        <pull.814.v5.git.1608157682.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 22:28:00 +0000
Subject: [PATCH v5 2/4] merge-ort: copy a few small helper functions from
 merge-recursive.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In a subsequent commit, we will implement the traditional recursiveness
that gave merge-recursive its name, namely merging non-unique
merge-bases to come up with a single virtual merge base.  Copy a few
helper functions from merge-recursive.c that we will use in the
implementation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 414e7b7eeac..6eac0cef491 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,8 +17,10 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "alloc.h"
 #include "blob.h"
 #include "cache-tree.h"
+#include "commit.h"
 #include "commit-reach.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -1348,6 +1350,24 @@ void merge_finalize(struct merge_options *opt,
 
 /*** Function Grouping: helper functions for merge_incore_*() ***/
 
+static inline void set_commit_tree(struct commit *c, struct tree *t)
+{
+	c->maybe_tree = t;
+}
+
+MAYBE_UNUSED
+static struct commit *make_virtual_commit(struct repository *repo,
+					  struct tree *tree,
+					  const char *comment)
+{
+	struct commit *commit = alloc_commit_node(repo);
+
+	set_merge_remote_desc(commit, comment, (struct object *)commit);
+	set_commit_tree(commit, tree);
+	commit->object.parsed = 1;
+	return commit;
+}
+
 static void merge_start(struct merge_options *opt, struct merge_result *result)
 {
 	/* Sanity checks on opt */
-- 
gitgitgadget

