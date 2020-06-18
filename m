Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB67C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E86420890
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYWtGiiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgFRUuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgFRUuB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:50:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D0C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 13:50:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b82so6499045wmb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xooQ39VErDRu2FBrmfpeyEopnVC1dUl7eLnWXAqGa/s=;
        b=WYWtGiiIG0kyAMf7WpFL3ULVRKDGjGE6/m7Q4y1LRiVfZsArYS45Kp+PEezXdXOYjp
         HOeE1LB+1LHsbZ7MCXA+JdEQs830cICnbJ+guleLzWluJpruLvcXgcyiiR7zyHNcRH6H
         xHpAQBij7ADm4PrVLpab0USXaVR1iM+9M5EXHJq4O3ZO4WkscVOOxOdAiXatmF8ThVGQ
         WRs5bg+Ntt+3eAAxDeUdQ2dhdDRRkULe0vtr2EsdO0wGK6XJ4IxrJvOZb7DTNZRw/lyu
         flDO3sBzIbVzrx5nPbVb+0eKi9grqxvRPLgBRpfbmDxQRarEtbMy/W4pY08RrGbLzYE9
         UR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xooQ39VErDRu2FBrmfpeyEopnVC1dUl7eLnWXAqGa/s=;
        b=SfO4RrnKFr13O5LbV8Z4YporYr6Ol53booFKSXF0JSPPkoJPuMbatlTaty3mo2zX/A
         Yde3O1MNV2P9deaOF5t5e6jLxAuaSoE4JaSCG5IgVMCj4kdQhkuh39sl9GbyLDSTIAsu
         oCvFThHfLHFbbBSygYhgQz3DYIMR9W1Bfls4eNmaMTrrkgIHeB6lw5fI2DkZ+8FwNDch
         3IY12AOWGkvb8A1i0fZekgmw54A+YYdDQFFu4Dv42tOJLxXwrS2567QmE1w3zoOCorxg
         zZ+GqBT43Kde8xYBdsf8CYI6c6fdbClUCE6qylYnp1PhtCGoFhtAT2fcFX690nAUJ5ki
         /xvg==
X-Gm-Message-State: AOAM532fUiXI71vFu+L/Pv2EScxMABfSpJe53KvTN/Hd6zn4/d1y5QuB
        MFVIKTLaJ2Bk5eOYeMTNnveJRszs
X-Google-Smtp-Source: ABdhPJzLyAGtYc4iX251vIuirKy8nzIY8IyErw4s2503tBS55NL0DnPAwvuMXM0coacqaLeMbM6Cpg==
X-Received: by 2002:a1c:24c6:: with SMTP id k189mr173308wmk.9.1592513399965;
        Thu, 18 Jun 2020 13:49:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm4842095wrm.57.2020.06.18.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:49:59 -0700 (PDT)
Message-Id: <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
In-Reply-To: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Jun 2020 20:49:56 +0000
Subject: [PATCH v2 0/2] Sparse checkout status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the feedback of folks trying out sparse-checkouts at $dayjob is that
sparse checkouts can sometimes be disorienting; users can forget that they
had a sparse-checkout and then wonder where files went. This series adds
some output to 'git status' and modifies git-prompt slightly as an attempt
to help.

Note that as per discussion on v1, we may want to later add a git
sparse-checkout subcommand named something like 'stats' or 'info' or
'status' that provides more detailed information for users to dig deeper.
That would be an additional improvement for helping users find out more
information once they realize or remember they are in a sparse checkout,
this is just aimed at giving them a simple reminder.

Changes since v1:

 * Replaced the -1 magic constant with SPARSE_CHECKOUT_DISABLED
 * Fixed a possible division by 0 (when there are no entries in the index
   AND sparse checkout is enabled; not sure when that'd ever happen but
   still better to guard against...)
 * Slight wording tweaks for the git-prompt commit message
 * Removed the RFC label

Elijah Newren (2):
  wt-status: show sparse checkout status as well
  git-prompt: include sparsity state as well

 contrib/completion/git-prompt.sh |  7 +++++-
 wt-status.c                      | 41 ++++++++++++++++++++++++++++++++
 wt-status.h                      |  2 ++
 3 files changed, 49 insertions(+), 1 deletion(-)


base-commit: b3d7a52fac39193503a0b6728771d1bf6a161464
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-808%2Fnewren%2Fsparse-checkout-status-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-808/newren/sparse-checkout-status-v2
Pull-Request: https://github.com/git/git/pull/808

