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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69342C43381
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A59229C5
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgL1LQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgL1LQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:16:54 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9C0C061796
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r4so9528309wmh.5
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LgKUK8hJbbqtv2edclen7bw3MGngHPyxn35OHpHBvhQ=;
        b=QU5pBdQbUx0DH+kq7o7s/HPPvAoAERPY+F/mG8EYWC09oZL647Qv98+gwxqslP+EjD
         5EW6+Rhwf8/DE8V8aHJWsc15vkzkyEbEDWH9V/QMNFhBOa4tRddybXNZ1zTUVEovE+BA
         R4Ms6ZRBUnYzPfLcutbmwgzuM5b7XV8TEaM1gI8oe7vjT2iEkWoj9KlSAXBYXHpQrfbl
         SMgkDl47/z12yOWsd/lVIHV3DWdYcIaOu+XcsVr0ZdAna0WgNnWiNDcRS9DqmYvjlrva
         pLZlIGbuuWISyiDPkehC2YgclO/wAqqzxysiCvvZ6nM262NkxhHIqohqZCrff4j9iWXi
         ChqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LgKUK8hJbbqtv2edclen7bw3MGngHPyxn35OHpHBvhQ=;
        b=Ds8dcYp1y3oDMfyIBzb4WFYptVuStyoYR4BWxoUkzkJxVmIqfJ4k7PwmRl1uscGsEh
         szsVwKnaq0NGhRZVRB1ygPLGArtaSGr9iThS9jp8jem2DZ4J5W3QwP8EkuEcT+NGgmrQ
         fgBA5QjraS2uxrFCSj7ouht+R7E7zmCM/vqn5nHclrAhPzegkF/7y8ZpWyuZbjzzCIrN
         wpQWsSMr7rUYZg081dH1u/3hNuR9X1hNyAGPNqWdkNFApxoVWhTan+aGadVaHwhXRoQA
         Rihv33nm91LpJE2TX1P4fXtrLqDYc4SWFkiw1g13WkqphSTzskvDq3ytQNrptZUNDyd3
         SxlA==
X-Gm-Message-State: AOAM532C3sHzoO6e1BzLApSwgZ5UqgGL4uIiYG2RNdIurEcKeUjPQ6xc
        XhvLdkIqBX8jSl23P+MCK1E7jOzhNWU=
X-Google-Smtp-Source: ABdhPJxj0AJrkBUcfLOJRgfBNgmBmRtRVuQk3mjVXq9BW+lBKG0/sxqzuUMjLCMOgnuXrr6JXg3p8A==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr20293753wmd.128.1609154172754;
        Mon, 28 Dec 2020 03:16:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm18865407wml.1.2020.12.28.03.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:16:12 -0800 (PST)
Message-Id: <7645e0bcef08c8fd726148b3545c0ca3adeefdec.1609154168.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 11:15:59 +0000
Subject: [PATCH v5 02/11] revision: parse parent in indegree_walk_step()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

In indegree_walk_step(), we add unvisited parents to the indegree queue.
However, parents are not guaranteed to be parsed. As the indegree queue
sorts by generation number, let's parse parents before inserting them to
ensure the correct priority order.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 revision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/revision.c b/revision.c
index 9dff845bed6..de8e45f462f 100644
--- a/revision.c
+++ b/revision.c
@@ -3373,6 +3373,9 @@ static void indegree_walk_step(struct rev_info *revs)
 		struct commit *parent = p->item;
 		int *pi = indegree_slab_at(&info->indegree, parent);
 
+		if (repo_parse_commit_gently(revs->repo, parent, 1) < 0)
+			return;
+
 		if (*pi)
 			(*pi)++;
 		else
-- 
gitgitgadget

