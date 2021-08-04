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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EEBC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A6F60F25
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhHDF32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbhHDF3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829BBC06179C
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:29:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m12so773949wru.12
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8ssAhpZO4uqKR4lOw5NukyYByJ/cVei+6HTXJ8uYrv4=;
        b=Atxa2XKloPVwxKR5tfOmV0JHcVyvWmG/lwBMR3uAMD8WKgpyjHDbUXx3NYkR1uqyeC
         Gd9X2woh7aGDGfhQkt6eHSB6hBkWoS0FmrmxHy1vUP1/0dHHzbR5qGqJWZVnVZauKtvq
         FSvOuE8yyO2evQfiIVjaacCmicvK/qWMViLps/oOxiWQtAQpqcwLXs/495xl+9fFt995
         ViMan8hR8FvfJRGBZ1VEHMd6p4GogKyZxj6yiCW8F/PQ/3LtZSLZ6T5bMmXailxY9MOD
         mA27L0qJfgOEAc5lFNecLyazjIEUz8O3N1nR1VH7JIc1/X1kQMYgRwGmKJIedoUHodCW
         9+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8ssAhpZO4uqKR4lOw5NukyYByJ/cVei+6HTXJ8uYrv4=;
        b=H7DaoeT+qBJiIREhk0xt310dt8pTKSGi8Su7ToDIHWRVN5FCD+HV48Xwy5Fq+hJ8jn
         hnsi3WI+ZtKX2gmDhqsEdtCeKJ2p3MUwASHaVtChQHsjtueOKo7SUjv7yz+3WyzkPrDM
         Sjv+DkmGxT9H/NcQk6gJ5X4rRF8Ex9p8qnQ1pKCE0sIpiNyCBx5e6Jq7L2VzLppn5g+T
         0GYKvk2etlG+CBLtQfvCXKqYWPJuLiNRfHA17zGpJcAixO6DU/wppf84JB7w4quKHkUy
         jYD+WBXQiFowvscMl33VQUHqf2lxLt8frLQjNaZUhktwp/QgltZ2cFHjbdIZ6y97Xq5Z
         BDvg==
X-Gm-Message-State: AOAM530tSWbjjPFK2VlJaygoDj6n5Rk7cyGKZsWgma2SESPGmWjPIHY0
        cLEVd7thTG8keFEx4mYmypikrCNGucU=
X-Google-Smtp-Source: ABdhPJyfcWHkKu0GF3RleCvC3W60x0rsYTr9CjSM1Ex265Sjd0D5TBF48+HVINdq5JvtmZtYHagW8Q==
X-Received: by 2002:adf:f145:: with SMTP id y5mr26465927wro.102.1628054943224;
        Tue, 03 Aug 2021 22:29:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12sm1038278wrq.59.2021.08.03.22.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:29:02 -0700 (PDT)
Message-Id: <bc92826f7e5e55978d4261b9c01626c215753990.1628054936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:54 +0000
Subject: [PATCH v2 09/10] merge-strategies.txt: add coverage of the `ort`
 merge strategy
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index b54bcf68f2d..210f0f850b2 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -95,6 +95,20 @@ subtree[=<path>];;
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
+ort::
+	This is meant as a drop-in replacement for the `recursive`
+	algorithm (as reflected in its acronym -- "Ostensibly
+	Recursive's Twin"), and will likely replace it in the future.
+	It fixes corner cases that the `recursive` strategy handles
+	suboptimally, and is significantly faster in large
+	repositories -- especially when many renames are involved.
++
+The `ort` strategy takes all the same options as `recursive`.
+However, it ignores three of those options: `no-renames`,
+`patience` and `diff-algorithm`.  It always runs with rename
+detection (it handles it much faster than `recursive` does), and
+it specifically uses `diff-algorithm=histogram`.
+
 resolve::
 	This can only resolve two heads (i.e. the current branch
 	and another branch you pulled from) using a 3-way merge
-- 
gitgitgadget

