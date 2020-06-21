Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CA6C433E0
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 05:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E4922261
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 05:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEjXxzBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgFUFVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 01:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgFUFVc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jun 2020 01:21:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0757C061794
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 22:21:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so11979171wmh.4
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 22:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zFdWMHMRN1rxybmDv49lv0HpESn5I6UmA/2keMIRdFM=;
        b=FEjXxzBcTq35izEvKemvFS1Ev3O60NRsQ3LTCpRusgWW6Pmh1bZRXXliTm/AKRAB7F
         XMfVuqddVmJws/kkhHvKAlaV6DJc2dHtpUbq9JSWUCzrPHt46Ejyc7c+HxyExSnSHHmS
         MmIni76H6odDB4eHZtVVjgoRnrNJXMank1pjcXuJJH8WWvBdPk6iyprwksFprkJchqDb
         HMghb8eoUAMC4GqGFBxaHsRw5Rk1uEktOCcUA0pitRoIhMRbaFwZQey/HWOj9V6i2GtF
         G79I2WzNjXpEUm7dtS7Y6Iw3Vs4FVfkxDOUwJUsph/Nu6K1eRgNJ6lcKSO7gehhvH/Kp
         GlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zFdWMHMRN1rxybmDv49lv0HpESn5I6UmA/2keMIRdFM=;
        b=CBEepBtIgMpbbCbMuNca8RuyuFxBVBJcbKSBKlCwIlPQ5ubpar5Ml3zkrUOjDl1luY
         bZtOGWcLqibIM/jZh6LVKYWpu5fTI9l6wHZ5pLl8u6WDBoVN4tfCDmlFnNCAyGXVswl5
         U0AhOmKHUuDj4sDyqHf8saKQ6UGHVlIzgbUwKkX2Cr/HCIvA2LD/VjXvoSdkAP8hBjmD
         y/0Nbxh0hmMBk1XOUvix870jIsqcplulxhXwx0FdbiITmy/clRpfknrufqSSMZTW8wcv
         xVM8IvaK29R02IN8Jm9oFBbVyrAsD79fGEKXUXmo/H5gTJFZD6Hlz++h4jGsKhnf17w8
         IQow==
X-Gm-Message-State: AOAM530HO58svQnYKLsWBnnidrfDzwccIPKSvXIIs92NoswKhPaLVOc0
        eJzxHgR4QFbDuzNgOYamsf8Z0iha
X-Google-Smtp-Source: ABdhPJz90ddsE1hPapWadk005KEEbri3KW4HOG+uLd03n64ksiO6g5kQn1tvgqcqI1fQ08+6HYyxeg==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr5090457wml.177.1592716889305;
        Sat, 20 Jun 2020 22:21:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w12sm1766767wrm.79.2020.06.20.22.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 22:21:28 -0700 (PDT)
Message-Id: <pull.808.v3.git.git.1592716887.gitgitgadget@gmail.com>
In-Reply-To: <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
References: <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Jun 2020 05:21:24 +0000
Subject: [PATCH v3 0/3] Sparse checkout status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the feedback of folks trying out sparse-checkouts at $dayjob is that
sparse checkouts can sometimes be disorienting; users can forget that they
had a sparse-checkout and then wonder where files went. This series adds
some output to 'git status' and modifies git-prompt slightly as an attempt
to help.

(As per discussion on v1, a "git sparse-checkout [status|info|status]" might
supplement the changes from this series later; this is just aimed at giving
users a simple reminder that they are in a sparse checkout.)

Changes since v2:

 * Added an extra commit to document how git-prompt works with in-progress
   state of operations (rebase/merge/cherry-pick/revert/bisect), since I
   want to refer to it for comparison later in the docs.
 * As requested by SZEDER, added the ability to shorten or remove the
   information relating to sparsity state in the git-prompt.
 * Since there are now three options for whether and how to show information
   related to sparsity state, I put a fair amount of effort into reasoning
   among the options about what is a good default and why; I included this
   in the final commit message. (While I suspect that we can easily change
   the default for the prompt in the future based on the big warning at the
   top of git-sparse-checkout.txt, having the rationale up-front for the
   original decision may help us out in the future.)

Elijah Newren (3):
  wt-status: show sparse checkout status as well
  git-prompt: document how in-progress operations affect the prompt
  git-prompt: include sparsity state as well

 contrib/completion/git-prompt.sh | 26 ++++++++++++++++++--
 wt-status.c                      | 41 ++++++++++++++++++++++++++++++++
 wt-status.h                      |  2 ++
 3 files changed, 67 insertions(+), 2 deletions(-)


base-commit: b3d7a52fac39193503a0b6728771d1bf6a161464
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-808%2Fnewren%2Fsparse-checkout-status-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-808/newren/sparse-checkout-status-v3
Pull-Request: https://github.com/git/git/pull/808

