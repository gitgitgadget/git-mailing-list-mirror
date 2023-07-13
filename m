Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B2EB64DD
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 04:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjGMEmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 00:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjGMEml (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 00:42:41 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AD2CF
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 21:42:40 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b056276889so232042fac.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 21:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689223359; x=1691815359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CohUKtPqTbts55u/TEmJpvh1dUcnBRe//1hSAGg2rlE=;
        b=NzgjfrmwxX8dcm4wo6XzUV42e3kM4iQnuQg4ozfPoEGiqtz0xjSmzuJThAC+N0xFvU
         wVpobUXBPlDzcSMaPh9VCmk+KHm4BTcGJpUNMdpVezvwK8J2prQ1qHNjG5NoiUnurPZP
         fHDKORCbfynJVHihq1L39SJ/WR9kz8PuekZAEH5po0ze267LzwfcWGfMfeFiLZn/OWSC
         PiQoH4MjRzN5IvoICp6nTAd9mxxCmTl3z9AG0c3IMppO2wNyeEvt95QAL4oLW/2hTh4/
         tJOnSmrmBRvBuSrc2jPEHhgRxZRfCvxFWHAMpiOEu90akPTFPRht+WOO2veUQ3ZNDGc/
         FfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689223359; x=1691815359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CohUKtPqTbts55u/TEmJpvh1dUcnBRe//1hSAGg2rlE=;
        b=JQupcAcF0ps96b4tFwXGqPHM4eihggDtpb/s8RXqnKN9GFtFIzecj213nAHcqFQijq
         uBwMH6nbC6P8v6L+z/RUSww5AZ/zFEhatxtzHmH9g7B8ZwG2d4vpxd5y1OqZovQmJuU/
         MkVnIxuh/E5+obzlfF59wArvVnQlKFknwnK9zcd/thMQQJ5MXTxgxkygRbQyanPG+u5Z
         VIHNYfgInPVXc89wlU5y3RNCKgzV5jzjrYIZ8VJPxWAgBwxl4osAimr3uC4wAuKi1rH/
         yLCNOCRTArXyWRUZdOwB1guuibGtHEJhZkQNMak0fTZobLsEqFrIAuPMsO0UV/YvmTaq
         6SYQ==
X-Gm-Message-State: ABy/qLbbXmgXLrikMQkWoYM4Nbg0lc6x/3MIqbueVcvvVN1V99Ksc56Z
        7TIsUDm5sXx9akr8xqVvpmukVewEVx0=
X-Google-Smtp-Source: APBJJlGxFXYldI7wUKvQ961YIbtOIwNz/ZVOJjBNqRilqKVJek1RndxHl03XkZT2OCQN9gYmuYMUYw==
X-Received: by 2002:a05:6871:29a:b0:1b3:afdc:6c14 with SMTP id i26-20020a056871029a00b001b3afdc6c14mr1039775oae.2.1689223359004;
        Wed, 12 Jul 2023 21:42:39 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902cd0d00b001ae5d21f760sm4843040ply.146.2023.07.12.21.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:42:37 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5 0/3] don't imply that integration is always required before pushing
Date:   Wed, 12 Jul 2023 22:41:12 -0600
Message-ID: <20230713044128.3771818-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707054257.3366355-1-alexhenrie24@gmail.com>
References: <20230707054257.3366355-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many times now, I have seen novices do the following:

1. Start work on their own personal topic branch
2. Push the branch to origin
3. Rebase the branch onto origin/master
4. Try to push again, but Git says they need to pull
5. Pull and make a mess trying to reconcile the older topic branch with
   the rebased topic branch

Help avoid this mistake by giving somewhat more general advice that does
not assume that the user always wants to do reconciliation.

Changes from v4:
- Don't show divergent branch advice in the middle of `git commit`
- Soften the advice, but don't specifically mention force-pushing

Alex Henrie (3):
  wt-status: don't show divergence advice when committing
  remote: don't imply that integration is always required before pushing
  push: don't imply that integration is always required before pushing

 builtin/checkout.c |  2 +-
 builtin/push.c     | 24 +++++++++++------------
 remote.c           |  8 +++++---
 remote.h           |  3 ++-
 t/t7508-status.sh  | 48 ++++++++++++++++++++++------------------------
 wt-status.c        |  3 ++-
 6 files changed, 45 insertions(+), 43 deletions(-)

