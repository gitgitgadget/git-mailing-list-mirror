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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C69BC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E002661158
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhDZQQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhDZQQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:09 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C5BC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:27 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so12396546oop.12
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMfOt+yTya2AASklWFX88cYlPjvsn+c/5pVwz4tdjDU=;
        b=hh9t6ZS1ZuZU1Th0cxpZHXDcl3l3nCf9kvMoK7t+U95gAjjVB87GjfD5GdXZ55HkXf
         +bCQwedP5GRDyaFc2wkJbVefLWeUlwv6LXcKQx8zD8nvgnNzbMsZI9Hv110JjFEeIorn
         KDLXOP+k6+cHdnrbUshmQaPuolvEeMWSvYObL7MYdPsn/Ze1uLFMB5jBUckghWAeGvqo
         tsH246I0BXaUgBXo32P/GY7ksy0RZ+4M7UyVgfK0JTyeMlZA8vighOs2qTwN1Bfx+1b+
         NaDaDtF+n4iV75Yx5nkqV93IibofNeeMJBXd7FYgG/AXbYJ+Lv/JVMpZZ6/xvCJbtuQ5
         HS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMfOt+yTya2AASklWFX88cYlPjvsn+c/5pVwz4tdjDU=;
        b=JRi0FgapKnaSoWy8hV0/QTzoe6o9QZYFRW7zFA+Np/+DVlqBRV1picNe14myw0mhF0
         AsHNidkF/T+2WE4hIlmkVe3sZRnt5BEO+5D7f3PvO3eJc9v3sC3yamp+frBO/MDaMYid
         3aZmdvIhIndxWzhUqIiyKAljZglCY6ILqMT0Ib+jrFrE/n3PiW0xv1rnt0Jd6DCz3QlH
         9Nim5xC1iR4AHYCFKLM3nQRTv1U8h4Hfj1WfyuiwLgO8EYLB8y7tzLIZtkyfbrsYIUmk
         uaueS5Pi2657FuR4RfCZ9KhDUK7PNVTNRZ55UUO8g1NC4dWofIb49SiR8Iyw5adcZ5qr
         4qug==
X-Gm-Message-State: AOAM530BvCoshWXnF2plgr1zqzzqo8IbxuupdI5M2MYoQqibkKxD3PmY
        NW3+FR8nVX/1N7Ft7bRmddZqZiaPrSmePw==
X-Google-Smtp-Source: ABdhPJzb4a60Jbr6+ai+qDVeYqX87g8cwLEfI585p9kWFHhPiZ7pkHLRVJSFM62cLRpDTy8A1UDf5A==
X-Received: by 2002:a4a:e873:: with SMTP id m19mr14192224oom.85.1619453726656;
        Mon, 26 Apr 2021 09:15:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u4sm65868ool.25.2021.04.26.09.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 05/43] completion: bash: do not modify COMP_WORDBREAKS
Date:   Mon, 26 Apr 2021 11:14:20 -0500
Message-Id: <20210426161458.49860-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index 0706f1e304..cbb2730bf9 100644
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
index 69f90913db..e2ea14fb33 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -45,6 +45,7 @@ fi
 
 local old_complete="$functions[complete]"
 functions[complete]=:
+COMP_WORDBREAKS=':'
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
 functions[complete]="$old_complete"
 
-- 
2.31.0

