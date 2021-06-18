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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850CEC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6807D611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbhFRS1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhFRS1q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:46 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B01C06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:35 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so10582118otu.6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRfU0FdazOvSRh5bUFkRqnoBSaUYu0K00H0qr8epigg=;
        b=qWvkCA+nHHRY5b0K/LzTRuYr04/7LJ8DYaw/TmeRqY1VUKT+NmIG0TOOMweEaIKv41
         lVZDz6rq99yF18XmJhXrfRP7np6YXnv26uXyhivYqVpBgj7HTlfVEcw2WIiz5lkSWHHu
         lOaKeY1ilQ5tco0Wtr0SJKBupCunKI5so7hukePXjqNZtDh7cFtev9a0XAKACQSqGEkF
         f9RvP7fXAlJ8wmHiH/9xpZd32RmRaohaUzC1pVzRU85q5MIvbaXvdb4LgFKgwnBaRjOU
         c4km0k9svHo5vSNTbzKiYs6fiCRU0oMHvBIFylfI/RaQJTrAjZZd8eld8hJ5BfCKol55
         MaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRfU0FdazOvSRh5bUFkRqnoBSaUYu0K00H0qr8epigg=;
        b=DVtLrfSw3lgrvUUHyouzwPlWP1S0DWrV48iJTZKLE59LVi15lAjDL3ijRIKkmO0Xst
         UbIb8+egyVjGTFdGwAGP2TPU3CuAluc7fw42L2krAOF8eNZ+HbU/hkJxgDh4bNUh7GUl
         Bfp0DUuZfEUXwUqjHkl7BaJaBtBf7jz9rGFbRSEYFREzCkOKryjjXTb7sGeDvzgDVlJG
         myITcpWkiOfof4Dz1faSZITfOdy13a12xw8JI01f46IA403yPF9iG9+B06nY/lyIPPHH
         quBmiqwMIVPyyitBvAZ2gfkOK50/m5wcl3V4YPt2ya3iDjcyaj8t3JmH+svVn2NRuuMa
         dZNA==
X-Gm-Message-State: AOAM531Fb8SzFzWCFzzQj+vx7uS7EyaOHKfysio96Ga8O+9zAUaNnonf
        no2VH4b/+yrc3jsfRneidekeThbVDpMOmA==
X-Google-Smtp-Source: ABdhPJyal4PrqPz3vcGARtJjou5CTBYsne6rwGsjSW9WrvYyeItLSvo23zqVfyPticoBDcZZWT0FUA==
X-Received: by 2002:a9d:4b98:: with SMTP id k24mr10825014otf.359.1624040734929;
        Fri, 18 Jun 2021 11:25:34 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u1sm1958187otg.17.2021.06.18.11.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/45] completion: bash: do not modify COMP_WORDBREAKS
Date:   Fri, 18 Jun 2021 13:24:41 -0500
Message-Id: <20210618182518.697912-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was no need for this once __git_reassemble_comp_words_by_ref() was
introduced. Now irrespective of the value of COMP_WORDBREAKS, words are
always joined together.

By default COMP_WORDBREAKS does contain a colon, and if it doesn't
somebody probably has a reason for it.

Completions are not supposed to modify COMP_WORDBREAKS and none of the
completions in the bash-completion project do.

We manually set it in Zsh so the Bash script is not confused.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 -----
 contrib/completion/git-completion.zsh  | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 943995689f..bede8a7e2a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -54,11 +54,6 @@
 #     When set to "1" suggest all options, including options which are
 #     typically hidden (e.g. '--allow-empty' for 'git commit').
 
-case "$COMP_WORDBREAKS" in
-*:*) : great ;;
-*)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
-esac
-
 # Discovers the path to the git repository taking any '--git-dir=<path>' and
 # '-C <path>' options into account and stores it in the $__git_repo_path
 # variable.
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 9f0e03e86b..5ddd2d6771 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -46,6 +46,7 @@ fi
 
 local old_complete="$functions[complete]"
 functions[complete]=:
+COMP_WORDBREAKS=':'
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
 functions[complete]="$old_complete"
 
-- 
2.32.0