Range-diff vs v2:

 1:  e266bc39d99 = 1:  e266bc39d99 wt-status: show sparse checkout status as well
 -:  ----------- > 2:  1fd1b919684 git-prompt: document how in-progress operations affect the prompt
 2:  17254b30a5b ! 3:  d99202f8e14 git-prompt: include sparsity state as well
     @@ Metadata
       ## Commit message ##
          git-prompt: include sparsity state as well
      
     -    The current git prompt includes a lot of possible state information from
     -    cherry-picks, merges, bisects, and various flavors of rebases.  Add
     -    sparsity as another state flavor (though one which can be present
     -    simultaneously with any of rebase/cherry-pick/merge/bisect).  This extra
     -    state is shown with an extra
     +    git-prompt includes the current branch, a bunch of single character
     +    mini-state displayers, and some much longer in-progress state
     +    notifications.  The current branch is always shown.  The single
     +    character mini-state displayers are all off by default (they are not
     +    self explanatory) but each has an environment variable for turning it
     +    on.  The in-progress state notifications provide no configuration
     +    options for turning them off, and can be up to 15 characters long (e.g.
     +    "|REBASE (12/18)" or "|CHERRY-PICKING").
     +
     +    The single character mini-state tends to be used for things like "Do you
     +    have any stashes in refs/stash?" or "Are you ahead or behind of
     +    upstream?".  These are things which users can take advantage of but do
     +    not affect most normal git operations.  The in-progress states, by
     +    contrast, suggest the user needs to interact differently and may also
     +    prevent some normal operations from succeeding (e.g. git switch may show
     +    an error instead of switching branches).
     +
     +    Sparsity is like the in-progress states in that it suggests a
     +    fundamental different interaction with the repository (many of the files
     +    from the repository are not present in your working copy!).  A few
     +    commits ago added sparsity information to wt_longstatus_print_state(),
     +    grouping it with other in-progress state displays.  We do similarly here
     +    with the prompt and show the extra state, by default, with an extra
              |SPARSE
     -    substring before the other states, providing a prompt that looks like:
     +    This state can be present simultaneously with the in-progress states, in
     +    which case it will appear before the other states; for example,
              (branchname|SPARSE|REBASE 6/10)
      
          The reason for showing the "|SPARSE" substring before other states is to
     @@ Commit message
          make them appear closer to where the user types and make them more
          likely to be noticed.
      
     +    The fact that sparsity isn't just cached metadata or additional
     +    information is what leads us to show it more similarly to the
     +    in-progress states, but the fact that sparsity is not transient like the
     +    in-progress states might cause some users to want an abbreviated
     +    notification of sparsity state or perhaps even be able to turn it off.
     +    Allow GIT_PS1_COMPRESSSPARSESTATE to be set to request that it be
     +    shortened to a single character ('?'), and GIT_PS1_OMITSPARSESTATE to be
     +    set to request that sparsity state be omitted from the prompt entirely.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## contrib/completion/git-prompt.sh ##
     +@@
     + # revert, cherry-pick, or bisect, the prompt will include information
     + # related to the operation, often in the form "|<OPERATION-NAME>".
     + #
     ++# When the repository has a sparse-checkout, a notification of the form
     ++# "|SPARSE" will be included in the prompt.  This can be shortened to a
     ++# single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
     ++# by setting GIT_PS1_OMITSPARSESTATE.
     ++#
     + # By default, __git_ps1 will compare HEAD to your SVN upstream if it can
     + # find one, or @{upstream} otherwise.  Once you have set
     + # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
      @@ contrib/completion/git-prompt.sh: __git_ps1 ()
       		return $exit
       	fi
       
      +	local sparse=""
     -+	if [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
     -+	    sparse="|SPARSE"
     ++	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
     ++	   [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
     ++	   [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
     ++		sparse="|SPARSE"
      +	fi
      +
       	local r=""
       	local b=""
       	local step=""
      @@ contrib/completion/git-prompt.sh: __git_ps1 ()
     + 	local i=""
     + 	local s=""
     + 	local u=""
     ++	local h=""
     + 	local c=""
     + 	local p=""
     + 
     +@@ contrib/completion/git-prompt.sh: __git_ps1 ()
     + 			u="%${ZSH_VERSION+%}"
     + 		fi
     + 
     ++		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
     ++		   [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
     ++			h="?"
     ++		fi
     ++
     + 		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
     + 			__git_ps1_show_upstream
     + 		fi
     +@@ contrib/completion/git-prompt.sh: __git_ps1 ()
     + 		b="\${__git_ps1_branch_name}"
       	fi
       
     - 	local f="$w$i$s$u"
     +-	local f="$w$i$s$u"
      -	local gitstring="$c$b${f:+$z$f}$r$p"
     ++	local f="$h$w$i$s$u"
      +	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
       
       	if [ $pcmode = yes ]; then

-- 
gitgitgadget
