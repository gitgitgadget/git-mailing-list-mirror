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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DFDC433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129A064EBD
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBSMe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 07:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBSMey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 07:34:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126DCC061788
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:34:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l17so6930289wmq.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NUP8hAaHIZ4GEw7Bpetf6PthcaIyZ9T5XakdU0bHZE0=;
        b=sJuHkWjuffDEijiq5W4FdX0SpwD1+UyNp/em8m2CcG0OEpRSGFUJ/9rRtnMLOS/C+P
         FtL7v/MkUHI9QX/Yw9SIB4VMf5cgw/w50sgmoLkBLGi9j6iZ5yHHWpWHK3OoZMVNtqlu
         dlesdberQf63jDA6XTGBlGicdIS2ZIU0OlIOL7tNGSw5oQfT7IctESfMjZgZDQsoPqAD
         TsnxoghxSgIH3bEWL1YQiiJill50vu9hwHM6LGG4tCYzqvZGx1wf+RmpMvXh35E64guR
         MIPvJrVl79dT2hmtyOdnLxS5rQt2n+lLMv2vTbxjc0A9OgtGvu/c3V7+LbqyZZ1VhHJy
         SYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NUP8hAaHIZ4GEw7Bpetf6PthcaIyZ9T5XakdU0bHZE0=;
        b=lRAqqizXrzkJXBRLSOynriBTgyh6CniZygjQ4U4/UO4vVaKz52u0CddW9i1Mae6AKA
         1bkwsHtW5f8HnJPz2RtyH2z0zRuV9kg36FhsPb7y5BYI/CerCBNAl2SDlVNDAfu07FgS
         s+9Ywhs6P19GXX8bPZiy9TxUyOeHV/ldBWJ4wpuwGCtSmxtGeJLiQDtafyy12MVWRDKi
         esermqHpWlDS/DUXcnOFDUMpIV3fQBzNeui4V7CYBcuTpsNhK6V1pTGHNJWqjgDaJmmi
         TVVCRTaiDLMw4GEUPBggwJr5dVSF59pV6A1odGoSTwxThAl4wt65Ap1Ug/MCEzpi8opv
         ojzg==
X-Gm-Message-State: AOAM532Am5dcfZJy1/OQHMQpoVh3KjE+EJRbFwJM7UAFSswTuCdNmrXM
        1OvFIL5UyfvQBcDDG5cM8eYEh3Wh3RU=
X-Google-Smtp-Source: ABdhPJy6RWcIjrc7wJAWxKVHFvQX3kmUDcMpC00dF343qW1mFyzJJiZ92EZgi+tP4HweRpFInHb2Gw==
X-Received: by 2002:a05:600c:3550:: with SMTP id i16mr7011864wmq.170.1613738052785;
        Fri, 19 Feb 2021 04:34:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm13439065wre.78.2021.02.19.04.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 04:34:12 -0800 (PST)
Message-Id: <649f6799e6bfa0662ed5a4debf915053598fe142.1613738051.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.v3.git.1613738051.gitgitgadget@gmail.com>
References: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
        <pull.852.v3.git.1613738051.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Feb 2021 12:34:06 +0000
Subject: [PATCH v3 1/5] commit-reach: reduce requirements for
 remove_redundant()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.com,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Remove a comment at the beggining of remove_redundant() that mentions a
reordering of the input array to have the initial segment be the
independent commits and the final segment be the redundant commits.
While this behavior is followed in remove_redundant(), no callers rely
on that behavior.

Remove the final loop that copies this final segment and update the
comment to match the new behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index e38771ca5a1f..9af51fe7e078 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -160,9 +160,10 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 {
 	/*
 	 * Some commit in the array may be an ancestor of
-	 * another commit.  Move such commit to the end of
-	 * the array, and return the number of commits that
-	 * are independent from each other.
+	 * another commit.  Move the independent commits to the
+	 * beginning of 'array' and return their number. Callers
+	 * should not rely upon the contents of 'array' after
+	 * that number.
 	 */
 	struct commit **work;
 	unsigned char *redundant;
@@ -209,9 +210,6 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	for (i = filled = 0; i < cnt; i++)
 		if (!redundant[i])
 			array[filled++] = work[i];
-	for (j = filled, i = 0; i < cnt; i++)
-		if (redundant[i])
-			array[j++] = work[i];
 	free(work);
 	free(redundant);
 	free(filled_index);
-- 
gitgitgadget

