Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E985EC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 17:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbiBARDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiBARDs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 12:03:48 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70803C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 09:03:48 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id r10so35949322edt.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cw1M8IFq4Rf3vbKRLACFboPMaldJDAHaYso2aKXneQc=;
        b=Dngdp6yNpfpJTz5e5MIqbyJVS9Xkw5OsLn3P8bK496NWXNPbC5ubxG3IdjIbhmdzMX
         jGzaNUac8bOz2PrB3NDFrLOJ0ibnznoXn/pb0MR50kk7dhWXYF5U2yj1QeGHmtSSdDXG
         E5yt2l/o7gQJO/Fw3LMEJ/Ym360Pp8wKgZT5RfduofxT3XB9djbk23ng8tgkLeUG0vQU
         QUaIwVTM+aUlM0aXhTr1KTk0fYkwYFJUfn97DH3rjAn8AB5f82cbE8KganR0uWDijYtO
         X57LVPbxcsf8/QzZpxv0pHvlDe+tsVcO1Ww+TPPohV8cNe3TVdtixPPuzWmegublCKgT
         Agag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cw1M8IFq4Rf3vbKRLACFboPMaldJDAHaYso2aKXneQc=;
        b=N9tSeXdgOTBtkqfWREaqC6oX3/90HdVbCglHI4P1cwN/D4v/wCJ29Jq4LvsMAqmQnY
         oEJR8Nlvsx3DBDdAZY+mIfz+mpHi1Yb2E7G11eL1NUqJQivRb52vyEPLiQx2WoIma9XZ
         sLoHFLmrpNO+rzXRaZNrmoa5CEFJq9x+3C7gB/SNNajD2G2oPJ5cfPZLVBo4L1Ew+spE
         V+trfbayXzhsIsfgz18+RIhHMoTA/eU7RdlX7A9z41NKkkdA8PgZkfxXNkECosnz7rfl
         Lcd7jaJSpemveplaFkbDMSvkwJ5Oj1FwyFKrLktymgZSNuVYEazczo7u6c1/YF0RNbQC
         0heQ==
X-Gm-Message-State: AOAM533biyRKHl8f3spVrxWCL5AalyR0JKxdQJaKOu93SN8E0g4/09f2
        fHuNenIZWka9FNvl+/sos3hHYgxg9UWizpMrmN0=
X-Google-Smtp-Source: ABdhPJx9zbzmeGoH4tGRc0/El+ilJRjdxb3p0h4DYBQ2RGido2dyawRITibcfchFBRlLbwrKlVtOiKl8XrBzZy5JRFo=
X-Received: by 2002:aa7:d313:: with SMTP id p19mr27053999edq.380.1643735026813;
 Tue, 01 Feb 2022 09:03:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com> <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Feb 2022 09:03:35 -0800
Message-ID: <CABPp-BEr+UVFo27qwnYuTO4WtWyz4yzUM8d0_zuxa52_XX9zow@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] rebase: reset_head() related fixes and improvements
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 5:05 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Thanks to Junio and Elijah for their comments on V2. There aren't too many
> changes this time.
>
> This series started out with the aim of converting 'rebase -i' to use
> reset_head() instead of forking 'git checkout'. As 'rebase --apply' already
> uses reset_head() I assumed this would be straight forward. However it has
> morphed into a series of fixes for reset_head() followed by the intended
> conversion of 'rebase -i'.
>
> reset.c::reset_head() started its life at ac7f467f (builtin/rebase: support
> running "git rebase ", 2018-08-07) as a way to detach the HEAD to replay the
> commits during "git rebase", but over time it learned to do many things,
> like switching the tip of the branch to another commit, recording the old
> value of HEAD in ORIG_HEAD while it does so, recording reflog entries for
> both HEAD and for the branch.
>
> The API into the function got clunky and it is harder than necessary for the
> callers to use the function correctly, which led to a handful of bugs that
> are fixed by this series. The bugs include
>
>  * passing the wrong oid to the post-checkout hook
>  * removing untracked files on checkout
>  * running the post-checkout hook if the checkout fails
>  * passing parameters to reset_head() that it does not use
>  * incorrect reflog messages for 'rebase --apply'
>  * sometimes setting ORIG_HEAD incorrectly at the start 'rebase --apply'
>
> Later steps of this series revamps the API so that it is harder to use it
> incorrectly to prevent future bugs and finally convert 'rebase -i' to use
> reset_head()
>
> Changes since V2:
>
>  * Updated cover letter as suggested by Junio
>  * Patch 4 - fixed typos in the commit message spotted by Junio
>  * Patch 9 - Moved later in the series to simplify the autostash canges as
>    suggested by Junio. This used to be patch 7
>  * Patch 10 - Added a comment to the commit message explaining why we cannot
>    BUG() on an invalid parameter until a change is made in a later commit
>  * Patch 13 - Reworded the first sentence commit message as suggest by
>    Elijah.