Range-diff vs v1:

 1:  462cee857ef ! 1:  e266bc39d99 [RFC] wt-status: show sparse checkout status as well
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    [RFC] wt-status: show sparse checkout status as well
     +    wt-status: show sparse checkout status as well
      
          Some of the early feedback of folks trying out sparse-checkouts at
          $dayjob is that sparse checkouts can sometimes be disorienting; users
     @@ wt-status.c: static void show_bisect_in_progress(struct wt_status *s,
      +static void show_sparse_checkout_in_use(struct wt_status *s,
      +					const char *color)
      +{
     -+	if (s->state.sparse_checkout_percentage != -1)
     -+		status_printf_ln(s, color,
     -+				 _("You are in a sparse checkout with %d%% of tracked files present."),
     -+				 s->state.sparse_checkout_percentage);
     ++	if (s->state.sparse_checkout_percentage == SPARSE_CHECKOUT_DISABLED)
     ++		return;
     ++
     ++	status_printf_ln(s, color,
     ++			 _("You are in a sparse checkout with %d%% of tracked files present."),
     ++			 s->state.sparse_checkout_percentage);
      +	wt_longstatus_print_trailer(s);
      +}
      +
     @@ wt-status.c: int wt_status_check_bisect(const struct worktree *wt,
      +	int skip_worktree = 0;
      +	int i;
      +
     -+	if (!core_apply_sparse_checkout) {
     -+		state->sparse_checkout_percentage = -1;
     ++	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
     ++		/*
     ++		 * Don't compute percentage of checked out files if we
     ++		 * aren't in a sparse checkout or would get division by 0.
     ++		 */
     ++		state->sparse_checkout_percentage = SPARSE_CHECKOUT_DISABLED;
      +		return;
      +	}
      +
     @@ wt-status.c: static void wt_longstatus_print_state(struct wt_status *s)
       	if (state->bisect_in_progress)
       		show_bisect_in_progress(s, state_color);
      +
     -+	if (state->sparse_checkout_percentage != -1)
     ++	if (state->sparse_checkout_percentage != SPARSE_CHECKOUT_DISABLED)
      +		show_sparse_checkout_in_use(s, state_color);
       }
       
       static void wt_longstatus_print(struct wt_status *s)
      
       ## wt-status.h ##
     +@@ wt-status.h: enum wt_status_format {
     + 
     + #define HEAD_DETACHED_AT _("HEAD detached at ")
     + #define HEAD_DETACHED_FROM _("HEAD detached from ")
     ++#define SPARSE_CHECKOUT_DISABLED -1
     + 
     + struct wt_status_state {
     + 	int merge_in_progress;
      @@ wt-status.h: struct wt_status_state {
       	int bisect_in_progress;
       	int revert_in_progress;
       	int detached_at;
     -+	int sparse_checkout_percentage; /* -1 == not in sparse checkout */
     ++	int sparse_checkout_percentage; /* SPARSE_CHECKOUT_DISABLED if not sparse */
       	char *branch;
       	char *onto;
       	char *detached_from;
 2:  64613ad7ad6 ! 2:  17254b30a5b [RFC] git-prompt: include sparsity state as well
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    [RFC] git-prompt: include sparsity state as well
     +    git-prompt: include sparsity state as well
      
     -    The current git prompt includes a lot of possible state information, from
     -    various flavors of rebases to cherry-picks, or merges, or bisects.  Add
     +    The current git prompt includes a lot of possible state information from
     +    cherry-picks, merges, bisects, and various flavors of rebases.  Add
          sparsity as another state flavor (though one which can be present
          simultaneously with any of rebase/cherry-pick/merge/bisect).  This extra
          state is shown with an extra
              |SPARSE
     -    substring before the other states.  (Sparsity is probably not going to
     -    change much within a repository, while temporary operations will.  So we
     -    want the temporary operation related state changes to be listed last, to
     -    make them appear closer to where the user types and make them more
     -    likely to be noticed.)  Thus, for example, the prompt might look like:
     +    substring before the other states, providing a prompt that looks like:
              (branchname|SPARSE|REBASE 6/10)
      
     +    The reason for showing the "|SPARSE" substring before other states is to
     +    emphasize those other states.  Sparsity is probably not going to change
     +    much within a repository, while temporary operations will.  So we want
     +    the state changes related to temporary operations to be listed last, to
     +    make them appear closer to where the user types and make them more
     +    likely to be noticed.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## contrib/completion/git-prompt.sh ##

-- 
gitgitgadget
