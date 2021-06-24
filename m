Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CBCC49EAB
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0BA610A2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhFXSci (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhFXSc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 14:32:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB86C061760
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:30:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i94so7760606wri.4
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HCGgFV/4p+si92OwwkB20ocGgqLCzyzM36tbv94A+ZU=;
        b=ssxuFO8+ZtRNuAsPA8Wqoo+ShbdDZMZ0xM/PdvzsefVJGxQs9sJ9IKg8EkIUd47bAr
         YEk8Yy/yfbIsm/3YLyyijSfj7jl7GZIPd9Pgwzp409znYTixJDP3ODJ7Whaq3w1mnpVc
         0wnctMb3elkb+CDgJrEFRnishP/VigjuslCC2AlWPk/qb9kk0RAIbGSKagC2F/HusNpR
         5coxepYhGT0gesN5RPy22b/YPmONno26cIIByojP7OPOZMJ7QCoUmqztDvarZWnHXzXd
         rYM1v9/jPA1i6HucYQRqxBzkQ6FharLH93TdTbuzL5n2tWaolj9BybkEOX8VFbXsR95Q
         3lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HCGgFV/4p+si92OwwkB20ocGgqLCzyzM36tbv94A+ZU=;
        b=fvIYVwg8zge3PtWLK7umaENB6P3Jloxy83QcoAImHSMdIwJIU0U1iXBIF0behZSXKS
         3Y47Xs/TcP62mChQmP3whxVTv/0JBLqTG1XLsBPNJ31Nd90bpXOzQ5dj1DdrOq0L6NsV
         e7v9qeRVar7M9tNlvOIJxzCZiv0NXFjwv3igQXZi3Hjsc4JWNTG7l6Icd3zQ0l+bFo+p
         1UNAhTkKUI34KGe2Lrq9QWiY6WOI7aZH7mwYs/hC5JxAxNO31gTp/GnBafg3VNjgNAuc
         RWxwaUrZcY34gzjBxmFcbCidNG3CMYh+ve1UUWYfruV0pj07THCWKYc37jsfTEK86NND
         ARjQ==
X-Gm-Message-State: AOAM531fP6nk6zMBBiRCmCURoU2i0hyXgUvL2hTZQ0DF50A4o6mHXVKK
        Dx+EIJ2iZmH7oJ6OnoSxCtsrEVUeeQk=
X-Google-Smtp-Source: ABdhPJz1CulCJTb0PSOiRSs0lEMptXKd3oUFI7cAUMqobltOrs2sL9gNcXa0P+yHU39uPWGdxmIekA==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr6036877wrx.347.1624559405322;
        Thu, 24 Jun 2021 11:30:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h206sm9253330wmh.33.2021.06.24.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:30:05 -0700 (PDT)
Message-Id: <627f1952fd8d4864b6b87f5539a9d9b802c5796b.1624559402.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.git.1624559401.gitgitgadget@gmail.com>
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Jun 2021 18:30:01 +0000
Subject: [PATCH 3/3] Write index when populating empty untracked cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

It is expected that an empty/unpopulated untracked
cache structure can be written to the index - by update-
index, or by a "git status" call that sees the untracked cache
should be enabled, but is running with options that make
it non-applicable in that run.

Currently, if that happens, then subsequent "git status"
calls end up populating the untracked cache, but not
writing the index (not saving their work) - so the
performance outcome is almost identical to the cache
being altogether disabled.

This continues until the index gets written with the cache
populated, for some *other* reason.

In this change, we detect the "existing cache is empty
and it looks like we are using it" condition, and queues
an index write when this happens.

This change depends on previous fixes to t7519 for the
"ignore .git changes when invalidating UNTR" test case to
pass - before this fix, the test never actually did anything
as it was not set up correctly.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 dir.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index ebe5ec046e0..a326e40e1c1 100644
--- a/dir.c
+++ b/dir.c
@@ -2703,7 +2703,8 @@ void remove_untracked_cache(struct index_state *istate)
 
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
-						      const struct pathspec *pathspec)
+						      const struct pathspec *pathspec,
+						      struct index_state *istate)
 {
 	struct untracked_cache_dir *root;
 	static int untracked_cache_disabled = -1;
@@ -2767,8 +2768,15 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 	}
 
-	if (!dir->untracked->root)
+	if (!dir->untracked->root) {
 		FLEX_ALLOC_STR(dir->untracked->root, name, "");
+		/*
+		 * If we've had to initialize the root, then what we had was an
+		 * empty uninitialized untracked cache structure. We will be
+		 * populating it now, so we should trigger an index write.
+		 */
+		istate->cache_changed |= UNTRACKED_CHANGED;
+	}
 
 	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
 	root = dir->untracked->root;
@@ -2838,7 +2846,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		return dir->nr;
 	}
 
-	untracked = validate_untracked_cache(dir, len, pathspec);
+	untracked = validate_untracked_cache(dir, len, pathspec, istate);
 	if (!untracked)
 		/*
 		 * make sure untracked cache code path is disabled,
-- 
gitgitgadget
