Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7B5C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352303AbiCaBPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352282AbiCaBOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178D6623D
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a1so31530037wrh.10
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkfEt7IgeFvbDfmMc33K/qFX1SFSh2hKKIfwtdzrGmk=;
        b=RnpBoODk0kJQeM5PyGJ4Hd+DolNtDDZaqrV5Bg24blOVtDkIWn1S0shCFoFZV9Jlem
         Dqw6H6aJ4ONGCAVw7C3ofuMmOUonFN9lczHznr5Z7tZ7bAKZyZAqdwl3Kol7EEHzMDkT
         acatSjMrE7Qfc298+Rr+l+5TvyrAQIfLsjsoHSkBj7zrZbc/k/WzWhL0n9SJS7m9OaoD
         ojtMFTk86RwdieGcOu5y5EcOSRsmYU0VWbb+CfkO1GoA630SE5YfurJbNUQRmq4qesdX
         EemHFjTeysptnJyiV72pVJJ4DrBbYdPzQ59TC5GS+uxpW15dVkL5S0E+RjYdOyoI+lQr
         PXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkfEt7IgeFvbDfmMc33K/qFX1SFSh2hKKIfwtdzrGmk=;
        b=qB8xqEpsmwnJBd021FiqqRSzL1g//AuG9UTUY2Gk5oSyjgctAqFKWsa72j9aAD4t7x
         dc2OtTTuptFlaAmCbdFZtMD5vhcmqcQjde0ePE3QFDVOXr3kvgkpfuoLo42j6T1BAR5/
         4Yy/hbQBl76Cg6dKGlb68OhSsVgbtrHu/lQIf5DELg8aUYtZBquRcleP2h8SE0u7/y0W
         c81ECSS6EcYL78uRgzjRr/dEdDTHM6CMhOX/ZnBJ2CyxU/oY2Z2G/9GMgVeXq+8gI6aL
         XOJUfA65aXVqCBtn5As6d8IUscxhgUuJPrTnikjYGAawjHbp46uKYRvFrcmTkGIieFux
         U/vw==
X-Gm-Message-State: AOAM531i3xkHgGtH4J6IWRRKAmKhraZESBa6AvmfS8swNtcjEZBEcUvq
        eajaKo1i1bgBgLq9OGOlXHiGTMtEboojfg==
X-Google-Smtp-Source: ABdhPJyLO4Wq6pbBRpYcE1qlNSfwiY08XqXPcrfnVNjjSiI9bcS6TOTeCcpnwkSqHvVlztlr6iWiSA==
X-Received: by 2002:a05:6000:15cb:b0:203:d94b:bd83 with SMTP id y11-20020a05600015cb00b00203d94bbd83mr2068612wry.113.1648689147990;
        Wed, 30 Mar 2022 18:12:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 26/27] revisions API: have release_revisions() release "topo_walk_info"
Date:   Thu, 31 Mar 2022 03:11:31 +0200
Message-Id: <patch-v4-26.27-b56db37940d-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
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
 revision.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 31fc5e58da0..33a458d7c0c 100644
--- a/revision.c
+++ b/revision.c
@@ -2954,6 +2954,8 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 	free(mailmap);
 }
 
+static void release_revisions_topo_walk_info(struct topo_walk_info *info);
+
 void release_revisions(struct rev_info *revs)
 {
 	release_revisions_commit_list(revs);
@@ -2967,6 +2969,7 @@ void release_revisions(struct rev_info *revs)
 	free_grep_patterns(&revs->grep_filter);
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
+	release_revisions_topo_walk_info(revs->topo_walk_info);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
@@ -3479,17 +3482,22 @@ static void compute_indegrees_to_depth(struct rev_info *revs,
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
 
-	FREE_AND_NULL(revs->topo_walk_info);
+static void reset_topo_walk(struct rev_info *revs)
+{
+	release_revisions_topo_walk_info(revs->topo_walk_info);
+	revs->topo_walk_info = NULL;
 }
 
 static void init_topo_walk(struct rev_info *revs)
-- 
2.35.1.1557.g4e3e9cdb5e0

