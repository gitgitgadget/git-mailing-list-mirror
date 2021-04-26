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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC3CC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D7061159
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhDZQP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbhDZQP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:15:56 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703A3C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:14 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i16-20020a9d68d00000b0290286edfdfe9eso41974328oto.3
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XdpVZbBb51lRACz6fnNhegxLQsigIZLmLPFefdHcqBc=;
        b=DXa/Gdjhs7WurM1CevMQJ3kcKjCvDQudfZfnqfC/vEkQd3QbXC7HstQDTX/CmpPeGY
         BqaRpmZKE16cWXFgCrbt517R5TnrJWMiu5AIVBczZlfzhnZmQ1SlStIrtM2XO6XbS3eY
         Snc46uiRz4XqXSEQO1j16NV5HD/LQALdKKV87YG3h5GsgZwMlI7Bjf5J0tNBDWAzv+jV
         rTVPSZva/M/PFzx7LU/jCC8AA0K8U7+vyNpBP9eBKOm6alxrmbN3oFAyZT7+z/OBttIz
         eCt9rpsvGk8P+YkJPrNBSSq2L7wnp11u2oy1XcibESU4RVlbkdow3d4RAX58H7avxsXy
         dQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XdpVZbBb51lRACz6fnNhegxLQsigIZLmLPFefdHcqBc=;
        b=pUw5YQyCVstgG6xvalTb9pSh6uZIM+Q91axMYmItrauHGaNpRj7xwRoYsdjW4RAleJ
         2jGI435L/BfGlGU672mU45JnJqCLmUNTKMnp7H4XAsn5MCGBAARNrKUkrs4SD3e7L60o
         iYlBKg33fazjhomV78fBX+evBm8sIQBV+9RjqX9FUl9xQP/w6bHB3NSptGLOtvPJEfw1
         AqigRBOBFms+ZNYHbvd8sKhJQDSusSuzEcVWaAzu0SUB9bF/y7LZosiIaUbrocXGBxbO
         lbFIXVIHqQ/X6G+fp6ZKzxxFTH2/IheJrnWpYxZzdR0Fo4PMeN+McPdrZpva24r8LP2S
         lX2w==
X-Gm-Message-State: AOAM530eozA5GOq4rDbAsLQ5UjNin9WY0fJJsYgRL90R3mnY1VMwfpOH
        VAZcu3oydC79aWp0q/AHOn4nLXyM4+ar2g==
X-Google-Smtp-Source: ABdhPJwSWtpo+IMW9NWe3x4pQn6ICCyost350EUtmnEvkzdyAK3Dg+HiN4BnVqdYL+4uST3Brwx1gQ==
X-Received: by 2002:a9d:449:: with SMTP id 67mr15017534otc.333.1619453712780;
        Mon, 26 Apr 2021 09:15:12 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id f9sm62530oou.48.2021.04.26.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:12 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 02/43] completion: fix for suboptions with value
Date:   Mon, 26 Apr 2021 11:14:17 -0500
Message-Id: <20210426161458.49860-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to ignore options that don't start with -- as well.

Depending on the value of COMP_WORDBREAKS, the last word could be
duplicated otherwise.

Can be tested with:

  git merge -X diff-algorithm=<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 contrib/completion/git-completion.zsh  |  2 +-
 t/t9902-completion.sh                  | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3323b770e1..e7173cfcdc 100644
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
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6c56296997..69f90913db 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -55,7 +55,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c IFS=$' \t\n'
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 04ce884ef5..7fc8eed375 100755
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
@@ -2358,6 +2367,12 @@ test_expect_success 'git clone --config= - value' '
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
2.31.0

