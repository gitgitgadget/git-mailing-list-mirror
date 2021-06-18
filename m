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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155BDC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0015F611CC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbhFRS2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbhFRS2O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:14 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671EFC0617A8
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:03 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso10548128oto.12
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HcR7r7lNHBbisAGzlImzTt8aK9UKElQOVUuSbVYiXc=;
        b=CrQFJ9GEs2xeGXLIrNdD1K6nEMe/IY9Vmc+1CHvJ2i8TGX1aLQBICsdnOdoUT801mL
         WXpd44mmI15/b+xE5gh9YVhL7G4Tu8doTlsEMm0TvvwvVC9vvBdx2yW7caizB8Lppw72
         2rPPwZtXItOCM4LRMFT8i+Vhlq5BjanJU5QSkbHHzUFrGwE0M/l6EQTEe1G//8AhcmNC
         YkcpwHpUbThIzLY13oYnudxaykdTNZYGLQig09+mTMoa1B4nIk0pFqriFp5BeV/KZV0f
         CONbdb+ALUIT+zkncp3wfT+mt6UoefwyO8TSWXjQkMm30CFu/0tVnFpoprG2+aChY87X
         oCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HcR7r7lNHBbisAGzlImzTt8aK9UKElQOVUuSbVYiXc=;
        b=jxFRHWGd+86FaieQpFQ8lJgvNdCzrSaPMcAwGRAk8ZHE5xWjIhZg03RvEJjf0TwTof
         3SSXH3JR9OlBFA2fzmi2apedJ91Vq9XhrTDbuuKHYeVIg8sKrHO6aEMpxnzESnQnPZ/O
         C7LF7TZu5d7kCR5pteil4h/gChj9sb0JVNji+OL4elk28AjC3+up5JIatYfCkxXl2E5m
         7LGS03AgYvG89o7LvfoXuGp5MF7tmmcFFPaURVTf/H15e4YKl5uwASFtjklxSBHUHMkl
         S5DxwTSgxcC8PWDPhFiPvb2LHIvRralnd9Fs2hrdgbafhOzBRDGOpRwXcFrNQ/FOog6n
         9dPQ==
X-Gm-Message-State: AOAM532ZO9qdQpr4F0V9z5WENWxisocJ955lg9OwIoIUgO8IEAwcjvZy
        xKlDGqJVROhE4U7LfhA1qrXFK8XLywJsAA==
X-Google-Smtp-Source: ABdhPJxHRRNwuQ5mWxaHT05yTov0A2oLALotYwhgcbI1wa4gevdGfRlvddFf98E7+BEbFR+ksU+OSA==
X-Received: by 2002:a05:6830:19fd:: with SMTP id t29mr10884568ott.296.1624040762572;
        Fri, 18 Jun 2021 11:26:02 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x73sm1125543oix.1.2021.06.18.11.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 21/45] completion: zsh: add excluded options
Date:   Fri, 18 Jun 2021 13:24:54 -0500
Message-Id: <20210618182518.697912-22-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more excluded options, for example: --bare excludes --git-dir.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 56a1bb16b0..426eec10a2 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -217,15 +217,16 @@ __git_zsh_main ()
 	local -a __git_C_args
 
 	_arguments -C \
-		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
-		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
-		'--git-dir=[set the path to the repository]: :_directories' \
-		'--bare[treat the repository as a bare repository]' \
+		'(-p --paginate -P --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
+		'(-p --paginate -P --no-pager)'{-P,--no-pager}'[do not pipe git output into a pager]' \
+		'(--bare)--git-dir=[set the path to the repository]: :_directories' \
+		'(--git-dir)--bare[treat the repository as a bare repository]' \
 		'(- :)--version[prints the git suite version]' \
-		'--exec-path=[path to where your core git programs are installed]:: :_directories' \
-		'--html-path[print the path where git''s HTML documentation is installed]' \
-		'--info-path[print the path where the Info files are installed]' \
-		'--man-path[print the manpath (see `man(1)`) for the man pages]' \
+		'--exec-path=[path to where your core git programs are installed]: :_directories' \
+		'(- :)--exec-path[print the path where your core git programs are installed]' \
+		'(- :)--html-path[print the path where git''s HTML documentation is installed]' \
+		'(- :)--info-path[print the path where the Info files are installed]' \
+		'(- :)--man-path[print the manpath (see `man(1)`) for the man pages]' \
 		'--work-tree=[set the path to the working tree]: :_directories' \
 		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
-- 
2.32.0

