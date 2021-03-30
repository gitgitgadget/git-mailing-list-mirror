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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731BEC433E4
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5402161994
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhC3NLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhC3NLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32969C0613DC
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so986337wmq.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i+gKe8EgHfQlDyjY32XCjj4qcNKDY7Jfl7pEV2IN20w=;
        b=XyWDIo9q9dYyhxQN4WHKj1TmJOlEVow8IhFQv9eXmLFuHi+rbXyPML5bIpp+0Y3ctF
         2d5jR+ULDtTO++43F4UVbqPbFdofUj7IxYmFPs1u63qfjpRNPjq5M3O585JEQaYtfm5A
         b7FU9aq8ATqyayMel6gCGn9gaAvQa5t+DdpDHZHv6TdT853OfbvdKkNseRi2n0BY8xqA
         gkcA3nDvxODWnbMKo4QnEqgO0YAI5eZHRbT2X+oe6RQGe+q4JVXr/DKZd8+NEyEqrDbS
         wqKmx7aGasbd/yt+aBYh+l8VM4+OwPVXu0iH0vUgETg5iIj0x3cKjkhF/LehHR/ygxl7
         XaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i+gKe8EgHfQlDyjY32XCjj4qcNKDY7Jfl7pEV2IN20w=;
        b=qQOiQAceTu9w/MnJgxYCsZMy/j04Ci7GFS/krli56mXycHGNLfUb1SSw5QN6QFwT2W
         nvjxAxvZGUB7zAp3MCjEGOgba3xhYMUdQDaK9G4/y46eIOsfPn/urCh442IABd82bSm6
         +ZTZ+8UAxvOGXRTpXaWBJB+M1c7amrqgWtS9RI8Tr0mPPAtcLE5/xMisEZNLCBkMHvr7
         POBr6FyqMz7nuno7LPfc0xTSnjMufhKlBrvSM3FdofzLdQsC8cG4JUhGXqyzMYx/2c9P
         +6lp2jYcRDFi9M/OAc564vKiXfxzIjtSsF2ygB97DrIA7i/Wlz29J4OoQLkaCp7rAbmv
         0gHA==
X-Gm-Message-State: AOAM531CK36yOx7DbsVrV+Yl0jZqeLhTewCFFsgOWhyMGgIfwHRN+cf+
        PRInE6KWLHI9BEaUHq/HaKfC6zxCO8k=
X-Google-Smtp-Source: ABdhPJzig4XeMzNQ+Mp/Sm/XBy0GemyWfyvZfATBkGkTrX2YaeiUZuikvylfGxI/aMLqD4RWGXOfWw==
X-Received: by 2002:a05:600c:2f08:: with SMTP id r8mr4054004wmn.95.1617109873955;
        Tue, 30 Mar 2021 06:11:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7sm3494919wmk.8.2021.03.30.06.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:13 -0700 (PDT)
Message-Id: <b276d2ed53238465b1416676a58506414022860f.1617109864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:52 +0000
Subject: [PATCH v5 09/21] unpack-trees: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The next change will translate full indexes into sparse indexes at write
time. The existing logic provides a way for every sparse index to be
expanded to a full index at read time. However, there are cases where an
index is written and then continues to be used in-memory to perform
further updates.

unpack_trees() is frequently called after such a write. In particular,
commands like 'git reset' do this double-update of the index.

Ensure that we have a full index when entering unpack_trees(), but only
when command_requires_full_index is true. This is always true at the
moment, but we will later relax that after unpack_trees() is updated to
handle sparse directory entries.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index f5f668f532d8..4dd99219073a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1567,6 +1567,7 @@ static int verify_absent(const struct cache_entry *,
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
+	struct repository *repo = the_repository;
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
@@ -1578,6 +1579,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
 
+	prepare_repo_settings(repo);
+	if (repo->settings.command_requires_full_index) {
+		ensure_full_index(o->src_index);
+		ensure_full_index(o->dst_index);
+	}
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
-- 
gitgitgadget

