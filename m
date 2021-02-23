Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE43C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAD664E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhBWUQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhBWUP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FFAC0617A7
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y17so2301639wrs.12
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i+gKe8EgHfQlDyjY32XCjj4qcNKDY7Jfl7pEV2IN20w=;
        b=IM3fFnKVDfv08Ss+hkWhj8mHOoFDTaC3Q+yo/VzGhaMZLDSrjxZjZ743WpRKjm4O1o
         ydiRbEdYY1FmGAQQeZiy+WPi7OaG27bJg6O1QEd7BWxZrxD0R7c49hqz7BJrbnHpRDCE
         njTpVMKPZDDoigQRwCDD3I9h1V+A1kKLmawETLTC+ci4Vu8lNQgRoctk7QNbCs47JY9G
         jSiYybFMPzwiDvQmR2uDuD6SrALGZOrCZ8k8WTDpmOTkWEoEQwoBtVxSVYs/clg4Ihsi
         NriXQzqDPIldPxVDemRDaJxQ4y9kmgV7mSuUtjaSV8OJe2dbkNnpxi6YHI+GWRdgA1Op
         Uemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i+gKe8EgHfQlDyjY32XCjj4qcNKDY7Jfl7pEV2IN20w=;
        b=e4YaiB1dudte2KmYTmY63hLbxwBctAIRmikPjLv5H86nT1dSkLUurRzjoRtoKW6CbA
         MxNWmJwm4hz6XnEjdtgtrfZ9dJTImOzNQamjgHGfsJbU1HFVm65ehL7Z1QUEHbMJ1CsD
         4bkEiX8u6SDEpTx7xLu1lB/Xdczf2iBIXkjn9jXXLzTjbg6ntwFKmJB/kLFwob7RFlE/
         ueY31frOEkTx7MXDWZZRqJjjEAgxTYE9MxI9AzkRDq9qwXqfCdz8dv0M+HN7Q4V1MYOA
         ZmyTew7rdlrGpFmcw1/1z6pDsoNHkzDI/NPacwbJHH16j09eWAqVMqhVFktpITvPfApW
         NfAw==
X-Gm-Message-State: AOAM5308fRaAiW6PT+Yfps6AIO8Ml73F3R6NUqUCyfBUxoQUOEVr5BJh
        ADx5f2ypp/4PTkZXHRitRmq5/LFOhZw=
X-Google-Smtp-Source: ABdhPJwtmgHFNj3nx1au9FJDNWwiOYMvzr0odbX/79UgvPW5Yg8shUOdzxoN560w68g0BDoYYUqLVA==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr28073175wrt.412.1614111276616;
        Tue, 23 Feb 2021 12:14:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm33144051wrr.41.2021.02.23.12.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:36 -0800 (PST)
Message-Id: <e71f033c2871cf4a1ed1f1344429027ec69a150b.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:18 +0000
Subject: [PATCH 09/20] unpack-trees: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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

