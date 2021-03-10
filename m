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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2611C43331
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B131C64EF6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhCJTbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhCJTbO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F11AC061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:14 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so11454222wmj.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i+gKe8EgHfQlDyjY32XCjj4qcNKDY7Jfl7pEV2IN20w=;
        b=nPXZErV6qHySWytLoOl9f7EugQpanl+q1uXl60kFcSZKWeIFJSMkpeIUjh3yvDurPE
         YWgnQm0NGgiw9s4dXRMUn//ggvaUXbYgeS0GEepeXworIa4ZMvIzDQw58zpvk32e8O4f
         BoVapKjRwKJqFsjFLjNlQEUKhz3y3m1eZTu7G7i6BwCMS5B/hnvRDY8UF1X8732Lw1/H
         Bs16ZW2O720WhV4HY/acns4FVvmJUuf3f9yyD5L1/bB6CZqwDEulbgBXuqOKt1y9QsIq
         PWb6KtNPPNXm6OKIQf4KlYWAzj26nCq/f+vR0mW5uRXjZVMJX01z/xuzmXIEWbIpL4lf
         rRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i+gKe8EgHfQlDyjY32XCjj4qcNKDY7Jfl7pEV2IN20w=;
        b=a5Ps/C7aChzrIfjkDuJisSN3GEAU0MJ4/QAayWKivVpJBzgyhWpIlgf6Z6XPzBLZ7B
         39HsLrbBGpkYAzzLSxe3YiG/hqXngXhV4uzaaU8Wm5GxbfVH63aFAlQI9KjNJJSp0wkt
         uQWc1KBHP/U9/JehQlMEiyiL/l+j392HUHngOOkagBBTBPqVT2PXMoQ1wpQlT8tFrTzW
         zDNdFHOtYWLiv4Ye+ewNUpQDIo5wxl0LrOmvNwhupvxOKMkimuWeazKUdyT4AyBKk96F
         C21a0IuK5OlIfrPKn5ceu5kzT3OuWzVpU0YyIB33+X3jCu59/oBbkIBWoeSgO27JcBVo
         iNgA==
X-Gm-Message-State: AOAM532PnQe9AfL4JbkY8h2TCZgFT3qbDD5L/maRBE24HT7QCT3A84mg
        FtidirkZqeJhzeMjrVaQJ8u0XqYsJ0w=
X-Google-Smtp-Source: ABdhPJxeO6rhvcvSdmVEPojtTtAzeYNJTUTPfbb7UI6q1a7vLA1E/8GgdyCFSr0hwB88+l7TZuCWqg==
X-Received: by 2002:a1c:2390:: with SMTP id j138mr4765929wmj.72.1615404672912;
        Wed, 10 Mar 2021 11:31:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s84sm446008wme.11.2021.03.10.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:12 -0800 (PST)
Message-Id: <48f65093b3da3fdee606e6d52e81795cdfcbbd22.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:52 +0000
Subject: [PATCH v2 09/20] unpack-trees: ensure full index
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
        Derrick Stolee <derrickstolee@github.com>,
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

