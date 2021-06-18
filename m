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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CB1C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80744611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhFRS2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbhFRS2E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:04 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB02C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:53 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso10528153otl.13
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JnvrF9wESkQ9rT6UToReU1QFMk6JyHzfs0dXq6cjZ8=;
        b=HX1g9JhBG21Pibt+QCTHrDqS5zDC4mNMCsPr3IJ6EB2CfRq1ljF+gj4jo67j+y4jWU
         +f/PZsh0qf5LwED+zUT8shIX9SdqSJw9HLaDoO0ZMhHg25zGR+edcnng6hhabPync4r9
         lwJ4Q/F8xBTSS9MQ0bk9ssSaJG+A0XdTjeChjPw33AcoTqjbsj1d7rsrQ+You4LNzLkq
         O9mAJv1qvHjhJfR26vRXhSxrUqrvRlxuUa30qcco5Jeq0EW2GRhcWrtOb3ZwB+l8nsSV
         Wllea6ZYrJ/OZtqspCaSXjol/w8jDEJiy0tlQltfN/EzMmJxMTEOUWZJNFtKTGODK0iI
         c1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JnvrF9wESkQ9rT6UToReU1QFMk6JyHzfs0dXq6cjZ8=;
        b=Ay5ZI3eX3dYqH3XY9Rlj8aw1WcwCuq7GtHbfi5ADe8DN+FmupxbQIMj+DD5PLZDxfi
         80KynY/1wQZ/mKM4VwXtoAhdV93QtSA9akMz9AbelZnraub1dCmIWeVAv//MP9dnxU7h
         np91yW0Q8jYjX9p2Bb/cmv2dyiqFnO+cjdwH4CBl0KCEgS3qpQ7cMn8ZQ1PuwdzEss8T
         JVrQV7Srhd0ft5q+7hXQN/oQP0N2uMlU0fK4sLN7ppCn+luNrETs4XWLhAKBwzMZlSym
         zXjiKPx+6RhMQMNIV5Ddp9JrpeylJUFJ3XoOtOjTsv3calr6F496TIDM8aye+y+VIGkn
         WoYw==
X-Gm-Message-State: AOAM531Nml+4vvPmI8RljcL4yfxm71Rd4NGUU4j1/kc23O07bfs+eX3m
        FqSsDfYvAkaBBJKBXkJf24pM+SSQXQ8TyQ==
X-Google-Smtp-Source: ABdhPJzZ4mHNGpbIqNW8/oa1aHasJ2/oF5BC2sl1aBSJbEJlYx0zlVCZPxEygoYxhQ1W+5kr1s+1xw==
X-Received: by 2002:a9d:7414:: with SMTP id n20mr10601395otk.194.1624040752996;
        Fri, 18 Jun 2021 11:25:52 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v1sm2228107ota.22.2021.06.18.11.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 15/45] completion: zsh: fix options with arguments
Date:   Fri, 18 Jun 2021 13:24:48 -0500
Message-Id: <20210618182518.697912-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They support both '--git-dir=value' and '--git-dir value'. Fix the
arguments to support both.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 8cbf4f83f5..33bbf3d993 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -215,15 +215,15 @@ __git_zsh_main ()
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
 		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
-		'--git-dir=-[set the path to the repository]: :_directories' \
+		'--git-dir=[set the path to the repository]: :_directories' \
 		'--bare[treat the repository as a bare repository]' \
 		'(- :)--version[prints the git suite version]' \
-		'--exec-path=-[path to where your core git programs are installed]:: :_directories' \
+		'--exec-path=[path to where your core git programs are installed]:: :_directories' \
 		'--html-path[print the path where git''s HTML documentation is installed]' \
 		'--info-path[print the path where the Info files are installed]' \
 		'--man-path[print the manpath (see `man(1)`) for the man pages]' \
-		'--work-tree=-[set the path to the working tree]: :_directories' \
-		'--namespace=-[set the git namespace]' \
+		'--work-tree=[set the path to the working tree]: :_directories' \
+		'--namespace=[set the git namespace]:' \
 		'--no-replace-objects[do not use replacement refs to replace git objects]' \
 		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
 		'(-): :->command' \
-- 
2.32.0

