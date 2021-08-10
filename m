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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44DAC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C5E61076
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbhHJJcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhHJJcY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 05:32:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203C2C0613D3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 02:32:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r6so3098606wrt.4
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L+KY8cxN8DDMbCjTy5FouBzRyhVwPOvd/APeFziK638=;
        b=VH87lXXzAJWX0SLIJ9uOxfFJDJy7P9Liqlc92sfklbD/3OAijBXqUxs8sXBoVh6dqN
         Zc94htyJ+7OaVxQpr8zCGQJcKjHm0aJPFnwXN/xOxdCMS8lAjLW9Zil6A8I67nnNIJ4m
         2AlKlW7nWsHy7xw8l3bZ78GTfEqI6HWl65nYhplpkEzU1xVXSmL/+btU5pH54agWi98i
         61LkdurgboFs35qfzah9lzZ+aAiR4B3ydhnbADEC1B8wYi1kHdBIVwLN4INS1uax7VYb
         ZNOBghrx10ZtPIeDffCrLz0i76EF/yJ1jKqL9VZ2gGZFu7KLATqO03k7qyx+ZSheVyVA
         sEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L+KY8cxN8DDMbCjTy5FouBzRyhVwPOvd/APeFziK638=;
        b=P2HjhJUPX5LJ1OQgJhwOj3UewOKleXToSPb4WVY6KkuuF9NS6WDrhC2EKoI4vxYCxF
         OwBEPp9q4tSajdf4zTnM+eCpOy4c1BtYv5WcYVUq1MMGWT/M0OSGeOIfpTmzX9eWV3av
         Ua4JyDsnFugpgpsP+FiDSliGd1UwvErjb8w0lc4r+y3KnW8J0eex6F2mltLRlTjt8OAe
         lBE+kac06OhDTIdQDH8/T/GlEoI+sJvepJ4ci7GcLHuaq0M2VIsn4WhufKbloiCPQmY9
         KAZmUq6yTUR5Y47E26GDmptvMjVuY+ivT3khrH0niBGu0LFC4dxfARzPP7+PLw5297Ot
         C9Wg==
X-Gm-Message-State: AOAM533/ODWZTrGuDsk1AJTwVWTtSfm3wYI/2e4qIMcrumRXzw0o79KO
        TZEq44ZmxEFRSSs2K/cvBUUtpvPtc1Y=
X-Google-Smtp-Source: ABdhPJxbGDg0NzeEFpSv879bjVDPifIVNouCb/g8SjX4BPglCBXNduOhmk6eCje8ky9Dx5iIKjiPsQ==
X-Received: by 2002:adf:d085:: with SMTP id y5mr29510050wrh.272.1628587920765;
        Tue, 10 Aug 2021 02:32:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm3084820wmj.0.2021.08.10.02.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:32:00 -0700 (PDT)
Message-Id: <7559781ca92096f89a6dcbfeeaa4d2b4d7b98094.1628587917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 09:31:55 +0000
Subject: [PATCH 1/3] t3403: fix commit authorship
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victor Gambier <vgambier@excilys.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Setting GIT_AUTHOR_* when committing with --amend will only change the
author if we also pass --reset-author

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3403-rebase-skip.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index e26762d0b29..6365c5af2f7 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -36,7 +36,8 @@ test_expect_success setup '
 	test_tick &&
 	GIT_AUTHOR_NAME="Another Author" \
 		GIT_AUTHOR_EMAIL="another.author@example.com" \
-		git commit --amend --no-edit -m amended-goodbye &&
+		git commit --amend --no-edit -m amended-goodbye \
+			--reset-author &&
 	test_tick &&
 	git tag amended-goodbye &&
 
-- 
gitgitgadget

