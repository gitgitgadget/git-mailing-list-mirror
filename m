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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA8C433E9
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CB8207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbhAACRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhAACRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:05 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62AC0617A6
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:49 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id b24so19328585otj.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTlh3GGSQV1wqMcx0z4En+dfaeITqB4RVZ2PZBZNPt0=;
        b=nNGdBjWl32CHdDCY0vDViNqV58A9MgBKiGW0b1/CtJVoZHPkuSKBINXsj68wKriPEB
         koKZEdx40rI4KYos0BO7l/dq26tCKDamThx0EeyH9HB0/bimOVmRPxdAOBAJ5Ww6QKNa
         geM3j4Fjp02CwYNcISQNMrJCU1oyHeGMTDQIcczzyymsAoCU6SBnRb52JO+hsEpvmw9z
         BrYFdT1UUxeELJnI52s06hDqb7Wpda4wiSOtO6k90Nm7oxLzBNHUoPYs5XgBjCt8gZFl
         H/5uB8WaRv/Np8Oj8p0ChszY8M4Gga9H1NHcwjxR3CB5tvbz5zovslo964LJWnIEbYeG
         X2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTlh3GGSQV1wqMcx0z4En+dfaeITqB4RVZ2PZBZNPt0=;
        b=hegUq3mXS4GRVLPmagvQFfDzz0rpldrtcsiM98151a+CVhdWw4nOIHTEJhHmwJE/Wp
         s5f/0mzcsUxuW/N0VGBJepbRbfAZs9DJ+96RqkU3DJkr5S6Ujaua8bkiC87sBYiAJO3e
         HkVQyZKwrZ/rLP+3NMliDSeG72Qcwekly3rI5K8LXwlEWqawp9FDV24lDWRXrOk+7iBe
         3wGlO0glqAeGY1d0YfVNHGE66YkhpGiqFfCoLHV5S4qeC5e3OouWZkVO8ZDfkNOorDYs
         9nGG0vCeP/ToZznIYJU+vFClvFKyjb2KUZ1mqw/OZ/fGWrF+BFvHomo9p6aA1LFA1Gjf
         OrLQ==
X-Gm-Message-State: AOAM5333NRUKdDndJXOPd0ks4ivsHLjABt45nsEmmXviXmnnSKkPByjV
        uEVt/vI6hGmCGRF/z9GJ54LSClrb1tY+hA==
X-Google-Smtp-Source: ABdhPJycOb32pjaX2fxLv/vg5s8U1WbHXbZCVt5EZiNaUj875pi6QJnpfRwOFBTUGWarO1BSDHIBTA==
X-Received: by 2002:a9d:73d1:: with SMTP id m17mr42612960otk.187.1609467409037;
        Thu, 31 Dec 2020 18:16:49 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h93sm11569501otb.29.2020.12.31.18.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:48 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 15/47] completion: zsh: fix for undefined completions
Date:   Thu, 31 Dec 2020 20:15:50 -0600
Message-Id: <20210101021622.798041-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
index a9177c7dcb..46564126e4 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -140,6 +140,9 @@ __git_complete_command ()
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
2.30.0

