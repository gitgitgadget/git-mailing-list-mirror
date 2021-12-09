Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF30C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhLIFMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhLIFMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F7DC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 133so3307923wme.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=POdQYn+wB8P6R6dKvarUZSBNCsOxZRG7ulwQoq/6ysU=;
        b=LaaYHxFS40XBZkief9MhLxJzxWvH9YDZF4wJdz5rt4PEzxQ7QuvlTqYxzID8IPAMNC
         70kukf9Xz4zdTxUeKCkP95RczLazvqUsZ/YO7IhFKKWy0ketjBmDfe83GORvZo7xugD2
         DrY+SaYYDwN5sGjpkG6kzByKH3Jg7MOtE00RAjssn26EJWBB2aO5b2SitmSuXIztTXQx
         BLb+M/WTB/K6EQNXce4xdHm7o0Pe8Ay/Tl9W73Lh++VN03J6NXvLO1SmuSPmmQ7WMzsy
         fZn6ah3/tG7bNkrP6n/xyGutBTRjmw6zmXvL0nmjnthN/HKwuDCaHjNHzlf459t8RAVS
         HJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=POdQYn+wB8P6R6dKvarUZSBNCsOxZRG7ulwQoq/6ysU=;
        b=cwkUv3B23Z92wr2OsPyFZEChPPQX+1Lsrnt0YwL/Zlk17L+443J+My3W7Dsp6H2zP5
         W1dnD+PJ1j3yBtyrVys2cJNB6A6IOygSuSGTrAmmHrMhHRHii8E61uKJNt5iFT4u9/d2
         LfMxQsoiIdMs3AKwUixHj76OMpNm+CAQbkXVOYR1OLBoTl5FHE5+wfjC+1xcQ/WjrnDA
         fDLly8tlDcu6OgQBF36g7DF+0Q2WtuJgPK6c8QHL2+QW/YE8P4bpD1Z+9aIUpJXSyroM
         JrGA9CnrtoJepxLJ9gjcA9fGv2oSzh8Uu950iifk12DWcGFsS0PgJwPs9PYtmklySsZA
         ZAqA==
X-Gm-Message-State: AOAM5306jGGYh8aRNpf99inXh1RJtDQ5ft8We9uC2AwY4+MMOm3Ndbjp
        xVCVFpUM0HCXpMYtU+oQ+H+qPNJ2ddI=
X-Google-Smtp-Source: ABdhPJym4zpKUYi0/mPmz+FYEAR3HKRmktL4Q3UygRhbrt1AG+scCSuHNXiVpnPUIUsqpvJG03LvxQ==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr4198962wmg.51.1639026517485;
        Wed, 08 Dec 2021 21:08:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22sm4453763wme.19.2021.12.08.21.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:36 -0800 (PST)
