Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2AEC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE02613A2
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhKQLqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhKQLqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 06:46:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811EBC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:43:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w29so4025148wra.12
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AN7d+1PY2b8w+LERv5FDWFdxItoEkuhLCN8wq2tweQs=;
        b=HZIKfTJjUoNvzy1jKKTX1ZZK4GofrcOTc98hxiBf9hplh2WNfkdzKRJatMA5PbCdxl
         BsodDbEhqrPSh3Zt0TDVRGle2a7WxlBfKEv5oWpbuAkAtPcILnPHE05AoIzOvU3/XFHr
         97sj0Jnv04RoKY6aDaEzAsF3gAWB/ZIShg0nzECA4Fl9NyvHmBqIKx6BbIySm2RKu0wK
         T4a+g4YxpuLGEQK4zMqv3XxuWHK0g1/hSutMQk//mqMHAUFJz1xcs7QjRduBSfPM0Hfm
         H58l3Fr1AIfQEKpntbjG6G6xEOZUo6R3FXJSRI8NjkEmncOsPQqYGb9kQZcrMpSUbpK5
         vURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AN7d+1PY2b8w+LERv5FDWFdxItoEkuhLCN8wq2tweQs=;
        b=NtU3jBfSJevOTeLfJou9F+OPqIzgFCOcdONLHysWPcBwrFhPAixbz0onHfLOh5WQyF
         JxjLh/7O+NZxedPps0A+I9/NVxfW0wWrlfR9Pa2CHe0yTf+FsDbo0NSslElX0P4W5v46
         pVQu9CewJnUDh8wmzj0EWPPISUml4oNPg2+fDQ2cqNyzKUkteHu9GJ7QjNPNj0Wnb18r
         8OfSoLk/nUmVm/vzk7RsCvgpBmmvj3a4ny10tfPWHizqYhNYnNNBOqNddyousxr49/X4
         wo6zGb98YVIEnPqce1nlr8aO0okOhr8MdiY4yybUzsVj1z7fl430cLeCI9siLO6MVe5P
         TM7A==
X-Gm-Message-State: AOAM5323AGvKfiydS++sTpn8cifi15lpz9MjlqIH+iCl6LqN7P7lwpl3
        jc54mDsqMV3y0yRFAHjxso2x+lDBvnwbrg==
X-Google-Smtp-Source: ABdhPJwMHxZLCAzE8Vi4B+4sjA3WBfGMcF8YgWBxCXi5ly4Kg+nbjdd5IDC4e/g/GxA/8FjUQraUdA==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr18969431wrs.207.1637149422779;
        Wed, 17 Nov 2021 03:43:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e18sm20398678wrs.48.2021.11.17.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:43:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/2] submodule: test what happens if submodule.superprojectGitDir isn't around
Date:   Wed, 17 Nov 2021 12:43:38 +0100
Message-Id: <RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <20211117005701.371808-1-emilyshaffer@google.com>
References: <20211117005701.371808-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16 2021, Emily Shaffer wrote:

> [...]
> A couple things. Firstly, a semantics change *back* to the semantics of
> v3 - we map from gitdir to gitdir, *not* from common dir to common dir,
> so that theoretically a submodule with multiple worktrees in multiple
> superproject worktrees will be able to figure out which worktree of the
> superproject it's in. (Realistically, that's not really possible right
> now, but I'd like to change that soon.)
>
> Secondly, a rewording of comments and commit messages to indicate that
> this isn't a cache of some expensive operation, but rather intended to
> be the source of truth for all submodules. I also added a fifth commit
> rewriting `git rev-parse --show-superproject-working-tree` to
> demonstrate what that means in practice - but from a practical
> standpoint, I'm a little worried about that fifth patch. More details in
> the patch 5 description.
>
> I did discuss Ævar's idea of relying on in-process filesystem digging to
> find the superproject's gitdir with the rest of the Google team, but in
> the end decided that there are some worries about filesystem digging in
> this way (namely, some ugly interactions with network drives that are
> actually already an issue for Googler Linux machines). Plus, the allure
> of being able to definitively know that we're a submodule is pretty
> strong. ;) But overall, this is the direction I'd prefer to keep going                                                                                                                          
> in, rather than trying to guess from the filesystem going forward.

