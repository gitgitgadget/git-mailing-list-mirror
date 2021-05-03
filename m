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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63FC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 16:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0673611AB
	for <git@archiver.kernel.org>; Mon,  3 May 2021 16:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhECQaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhECQaE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 12:30:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6459C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 09:29:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so6240824wry.1
        for <git@vger.kernel.org>; Mon, 03 May 2021 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MkUMfLan4OKpQNqy1VAU/SYdNvR0urcsccwgfBxzYL0=;
        b=JMRvJLIyZcCG3RdWa1uJQ24i9AZ+y5WelXp4UPVnpEMrKnmyAaBYStunxNgDUhuFzp
         M9XxIMuTwMYcLZ4rHoHXpynu9zzQhgv4yducvd+qvlXYUF+ZwGtJWLTPB/JXJeEBiZ68
         Aa1fWkquMqAnAuqnvbe1ggFlgomG3BVsCvKZbaHbmzQpotmJv1BoYUEcSO0pBnKkH058
         4I/+5ypPqpFB1siQWgpiJYyBuXfoynSw0NCC7yNYz6f43ZRELduklz9CZyhnpxFH6Xep
         4QwL632lNtbMbEU/e17NmKs73iAqqXjHbOB4nhGspiRzssW+vEmNfs+PSWFTeSH7QjF9
         Is7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MkUMfLan4OKpQNqy1VAU/SYdNvR0urcsccwgfBxzYL0=;
        b=BXctm/aW5s27qizn79rPO5QWg8Sv/VNDEO3jXGoGswlZv7OrHUFo7vErRRJd+HqXs+
         KlyJm5AkeT9pIkcWASJ9ZcsHjn4OZ5SUhJ4EBAoqRUmOcJzUj2BQpXMAUlmQZPY8UD3Y
         rDSVfRzBT4T68rlgc3FlqZrvZLkJDKHJsy8sOP4xPIl21Q+fNuQ3/28rDDM+TaHKgn9m
         LcTc59h5zqisi4pZAjbirKu3KpHJkvcQeKvjabGUTeepCqofqcFh7vKpBN9nC6XlEfBB
         uWmb28NGopYKN4UIQpYF09zFgPlQc1SsP557f1Qnvj6Jq9DEJn+PAgteKgxkpa407rIl
         C33A==
X-Gm-Message-State: AOAM533N8kuldeWvZEZhRw+DfqxfBICl3c6clg4YJzz6KZ6At/BqCiEz
        bLdlN1uNgWx5UnwLyfcJc3CVHRnQUG8=
X-Google-Smtp-Source: ABdhPJwF05mLdPw2Ys15pH03zUix5pEuYYc/w1UfaLiqoaggCuUwZJeecd+DXD2f7i3G/Vy306OvUw==
X-Received: by 2002:a5d:610c:: with SMTP id v12mr26205195wrt.57.1620059348653;
        Mon, 03 May 2021 09:29:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x5sm8731929wrt.49.2021.05.03.09.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 09:29:08 -0700 (PDT)
Message-Id: <pull.943.v2.git.1620059347674.gitgitgadget@gmail.com>
In-Reply-To: <pull.943.git.1619685833872.gitgitgadget@gmail.com>
References: <pull.943.git.1619685833872.gitgitgadget@gmail.com>
From:   "Sardorbek Imomaliev via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 May 2021 16:29:07 +0000
Subject: [PATCH v2] work around zsh comment in __git_complete_worktree_paths
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

[PATCH]: contrib/completion/git-completion.bash, there is a construct
where comment lines are placed between the command that is on
the upstream of a pipe and the command that is on the downstream
of a pipe in __git_complete_worktree_paths function.

Unfortunately, this script is also used by Zsh completion, but
Zsh mishandles this construct when "interactive_comments" option is not
set (by default it is off on macOS), resulting in a breakage:

$ git worktree remove [TAB]
$ git worktree remove __git_complete_worktree_paths:7: command not found: #

Move the comment, even though it explains what happens on the
downstream of the pipe and logically belongs where it is right
now, before the entire pipeline, to work around this problem.

Signed-off-by: Sardorbek Imomaliev <sardorbek.imomaliev@gmail.com>
---
    Fix: wrongly put comment for __git_complete_worktree_paths completion
    helper function
    
    git completion script fails for zsh
    
    $ git worktree remove [TAB]
    $ git worktree remove __git_complete_worktree_paths:7: command not found: #
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-943%2Fimomaliev%2Ffix%2Fgit-completion-worktree-subcommands-comment-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-943/imomaliev/fix/git-completion-worktree-subcommands-comment-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/943

Range-diff vs v1:

 1:  89a2a4d66b73 ! 1:  60ba6801e0f5 Fix: fix comment for __git_complete_worktree_paths
     @@ Metadata
      Author: Sardorbek Imomaliev <sardorbek.imomaliev@gmail.com>
      
       ## Commit message ##
     -    Fix: fix comment for __git_complete_worktree_paths
     +    work around zsh comment in __git_complete_worktree_paths
      
     -    Completion helper function fails for zsh because of wrongly put comment
     +    [PATCH]: contrib/completion/git-completion.bash, there is a construct
     +    where comment lines are placed between the command that is on
     +    the upstream of a pipe and the command that is on the downstream
     +    of a pipe in __git_complete_worktree_paths function.
     +
     +    Unfortunately, this script is also used by Zsh completion, but
     +    Zsh mishandles this construct when "interactive_comments" option is not
     +    set (by default it is off on macOS), resulting in a breakage:
     +
     +    $ git worktree remove [TAB]
     +    $ git worktree remove __git_complete_worktree_paths:7: command not found: #
     +
     +    Move the comment, even though it explains what happens on the
     +    downstream of the pipe and logically belongs where it is right
     +    now, before the entire pipeline, to work around this problem.
      
          Signed-off-by: Sardorbek Imomaliev <sardorbek.imomaliev@gmail.com>
      
     @@ contrib/completion/git-completion.bash: _git_whatchanged ()
       __git_complete_worktree_paths ()
       {
       	local IFS=$'\n'
     -+	# Skip the first entry: it's the path of the main worktree,
     -+	# which can't be moved, removed, locked, etc.
     ++	# Generate completion reply from worktree list skipping the first
     ++	# entry: it's the path of the main worktree, which can't be moved,
     ++	# removed, locked, etc.
       	__gitcomp_nl "$(git worktree list --porcelain |
      -		# Skip the first entry: it's the path of the main worktree,
      -		# which can't be moved, removed, locked, etc.


 contrib/completion/git-completion.bash | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 49e76e9d08cd..73f9fcf493c4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3268,9 +3268,10 @@ _git_whatchanged ()
 __git_complete_worktree_paths ()
 {
 	local IFS=$'\n'
+	# Generate completion reply from worktree list skipping the first
+	# entry: it's the path of the main worktree, which can't be moved,
+	# removed, locked, etc.
 	__gitcomp_nl "$(git worktree list --porcelain |
-		# Skip the first entry: it's the path of the main worktree,
-		# which can't be moved, removed, locked, etc.
 		sed -n -e '2,$ s/^worktree //p')"
 }
 

base-commit: 7e391989789db82983665667013a46eabc6fc570
-- 
gitgitgadget
