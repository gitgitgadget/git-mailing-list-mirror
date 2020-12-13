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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F16C433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7C922D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394097AbgLMIGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393181AbgLMIFx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:53 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39961C061282
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:39 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r7so13253153wrc.5
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ebAd0ejwDqj4cDZCIKl+zb9eM9wtPgQZTfvPCZY9VMA=;
        b=UFL3YIoV4M3QtwyZr2G1TbJ4RmnFQZQlgQEWrRr+tHg7lfooKN8CcYvEiVXkmFhiYV
         jZ9VGmgM50vcTNkPmQiyFSCbkyuazPTD1abRcjOavyNjFglOoA0+KOWigyyL08B5pLrZ
         VhE6bN1NWqqnpnUYH458erOJxpoXZLKYtW0f/VfkA8Z9M2QKcAeb6EdgIRsj5qrWVtMl
         fU09QmgrjSGTpkg/ukpi2EYK0V1WdOqqhAlXQ7bT3idxPkD0eZutlVDKgyJKKcvfP6bP
         OcIfGMXAOz/LVAk/ZRqQpX6QTD2qOVGTfGfcfw4qjOoxmjbVL8GR4ucOy/CxOqawpPYa
         VBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ebAd0ejwDqj4cDZCIKl+zb9eM9wtPgQZTfvPCZY9VMA=;
        b=Jh1Ogv91OLqEGAnbKupQRorMZvBCarv/jtQsUZmU08Da3ETWebxnEG8BXBhexpPQqp
         k7oNCm/59H8mS7CEZnr8nYyx79wHdKb8DdgTHbbmaE7/1svqlhqJlCT4c7vRkZd7sv84
         1mBIumqgbv9ZWcqQMMGct0KS2kOK/LEYXmrlfgw4Ol7udlpwvMMF1XxfGqlwa1c+Ew0F
         8wesaG/cu6SUkiCJ4ae6hkvuUN4CQbRBy2IpEsXv1u/6+LHaL+vjYveB5ioXGca6jN0A
         4SwBg2U9pDVlApfKDKaWjxWG+nY/DfusnELijryUBf4+jjzed7u1nMwKw8sZ7j2AuFU7
         IIYQ==
X-Gm-Message-State: AOAM53236EKYparJq+67XMd5IFqq1BqHLDY/iNB8UW9hYYJ8kIgbRBzv
        im14bmZDGpUJ0wTmvIcgXHTOHH5uDtA=
X-Google-Smtp-Source: ABdhPJwX2KN1db++7IVafM/OAUQaN3U2ID2Cz4U0CrnSWa3oRD1tke8i5z+i1AUDwYVIE5PKw8mdRg==
X-Received: by 2002:adf:8503:: with SMTP id 3mr23099039wrh.56.1607846677804;
        Sun, 13 Dec 2020 00:04:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm23697118wmj.28.2020.12.13.00.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:37 -0800 (PST)
Message-Id: <6fdf85c8f1a9c4ced61a81a051e8ee88b52eae01.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:17 +0000
Subject: [PATCH v3 10/20] merge-ort: avoid recursing into identical trees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
index bbfc056300b..868ac65091b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -367,6 +367,19 @@ static int collect_merge_info_callback(int n,
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

