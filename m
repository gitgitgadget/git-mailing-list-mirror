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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4963AC3526D
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3BC23B52
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgLSOHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 09:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgLSOHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 09:07:09 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE7EC061248
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:06:29 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id l200so6187885oig.9
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gj2etuvarE1/ePEBdF/7YM3vl9CtQrgSFNEjoBu0lDE=;
        b=I1gaon2AxkSLR2IjaFZkAVST9U4TzGgF49pzoDH0dgLp9N0aD98KbASDd3LT1tNVMx
         s93K3XrDR/v6ces/L19ivkJcaXrL7ibcJiegGZI/M90nyUrHFzVPFg7JEeA+mkiqjdb0
         sKOA1hhyoanJdptggjAZbTb6TgNmwEK23gxwofrgPqypejSb0NIklbkZMv2mvUm8PI2h
         6lUkdABs3VL2C8Sb94pr5Aem35yEw43aHE+AN25wnyrk//cujmjQV3HZJQYr97/myilI
         2LmX/S+1kvWxK+lEU5IcZM/PZcPf4f+uZ4N5PPbfE1P6BThFRIy1Nj/NX5qLQ0kXJJif
         K8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gj2etuvarE1/ePEBdF/7YM3vl9CtQrgSFNEjoBu0lDE=;
        b=AcMDvpiCGKQGYG7PXCe/ktfKdQ31BnH3yNYGws7lNlMnAau8ni21O/XyUbod6EoONG
         Odzfs96iPtCevMaQcJO+Q8s+Mko9DmQSO9Zw8f+MsdmdBHqlfHP3X0RadyVMo/oKM1Ec
         2ndSzOnD03euE8Ou+R4kuU+hP1EiP6LSM5fVpFnnIfEnIqiyCsl8FGPHvt0nxXTiN9+P
         O9xDtsF85K426nysSRPmf13RYbLHu3nJDZw9sK5HcgarfXpaLGO6SDsLZz2sNN45ZTMO
         KwUXkzgbYBSMZZKpCQ8ee8nVkLb+N108meaiM14TfJ3ZI5iDmoIwy0BErx7OdK0P+Lvp
         MBvg==
X-Gm-Message-State: AOAM533lWqjPrQMm4b6yHrorwB7J2ImAPTRJuAxnzA8XC714HnflZb1+
        pQ9a22kSZorlOM8IrF+epnpXOZnk/QMorA==
X-Google-Smtp-Source: ABdhPJwYeHpPT30Pms7iv2u8SwZ3D30IGBRqPJwWkiUVvsHgqB/NRQ4xHJAQAMki7E5pkp9psA7RHg==
X-Received: by 2002:a05:6808:6c2:: with SMTP id m2mr5783767oih.123.1608386788809;
        Sat, 19 Dec 2020 06:06:28 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a195sm1614989oib.52.2020.12.19.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 06:06:28 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 3/4] completion: bash: fix for suboptions with value
Date:   Sat, 19 Dec 2020 08:06:20 -0600
Message-Id: <20201219140621.1961760-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201219140621.1961760-1-felipe.contreras@gmail.com>
References: <20201219140621.1961760-1-felipe.contreras@gmail.com>
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
index bbdb46d87e..5b2dff150d 100644
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
index 4a3d3d1597..4deda01153 100755
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
@@ -2342,6 +2351,12 @@ test_expect_success 'git clone --config= - value' '
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
2.30.0.rc0

