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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CD0C4320A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834B761B5D
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhHPJLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhHPJLD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 05:11:03 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8AAC0613C1
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:10:32 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id b25-20020a4ac2990000b0290263aab95660so4742284ooq.13
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pBJDJRFPG8PsuqUZ7/xyal6w9nauHokJcq7BwxuhENs=;
        b=uppQlyyr1xpBqnxede2pIRqueECaJTXJOoCa+t8+V1Q9LVGYNmenZlwuBuvAo1Awy2
         8iiEzWRemqGw72DooPyXN4iV9Dl5hPqdu1mcsWmQLay+1oKRCAmL+XkCl5GrutijswHw
         gADK4/f2JKVVqN9D0B7FflVZCMewYFmcoqpgESlFFiG5De1CwfeGZdTMBQy8TJOBFjgF
         bNCYNjTfh8JPi0MXT+QHthGbDcnbYTOTWBmGEV1IgSAeRRAiemhN3aJVBnHLeCaizJba
         GBiKj5KND55U00LPj46MWu81vJn9EtfWo25yLzMwjNQziaNnKX0qAKy2SJU++Jr72+nJ
         7onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pBJDJRFPG8PsuqUZ7/xyal6w9nauHokJcq7BwxuhENs=;
        b=t3B5CrN5Fp+X/6yXvQCuYPp3sgCwIP8q6SLJCW4bMEwxATeFYcmxVmtU0nDX7VeVjt
         xMyq0RRKjlQGERUItBH+KsqztU0sszVdVMBdDbg7oDlvhtfjV/GWU7vPZQPjWkFHwQaY
         jjsNpqKoV12oXmweSFOQ3LgMBXPUWSVwDPCQImIiC4Pq5zJNLQptUhF/98nCe8cIMUtg
         FX3a7DaVZdWO3PdZ+W0l3fG1dQJHZ08VIamcDsFOaYofCQPwK/oFvOSkAPDxj4UebhXc
         v2mPC7CRxEm3PDJMYd6isoyyIXBiOlOAUXfs6RGILvdckB8XSTn6iD/xE0yglLf5Cvwj
         a6ww==
X-Gm-Message-State: AOAM532gBZmLUAPky2A/CZ3uBq1CFWJKlrNjS+/exXQ3/W0DspukLTvX
        hznSVgXnp/BoPgkpuz27EoaZQ12Uod8=
X-Google-Smtp-Source: ABdhPJxUtRLi1c1NNX1vnpB0/LKjDsQWSSCm4MHgq/+Tmm8CGR79FQeWQ2K1XvjzQRfr3/2R77xJPQ==
X-Received: by 2002:a4a:2c49:: with SMTP id o70mr8995521ooo.71.1629105030232;
        Mon, 16 Aug 2021 02:10:30 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id z7sm665518oti.65.2021.08.16.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:10:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 try4 2/4] completion: bash: fix for suboptions with value
Date:   Mon, 16 Aug 2021 04:10:23 -0500
Message-Id: <20210816091025.548095-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
In-Reply-To: <20210816091025.548095-1-felipe.contreras@gmail.com>
References: <20210816091025.548095-1-felipe.contreras@gmail.com>
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
index 6bcf97ce79..7aea1abda5 100644
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
2.32.0.48.g096519100f

