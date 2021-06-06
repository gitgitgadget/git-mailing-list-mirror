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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB2FC4743D
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01A0613EF
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFFStd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhFFStd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 14:49:33 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1856DC061766
        for <git@vger.kernel.org>; Sun,  6 Jun 2021 11:47:43 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso3601748ooc.13
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mv+Cefy9wvrPE14KIoxHNQPN4t5LZB/xfpHKLXR6F+Q=;
        b=Fim3tDCLVF8+ERNWtHmxxfp1wMv2cNGon2aVaxP1Q5NJTtXxBJOhlNGqQR57Km6ZBK
         Tpn8Neq5ScTOLKK6k3eCyDvY4lalRLYRDICbcniNGRnRPW/KdejX/7AsAy4FxdUaG97a
         TTGAt9Mxu7rJ4J4+kX8jl27pyXLl7TR/bxPW9q9yW9Xgrfxaxf9nO0953sqH0DCjqhxf
         XDpM9xrRDG0w7eI/1C1sgWfg4jCJedLjoKeiDXWQheG89pIonBkdV3y2r1M8bIYHc+bS
         L0vE5Y9FLsnpbA5Xjuw/EzRJcRkRcjOkWdaEq65ytyIMOy+ZZ7wTnP6PvBpKGh7FeShq
         69PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mv+Cefy9wvrPE14KIoxHNQPN4t5LZB/xfpHKLXR6F+Q=;
        b=rrBqenvX2asFpHdI9FE3oQkDpGBW9Naj8sgqKKsoOuKMmSmm8H8vt/ODBh1zNtSYD5
         NafiDQc5YIDHt8ga9IuP6iSjH8aHkgZMyf+Y+ArGezQ+R5hca8hWbe/6n2QDZKOEHnBQ
         sIBxJYtu+7DhXzAnI1NpDkk7A/F1rKCzk8qMSzYZ6OZjbnwSXisO7djs9HOVH9gt/rGI
         PmNQk2SUXoLFhB0is/4gBukAoOuj9Jd0nhWra1M2x6oriUMBCoIYaRSXyX18qgZn827/
         A2d1dwiwO/FRCvHegTjEg/vHcHL3V/Cw+vpOr7SGQeJITsB0bWNjrqPutSXrXm/W1Q5Q
         IW1g==
X-Gm-Message-State: AOAM530LnzxZW2a7hC37Vl+l9gYasOJYR/Pg5lBFF5UWbOXFNGsmM9J9
        KJlyZLySQz2YwrvuSFZOVE87qmlLcxashQ==
X-Google-Smtp-Source: ABdhPJxI+GmNC1kiFWeql2gaq4acix/BHCRPWztNOMs+iZFUlr8JXI4RCEXgP8tMqvtLBI2Co3D9Ng==
X-Received: by 2002:a4a:85ca:: with SMTP id u10mr10896918ooh.80.1623005262285;
        Sun, 06 Jun 2021 11:47:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id j26sm1867709otp.15.2021.06.06.11.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 11:47:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 2/4] completion: bash: fix for suboptions with value
Date:   Sun,  6 Jun 2021 13:47:24 -0500
Message-Id: <20210606184726.1018460-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1.2.g0532ba4bf6
In-Reply-To: <20210606184726.1018460-1-felipe.contreras@gmail.com>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
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
2.31.1.2.g0532ba4bf6

