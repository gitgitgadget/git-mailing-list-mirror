Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD7FC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630DB60FE6
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhHQRuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbhHQRuf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:50:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28788C0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:50:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b7so32730470edu.3
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3IyeUwWcUD97X0PkOm7CDHHBJQ3/bOTStRsJB0ebaHg=;
        b=c2MEPjf3gZikUArDodQh7oNLm0U+URLkpjOdesO3hi2YnRYpMZ2KLrQmtkjxDazzmG
         hs/uV+a5o2XQwG61yjKyqPztN/50ACAzzRu/4h35JJzx3q3T5PqPL6JINILdw+t6gPm2
         2iEm6SFmXuNFJBkVin6+Cwthprz2ciTFOFaSL0NsNViP9hq/b9Lk6w4/45ABdQS5Qwmn
         7GoG/cKCSm50kApYpdshrdKzrTvKeT1fQD+6LD/sAdzRuhr9UBn4Mq/r6XEMsX8KCwkA
         5s4+mAvJjVbKnHDZ3UIJXT3Aw9mFBA0XRQt+1OCdo9SP46yQb5+Nqoacw/Un9Jw97+H7
         +4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IyeUwWcUD97X0PkOm7CDHHBJQ3/bOTStRsJB0ebaHg=;
        b=i3VB/O8oomM4nSY09NEXO4vfu+bSPX+D5GugZ7WRWoUZ55k/lQ6roPUVlUEcSneiXv
         g1HwXwAvZc1LwBYJ3dtC8atmhFYvI8hMLJdJmr8o+fT8/bNBZq58hoSOJhuP94C/Fszz
         fuxsr/utfA9RQO49gDkVelyw/nS8wFFtkwHw2n1QpX2EdF9BkqtifCuAfkMGkL4wHLvt
         OERAGzgJjiS3i5RalwnyeLZ/Jnob8EkCuIM4XQy3hd0eM2PjH68LOr4DbDfcHLjMai/p
         vcp21SIK+vxHrRjWZNS/Evnzlxs6DQxT0Hw1bULimkmKkxElXXPpnNwcT0HAZguTQcYz
         JD9w==
X-Gm-Message-State: AOAM5321+3B7wqI/aEP21uI3p5FbBv8qPI8tErmi7es9q2T0BlYTFy0+
        APl3rxlRSU0r6Sa1CbtxkQ+O6h7xYro=
X-Google-Smtp-Source: ABdhPJxAB+9hu9EA9+CQQh9VLa/U02CGIOpuMFryvsk51I8Ft5+L9uLDQzrvHVunJUyq9nSXJR4Jug==
X-Received: by 2002:a05:6402:1a45:: with SMTP id bf5mr5384489edb.169.1629222600843;
        Tue, 17 Aug 2021 10:50:00 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id p23sm1375240edt.71.2021.08.17.10.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:50:00 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/6] t1600-index: disable GIT_TEST_SPLIT_INDEX
Date:   Tue, 17 Aug 2021 19:49:35 +0200
Message-Id: <20210817174938.3009923-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.453.gc5e41af357
In-Reply-To: <20210817174938.3009923-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests in 't1600-index.sh' check that various bogus index version
values are recognized and an appropriate warning message is issued.
GIT_TEST_SPLIT_INDEX=1 is supposed to trigger index splitting
randomly, and thus might interfere [1] with these tests: splitting the
index means that two index files are written (the shared base index
and the split '.git/index'), and the same warning message is then
issued twice, failing these tests.

Unset GIT_TEST_SPLIT_INDEX in this test script to avoid such
interference.

[1] There is no such interference at the moment, because, alas,
    GIT_TEST_SPLIT_INDEX=1 is broken and never split the index.  There
    was no such interference in the past (before it broke) either,
    because the first index write with GIT_TEST_SPLIT_INDEX=1 never
    split the index, only the second write did.  A subsequent commit
    fixing GIT_TEST_SPLIT_INDEX will have all the details on this.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1600-index.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index aa88fc30ce..46329c488b 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -4,6 +4,8 @@ test_description='index file specific tests'
 
 . ./test-lib.sh
 
+sane_unset GIT_TEST_SPLIT_INDEX
+
 test_expect_success 'setup' '
 	echo 1 >a
 '
-- 
2.33.0.453.gc5e41af357

