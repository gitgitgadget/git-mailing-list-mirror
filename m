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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ACBC433E6
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B1B23340
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 14:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgLWOtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgLWOtc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 09:49:32 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246A3C061793
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:48:52 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w3so15162093otp.13
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 06:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqtDNFOwOU5xPt2CVHgesK1Ini4o5oeEVc3kkxCYIak=;
        b=VOeEF864EtO/ZUa1k0eFqpVQ4vH0XUfKibD6+D4I6dgo8GHaqr3I3AUCMZcA3Zius+
         aaUBcLBiAbRj+eLT7zcKuMRE1Tc1fp53NWpOga2KIboOVXnHgaIZ+QcYAqPt2h7veME0
         a6ztImBtw7RxhkPJW95Qm3UxbOudL/24PZG3QaL8wht56R2sQ/gzQxVVJJaO9+cqdeE/
         iL4WWbm/wiGZYneGCNrcnBSuwxh5J6ZgOoYQ0YLN3E8XWexsEIbGyvwo5scTrqTjjLK6
         AT2eBEiII2ANqR+5fVLXGaz6FyZnqafdKZZwSisr5ZrHabhIgwaIQnKoooOmc7qJdztC
         W4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqtDNFOwOU5xPt2CVHgesK1Ini4o5oeEVc3kkxCYIak=;
        b=ek7Q9YOsU06smECtcJAAFU1/gcn2sXzCxIQjISbHS4IiT9834fmT6aygy55Rg/CD0z
         qFPaQ73OQvREHm7D6iz35URFkSAYGF4G2A4AJkgrtmN5s3d5DY4bRCqTv/SZF29cLp88
         Ztkg57DDoyb/FsicMg7sjepMD4RPX1UwtBbYY5l24T0LpDPiP/Wqq1Limv0zuR+QuT8C
         LYnY9vW/8EHXQQcWWpPUwoXzRAAfam6a0bvxXpFWkUqUvaCZkHxQ1EGeBo9YUNJk+pQK
         WlkTBvZczbYYuVs1XTBJ9W2HRlEN+XhnXr5lr08lWfXMFslFzHERplPUghXv/+1KfXUw
         L5Og==
X-Gm-Message-State: AOAM533sJx075W0Hv7/Ac0ysVkXOmdZaVDm/nBNsAqd8yrALpLfLzibm
        +tU/dfn3yzBBTwX5wsBuGG9mD+nHecijyQ==
X-Google-Smtp-Source: ABdhPJxoWZVqeTFBhOdv3dxGbMImJ99VMTqwq9e/l05nD4E19QekNRnfWxrs6kj0eHAxOGrjPEawYw==
X-Received: by 2002:a05:6830:1be9:: with SMTP id k9mr19748623otb.226.1608734931354;
        Wed, 23 Dec 2020 06:48:51 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 126sm3303699oop.30.2020.12.23.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 06:48:50 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/4] completion: bash: fix for suboptions with value
Date:   Wed, 23 Dec 2020 08:48:43 -0600
Message-Id: <20201223144845.143039-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <20201223144845.143039-1-felipe.contreras@gmail.com>
References: <20201223144845.143039-1-felipe.contreras@gmail.com>
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
index 10d225cc9c..10e69af9ed 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -347,7 +347,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 81a728c743..c41030b6cc 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -537,6 +537,15 @@ test_expect_success '__gitcomp - expand/narrow all negative options' '
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
@@ -2354,6 +2363,12 @@ test_expect_success 'git clone --config= - value' '
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
2.30.0.rc1

