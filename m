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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C87CC64E8A
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA0320809
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAiEjYiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgK2Hou (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgK2Hot (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:49 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D9C061A4B
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:35 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 3so11633701wmg.4
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GjWh6CVSL/ax4SCb+UslMA7Nn+yKmwId9N+80UoDxe4=;
        b=MAiEjYiMQqC6ba1KQeWrevhNC2bEK5GKTUptTiTo7X6tc4/Ylyz0anflNTaudvt1MV
         IDyILuvmfK+VNxYQ5aNOz+DxtzZMi0EGK88+hoejq3OrWsne2+4TA9SEytUp39WW7k5d
         o5FHO7tlERlK/KYhEzKBWfD3DpXIXosokfkleOZmxAldQ9VlBwav50iInTKFnkOQwzi/
         dvCXbPQl+ig0TY5utY6Fln6ejXMQQ7l7Iz8JjOqoKyi8etbTW4lmqmxM9OU/t1ZWt9h3
         kGlMuktsL34xdr+a6t6Y0ipg/oFcYYfGVdSUBnk7xxZ+aNNbqWfw6bCuvrGyV6Ixsnl1
         bqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GjWh6CVSL/ax4SCb+UslMA7Nn+yKmwId9N+80UoDxe4=;
        b=XFtEvP2+v8EUTeAfzP+ZDtXfOzSjILQ1/rxOy5PfWRnY9mWJ91YnI4WT2fuxQo7PoK
         2Fk1KZ0vXX9yMug0pBrPm1VZy6ctBUiZXwbSK14jOfGFIqyCzlrMLuWS0hgGlJl85mH4
         xIIufBXeS5x4mW4y01ReHUM6EwTEVEvKPCGywWoosO4U4HhYPIs2jjReLsvSaOsOZDDO
         VL3TIISTUTYsHj5eA3G9fjfC3dOglFce9S9M21uHStj173eA3lbVli+McRNw0lt3oAGy
         Fm/RUCuHKQKlOELfZU+FOwylBWpYsDKwPv4pRzkizAeCpK6HoZ8G4nPDbyQg0tdRHOva
         D85g==
X-Gm-Message-State: AOAM532kmq857tGegBUVqbwMhkdeWzpSz0apd9cbOkv3M26O7L2S1wLd
        xu3hRC6BAgnTEpVxzXWrDLsqgIy9zJI=
X-Google-Smtp-Source: ABdhPJx8v8VJnlfNGPkZ3rQDUiPR9HQc0pDcLlxZtPSlhvx17AD1NsQ08AODeBzCdNDxXfEosms5lA==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr17185024wmk.4.1606635813726;
        Sat, 28 Nov 2020 23:43:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm21894728wmc.1.2020.11.28.23.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:33 -0800 (PST)
Message-Id: <3ec087eb68619f4e0587fa098f7de1f137a9e3d3.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:13 +0000
Subject: [PATCH 10/20] merge-ort: avoid recursing into identical trees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When all three trees have the same oid, there is no need to recurse into
these trees to find that all files within them happen to match.  We can
just record any one of the trees as the resolution of merging that
particular path.

Immediately resolving trees for other types of trivial tree merges (such
as one side matches the merge base, or the two sides match each other)
would prevent us from detecting renames for some paths, and thus prevent
us from doing three-way content merges for those paths whose renames we
did not detect.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 52a8c41cf8..0789816ae9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -340,6 +340,19 @@ static int collect_merge_info_callback(int n,
 	fullpath = xmalloc(len + 1);
 	make_traverse_path(fullpath, len + 1, info, p->path, p->pathlen);
 
+	/*
+	 * If mbase, side1, and side2 all match, we can resolve early.  Even
+	 * if these are trees, there will be no renames or anything
+	 * underneath.
+	 */
+	if (side1_matches_mbase && side2_matches_mbase) {
+		/* mbase, side1, & side2 all match; use mbase as resolution */
+		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				names, names+0, mbase_null, 0,
+				filemask, dirmask, 1);
+		return mask;
+	}
+
 	/*
 	 * Record information about the path so we can resolve later in
 	 * process_entries.
-- 
gitgitgadget

