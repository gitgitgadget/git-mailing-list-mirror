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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC89EC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819A122D50
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 20:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbhAWT74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWT7o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:59:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8496C061793
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c128so7305208wme.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TuqSkycyIw6sa7UCYR8334RJzyjQdAuVGemdSXJzD5o=;
        b=kUI1i3UraOnKAPPdYY2vXknL584TyleXwbpE6OT/o0smuYuo0oR6Bl3Djk9tA8CZSf
         hqfhfEhIjLxEzwmww2wIKQyV2r7X1TFTK4Z6qcO80BHtf8CEqDgc91CBj1unx24X08R7
         EzD03LJjBHHcx713SHpPj5boAwLWHaD0LjFge+CBqXmbZxmzsMQz1XUV3qsNTJ5TYSMA
         Tr8ENzd0fg3UEIMEfddrcZeBBsf6fM7UI/TKvLkaNEGihy4DjA+Vj9iqwkm/qeXR4bE7
         e0hF+q1mpgXaBga8YKo6BpxgK9mhB7GydzNFicHbbAETSSXkhtxcK1R1ONnXld9ld2Iq
         GxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TuqSkycyIw6sa7UCYR8334RJzyjQdAuVGemdSXJzD5o=;
        b=tS7T7q8jEPEaYzoE7MgwGNAIo+yzu0Ro3DGMWX3CR2D2p2/9ngbGl2QV10OmtNV/PX
         MSoc3DXkvEttbFCwtAOji6HbzoR0I/bY76hREfjBN1dlNEi8kLWS130sM9j+TBFhkElT
         YShzHbukZ1fjyrKZzBX9oTA1dQv6mE8eTSTo18N1zNU5Y8pSU3zVS9WMhFrAACUpYB+E
         104RDeJW6awBwlDSPNBEL7A8+QqQXbeAepGL22DbUbDcERfZvkJEuh/RrFgIxC2oL+Rh
         X5VM80ThFF8g40mw2AD/bCtbljLdU/+CBNjvHvysGRE6wVmbGO3UwNRot+2LfdW5VwvR
         CcGA==
X-Gm-Message-State: AOAM530XiCSDfF6qGhOmCgyKDy+x4DiO7u4oAbFU4FSmoErqebiVYws+
        /rdKMav0MX24z5d1k7kAxXpABqw7k10=
X-Google-Smtp-Source: ABdhPJyqwJmWHt3KbuD47+NIVGvh53lK3PnMbT8kNQjEYEyXM0cn4EZiPeQnYp8cgMyDMFcIDrbpUw==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr7110045wmh.4.1611431905452;
        Sat, 23 Jan 2021 11:58:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h187sm16385239wmf.30.2021.01.23.11.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:58:25 -0800 (PST)
Message-Id: <6373997e05c04f57e441355eac94ca03c634e3fb.1611431900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 19:58:15 +0000
Subject: [PATCH v3 5/9] repository: add repo reference to index_state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It will be helpful to add behavior to index operations that might
trigger an object lookup. Since each index belongs to a specific
repository, add a 'repo' pointer to struct index_state that allows
access to this repository.

Add a BUG() statement if the repo already has an index, and the index
already has a repo, but somehow the index points to a different repo.

This will prevent future changes from needing to pass an additional
'struct repository *repo' parameter and instead rely only on the 'struct
index_state *istate' parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h      | 1 +
 repository.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/cache.h b/cache.h
index 71097657489..f9c7a603841 100644
--- a/cache.h
+++ b/cache.h
@@ -328,6 +328,7 @@ struct index_state {
 	struct ewah_bitmap *fsmonitor_dirty;
 	struct mem_pool *ce_mem_pool;
 	struct progress *progress;
+	struct repository *repo;
 };
 
 /* Name hashing */
diff --git a/repository.c b/repository.c
index a4174ddb062..c98298acd01 100644
--- a/repository.c
+++ b/repository.c
@@ -264,6 +264,12 @@ int repo_read_index(struct repository *repo)
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
 
+	/* Complete the double-reference */
+	if (!repo->index->repo)
+		repo->index->repo = repo;
+	else if (repo->index->repo != repo)
+		BUG("repo's index should point back at itself");
+
 	return read_index_from(repo->index, repo->index_file, repo->gitdir);
 }
 
-- 
gitgitgadget