Message-Id: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:24 +0000
Subject: [PATCH v6 00/11] Avoid removing the current working directory, even if it becomes empty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Traditionally, if folks run git commands such as checkout or rebase from a
subdirectory, that git command could remove their current working directory
and result in subsequent git and non-git commands either getting confused or
printing messages that confuse the user (e.g. "fatal: Unable to read current
working directory: No such file or directory"). Many commands either
silently avoid removing directories that are not empty (i.e. those that have
untracked or modified files in them)[1], or show an error and abort,
depending on which is more appropriate for the command in question. With
this series, we augment the reasons to avoid removing directories to include
not just has-untracked-or-modified-files, but also to avoid removing the
original_cwd as well.

Peff and Junio provided some good pros/cons, if it helps:

 * Pros: Peff (original suggester of the idea)[2], and Junio[3]
 * Cons: Peff [2, again -- see the "P.S."], and Junio[4]

[1] well, with a few exceptions; see
https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/YS8eEtwQvF7TaLCb@coredump.intra.peff.net/
[3] https://lore.kernel.org/git/xmqqo86elyht.fsf@gitster.g/ [4]
https://lore.kernel.org/git/xmqqo8691gr8.fsf@gitster.g/

Changes since v5:

 * It's been about a week without changes, so including Acks that have come
   in (let me know if I was wrong in my interpretation of these statements
   as Acks):
   * from Stolee ("This version is good to go",
     https://lore.kernel.org/git/aa85e35d-143e-93e4-f54b-146b38dd4b88@gmail.com/)
   * from Ævar ("I've got no objections to these changes going in as they
     stand.",
     https://lore.kernel.org/git/211207.86ee6opy0f.gmgdl@evledraar.gmail.com/)

Changes since v4:

 * actually fix bashism

Changes since v3:

 * fixed one codepath from v2 so that the series really is only about the
   working tree
 * used test-tool getcwd instead of pwd -P as suggested by Ævar for some
   less common platforms
 * fixed bashism
 * check for clean index/worktree after verifying that expected-to-abort
   codepaths do abort, to make it clearer that we expect an early abort
 * remove a leftover (and confusing) is_absolute_dir() check in sequencer
   and stash from an earlier round of the series

Changes since v2:

 * the series is now only about the working tree. So if the original cwd is
   outside the worktree (or we're in a bare repo), then the new code is a
   no-op.
 * fixed ugly early die() possibility (uses strbuf_getcwd() instead of
   xgetcwd())
 * modified the initial tests to show both expected and desired behavior.
   subsequent patches fix the tests. One new patch added at the end which
   simplifies the tests to only check for desired behavior.
 * NULLify startup_info->original_cwd when it matches the toplevel worktree;
   that is already protected and we don't need secondary protection for it.
   This simplified some other codepaths so we don't have to check for
   startup_info->original_cwd == "".
 * clarified some commit messages

Changes since v1:

 * clarified multiple commit messages
 * renamed the_cwd to startup_info->original_cwd to make it clearer that
   it's our parent process'es cwd that really matters, which we inherited at
   program startup. Also pulls it out of the global namespace.
 * Normalize the path for startup_info->original_cwd, and ensure that it's
   actually the original cwd even if -C is passed to git.
 * small code cleanups suggested by René and Ævar
 * split the final patch (which got the most comments) into two -- one for
   each function being modified. Also, add a bunch more history to the first
   of the two resulting commit messages
 * no longer has a content conflict with so/stash-staged
 * add another value for the flags parameter that remove_dir_recursively()
   takes so that it can opt into either the old or the new behavior. Use
   that for the one special corner case I could find where it matters, and
   add a few tests around it to highlight the utility of the flag.

Elijah Newren (11):
  t2501: add various tests for removing the current working directory
  setup: introduce startup_info->original_cwd
  unpack-trees: refuse to remove startup_info->original_cwd
  unpack-trees: add special cwd handling
  symlinks: do not include startup_info->original_cwd in dir removal
  clean: do not attempt to remove startup_info->original_cwd
  rebase: do not attempt to remove startup_info->original_cwd
  stash: do not attempt to remove startup_info->original_cwd
  dir: avoid incidentally removing the original_cwd in remove_path()
  dir: new flag to remove_dir_recurse() to spare the original_cwd
  t2501: simplify the tests since we can now assume desired behavior

 builtin/clean.c      |  44 +++++--
 builtin/rm.c         |   3 +-
 builtin/stash.c      |   4 +-
 cache.h              |   2 +
 common-main.c        |   4 +
 dir.c                |  15 ++-
 dir.h                |   9 +-
 sequencer.c          |   2 +
 setup.c              |  65 ++++++++++
 symlinks.c           |   8 +-
 t/t2501-cwd-empty.sh | 277 +++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c       |  30 ++++-
 unpack-trees.h       |   1 +
 13 files changed, 442 insertions(+), 22 deletions(-)
 create mode 100755 t/t2501-cwd-empty.sh


base-commit: 88d915a634b449147855041d44875322de2b286d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1140%2Fnewren%2Fcwd_removal-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1140/newren/cwd_removal-v6
Pull-Request: https://github.com/git/git/pull/1140

Range-diff vs v5:

  1:  7c72e888d2e !  1:  1fd76d4f8a8 t2501: add various tests for removing the current working directory
     @@ Commit message
          Also add a few tests suggested during the review of earlier rounds of
          this patch series.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t2501-cwd-empty.sh (new) ##
  2:  37f333b2024 !  2:  cd1f564c4c0 setup: introduce startup_info->original_cwd
     @@ Commit message
      
          Subsequent commits will make use of this new variable.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## cache.h ##
  3:  b611c73bd15 !  3:  4a1f62b662c unpack-trees: refuse to remove startup_info->original_cwd
     @@ Commit message
          error out if the directory is the current working directory we inherited
          from our parent process.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t2501-cwd-empty.sh ##
  4:  706415a4547 !  4:  03f2b0b8fb7 unpack-trees: add special cwd handling
     @@ Commit message
          there is no untracked checking to be done, so we simply add a special
          case near the top of verify_absent_1.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t2501-cwd-empty.sh ##
  5:  66ef6b4d943 !  5:  e75f6c3f9ad symlinks: do not include startup_info->original_cwd in dir removal
     @@ Commit message
          commands) that would otherwise report confusing messages about being
          unable to read the current working directory.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## symlinks.c ##
  6:  54d059c683e !  6:  d4f8784a6e4 clean: do not attempt to remove startup_info->original_cwd
     @@ Metadata
       ## Commit message ##
          clean: do not attempt to remove startup_info->original_cwd
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/clean.c ##
  7:  f8efb7446c3 !  7:  fd500cc1843 rebase: do not attempt to remove startup_info->original_cwd
     @@ Commit message
          the startup_info->original_cwd directory, so that the checkout process
          knows to protect that directory.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## sequencer.c ##
  8:  2855ed45112 !  8:  6f3c4fd49b9 stash: do not attempt to remove startup_info->original_cwd
     @@ Commit message
          longer run from the toplevel, pass the ':/' magic pathspec to ensure we
          still clean from the toplevel.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/stash.c ##
  9:  23dfc3e399d !  9:  1a66b1a2386 dir: avoid incidentally removing the original_cwd in remove_path()
     @@ Commit message
          looked through every caller of remove_path() in the current codebase to
          make sure that all should take this change.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## dir.c ##
 10:  fe47c0f0c17 ! 10:  4a18efd51ef dir: new flag to remove_dir_recurse() to spare the original_cwd
     @@ Commit message
          highlight that very specific case involving submodules && --git-dir &&
          --work-tree.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/rm.c ##
 11:  431dd651a7e ! 11:  63781ed8b8e t2501: simplify the tests since we can now assume desired behavior
     @@ Commit message
          We no longer are dealing with a mixture of previous and desired
          behavior, so simplify the tests a bit.
      
     +    Acked-by: Derrick Stolee <stolee@gmail.com>
     +    Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t2501-cwd-empty.sh ##

-- 
gitgitgadget
