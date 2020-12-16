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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD876C1B0D8
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E642339E
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgLPW2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgLPW2t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 17:28:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC7C0617B0
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:28:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c5so21019650wrp.6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pXzQNJcGRBaFDEnE0Nhq8OgR+4h+nxdlFWtqctfkr2w=;
        b=Kta/Z+XfQ6A0SqijU3VsR9y4Njbl6QqlCdBRMV39vZZ66hkMc3fqsirh77qqulbK8s
         oyLY+F5ib+1ISn/2fET14gQwe8Ej9KDXhviog5EnKkNWtDxud0VtNiqCctQFYcfgKr6F
         SFTKsF3YO6XPLMLkHiCibJg9LQThA9U+XV5SyFMo9W8QCpi1zGkQGcuqBkWHTorUoD6b
         G2OkPjaxkNAFJIcOYuf2rxRFKI4PJchCi3TsSyUyu+pBwJL9TRJd6lIzBXXNNwgsCCDu
         V2pLG+ZTvgl4cFxubFVbA9VNQ7dBKxI1FKBC/ZwTZ9lh01wAyvkO3ce7SqM5Dy5kTRPk
         Lssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pXzQNJcGRBaFDEnE0Nhq8OgR+4h+nxdlFWtqctfkr2w=;
        b=lPbsK9AE5CqV+rlgyKzVnmnKftJoYSoPwi2Hg2njpYnFceQnJ2sgyOGthoqH3cPbmY
         IhujieJEPdhVdZmYY4dn+La63jOLpvP6MqT+lwaGGlSvK6gofKKNW4T0qntVns+DWtFe
         WhdGOUzI3kuenk1x2g+ASQrBtgoPM+d1FbtB7+PN8GInicUxCmELED5LEIBayf9HnM05
         xI4lJkxjbAMUcT4ZzhmsCDGHYBg+gHjm84oGgBmZ+wThMH4+cN1fUs+qrZrE0GVN99JA
         HObrecGmQ1Cicjl+2cEC/47bS/9uyJIQMeid2j8PaJaVZg0BNq+DPjmuVZe2fljSD2Df
         OdOg==
X-Gm-Message-State: AOAM532yKFv89D/lpqhgUy0HHVOmY2YOCkK9zwIzr1XWhIm1R2tgi6a1
        K2LMfm752JOAZ1dSuuoERWY9WMGeVcM=
X-Google-Smtp-Source: ABdhPJx+FYEWIg3TyDH/HdOmpqAJeqvH2zke9UNsVG2WWjx4n4b6DGNZrhBf6JcD0kl2krn+9D+4Mw==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr39993166wrs.284.1608157686930;
        Wed, 16 Dec 2020 14:28:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm4987966wmj.5.2020.12.16.14.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:28:06 -0800 (PST)
Message-Id: <3852125c70b330fa8835b47c1dd6cd9b8f3ca041.1608157683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v5.git.1608157682.gitgitgadget@gmail.com>
References: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
        <pull.814.v5.git.1608157682.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 22:28:01 +0000
Subject: [PATCH v5 3/4] merge-ort: make clear_internal_opts() aware of partial
 clearing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to handle recursive merges, after merging merge-bases we need
to clear away most of the data we had built up but some of it needs to
be kept -- in particular the "output" field.  Rename the function to
reflect its future change in use.

Further, since "reinitialize" means we'll be reusing the fields
immediately, take advantage of this to only partially clear maps,
leaving the hashtable allocated and pre-sized.  (This may be slightly
out-of-order since the speedups aren't realized until there are far
more strmaps in use, but the patch submission process already went out
of order because of various questions and requests for strmap.  Anyway,
see commit 6ccdfc2a20 ("strmap: enable faster clearing and reusing of
strmaps", 2020-11-05), for performance details about the use of
strmap_partial_clear().)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6eac0cef491..bd237f3472e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -253,10 +253,11 @@ static void free_strmap_strings(struct strmap *map)
 	}
 }
 
-static void clear_internal_opts(struct merge_options_internal *opti,
-				int reinitialize)
+static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
+					  int reinitialize)
 {
-	assert(!reinitialize);
+	void (*strmap_func)(struct strmap *, int) =
+		reinitialize ? strmap_partial_clear : strmap_clear;
 
 	/*
 	 * We marked opti->paths with strdup_strings = 0, so that we
@@ -266,14 +267,14 @@ static void clear_internal_opts(struct merge_options_internal *opti,
 	 * to deallocate them.
 	 */
 	free_strmap_strings(&opti->paths);
-	strmap_clear(&opti->paths, 1);
+	strmap_func(&opti->paths, 1);
 
 	/*
 	 * All keys and values in opti->conflicted are a subset of those in
 	 * opti->paths.  We don't want to deallocate anything twice, so we
 	 * don't free the keys and we pass 0 for free_values.
 	 */
-	strmap_clear(&opti->conflicted, 0);
+	strmap_func(&opti->conflicted, 0);
 
 	/*
 	 * opti->paths_to_free is similar to opti->paths; we created it with
@@ -1344,7 +1345,7 @@ void merge_finalize(struct merge_options *opt,
 
 	assert(opt->priv == NULL);
 
-	clear_internal_opts(opti, 0);
+	clear_or_reinit_internal_opts(opti, 0);
 	FREE_AND_NULL(opti);
 }
 
-- 
gitgitgadget

