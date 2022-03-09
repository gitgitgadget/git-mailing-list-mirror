Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EADBC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiCINTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiCINT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:26 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB51637F0
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:18:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q14so3015399wrc.4
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQApnMwuWLOJ2aBYSiR9ITMkoMHBKZfKETjSveY62Ik=;
        b=VCjFZ3HVbh49Ma2vNWaylvt8T0tEeztyL/GrRh3HilzyYQUZPDevhJonU8mv47CZ9N
         ZoN56+s2llAPFZDPKxRTyVTvU+yAoruzHfbZBaeBUYGFqh2BcezMBHQO179SYTTDkPgR
         PCiQvSyBfMv4KgI77sbaCCcG5UWRYXMAwpA314mFg83OArKUErjc8ElC4Qh63xBnaQJn
         G6+wIX35L6KFGiLNOLi1IXVaq9Q4g0vAqpwLNzIOxEpNWkje9HmIFNm6x3a94TH2Pe9P
         kWX+yqmJPZAzvmIP7h8tFj9mpSTq8Ea69FiKZUJu8wfs/sl/lxV2FyOlbjavgeNRfSkX
         Ubqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQApnMwuWLOJ2aBYSiR9ITMkoMHBKZfKETjSveY62Ik=;
        b=fakTxKQdxUSWu1/o4WUiUdT2CnzTb5ZfHfgT+VYS6h0AeCdfHDpelEoW9GzCN3Tfmu
         pB4ja07AitvYaigQdSEjy/gzTsNK2JdIyHaeCz/4EfksjhqzH2+5kYuGMrnaZuvqZyUC
         cYCBWLz1NT9I2r/x3bWtT+e/KlQLsTRSbjQWX5sbH5egTAnvOVuqNWlrUvpaP2+5jcf8
         NTusIwxruJ+RQGLqjyX8iYMfCF5CCs0TB0+Qai1TMfnXgsKAQJthARLgpyk3cOvZFLkA
         fnOG/aHJQ//Q8Hlp+jBldr9+A7AUBs1XO0cRs5ga8T5W+DEqBPR39Ade6TcmDBqeh6IZ
         MVHg==
X-Gm-Message-State: AOAM530bCJlJmHcU7SxIKomxyiFHthOATxEq8MHkvo0A1Zed/b1zGg0x
        j32y2vzlWZYcx48fqC0iKYAacEyrP6DDKQ==
X-Google-Smtp-Source: ABdhPJyJgnKSZUEsWZ510t3znSSEuHd0R4GCeUefhnqyVoDjeKoQb8sxki3EMm5DDKqe7CYuWnqFpA==
X-Received: by 2002:adf:e44b:0:b0:1f0:250a:d3ef with SMTP id t11-20020adfe44b000000b001f0250ad3efmr15874310wrm.402.1646831885266;
        Wed, 09 Mar 2022 05:18:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:18:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 24/24] revisions API: have release_revisions() release "topo_walk_info"
Date:   Wed,  9 Mar 2022 14:16:54 +0100
Message-Id: <patch-24.24-e02a097b884-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the existing reset_topo_walk() into a thin wrapper for a
release_revisions_topo_walk_info() + resetting the member to "NULL",
and call release_revisions_topo_walk_info() from release_revisions().

This fixes memory leaks that have been with us ever since
"topo_walk_info" was added to revision.[ch] in
f0d9cc4196a (revision.c: begin refactoring --topo-order logic,
2018-11-01).

Due to various other leaks this makes no tests pass in their entirety,
but e.g. before this running this on git.git:

    ./git -P log --pretty=tformat:"%P   %H | %s" --parents --full-history --topo-order -3 -- README.md

Would report under SANITIZE=leak:

    SUMMARY: LeakSanitizer: 531064 byte(s) leaked in 6 allocation(s).

Now we'll free all of that memory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 9d03e7805ff..5a9400667df 100644
--- a/revision.c
+++ b/revision.c
@@ -2945,6 +2945,8 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 	free(mailmap);
 }
 
+static void release_revisions_topo_walk_info(struct topo_walk_info *info);
+
 void release_revisions(struct rev_info *revs)
 {
 	if (!revs)
@@ -2960,6 +2962,7 @@ void release_revisions(struct rev_info *revs)
 	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
+	release_revisions_topo_walk_info(revs->topo_walk_info);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
@@ -3472,17 +3475,24 @@ static void compute_indegrees_to_depth(struct rev_info *revs,
 		indegree_walk_step(revs);
 }
 
-static void reset_topo_walk(struct rev_info *revs)
+static void release_revisions_topo_walk_info(struct topo_walk_info *info)
 {
-	struct topo_walk_info *info = revs->topo_walk_info;
-
+	if (!info)
+		return;
 	clear_prio_queue(&info->explore_queue);
 	clear_prio_queue(&info->indegree_queue);
 	clear_prio_queue(&info->topo_queue);
 	clear_indegree_slab(&info->indegree);
 	clear_author_date_slab(&info->author_date);
+	free(info);
+}
+
+static void reset_topo_walk(struct rev_info *revs)
+{
+	struct topo_walk_info *info = revs->topo_walk_info;
 
-	FREE_AND_NULL(revs->topo_walk_info);
+	release_revisions_topo_walk_info(info);
+	revs->topo_walk_info = NULL;
 }
 
 static void init_topo_walk(struct rev_info *revs)
-- 
2.35.1.1295.g6b025d3e231

