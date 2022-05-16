Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F6FC433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 08:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbiEPIiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 04:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbiEPIiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 04:38:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C025E0C5
        for <git@vger.kernel.org>; Mon, 16 May 2022 01:37:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a5so15658676wrp.7
        for <git@vger.kernel.org>; Mon, 16 May 2022 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=t4bxnJU3iXmbVsmbfNuY+tPWfOtqaSvH9S9xHyXlphM=;
        b=dBb6XTzxqa4b7JWHRBJnFEOZqKrFw22MPWwQRDHtO99NFtcNNNWghyzzF8JSKEqzBd
         I/JgtEO9wdzzli/Hw8PdTbKK/Lr2DL9adFaVfiqeBMUEoEGNzzgtB1lA4lQoH0YEL+cS
         IReBmVVT2kVN2wbQPQLOlsWJ0Y2vYhhQSXRDERG92NxM6APA7lXyXKOjA1Z5VdAJS8/e
         zyDyhDXa85RwwDPv33tFQShTrsK1uyfnmCsa078clZ3+Dj2VX4RLseGbzNhlydfFgxk5
         wmr3Pn5gH/NjSdFgsoNxVTuEUIEvUKnvNIKUOBBbX2XoyKR/KMmkSs5/2ulC3qUyc9da
         adBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t4bxnJU3iXmbVsmbfNuY+tPWfOtqaSvH9S9xHyXlphM=;
        b=pjwtFhdTq+WNpqBgsVVTlWKFf8WZ6Z3rXXu/XcWIBuIe3pW1YKE4QFrdW5fDPbiA83
         AEBVNubKDJ03/OQm8b8Y4GHGaiig/rIr2CPGCHkZenM3r/3VBOuCzwbobAxKkbGmsC11
         FeM4r+ThwJbYtWHcADbMdHZwm84kDA8D4lt1+9i0d92fI77gLozQvVP4QrELyiSI0OBa
         jb9dwDka55SArizOu56IqnGaFoLNbnnhGEKmpE1TcMEd21qQ23r71Gn7eJPCeEVIF8In
         E15iSMr7h4bGuDk3uhoilDv+TnmOBq2aLNYIjXJHGtlhKqYl+K8fcli45hNmrIsJRUiy
         mJCw==
X-Gm-Message-State: AOAM530YDrP+4spzT0blX/BMXRV8pQL5yXRGBeXxq1LmtLq65n8Br69m
        nE15ckfty722WzTVns2xNGRImW6VZe4=
X-Google-Smtp-Source: ABdhPJzYEGAvD9P8NwNlkkeMYWZSlfLh8mWcxZjc6j1y6TKJSUfbMJbz+D9XfKrOB4e8vU9dwFe9OQ==
X-Received: by 2002:adf:ea11:0:b0:20d:768:da9f with SMTP id q17-20020adfea11000000b0020d0768da9fmr4050578wrm.625.1652690277241;
        Mon, 16 May 2022 01:37:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c431200b003942a244ee0sm9108209wme.37.2022.05.16.01.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 01:37:56 -0700 (PDT)
Message-Id: <pull.1266.git.git.1652690275625.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 08:37:55 +0000
Subject: [PATCH] fetch: limit shared symref check only for local branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

This check was introduced in 8ee5d73137f (Fix fetch/pull when run without
--update-head-ok, 2008-10-13) in order to protect against replacing the ref
of the active branch by mistake, for example by running git fetch origin
master:master.

It was later extended in 8bc1f39f411 (fetch: protect branches checked out
in all worktrees, 2021-12-01) to scan all worktrees.

This operation is very expensive (takes about 30s in my repository) when
there are many tags or branches, and it is executed on every fetch, even if
no local heads are updated at all.

Limit it to protect only refs/heads/* to improve fetch performance.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    fetch: limit shared symref check only for local branches

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1266%2Forgads%2Ffetch-perf-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1266/orgads/fetch-perf-v1
Pull-Request: https://github.com/git/git/pull/1266

 builtin/fetch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed5..4f16fc357b0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1440,6 +1440,7 @@ static void check_not_current_branch(struct ref *ref_map,
 	const struct worktree *wt;
 	for (; ref_map; ref_map = ref_map->next)
 		if (ref_map->peer_ref &&
+			starts_with(ref_map->peer_ref->name, "refs/heads/") &&
 		    (wt = find_shared_symref(worktrees, "HEAD",
 					     ref_map->peer_ref->name)) &&
 		    !wt->is_bare)

base-commit: 277cf0bc36094f6dc4297d8c9cef79df045b735d
-- 
gitgitgadget
