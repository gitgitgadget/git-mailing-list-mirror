Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B7C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956616128A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhFHGCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFHGCP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:02:15 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10CAC061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 23:00:23 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u11so20521816oiv.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 23:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsBEh+k7PNgU3zRgE/MXn+0aQKaNCM5BdfpP+nGasBg=;
        b=MRO3HJ2l69hFKHDJVCbvmSGRwZS9vcIokMRS82TAswvrElk/Kh0slIKli3A3bImw1j
         hYEgVWriJz6OYsbnbK/Uw+zp2rOaA7cf0hmmtb/3IYfzQLSqc0xtuTuDGxnsVaM3tuVl
         XH0MUYBapLEr0WhtcyTHYkW4BUPMc27n7kp8Gf3Zrr5LBxb8O7Vevk1MD8KKB0oM3Sjn
         UOoGlCf+vJ5Pxunv1DfB9l2SbrDPuOfUZgkdsnGWk48yhon9x0Roe7brCx/7CPRZ7RDX
         BXedHshNka6j5v8AoDkz3eMn4NUyCYk0baj4g5sKFwgLxqFu91ZomCsBLAgCQ7KwKn3j
         390A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsBEh+k7PNgU3zRgE/MXn+0aQKaNCM5BdfpP+nGasBg=;
        b=jZvmPAp3zqh0htjGBMXri/kuewc2LYR9gBkeou5rJTKFyhxfZLk5uWuNiG7zpiEaFe
         u1To9fcMhI9XYiysdE3hVDYzKPZBMCUc/seB0vY5vg/8UwDs3HmiPLO8KrRxWQwfwQJh
         urRupcGfcO3uW/HQWAmueFJbIk9L7N8deOw9LoHcSPY4DGIHoLvnfMYYJL2Aq6ROevnz
         wX/qBG+eH/hyrm9+Npg1BauQStKc+gC8AgvVZapuRL7YVrC9HX3ERfBtg08l1sqa9tHR
         kqYIJLxQ0bFTlu7SBevkn6nXUivtnCoTuMQJqL1GbmG9Tk32rddkVsCunSMYBDwVvJ1K
         7WwA==
X-Gm-Message-State: AOAM530kji6AuXfmKnoW+ZVxIPlhDS/Fu22Ng5r4vkORgeOVqG0TtQHd
        doUmI18xdlDkQTQEQkg4vZ+ogA3gWDICxw==
X-Google-Smtp-Source: ABdhPJziJUCJMMA0YEGEquDJ9+7vLbm4lo/eySXTC+ArmZDVY3zNiZB46LYsu/DBwFz6ysBrAKmrpw==
X-Received: by 2002:aca:4fd7:: with SMTP id d206mr1703057oib.16.1623132022892;
        Mon, 07 Jun 2021 23:00:22 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w186sm2679992oib.58.2021.06.07.23.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 23:00:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 2/4] completion: bash: fix for suboptions with value
Date:   Tue,  8 Jun 2021 01:00:08 -0500
Message-Id: <20210608060010.1676208-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608060010.1676208-1-felipe.contreras@gmail.com>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
 <20210608060010.1676208-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to ignore options that don't start with -- as well.

Depending on the value of COMP_WORDBREAKS the last word could be
duplicated otherwise.

Can be tested with:

  git merge -X diff-algorithm=<tab>

Tested-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 47b48fbab6..05606609f9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -356,7 +356,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cb057ef161..6b56e54fc3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -540,6 +540,15 @@ test_expect_success '__gitcomp - expand/narrow all negative options' '
 	EOF
 '
 
+test_expect_success '__gitcomp - equal skip' '
+	test_gitcomp "--option=" "--option=" <<-\EOF &&
+
+	EOF
+	test_gitcomp "option=" "option=" <<-\EOF
+
+	EOF
+'
+
 test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
@@ -2380,6 +2389,12 @@ test_expect_success 'git clone --config= - value' '
 	EOF
 '
 
+test_expect_success 'options with value' '
+	test_completion "git merge -X diff-algorithm=" <<-\EOF
+
+	EOF
+'
+
 test_expect_success 'sourcing the completion script clears cached commands' '
 	__git_compute_all_commands &&
 	verbose test -n "$__git_all_commands" &&
-- 
2.32.0.2.g41be0a4e50

