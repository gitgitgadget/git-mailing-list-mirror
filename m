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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D46C433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616C6610CB
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbhIXGiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244182AbhIXGir (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:38:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBE9C06175F
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t7so23945828wrw.13
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pUpiJ+aSkh0kTgVjyZ4ZHGy2r4u4WRRlWVdd1EmNm3o=;
        b=VIjjp8YHBQtPacBJuwig5WM3qIMwNjvc/A+bVoNXh5TByq4xogdCMslQtNq7JmY6f/
         qOIHiqhIY2meTEYxToHjCdrjhtTPBJCosSShEDb5R+etIB3/7wQdAAk3Tqh9/T3cYzhJ
         tcuT+3CZzyg+ETnqjj3xZZ6lIGWaC3uVt/3Ls9qJ2MGgRwKUlXj/16U8Oyb8xSiix/zp
         8L0hy3sIddBQv5O2nC75EEPG3cNwpB3Fjc5uKNPRycEHJInCHuA1UXbcXK9Oe7rbBFjl
         F4G2NkRn4N32EG5Jx6iudNyHqBtCpXk4d68/qGtqOPxGf3vNYwR78RnOEljdapY9XD9w
         mTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pUpiJ+aSkh0kTgVjyZ4ZHGy2r4u4WRRlWVdd1EmNm3o=;
        b=BB5JlVTGS3F1bisPr1PO5At2OQZC9aA5YK6UozPNk7kAevTSk12ZOPxN1+WkkzYs5P
         CslKE2NgVwSi/tMB5lQHPrd1NlephAeeEMH1UayToNkZ5aBuEpqzc1drEoY5VJ4E4POM
         fEfddZHOpNx4cywp4AnoW0yheQCqSYH/QzjdwIILwKMJWhVcUQo4KJbQX4ywJUysoheC
         QBFmxuTplJAaR3Q+NXZeI2Dh5i7NduJ0xG5TrLAxW4Sq6cNl23v1L6nimdZvJULl88Ei
         td29ttW2Dkis21xcY/B/1IYB6QtzwBoi8ZI9+/x0Hb/MC06cxgBmHcKKqSffYG599bVs
         dbtA==
X-Gm-Message-State: AOAM5313MbmHlTO6+oyl+TOHTbQu/cZ0TJbJT8Zt25KRTum6Cab3hO/s
        wuIjhDp5qs/sD9rv8O/4MRim4AyuMY8=
X-Google-Smtp-Source: ABdhPJwt/NtgXEvtwJOYOvMz8DgbXm3j32RWNhyp3as8uTCYfLHaMtgKr5Nd0t/6f7kZ0KjUGGgJvA==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr9722521wrw.327.1632465433394;
        Thu, 23 Sep 2021 23:37:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r25sm7347511wra.76.2021.09.23.23.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:37:13 -0700 (PDT)
Message-Id: <0a0997d081b5e85f1a3d94b204c073f81a469440.1632465429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
        <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 06:37:07 +0000
Subject: [PATCH v2 4/6] unpack-trees: avoid nuking untracked dir in way of
 locally deleted file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2500-untracked-overwriting.sh | 2 +-
 unpack-trees.c                   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 5ec66058cfc..5c0bf4d21fc 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -218,7 +218,7 @@ test_expect_success 'git am --abort and untracked dir vs. unmerged file' '
 	)
 '
 
-test_expect_failure 'git am --skip and untracked dir vs deleted file' '
+test_expect_success 'git am --skip and untracked dir vs deleted file' '
 	test_setup_sequencing am_skip_and_untracked &&
 	(
 		cd sequencing_am_skip_and_untracked &&
diff --git a/unpack-trees.c b/unpack-trees.c
index f7d0088a4fd..b1e7ee9dfc0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2392,7 +2392,10 @@ static int deleted_entry(const struct cache_entry *ce,
 		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
 			return -1;
 		return 0;
+	} else if (verify_absent_if_directory(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o)) {
+		return -1;
 	}
+
 	if (!(old->ce_flags & CE_CONFLICTED) && verify_uptodate(old, o))
 		return -1;
 	add_entry(o, ce, CE_REMOVE, 0);
-- 
gitgitgadget

