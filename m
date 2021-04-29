Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B35C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB6E6141E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhD2Ion (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 04:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhD2Iom (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 04:44:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06569C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 01:43:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h15so13714340wre.11
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Pk01i3F6OKXkufOFtKbiSH/nCE/KwOnzUKC1ocDoWr4=;
        b=YjEQvPQRDxAZLchee/QkH2wn0lW02/yOvM+8XnJpZt8h409VypxHqQr4n6BL8h20mE
         0u0xe+vXxg7it3RgaYj1uDxzufmN4i4BT49wY1rVDDGKIU1YKsakjPoMEDtocJxABzEn
         vM3JSRreTzTKtdEMC3hyi7BVe9Y8HbzmQ9e/7jUSID4OfM+F7vhRFhf3DG1pIGhG9HHr
         nPVacv9JPv1IlhUAxNwfoQNMjK9eeXc5a9ENPIqvhPNGDR2KyPQhX1Pu4Vs3j+GPdUQZ
         xvfrA9yHSpPF+8B0aLQUe+lOcOsLO9l5QbWcnWi6bVAqiWK7QhnCH9L+hZFJXRtv++EF
         alOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pk01i3F6OKXkufOFtKbiSH/nCE/KwOnzUKC1ocDoWr4=;
        b=hrxquC/KoqQYXDA/BFN88aO59M4CEUZmu5XY1bxPgltlHkiNvR9jbSBa/BIei2jcAi
         PTV0WqxzKh5ptNlUosF7FlhVQ3pZbMiI87lsFZUHrh1z5e00YT6FhT0UKTQSOkVrFquv
         rQPZD+Xhb/VqNNUYxW9rL+PcF/N7GGXddhzKc8YZ3CWLisnywGWnQ+ku/xc+rR0mr59y
         gK8lCbOJEV0YdGqDoY7DgfM3th1dFMH5EnVwM22wBT5OFeuaOadOe/knGIp+6wPp6LNK
         QctvwcJFj5Xq9kz5lm0gisDzQafW43Xr+t/pWUzoEjG/ogDS83PzntEBgEW+hO8OXERj
         qflw==
X-Gm-Message-State: AOAM530A5Mtr34i1OSBAQl7vuyx7CdloVzQQC3RBqMrCw4dBpS8FUlL/
        58jG0tH7dZIIT4lKTPzrpEqbza1o384=
X-Google-Smtp-Source: ABdhPJxMa6IASZ3mM8CkZf8jCUzxOAe8TrB0VJOFtH0CWJ1TNwXaxQZIBQNKv4cpH2rQ69KlAX8pdA==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr15726856wrr.295.1619685834808;
        Thu, 29 Apr 2021 01:43:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm11527356wmg.9.2021.04.29.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 01:43:54 -0700 (PDT)
Message-Id: <pull.943.git.1619685833872.gitgitgadget@gmail.com>
From:   "Sardorbek Imomaliev via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 08:43:53 +0000
Subject: [PATCH] Fix: fix comment for __git_complete_worktree_paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sardorbek Imomaliev <sardorbek.imomaliev@gmail.com>,
        Sardorbek Imomaliev <sardorbek.imomaliev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sardorbek Imomaliev <sardorbek.imomaliev@gmail.com>

Completion helper function fails for zsh because of wrongly put comment

Signed-off-by: Sardorbek Imomaliev <sardorbek.imomaliev@gmail.com>
---
    Fix: wrongly put comment for __git_complete_worktree_paths completion
    helper function
    
    git completion script fails for zsh
    
    $ git worktree remove [TAB]
    $ git worktree remove __git_complete_worktree_paths:7: command not found: #
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-943%2Fimomaliev%2Ffix%2Fgit-completion-worktree-subcommands-comment-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-943/imomaliev/fix/git-completion-worktree-subcommands-comment-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/943

 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dfa735ea6299..b2e158edaf6b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3268,9 +3268,9 @@ _git_whatchanged ()
 __git_complete_worktree_paths ()
 {
 	local IFS=$'\n'
+	# Skip the first entry: it's the path of the main worktree,
+	# which can't be moved, removed, locked, etc.
 	__gitcomp_nl "$(git worktree list --porcelain |
-		# Skip the first entry: it's the path of the main worktree,
-		# which can't be moved, removed, locked, etc.
 		sed -n -e '2,$ s/^worktree //p')"
 }
 

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget
