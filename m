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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CADC433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A70822B3B
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbhAYSBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbhAYR4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:56:00 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F15CC061355
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q7so13802337wre.13
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kZFR1isx3QPYkeyF9f202HOAtWRotawyy8Lv6DfXCFY=;
        b=bxGn7H49iYHdodS3nGQOYnt7O513xRdZ/Ukw6aL8WfZprlnLWumNM2XyeyoOWQkvIr
         m8qCTn2C9sKGbdnix6FsGCqu15WOtjndUe2OsXZgGVxNSJl6DSpdokptNQfD8rEfmvpq
         kSjWGZB7BIzn1TBNKhin+vTVVhTr2H41bxZAUXKQKm+04My1RNvq15FWwj9OhZk+L6lq
         7QDxmEVRohnyi3hv7SKhqgRJK+T7+rWcK5y/SCzncsO7wYlDE208EDySjz0z9uNVjIdr
         t4SJoL9mURnMT3NdHqnaJOhcqYLe/Znzt5rvzDLeNxTlXNEWSsEYTHrgBuQSjSgVVL/S
         1+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kZFR1isx3QPYkeyF9f202HOAtWRotawyy8Lv6DfXCFY=;
        b=KL0Udmbp/mPmzX1BgqXqZ5c7B1LEE9BbJ535mggq/d3eI0gFnhZPlskEqPgVxdiKHm
         uaGsRO+ORu6AysH5Q/iYitNuiIdEyrg7qmGyMG3QHr1Q2j3mKOjuBQKdFKMwQMlIWnmu
         nNWP6zTxHe72YjwWpyCHcGFvScsQiMqXFpSCE5Eq5HbHQFnX7Yn+lYT887FzRvTxG8Tf
         lIkRE8236VVWfkGKrFYGdcPZl2oFwjt3ayUtO8FjlfzhAH6p90lDs8B0dvRwwrxO/5d+
         Wvta/+90r1a29nMJCt4um/WwFZfIwTjy9+Sf1CFbxH9k2O/yhQKQOyjszQMc4q442v9K
         nP/A==
X-Gm-Message-State: AOAM531juRpLzSDr+txpSpY/1zdu8CBDFOU0hsY/173V3pVxqIL0yMf9
        6c4D64zZ1M30XGIqr5sZqkJjiPXhzWk=
X-Google-Smtp-Source: ABdhPJzrZtHEcPB71nGpmrkzZGRED9gJcpcEw5yDQIN2tOx+HBrtYMpaB+2AZVeX8tc66EDzfCAp6w==
X-Received: by 2002:a05:6000:41:: with SMTP id k1mr2225352wrx.386.1611596544950;
        Mon, 25 Jan 2021 09:42:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x25sm27835wmk.20.2021.01.25.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:24 -0800 (PST)
Message-Id: <9cd38fb0e9e67109940b73489364b2f2099002ba.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:56 +0000
Subject: [PATCH 10/27] submodule: sparse-index should not collapse links
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A submodule is stored as a "Git link" that actually points to a commit
within a submodule. Submodules are populated or not depending on
submodule configuration, not sparse-checkout. To ensure that the
sparse-index feature integrates correctly with submodules, we should not
collapse a directory if there is a Git link within its range.

This allows us to remove ensure_full_index() from
die_path_inside_submodule() because a sparse-index will not remove the
entries for Git links. The loop already 'continue's if the cache entry
is not a Git link.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sparse-index.c b/sparse-index.c
index d8f1a5a13d7..5dd0b835b9d 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -52,6 +52,7 @@ static int convert_to_sparse_rec(struct index_state *istate,
 		struct cache_entry *ce = istate->cache[i];
 
 		if (ce_stage(ce) ||
+		    S_ISGITLINK(ce->ce_mode) ||
 		    !(ce->ce_flags & CE_SKIP_WORKTREE))
 			can_convert = 0;
 	}
-- 
gitgitgadget