This round looks good to me.  Thanks!

> Cover letter for V2:
>
> Thanks for the comments on V1. I have tried to improve the commit messages
> to explain better the motivation and implications of the changes in this
> series and I have added some more tests. I have rebased onto v2.34.0 to
> avoid some merges conflicts.
>
> Changes since V1:
>
>  * Patch 1 - unchanged.
>  * Patches 2, 3 - these are new and fix an bug I noticed while adding a test
>    to patch 4.
>  * Patches 4, 5 - improved commit messages and added tests.
>  * Patch 6 - reworded commit message.
>  * Patch 7 - split out some changes that used to be in patch 9.
>  * Patch 8 - in principle the same but the range-diff is noisy due to the
>    addition of patch 3.
>  * Patch 9 - reworded commit message.
>  * Patch 10 - unchanged.
>  * Patch 11 - reworded commit message and a couple of comments.
>  * Patch 12 - minor changes to comments.
>  * Patch 13 - cosmetic changes to commit message and tests.
>  * Patch 14 - cosmetic changes to commit message.
>
> Cover letter for V1: Fix some issues with the implementation and use of
> reset_head(). The last patch was previously posted as [1], I have updated
> the commit message and rebased it onto the fixes in this series. There are a
> couple of small conflicts merging this into seen, I think they should be
> easy to resolve (in rebase.c take both sides in reset.c take the changed
> lines from each side). These patches are based on pw/rebase-of-a-tag-fix
>
> [1]
> https://lore.kernel.org/git/39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com/
>
> Phillip Wood (14):
>   rebase: factor out checkout for up to date branch
>   t5403: refactor rebase post-checkout hook tests
>   rebase: pass correct arguments to post-checkout hook
>   rebase: do not remove untracked files on checkout
>   rebase --apply: don't run post-checkout hook if there is an error
>   reset_head(): remove action parameter
>   reset_head(): factor out ref updates
>   reset_head(): make default_reflog_action optional
>   create_autostash(): remove unneeded parameter
>   rebase: cleanup reset_head() calls
>   reset_head(): take struct rebase_head_opts
>   rebase --apply: fix reflog
>   rebase --apply: set ORIG_HEAD correctly
>   rebase -m: don't fork git checkout
>
>  builtin/merge.c               |   6 +-
>  builtin/rebase.c              | 101 +++++++++++++----------
>  reset.c                       | 149 ++++++++++++++++++++--------------
>  reset.h                       |  48 ++++++++++-
>  sequencer.c                   |  47 ++++-------
>  sequencer.h                   |   3 +-
>  t/t3406-rebase-message.sh     |  23 ++++++
>  t/t3418-rebase-continue.sh    |  26 ++++++
>  t/t5403-post-checkout-hook.sh |  67 +++++++++++----
>  9 files changed, 312 insertions(+), 158 deletions(-)
>
>
> base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1049%2Fphillipwood%2Fwip%2Frebase-reset-head-fixes-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1049/phillipwood/wip/rebase-reset-head-fixes-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1049
>
> Range-diff vs v2:
>
>   1:  0e84d00572e =  1:  0e84d00572e rebase: factor out checkout for up to date branch
>   2:  a67a5a03b94 =  2:  a67a5a03b94 t5403: refactor rebase post-checkout hook tests
>   3:  07867760e68 =  3:  07867760e68 rebase: pass correct arguments to post-checkout hook
>   4:  2b499704c8f !  4:  f4b925508e7 rebase: do not remove untracked files on checkout
>      @@ Commit message
>           <upstream> is an ancestor of <branch> then it will fast-forward and
>           checkout <branch>. Normally a checkout or picking a commit during a
>           rebase will refuse to overwrite untracked files, however rebase does
>      -    overwrite untracked files when checking <branch>.
>      +    overwrite untracked files when checking out <branch>.
>
>           The fix is to only set reset in `unpack_tree_opts` if flags contains
>           `RESET_HEAD_HARD`. t5403 may seem like an odd home for the new test
>           but it will be extended in the next commit to check that the
>           post-checkout hook is not run when the checkout fails.
>
>      -    The test for `!deatch_head` dates back to the
>      +    The test for `!detach_head` dates back to the
>           original implementation of reset_head() in
>           ac7f467fef ("builtin/rebase: support running "git rebase <upstream>"",
>           2018-08-07) and was correct until e65123a71d
>   5:  04e7340a7e7 =  5:  4de5104d22d rebase --apply: don't run post-checkout hook if there is an error
>   6:  32ffa98c1bc =  6:  ff23498e93e reset_head(): remove action parameter
>   8:  29e06e7d36d =  7:  688ebc45bf7 reset_head(): factor out ref updates
>   9:  9d00a218daf !  8:  a5cc7eaa925 reset_head(): make default_reflog_action optional
>      @@ reset.c: int reset_head(struct repository *r, struct object_id *oid,
>
>        leave_reset_head:
>         rollback_lock_file(&lock);
>      -
>      - ## sequencer.c ##
>      -@@ sequencer.c: void create_autostash(struct repository *r, const char *path)
>      -          write_file(path, "%s", oid_to_hex(&oid));
>      -          printf(_("Created autostash: %s\n"), buf.buf);
>      -          if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
>      --                        "") < 0)
>      -+                        NULL) < 0)
>      -                  die(_("could not reset --hard"));
>      -
>      -          if (discard_index(r->index) < 0 ||
>   7:  341fe183c18 !  9:  dd3a22384d2 create_autostash(): remove unneeded parameter
>      @@ sequencer.c: void create_autostash(struct repository *r, const char *path,
>                 printf(_("Created autostash: %s\n"), buf.buf);
>                 if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
>       -                        default_reflog_action) < 0)
>      -+                        "") < 0)
>      ++                        NULL) < 0)
>                         die(_("could not reset --hard"));
>
>                 if (discard_index(r->index) < 0 ||
>  10:  5ea636009e7 ! 10:  ad7c6467987 rebase: cleanup reset_head() calls
>      @@ Commit message
>           currently possible so we delay fixing that caller until we can pass
>           the message as the branch reflog.
>
>      +    A later commit will make it a BUG() to pass reflog_orig_head without
>      +    RESET_ORIG_HEAD, that changes cannot be done here as it needs to wait
>      +    for move_to_original_branch() to be fixed first.
>      +
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>        ## builtin/rebase.c ##
>  11:  24b0566aba5 = 11:  d170703e833 reset_head(): take struct rebase_head_opts
>  12:  dc5d11291e7 = 12:  4973892561e rebase --apply: fix reflog
>  13:  45a5b5e9818 ! 13:  0ef0e978112 rebase --apply: set ORIG_HEAD correctly
>      @@ Metadata
>        ## Commit message ##
>           rebase --apply: set ORIG_HEAD correctly
>
>      -    At the start of a rebase ORIG_HEAD is updated to tip of the branch
>      -    being rebased. Unfortunately reset_head() always uses the current
>      -    value of HEAD for this which is incorrect if the rebase is started
>      -    with "git rebase <upstream> <branch>" as in that case ORIG_HEAD should
>      -    be updated to <branch>. This only affects the "apply" backend as the
>      -    "merge" backend does not yet use reset_head() for the initial
>      -    checkout. Fix this by passing in orig_head when calling reset_head()
>      -    and add some regression tests.
>      +    At the start of a rebase, ORIG_HEAD is updated to the tip of the
>      +    branch being rebased. Unfortunately reset_head() always uses the
>      +    current value of HEAD for this which is incorrect if the rebase is
>      +    started with "git rebase <upstream> <branch>" as in that case
>      +    ORIG_HEAD should be updated to <branch>. This only affects the "apply"
>      +    backend as the "merge" backend does not yet use reset_head() for the
>      +    initial checkout. Fix this by passing in orig_head when calling
>      +    reset_head() and add some regression tests.
>
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>  14:  3f64b9274b5 = 14:  9b9560ef676 rebase -m: don't fork git checkout
>
> --
> gitgitgadget
