Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB607C433E0
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D7561952
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 12:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCUMk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCUMj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 08:39:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546EC061762
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 05:39:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y124-20020a1c32820000b029010c93864955so9815894wmy.5
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qKqThk+JiOBkcx8UUac/HdTBNQet8ZCnWPCSJJszbpg=;
        b=BSRfn8dv8urMS3dWpq+QozM07Tf9QM6PWGFI6u4ah2b7SF1ZM8tH2Mb0Skv04QdwXv
         WIeyMxNNcwe/5p8dJqHWaiBENSRyTclvqfK1eKiFu89Qi2PGkmyWEwmpmniiHxRlApXu
         7Q8hShOJHwFetBSByBB3S6i1PzZy6617UIw9M3lyGZmRMvTnPGU6BxRw4QxuQ1PvzcRz
         IZDi5h2YOLYUOTTe1OSJyhwZkAClFg5MCLhYHF5i+fvyWcvL+HjMMybc+p1CA2ejYdi0
         Y+TR8I+PiYul5k9F3+3NihelL6K6DASQh2e6YivlUeAN/z5EaCrXW5IoJUdR7JfQaRNK
         3p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKqThk+JiOBkcx8UUac/HdTBNQet8ZCnWPCSJJszbpg=;
        b=lzZ9oSeNQG3jV0n+1brN1JqH6lExfU49YzMHGzxvZOjzaVMIpMJdihdaoCTVJt+bra
         t4Lq0JIwuW9eP58Z8oYz2KFK5mjLdmIc9mRb+yOyyDUKCKRWSEGfwGnON17j+BrADjbA
         k2iv5iVh1llbtORAMXRNtfCArK/Uv/JKvU0+NozNDw05d3XcF6ORSUgxcJbYIYzQcaVb
         jnSnXomhrutB/lYZzEPeeFvMubs9oC6MN6M7tAcXj7lPu5hU4+xiGZ9ErBK9Ag2zBeK2
         34d/0aqajYbGiJK7HW91MYGE5AExcKHMFtZs1J5e4JGAogWU5/cUPi/SsivnGJwumiJr
         KK6w==
X-Gm-Message-State: AOAM530xucWWO5hTcNm0b7xXKFvqEmsY2ULBLBZsE/KqjiYsEDhjwNFH
        EGIvbnF51dqEtsPTgXBLwUGRaowvwSsIFg==
X-Google-Smtp-Source: ABdhPJysgx3Nc2CJAF2U80Bwm2hd6DP6SEq777U0f/j2fxgJeMPR834nAN4M4IBLE1O94ZawlxO+7w==
X-Received: by 2002:a05:600c:2f08:: with SMTP id r8mr11753910wmn.95.1616330394618;
        Sun, 21 Mar 2021 05:39:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m17sm16633279wrx.92.2021.03.21.05.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:39:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] diff --no-index tests: add test for --exit-code
Date:   Sun, 21 Mar 2021 13:39:22 +0100
Message-Id: <a6e4ed6c3f1d37170d7e99a2fab9c90662cceb19.1616330120.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616330120.git.avarab@gmail.com>
References: <87wnu0r8tq.fsf@evledraar.gmail.com> <cover.1616330120.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for --exit-code working with --no-index. There's no reason
to suppose it wouldn't, but we weren't testing for it anywhere in our
tests. Let's fix that blind spot.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4053-diff-no-index.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 0168946b639..9b7a8ebfd3f 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -16,7 +16,12 @@ test_expect_success 'setup' '
 	echo 1 >non/git/b
 '
 
-test_expect_success 'git diff --no-index directories' '
+test_expect_success 'git diff --no-index --exit-code' '
+	git diff --no-index --exit-code a/1 non/git/a &&
+	test_expect_code 1 git diff --no-index --exit-code a/1 a/2
+'
+
+Test_expect_success 'git diff --no-index directories' '
 	test_expect_code 1 git diff --no-index a b >cnt &&
 	test_line_count = 14 cnt
 '
-- 
2.31.0.282.gcc1ec606501

