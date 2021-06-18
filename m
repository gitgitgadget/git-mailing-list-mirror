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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DF9C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A952D611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhFRS2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbhFRS2K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:10 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF56C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:00 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id b24-20020a4a34180000b029024b199e7d4dso2344763ooa.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZvKHds7M4uEFzudoySAlpiECLLXAMj37W7YMAoHiq7E=;
        b=ZboUPXcG4ld9pvR8XFGjks4hmhQO7bqp2zT4qXSMICILPRU5GElyPkCQ0bF26seTy9
         XH4uTt6WdCgsx5t/sqvWaPZLsqrHr1JnvOzyXDWMryKMYgLUoG3/QStjniD6IarPsDf9
         tSRplR+jzcZMCXRLo5tpBYGjdoHxZIIDwLViT73JIR8XKg78258SSSA2nOOzoP9Bl+Ue
         dmbtK/Wl9JDD9+KBATB9gEzbauy4NYANR9EzzMdba6/Kub6NR02NOe/b4x0LIt3sfJdF
         TOU646i3kALE2vVjnc6fZa6eDoodyaw7U1b4/PJG9ckDDxu3YHPn6mKscMyUcMaTfRJj
         x5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZvKHds7M4uEFzudoySAlpiECLLXAMj37W7YMAoHiq7E=;
        b=ohq9EgYAjhA7IVqIAb1C7w5snL93NtGeS7N0B5hfpwmLLgRVHXDQJt/GGXkQ0ykC1N
         /2BQ2I9oiEhqNpg/ue9KYrlD2TEkZUddx5Yv02QTVvv0XQkXu19xW+HmF3uMVQDGueJJ
         uB5HVxLKH/1XAR7Xk/mep3dDg22MdSDuLidqduX/uMU4YtPpbExH/+fI6D6O4ZoqqMvl
         u8wURPC+EbLNAumZR7tkwzkgdh/OU6V4ZJKFHxKtP0MG7hzmbi3OtddRhdR9susm0aw3
         Bg5n8N1F8eC2gRlnjYsOAT/PBTrJOg76qcTYqfab7CyjPPCa63bll9mwTQAHaYRkWuV4
         Jhww==
X-Gm-Message-State: AOAM5327j6qpHb7ldo64z+gNmgsEDUzsBiR9Lhe3VY+xqqm7yHWmw1rm
        oQHC65skil3yKeA0VlsrWp4LAjRg2IB4Cw==
X-Google-Smtp-Source: ABdhPJyAN41R62yFTmoeevPckgkHnHUyWoKqkbcHg2ZGsGkJkCK5fB3k78zn6EEVh5xHrw3d3a7QAg==
X-Received: by 2002:a4a:e6c7:: with SMTP id v7mr10289567oot.86.1624040759605;
        Fri, 18 Jun 2021 11:25:59 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x31sm2133911ota.24.2021.06.18.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 19/45] completion: zsh: add support for general -c opts
Date:   Fri, 18 Jun 2021 13:24:52 -0500
Message-Id: <20210618182518.697912-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we can specify configurations.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 5cfbcfe7a2..f3e8cb7535 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -231,6 +231,7 @@ __git_zsh_main ()
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
 		'*-C[run as if git was started in the given path]: :_directories' \
+		'*-c[pass a configuration parameter to the command]: :->config' \
 		'(-): :->command' \
 		'(-)*:: :->arg' && return
 
@@ -244,6 +245,10 @@ __git_zsh_main ()
 			let _ret || break
 		done
 		;;
+	(config)
+		compset -P '*[=:]'
+		emulate ksh -c __git_complete_config_variable_name_and_value
+		;;
 	(arg)
 		local command="${words[1]}" __git_dir
 
-- 
2.32.0

