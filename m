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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9E9C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBF164EA2
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 12:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhBAMsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhBAMsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 07:48:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE139C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 04:47:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l12so16446224wry.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 04:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D5QXzi/cbFOuguGsQb1Cl9Xqof6bgvqas9cgqXBJIbE=;
        b=gNvTB9NXTkQ87goJ38Yc4Sa5puLCjRECAbZ6kZXh2w9fR5/oTmIsuNJ30HAhUQB0Mg
         BibjMrdhpzRcob9QQY4S937RrjEjYvjS6JXdCOjM3cnPj78gva0sKJHaP7jA5weby4i1
         H2C4azKEKUErUE14UuZanZpMy/VVOc35AAx+4ctgz/bZonaXiWb5Ld2Tihq6o1oo+Awb
         icFucZFVyUEjiz6jttqiObXVFhjJqqDdeuzUb7mQ+2SvGjRCZcVaO/Pqb2BENcuZqETu
         w2b/OZLFF0TGEmnQYEgN/URaDbV1PKegvMmmxjN+jHU93s/oMmI0mtKjadzsVIK4syi4
         U7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D5QXzi/cbFOuguGsQb1Cl9Xqof6bgvqas9cgqXBJIbE=;
        b=tBdBLUJg0WUZ5il7NiKhVz7VZ72TTXR51S79ccVJ5j9yxeQnurhUAlLV79IDaF3Q3E
         rNcJK1tURMrKf1siwLrRZh/WeH2QJ2nfT+PqexuTskiQ17LCa5wnY/8+BYH6RDH078Qr
         7+t826lGObIuj0DqZMWyyfzzUQV2rcxvTWAXqo/pvdhfF36ylC2PWPYLU8gRYWsEijUs
         YMYPUIxdwWbfOE35frb4VMDW0tLjFLaqKOWfGHnw61OwIgEIfGAeAQKVHOP5rUKpfWBQ
         9wrm3rIr3ER9diqNQyAoA2+4rowsTiNZxjIF+aqA6r+pe9+3WeHN0Tk/CJufKQnSNWGB
         0qmA==
X-Gm-Message-State: AOAM5300f/1v+AaQMhJvDpNbOvcBTt2lxsf0dz4oOLACJaASnXNRB6+E
        gW2kfwRV+vntjJv2ZotCiDKEUJJac2c=
X-Google-Smtp-Source: ABdhPJymU7oiY2Tlo+yhsO011rbSXxXV4ijPI/DVaRHscdpPyXcBIkFJ/uTa7Q58w+RLh9DD4ri9qw==
X-Received: by 2002:adf:a2ca:: with SMTP id t10mr17844805wra.370.1612183649518;
        Mon, 01 Feb 2021 04:47:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm26914534wrp.13.2021.02.01.04.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:47:29 -0800 (PST)
Message-Id: <649f6799e6bfa0662ed5a4debf915053598fe142.1612183647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 12:47:23 +0000
Subject: [PATCH v2 1/5] commit-reach: reduce requirements for
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
index e38771ca5a1..9af51fe7e07 100644
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