Range-diff against v4:
1:  9626721c13 < -:  ---------- remote: advise about force-pushing as an alternative to reconciliation
-:  ---------- > 1:  e84989c4a6 wt-status: don't show divergence advice when committing
-:  ---------- > 2:  9bb643df7e remote: don't imply that integration is always required before pushing
2:  209e86588a ! 3:  5ff9ecb51b push: advise about force-pushing as an alternative to reconciliation
    @@ Metadata
     Author: Alex Henrie <alexhenrie24@gmail.com>
     
      ## Commit message ##
    -    push: advise about force-pushing as an alternative to reconciliation
    +    push: don't imply that integration is always required before pushing
     
    -    Also, don't put `git pull` in an awkward parenthetical, because
    -    `git pull` can always be used to reconcile branches and is the normal
    -    way to do so.
    +    In a narrow but common case, the user is the only author of a branch and
    +    doesn't mind overwriting the corresponding branch on the remote. This
    +    workflow is especially common on GitHub, GitLab, and Gerrit, which keep
    +    a permanent record of every version of a branch that is pushed while a
    +    pull request is open for that branch. On those platforms, force-pushing
    +    is encouraged and is analogous to emailing a new version of a patchset.
    +
    +    When giving advice about divergent branches, tell the user about
    +    `git pull`, but don't unconditionally instruct the user to do it. A less
    +    prescriptive message will help prevent users from thinking that they are
    +    required to create an integrated history instead of simply replacing the
    +    previous history. Also, don't put `git pull` in an awkward
    +    parenthetical, because `git pull` can always be used to reconcile
    +    branches and is the normal way to do so.
    +
    +    Due to the difficulty of knowing which command for force-pushing is best
    +    suited to the user's situation, no specific advice is given about
    +    force-pushing. Instead, the user is directed to the Git documentation to
    +    read about possible ways forward that do not involve integration.
     
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
    @@ builtin/push.c: static void setup_default_push_refspecs(int *flags, struct remot
      	N_("Updates were rejected because the tip of your current branch is behind\n"
     -	   "its remote counterpart. Integrate the remote changes (e.g.\n"
     -	   "'git pull ...') before pushing again.\n"
    -+	   "its remote counterpart. Use 'git pull' to integrate the remote changes\n"
    -+	   "before pushing again, or use 'git push --force' to delete the remote\n"
    -+	   "changes and replace them with your own.\n"
    ++	   "its remote counterpart. If you want to integrate the remote changes,\n"
    ++	   "use 'git pull' before pushing again.\n"
      	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
      
      static const char message_advice_checkout_pull_push[] =
      	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
     -	   "counterpart. Check out this branch and integrate the remote changes\n"
     -	   "(e.g. 'git pull ...') before pushing again.\n"
    -+	   "counterpart. Check out this branch and use 'git pull' to integrate the\n"
    -+	   "remote changes before pushing again, or use 'git push --force' to delete\n"
    -+	   "the remote changes and replace them with your own.\n"
    ++	   "counterpart. If you want to integrate the remote changes, use 'git pull'\n"
    ++	   "before pushing again.\n"
      	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
      
      static const char message_advice_ref_fetch_first[] =
    @@ builtin/push.c: static void setup_default_push_refspecs(int *flags, struct remot
     -	   "(e.g., 'git pull ...') before pushing again.\n"
     +	N_("Updates were rejected because the remote contains work that you do not\n"
     +	   "have locally. This is usually caused by another repository pushing to\n"
    -+	   "the same ref. Use 'git pull' to integrate the remote changes before\n"
    -+	   "pushing again, or use 'git push --force' to delete the remote changes\n"
    -+	   "and replace them with your own.\n"
    ++	   "the same ref. If you want to integrate the remote changes, use\n"
    ++	   "'git pull' before pushing again.\n"
      	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
      
      static const char message_advice_ref_already_exists[] =
    @@ builtin/push.c: static const char message_advice_ref_needs_force[] =
     -	   "to integrate those changes locally (e.g., 'git pull ...')\n"
     -	   "before forcing an update.\n");
     +	N_("Updates were rejected because the tip of the remote-tracking branch has\n"
    -+	   "been updated since the last checkout. Use 'git pull' to integrate the\n"
    -+	   "remote changes before pushing again, or use 'git push --force' to delete\n"
    -+	   "the remote changes and replace them with your own.\n");
    ++	   "been updated since the last checkout. If you want to integrate the\n"
    ++	   "remote changes, use 'git pull' before pushing again.\n"
    ++	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
      
      static void advise_pull_before_push(void)
      {
-- 
2.41.0

