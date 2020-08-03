Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC67C433E3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 05:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561F7206DA
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 05:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb8TUGVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgHCFhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgHCFhT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 01:37:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A3C06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 22:37:18 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id t15so28422840iob.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxkJq1fPygNutclk3vXYb2bpp8vYuwuURln7k0NDtlw=;
        b=nb8TUGVqe+u8z4Y/pSR8oiC6oBlMBfxl15XJNcSVXVlpSLPUolbs3l73ndLHBtGcct
         1c5QuxTBCo350wLIbo0eJwb9LYOAEyE/igaAWBAMnUxTng1fhrCnHWrazNGOerhj9Czu
         p4JKtvKETjS6ZqhRFf+x7P2bCob4pYcSFXVKCX29XgVyUg+s7THmlOHr6kaOFE2gNBmf
         dwLnqNtHYtw1rraJ9UHZn0uwq/je2k470DQWHda35Yx2MRsAwF4Fti2vgqkUBPP+9B6m
         yUqJKKgkeBwBbv9AGcwY2kvZfGw2MnAMertKAgJX71Qo+HmmAPrF5IWbpsTrWVATGOTr
         3qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sxkJq1fPygNutclk3vXYb2bpp8vYuwuURln7k0NDtlw=;
        b=srNSad/OLpoz8R7eRwZV0pJv5ZYBsdqMvs4kzxrPH0bawBU03/fHEcVNZLa2bUr0ro
         lC427ltmjPhQ8k+jFu+Zy8vU5Q9HbYY8jvR9uEMisXE+spsKvxMKgpTpZuVDd+hgedOt
         QvNHRm+F+YEURFt7s6jWQzAzaeuaJOin5hWevFuuT0+opEM7KFXleH/0QPOkYJb+BcY5
         DBw4n6Mq9IGWTYclNoGwVQLmFrkgqoozshsyk6vkZRk8S7xWwUapbPLtL922wANowzvV
         O6dRm149Rjdj2/Wfw4eqnIW1fcuV3ZIr5ofyKDBdJPEbtas3m0TOykZV18oNjd+55xJO
         ewtw==
X-Gm-Message-State: AOAM533fBafSQugxplJGvNPx3EOjlDwODvZWyTx1mFqaAxqylHc6vba1
        5bTrywmA60ZFpDtLNU1XP9DNCLVYvHo=
X-Google-Smtp-Source: ABdhPJyY4Y0OAZuiIJj4ZtyiD8J4VdH6nPFOj+NXbhTFpAU06rAY6sVLRj8Q506xxlLs5UTw9oKlgw==
X-Received: by 2002:a6b:5c17:: with SMTP id z23mr15352993ioh.67.1596433038010;
        Sun, 02 Aug 2020 22:37:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r6sm8183114iod.7.2020.08.02.22.37.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2020 22:37:17 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/4] git-worktree.txt: make start of new sentence more obvious
Date:   Mon,  3 Aug 2020 01:36:12 -0400
Message-Id: <20200803053612.50095-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966
In-Reply-To: <20200803053612.50095-1-sunshine@sunshineco.com>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading the rendered description of `add`, it's easy to trip over
and miss the end of one sentence and the start of the next, making it
seem as if they are part of the same statement, separated only by a
dash:

    ... specific files such as HEAD, index, etc. - may also be
    specified as <commit-ish>; it is synonymous with...

This can be particularly confusing since the thoughts expressed by the
two sentences are unrelated. Reduce the likelihood of confusion by
making it obvious that the two sentences are distinct.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 49422454d1..260bfe9105 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -48,8 +48,8 @@ add <path> [<commit-ish>]::
 
 Create `<path>` and checkout `<commit-ish>` into it. The new working directory
 is linked to the current repository, sharing everything except working
-directory specific files such as HEAD, index, etc. `-` may also be
-specified as `<commit-ish>`; it is synonymous with `@{-1}`.
+directory specific files such as HEAD, index, etc. As a convenience,
+`<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
 +
 If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
 and neither `-b` nor `-B` nor `--detach` are used, but there does
-- 
2.28.0.236.gb10cc79966

