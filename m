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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167D9C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A5F61405
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhFQOho (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhFQOhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 10:37:42 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27AC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:35:33 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s23so6734340oiw.9
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cy3WP75DjFgSdHbIbldKJvfuf4B4avPb0n6FTHa9Cf8=;
        b=cuCqvM6jJJ+tBEjr6bOl0gctkMXLRG4rzC3L8dGPjxpkR1W6nuPeTUExaosFaFsFph
         +oFnX0cnNOB6FaPDzgs16tJ0fnG92n73Wt+Sxv+qu3Mx73CDcOwmvNuLv5MOC4X8tF7Y
         iMAZ2tcsvK399jBfUNC1Uq1iUO38pzK2gc8+IUKMQwcz1IK47IiFLslACugrEKA/9Nzd
         l0/ohXuDqWAWqDTZBfWIVafrmk4Fx+fUcMOqzLqlEXuWR3zsRmQU/N/ct0oHdsBXH6g3
         BPC7WYmgMZBxHFqlzCgvWw//y8E0mnTEbannG1vlk4YXnmCIaEIfuiFcimjwmfZ1lhyf
         Iq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cy3WP75DjFgSdHbIbldKJvfuf4B4avPb0n6FTHa9Cf8=;
        b=SsVl3zg75hmofnHWHG4tQmgXqwkBS0l3mfiRGVZxT5SYQHy/lJHpPlHebCLeEGC5KB
         msEZ9DdiNdE9/3o+BSzO/d2hVjbjMoLe5b7vcXDGY+pBeDn5jL3ggfRsyp6CvYjyk7Px
         OosbwSvMbxVhtDPW+krY7L6OY+kOIJJ7uFn0LrNFlusO2qzXUvCnLdn9gTwtXTVUQ4Xp
         AfWOZ2NSHTUfqK8qPXr2Ytc2DV+GO0AZgLCZU5XarjJxGjOB5LAsFLURQiM5ya5QK/Uo
         DschhvLjqs23hie6uL7TCwbeHf5VweX8UGzgVfYIA1BEo16eSGG97ScR04oDVEzW3QN6
         TL9Q==
X-Gm-Message-State: AOAM532zzii/LkJH+Zvir7EK0EqFy2T47l5HxD6d/7dZ385fjUwq1a4+
        M/Ckic8aXlOWagCvax6wsqRy9WPEDuO+5Q==
X-Google-Smtp-Source: ABdhPJy253ysvhPqRPnt1CoB7JISNlzLuRZDOjmE1LH4PP/U0y87+t2bSyaj+0II4T0iUTK85H2oMQ==
X-Received: by 2002:aca:3bc5:: with SMTP id i188mr3619053oia.72.1623940532437;
        Thu, 17 Jun 2021 07:35:32 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e29sm1147180oiy.53.2021.06.17.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:35:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 2/4] completion: bash: fix for suboptions with value
Date:   Thu, 17 Jun 2021 09:35:25 -0500
Message-Id: <20210617143527.77329-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617143527.77329-1-felipe.contreras@gmail.com>
References: <20210617143527.77329-1-felipe.contreras@gmail.com>
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
2.32.0

