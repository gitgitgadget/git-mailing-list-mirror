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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B6CC433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96BD20798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbhAACQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhAACQt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:16:49 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8FCC06179C
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:33 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id d203so23463615oia.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SfpgsUg8VQf6Ve+Ijsx6DZzeMM4wR/GyWrZ9ybtN6Ds=;
        b=aucRO2WrVDpnIXH5JeW4fOBFuneTuQw7r+cagGHWz37mRW3wlFGlWzAF5ZD/Zlfgcp
         JJqNcrYLGXgJZIQq21g88WPTrGqqFL8AzC7UJF4bLnxF27TWfE/cHxwhGCL6ZiuRtFIw
         kDUSsEh2C6x/yeWTRCniIphIAz4bvvoJzh2rsS0tOS+JJSMkIBHjNFsFd0qkvyQZf7xv
         vPj1waSzwawFPdPPjJg5v1hd29gDW4Aj8rIOUOYa+FeUU3nMWqr6pmBNnr7uhQPUKAfa
         dV5monVw16ZDQWIHCrNa3BmCVvqyDPUisaAAkIxbOGkt0dpFGnFlteBSn0nBWMUkpK/G
         FcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfpgsUg8VQf6Ve+Ijsx6DZzeMM4wR/GyWrZ9ybtN6Ds=;
        b=b4ACTx7ikqCH7mpJcuQGxFKuF8SxsyPTeKwOBu88Jw5AxVmhmN7IarYkdMsOeDFcw9
         Vu15hfu8SyLGu2wYhzEVs4V6paoSSQ8IlMVRm5ghQaIIP3T2tGUdjfCpyPURUbJKoKdq
         K/40AyFzAbQe0h2SHzcgSnwCKxY1A1TOyP/vMf7gyzkjqqaBt0XnpFoOjHV9u+uYqGA3
         UpvbQY9ttErgg3quIbVOE24+/uktZObkQ1jf+NB/mSKL05Xsnor6EFez137XghU2UE1J
         R2KA0tLPU6X6i2Zo86WBSXgD1z7EfDqsqgyYtHDAzupoVEpopCtSeOX7LtMpjfzJ368v
         rxmQ==
X-Gm-Message-State: AOAM531bPqywllhpIi2Csgp/pu5frHcWCoxf3ptffOggwDUui/HEOxYX
        TkAdyMme1zrpb3+XfnxtrlgdD++gMuZ8uw==
X-Google-Smtp-Source: ABdhPJxd9CstY/ntWPBEr7O7xbtxJxhKD077ISIy06iZpuarJ91fhxb/o+0yvUjgmHPkVMRWyqrk7g==
X-Received: by 2002:aca:aa83:: with SMTP id t125mr9194071oie.103.1609467392721;
        Thu, 31 Dec 2020 18:16:32 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l73sm9440916ooc.43.2020.12.31.18.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:32 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/47] completion: bash: do not modify COMP_WORDBREAKS
Date:   Thu, 31 Dec 2020 20:15:40 -0600
Message-Id: <20210101021622.798041-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
index 926e9ceb56..9ea31f7d4d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -45,11 +45,6 @@
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
2.30.0

