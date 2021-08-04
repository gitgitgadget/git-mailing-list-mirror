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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D34C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBE860F25
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhHDF3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhHDF3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4569CC061799
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:29:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h13so816215wrp.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=traUx1JAtZS800VoUX12vM6gGi4bA9DkYrzyhIB75ms=;
        b=HKYc2BV7iKMjT7to6oWZHRpd0rcmMmSiy14YTXSIqTQJb2zBHi8TouKiw3MOLziUUP
         JWGFyxzWm4LYxF9klOqRaxNHn3X283tbHNgXdvtCqDVzyCPXoqjGBk6EbjKIE2LA0DUq
         aqNoLrrPNzXAnqulpycl7rMjGguIuS+vSS8//OU8ASmbiaHW2UTxg23zUJybG56J0rHA
         DwNg3tTqp1vrD0Fr/9g5MmGg/BUPyDnjEAHooVJE82kgTv1PCAOfEEy6QsVvqfy/CdUl
         zZblMMC84o7cTrFloCPuEBIUV38HlQNmD3bAqPd9yxdYoPhE5oGmaMk+Cy1tf7Lf9f37
         2znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=traUx1JAtZS800VoUX12vM6gGi4bA9DkYrzyhIB75ms=;
        b=dNQnwDyxkvg5yLMlRxHLIRiB1WR9SBPQCmP3l5kaAygZOO9PEmjUtEWZB/l9nqm3yt
         6JS1ba/nvj6rxvLcLCJIpR3R6M7jtbOc5HkT5iQeaCupzj3nWXH/lWzURucvg6uX15fv
         tvwhjDa4qeq6oEAX+nhtZcbpjW6FMv4nFiNyGEW27uOoX62tF616DQSnw/sJxTj7yenJ
         uQBrhvpCjYPWumyca9SyPSibrdxHzbG6hGkn5a+r/cZC2h9vXlepHRapZvjjujDbSvNi
         QEU1PjbQCY+ke9nHXQcNXwjmXJM3TLy1Z1+o1/giJ+cp7lg2wokBxPUX27RSbBMvx2eX
         S63A==
X-Gm-Message-State: AOAM530iRnxXIt8H7Ughu+sSLEfrhP/Rd9P/rEf7pxe9/+GhxJLRupQC
        jDwOYbMyffbXhqe4EsBj+u3dc5tpBpA=
X-Google-Smtp-Source: ABdhPJwv4TrVLPJ7r0+ecNgvitiRk2898HUq3OokafHODW44zzpnsRtvsU56l0+ZmstQXp8CbI9P7Q==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr21585393wrr.213.1628054940907;
        Tue, 03 Aug 2021 22:29:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l25sm920956wrb.44.2021.08.03.22.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:29:00 -0700 (PDT)
Message-Id: <b1db5fdebe5529d9630129dc7ee5ab0eff6adf69.1628054936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:50 +0000
Subject: [PATCH v2 05/10] merge-strategies.txt: do not imply using copy
 detection is desired
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Stating that the recursive strategy "currently cannot make use of
detected copies" implies that this is a technical shortcoming of the
current algorithm.  I disagree with that.  I don't see how copies could
possibly be used in a sane fashion in a merge algorithm -- would we
propagate changes in one file on one side of history to each copy of
that file when merging?  That makes no sense to me.  I cannot think of
anything else that would make sense either.  Change the wording to
simply state that we ignore any copies.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index f100fad1e43..e2988124581 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -16,9 +16,9 @@ recursive::
 	causing mismerges by tests done on actual merge commits
 	taken from Linux 2.6 kernel development history.
 	Additionally this can detect and handle merges involving
-	renames, but currently cannot make use of detected
-	copies.  This is the default merge strategy when pulling
-	or merging one branch.
+	renames.  It does not make use of detected copies.  This
+	is the default merge strategy when pulling or merging one
+	branch.
 +
 The 'recursive' strategy can take the following options:
 
-- 
gitgitgadget

