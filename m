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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BB4C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463D3611ED
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhFRS2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhFRS2J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:09 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FEAC0617A8
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:58 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u11so11511589oiv.1
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJcQ6gFN99CzFplbb3qLyaijbrXnk6PemYxzXnylJrs=;
        b=KCi3cK3phn+xgeFBJ7L313INyadS7R8v+7T75ZuS8ie/Yg92rXf+YWJsYeSM12R7ZF
         UVbk9GB+8IDbpFdmrgN+ZJ+CB1hqRvD5E8ktX+pVVDRti0X8JiSsoIy+ppKdEqyM+0zU
         U/7NuiXP48DUN9bSi/fntw9YLz2eOZZKn6X8yxqsT+RBhX/FDMNa74/MSvU8Fb8yHyE7
         4OR/RqJBhAQlNCT69KhJqvahRMncGi/N8QxD2bP0npsmnU/QIumpyFctHD/mR+d/Oin4
         F/J4pV7e3BtMog7KYghwCLJkTvMb8/otC32w+U8uiqE7yI0OHKdOGPX2+KEhTJQIz+Oj
         uakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJcQ6gFN99CzFplbb3qLyaijbrXnk6PemYxzXnylJrs=;
        b=HgpyaHxkK4DQXBuCOXCrfetu1DhOKH6kKjT+ITSQfkcFqAXERlrDheAZW5sQ6vMwlM
         sEvx+HzW5xSQ1ywZgOY53/kkTAQP9O5uXPvD8Vj3xOFh0sKboDIs/ELO0+aCR/3V4Zpv
         Ul4DOBgVpO6D4nPfYTmZYXzALG5GvoXmG2DXk6M+I9x6joqkxlTXYWJb1U1IXbCkuKFn
         jf9fxozmxrWxlNbX22PpVZRdUrVQSIyG5IlXbOXXnZ6dSXPAhic9Kb+PYnGelius9SFN
         GBdNVOBkt3WzIniGMh4yv1tOOu0EBYxNA3/H56+estb41y/OhF388vwlyPrUSAo95sdF
         1jfA==
X-Gm-Message-State: AOAM533RLciaTI45h98EuQdQEldbS6VO2rEtWWok1xjEs9xyDDiRJRbp
        oAT8EZpwW4fjr/N047ir8OprxRH2PzyhCw==
X-Google-Smtp-Source: ABdhPJwz0UmVt2wmO40fP4F95CktZ+z9HQ1iVsxRjlZ+8Nj+ByOuD3MdJl+InZkZkVt8bhhzHpTyYw==
X-Received: by 2002:aca:4d3:: with SMTP id 202mr8263179oie.9.1624040757911;
        Fri, 18 Jun 2021 11:25:57 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u10sm2280369otj.75.2021.06.18.11.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 18/45] completion: zsh: fix for undefined completions
Date:   Fri, 18 Jun 2021 13:24:51 -0500
Message-Id: <20210618182518.697912-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parseopt helper can generate the completions even if the function is
unspecified.

  git version --<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index f60801741a..5cfbcfe7a2 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -141,6 +141,9 @@ __git_complete_command ()
 	if (( $+functions[$completion_func] )); then
 		emulate ksh -c $completion_func
 		return 0
+	elif emulate ksh -c "__git_support_parseopt_helper $command"; then
+		emulate ksh -c "__git_complete_common $command"
+		return 0
 	else
 		return 1
 	fi
-- 
2.32.0

