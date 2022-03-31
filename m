Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5E3C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352297AbiCaBPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352269AbiCaBOO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0513166222
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so1076651wme.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=067eln4ntqPWqXCwGl1UtpQQ+Tz4890jcyLeGfxj6bQ=;
        b=OCuK0D2HYfulipVaT3H0bvdrNAG0R0Kl1Mwu3rVYzsDpt7T75uVVXhy165yT+4VCAu
         DaTaSEIi5ssWYZD5Q2TC3//jVrigvpIZGXwXR1A5ExyH5qno7OdytXn3fnpfpWy2Ds+s
         9xeDt7yoXTR0GROFwm5moCFyLRzGSgElJ+rqevA/4Odf+Uimxh0rj0Dqb8hHZallAaSc
         PVtAoou+lnumfi9z2uqrGMOkNDnlGQvJ1fwIDWnkXFJxjeOHgNMYx8qXvtp8wyFJKrsf
         NQtnsNQsV6EdmGF74i7j2n+I6pTcqfHJ9YZYqT/O9lt2P5/ehifigt6c7b9S1ZeLJgXJ
         OeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=067eln4ntqPWqXCwGl1UtpQQ+Tz4890jcyLeGfxj6bQ=;
        b=wITViAI0z7i4lD7FLhkpza0G+91S5Qu/5ekV7Df/Io2VbHTQqyduXN+1RYc/Qpe6VO
         RgwccV360ym/ynr9TgNZFM/qAl8NM6fWlb6Lt4P++6nOxZLeOUiluYeX+rctG2xKn/Br
         hORoQrfcMFp8GxFKtliCgIj6Y9tcXJ3dR6Hk29Mpa1e2YC6H1AyZAQSzE5ycUtaDkp63
         nR9DZbHwfZ8Xp5N9ChKoUkGa6qKnb4qV66apjUhrzzHvLOjX5se0XKJSR3T+aVDGewK3
         h3DQmfXJvskdLiA/YlqVeBUwaG8zmgZxlfR6D8D4cfx5y74EUm1yuqJ6CPV5GRUgD5jS
         ndJA==
X-Gm-Message-State: AOAM533hkMtVUUWZ9aieltFszIbzBaq7vbtqVjxU36qMQG6JGy2UwaP1
        Ctp3WbF41NZwb7GwGS7mFQ8+9x1FKSYfkA==
X-Google-Smtp-Source: ABdhPJwSGgFlmPjL0w/UXKxoNpl9wlXTUXBKlEEfOeXqHM9zi5QMK6i5Z0xTWJ0NL6T4BCWVZEaCCA==
X-Received: by 2002:a05:600c:5111:b0:38e:3535:b258 with SMTP id o17-20020a05600c511100b0038e3535b258mr2334712wms.169.1648689139377;
        Wed, 30 Mar 2022 18:12:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/27] revisions API: have release_revisions() release "commits"
Date:   Thu, 31 Mar 2022 03:11:21 +0200
Message-Id: <patch-v4-16.27-2e351702677-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"commits" in the "struct rev_info".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 8fc157e9ee7..394e2dcdd90 100644
--- a/revision.c
+++ b/revision.c
@@ -2937,6 +2937,7 @@ static void release_revisions_commit_list(struct rev_info *revs)
 
 void release_revisions(struct rev_info *revs)
 {
+	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
 }
 
-- 
2.35.1.1557.g4e3e9cdb5e0

