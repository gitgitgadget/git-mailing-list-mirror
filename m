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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C434EC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A735F610A8
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbhIMPq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbhIMPqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB6CC0A8895
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so7295937wmq.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YJq5Xh/G/r0K+xh06bV/qLGR4+89b3t/Z277xbA+z+o=;
        b=I32o60pHPRllGLqQE12fAMX4fUsg6xf8gECdL9T/uwSkpmne2zH/g0IH3srhng3K1N
         xPGMEgxCRvF8XklKNqW3F1W0U2mOuuMwQgX9V/e2txtL6IB+j92up5n3QJJpndhhPZtp
         OaFymRzjgsSYJV+MxXqyEL/4sC3+ETFSwwVx4gsw/QGdujpIYEMcobo+8K8AqirWHTeg
         EQ6aJlvHUdgkaGAoSoKgvaLNSwMkUnOOsT4wkTpDVbv03Y39fuMGyNcBiNEL/+Jckw3b
         JlAli7e7zZRd/7pnr4vOI9EuQB0pulrGorHJQmYZglLP6rMqbqGMWX4PfzZG2zom0dla
         NK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YJq5Xh/G/r0K+xh06bV/qLGR4+89b3t/Z277xbA+z+o=;
        b=5eavjG1WhoeaH0n3TDv1YlI/NY/kaLQCRORmQk7vYPTaKwGSiSm5Lk1WTVQdP1fgH8
         2htPQg+sBvkqt/I8roTiX7WCNrfq9LGjqMEtUkC7yWiLAx+CLfQ818J3dKL1VOE5f/oI
         4ir0dc9LglItMlxTUWBIFlaq3+Aad7H8xHQqOA9QcwrLFhEfMNe8spBpsslkdJg2KgIP
         f5gtCm1LAWRis5yx5QfQsHBtkKATH/RHi1CBPRIjPbss+0JFmr0QGiXWpiApa3+9tV9d
         6/nTDSXXe8wZ7bc3EP4F03/4nsx9tKk14CW9Ml00hnzE86hB3KyeP7MBQaN+eLn38PVY
         4Myg==
X-Gm-Message-State: AOAM5308S1x9nzgP+XsUGOkoAPNryUELbHrTd4Dp06W/7bNlqyva/1as
        pWL1fmPBwH2t/3OEFjqKWO0V78bpBus=
X-Google-Smtp-Source: ABdhPJxOP2z6GRM0+m1Pxs7xsUtMeTqb/+TvpM1pefFvst3PAYVOQQ6bBs8oX5o58LOLO31G6Wr67Q==
X-Received: by 2002:a1c:e91a:: with SMTP id q26mr11735918wmc.128.1631546371337;
        Mon, 13 Sep 2021 08:19:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13sm5651364wmh.20.2021.09.13.08.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:27 -0700 (PDT)
Message-Id: <6866630528b24d7629adebea132970241fa0d380.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:17 +0000
Subject: [PATCH v2 06/11] t3407: strengthen rebase --abort tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The existing tests only check that HEAD points to the correct
commit after aborting, they do not check that the original branch
is checked out.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 7eba9ec1619..f8264449b6c 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -19,6 +19,13 @@ test_expect_success setup '
 	test_commit "merge should fail on this, too" a e pre-rebase
 '
 
+# Check that HEAD is equal to "pre-rebase" and the current branch is
+# "to-rebase"
+check_head() {
+	test_cmp_rev HEAD pre-rebase &&
+	test "$(git symbolic-ref HEAD)" = refs/heads/to-rebase
+}
+
 testrebase() {
 	type=$1
 	state_dir=$2
@@ -29,7 +36,7 @@ testrebase() {
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$state_dir" &&
 		git rebase --abort &&
-		test_cmp_rev to-rebase pre-rebase &&
+		check_head &&
 		test_path_is_missing "$state_dir"
 	'
 
@@ -41,7 +48,7 @@ testrebase() {
 		test_must_fail git rebase --skip &&
 		test_cmp_rev HEAD main &&
 		git rebase --abort &&
-		test_cmp_rev to-rebase pre-rebase &&
+		check_head &&
 		test_path_is_missing "$state_dir"
 	'
 
@@ -56,7 +63,7 @@ testrebase() {
 		test_must_fail git rebase --continue &&
 		test_cmp_rev ! HEAD main &&
 		git rebase --abort &&
-		test_cmp_rev to-rebase pre-rebase &&
+		check_head &&
 		test_path_is_missing "$state_dir"
 	'
 
-- 
gitgitgadget