Did you try running the ad-hoc benchmark I included in [1] on that
Google NFS? I've dealt with some slow-ish network filesystems, but if
it's slower than AIX's local FS (where I couldn't see a difference) I'd
put money on it being a cross-Atlantic mount or something :)

Re your:

    "this isn't a cache of some expensive operation, but rather intended to                                                                                                                          be the source of truth for all submodules."

In your 5/5 it says, in seeming contradiction to this:

    This commit may be more of an RFC - to demonstrate what life looks like
    if we use submodule.superprojectGitDir as the source of truth. But since
    'git rev-parse --show-superproject-working-tree' is used in a lot of
    scripts in the wild[1], I'm not so sure it's a great example.

    To be honest, I'd prefer to die("Try running 'git submodule update'")
    here, but I don't think that's very script-friendly. However, falling
    back on the old implementation kind of undermines the idea of treating
    submodule.superprojectGitDir as the point of truth.

Most of what I've been suggesting in my [1] and related is that I'm
confused about if & how this is a pure caching mechanism.

Removing mentions of it being a cache but it seemingly still being a
cache at the tip of this series has just added to that confusion for
me :)

Anyway. While I do think this caching mechanism is probably
unnecessary in the short to medium term, i.e. it seems to the extent
that it was ever needed was due to some bridging of *.sh<->*.c that
we're *this* close to eliminating anyway.

But maybe I'm wrong. The benchmark I suggested above on that Google
NFS might be indicative. I don't really see how something that'll be
doing a bunch of FS ops anyway is going to be noticeably slower with
that approach, but maybe opening the index/tree of the superproject is
more expensive than I'm expecting.

In any case, all of that's not the hill I'm picking to die on. If
you'd like to go ahead with this cache-or-not-a-cache then sure, I
won't belabor that point.

I *do* strongly think if we're doing so though that we should have
something like this on top. I.e. let's test wha happens if we do and
don't have this "caching" variable, which is demonstrably easy to do.

Benchmarking the two gives me:

    $ git hyperfine -L rev HEAD~0 -L s true,false -s 'make -j8 all' '(cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR={s} ./t7412-submodule-absorbgitdirs.sh)'
    Benchmark 1: (cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=true ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD~0
      Time (mean ± σ):     545.9 ms ±   1.6 ms    [User: 490.3 ms, System: 114.0 ms]
      Range (min … max):   543.5 ms … 548.1 ms    10 runs
     
    Benchmark 2: (cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=false ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD~0
      Time (mean ± σ):     537.9 ms ±  11.4 ms    [User: 476.8 ms, System: 117.6 ms]
      Range (min … max):   532.7 ms … 570.1 ms    10 runs
     
    Summary
      '(cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=false ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD~0' ran
        1.01 ± 0.02 times faster than '(cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=true ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD~0'

I.e. not using the cache is either indistinguishable or a bit faster
(the "a bit faster" is definitely due to just running less test code
though).

I'm sending this before the CI run[2] finishes (which now tests both
modes), but both of these work for me locally on a full test suite
run.

1. https://lore.kernel.org/git/211109.86v912dtfw.gmgdl@evledraar.gmail.com/
2. https://github.com/avar/git/runs/4237446991?check_suite_focus=true

Ævar Arnfjörð Bjarmason (2):
  submodule tests: fix potentially broken "config .. --unset"
  submodule: add test mode for checking absence of "superProjectGitDir"

 ci/run-build-and-tests.sh          |  1 +
 git-submodule.sh                   |  2 +-
 submodule.c                        |  7 +++++++
 t/lib-submodule-superproject.sh    | 24 ++++++++++++++++++++++++
 t/t7406-submodule-update.sh        | 13 ++++++-------
 t/t7412-submodule-absorbgitdirs.sh | 19 ++++++-------------
 6 files changed, 45 insertions(+), 21 deletions(-)
 create mode 100644 t/lib-submodule-superproject.sh

-- 
2.34.0.796.g2c87ed6146a

