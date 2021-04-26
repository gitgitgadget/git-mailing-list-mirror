Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC08C43603
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03BF61164
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhDZQRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbhDZQQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:59 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB4DC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:17 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id e89-20020a9d01e20000b0290294134181aeso26802862ote.5
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YE93WeQLkhDC8PCnEEAgY+GsjpFprY/UOVl8NiYKJ8Y=;
        b=gxXfu1PuEhbH5gFf0ROwv+FqdUJ638Kuq8dK3hzHdrdDl1X571eoqCeOVjAXIcJvbj
         MtiN6fiJWMj7eqp32WY+GpyZWDQ5UMQC4Q4ahj8OrQSYoGrV5+Jp5VdGUSBQcYKNc0Ag
         7TpG4KLMPZOdXHrG+B75q7pI1HLUE+Bd19rdDYd3jvH4gDEo1bgDVtXsM1JcSOfakCA4
         53/PU1XyYivuuKT+b4tHNSjM6lB1Jj21u/4rAxMNwtAlALF1mb3fqqiMDup7Y3O2eSIG
         IZi1SRqpNz24XUNCq8GaubZh25Tb9hOYjow/Q2Y4yq6Lhr5KN5idbFhahBR5ThY+6HJz
         ms1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YE93WeQLkhDC8PCnEEAgY+GsjpFprY/UOVl8NiYKJ8Y=;
        b=r/5wKT7cYH6oXWN+ijnd9AXPeH/KZu3lxufp2eNX/zJKEek20BEO3KwH5hZfEn0GAp
         PJRf5YE8hS1dsue1sTCZDpatF93S2kiey1IhhebeDIhEfMV79Pb1VX5IPrMm4GvFaMu3
         cOjla4pW2rg1TZ7rfcmoJp83JzTT5okLxgQzLTdW09K+aaf+G4tcLzbm3BDj+YdFQdWd
         nJU10EAeMb7BZndltaN/eZ9er9+uad3tZ1qXGLATmXWU8pBxypP8QK+QIxzwY8goharJ
         s4PRd8QiyQ/FH56DTgs4jchDzDZq3XdI11BuCUu9PP5yC+GK0TinnAPvj97sxyRVLch9
         F3rg==
X-Gm-Message-State: AOAM533EWajkJ/DHAC0SI3sGX8WnX6vo1qMrKd0cla9gSZB3yKqyZ+Ie
        cd8IUvcjY1k9IOIqTQlocfWPdmfelUHWnQ==
X-Google-Smtp-Source: ABdhPJxGBz/arJwNKthysMh7h6CLcDNbHmlMnsRk1W7iPHghhF9Rdq3PHC8h6/umQ5yUgDbC7C8ruw==
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr15687407otg.252.1619453776691;
        Mon, 26 Apr 2021 09:16:16 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 2sm69881ooy.22.2021.04.26.09.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:16:16 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 16/43] completion: zsh: add support for general -c opts
Date:   Mon, 26 Apr 2021 11:14:31 -0500
Message-Id: <20210426161458.49860-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index 46564126e4..6232d0a823 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -232,6 +232,7 @@ __git_zsh_main ()
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
 		'*-C[run as if git was started in the given path]: :_directories' \
+		'*-c[pass a configuration parameter to the command]: :->config' \
 		'(-): :->command' \
 		'(-)*:: :->arg' && return
 
@@ -245,6 +246,10 @@ __git_zsh_main ()
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
2.31.0

