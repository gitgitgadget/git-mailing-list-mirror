Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAB4C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E46613AA
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhGEMet (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGEMet (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:34:49 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3929DC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:12 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id h9so20605717oih.4
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo514KyQS+dsaO5cFoYPBucJn0p7vQ89OK5RTI4YUZE=;
        b=hK/WGpMlfKzMpdziLWTcJmPkjE/MaqTxprpnIi8SiOG2StXTK2CHVisBQV30ytHtKx
         XsARMHpojn9oB2PBcvDaf0AwylpASoA0ttd5qwWUbFuOvZgaHcymWPsKtbZmwijiqAMx
         KLWO6FHsdnwL3EY8lA4xwQw2Ltrl8WgXu573cZdUKpB9svNoA2GHmZtEfs0rUjEFj0L1
         VR5ToIj3Zxf6TZFaH7M0arjkJdSnyDxGANFJyCBTvbcVxxQUIYgiNltPsNAj5GuWIjD0
         Jd2pTHKqjMjHL55CvXpvEgPCrfwkxhgMqNhODr2S/Z+/uG+pAlYWpY1Yf9T/NU5AyW/2
         UIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo514KyQS+dsaO5cFoYPBucJn0p7vQ89OK5RTI4YUZE=;
        b=LMgve14OH5DGBNbB8kN6CiFMKGzs6TpE7RBAU1Tf5bzn9gW0GkzttjOp/YSNnu41EE
         m+brP6ra83tGsrx2zTT7UWBV4MNc3VSYhcGBDKcMFDEUbHwq9jtwbSGNUlfVA1ZGwEyr
         ycE8lmohupXAfVWEabCWOIS8zx3TllceDzXknpD/k6pLOTPFXyM6YjCgxhq5S1Ch7hiI
         jWKgb8LNq6i9fYxwnc0oZ/IjFOyoZjejzPQbN3F47vGvCz+ChQHyJKzs66tzZc2v7b4X
         e9T50MZhanh4p1I/fANY58InwUbBwkyBQ4UMinj8asOoeYfLouh2H9FLvKvP7h1FVGbK
         qZTw==
X-Gm-Message-State: AOAM530vGwcuzDS5HgmsWYfdiaQGp0C5fAu8//2/AhGEVwfsDwlHwy/S
        nqApscEh6qh9ylO0fK3yHlj2ejghf56VUw==
X-Google-Smtp-Source: ABdhPJxaePrXQXRKNbKgO7O/vDCCw4UEi/WPlH0SyXhCCZ/wzhXwWu21AJP5HQCvdYTX5Uh525uH6A==
X-Received: by 2002:aca:2802:: with SMTP id 2mr10151395oix.46.1625488331262;
        Mon, 05 Jul 2021 05:32:11 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id z15sm2559175otj.33.2021.07.05.05.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 00/35] git update: fix broken git pull
Date:   Mon,  5 Jul 2021 07:31:34 -0500
Message-Id: <20210705123209.1808663-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Throughout the years many big threads have been started [1] [2] [3] [4]
[5] [6] because `git pull` is broken (for everyone that isn't a
maintainer), and nothing has been fixed.

The two main problems are:

  1. The order of the parents is the opposite of what it should be
  2. By default it should fail unless it's a fast-forward

However, every attempt to fix these issues gets entangled in an
inescapable web of interrelated problems.

That's because `git pull` is in fact *two* commands pretending to be
one.

I have spent several days re-reading old threads looking for anything
related to `git pull` and fast-forward throughout the entire history of
the git mailing list, going as far back as 2008.

This process has been illuminating.

The amount of people that have pondered about, and even suggested, a
`git update` command is striking:

 * Linus Torvalds: [7]
 * Junio C. Hamano: [8]
 * Richard Hansen: [9]
 * John Keeping: [10]

And of course me [11], who not only suggested it, but implemented it
as well [12].

It's not just the name, but the behavior too:

  `git fetch` + `git merge --ff-only`

This way `git pull` can be used by maintainers to integrate pull
requests, and `git update` for everyone else (normal developers) to
update their local branch to its upstream.

Plus it has a --merge mode that creates a merge commit, but with the
parents in the right order (master to upstream, not upstream to master).

Both problems are fixed by this approach.


Also, a thorny issue since a long time ago has been how to properly
advise users what to do in case a fast-forward is not possible.

I propose a new command: `git fast-forward`. When a fast-forward is not
possible `git fast-forward` fails, and shows an advice (that can be
easily turned off).

Therefore in fact `git update` is really `git fetch` +
`git fast-forward`, and it's the latter that throws the advice. The
advice also suggests `git help fast-forward` which has an explanation
about what a fast-forward is, what are the options to synchronize
with the remote branch (merge and rebase), and what do they look like.

In addition there's a ton of fixes for `git pull` which have been sent
before, including the `pull.mode` configuration, the `--merge` option,
the per-branch `pullMode` configuration, `pull.mode=fast-forward`, and
an improved advice message to prepare users for a future default change:

  The pull was not a fast-forward, in the future you will have to choose
  between a merge or a rebase.

  To quell this message you have two main options:

  1. Adopt the new behavior:

    git config --global pull.mode fast-forward

  2. Maintain the current behavior:

    git config --global pull.mode merge

  For now we will fall back to the traditional behavior: merge.
  For more information check "git help fast-forward".

It doesn't just improve the situation for normal developers, but it also
opens the possibility to fix a wart in `git pull --rebase`:

Right now:

 git pull --merge github john (merge "github/john" into "master)
 git pull --rebase github john (rebase "master" onto "github/john")

Since now `git update --rebase` can be used to rebase the current branch
onto its upstream, that leaves `git pull --rebase` open to rebase
github/john onto master, not the other way around like it currently is.


Junio has suggested there's no consensus over fast-forward by default,
but that's not true. Here is a non-exhaustive list of people that have
agreed the default should be fast-forward only.

 * Linus Torvalds
 * Junio C Hamano
 * Jeff King
 * Jonathan Nieder
 * Richard Hansen
 * Philip Oakley
 * Elijah Newren
 * John Keeping
 * Ramkumar Ramachandra
 * Alex Henrie
 * W. Trevor King
 * Greg Troxel
 * Peter Kjellerstedt
 * Konstantin Tokarev
 * Robert Dailey
 * Vít Ondruch
 * Raymond E. Pasco
 * Jacob Keller
 * Felipe Contreras

There's only one person against the change: Matthieu Moy. His argument
back then [13] was: why ask users to merge or rebase if newcomers will
not pick a rebase? To that my response is: for the same reason we ask
them to do `git commit --all`: so that they eventually learn about the
staging area. Just like they can do `git commit --all`, they can do
`git pull --merge`. They can figure out what that means later.

The people in favor of reordering the parents:

 * Andreas Krey
 * John Szakmeister
 * Jeremy Rosen
 * John Keeping

And the people in favor of my old `git update`:

 * Damien Robert
 * Ping Yin
 * Philippe Vaucher


This patch series doesn't implement all of the features my old
`git update` had, but it implements most of them, most
importantly--unlike `git pull`--it's not broken.

Right now only `git update` without arguments works, and only if the
upstream branch is configured. I have a pretty good idea of what the it
should do with different arguments (as I had already implemented that),
but for now that's open to discussion.

If you want to give it a try:

https://github.com/felipec/git/tree/fc/update

[1] https://lore.kernel.org/git/200910201947.50423.trast@student.ethz.ch/
[2] https://lore.kernel.org/git/20130522115042.GA20649@inner.h.apk.li/
[3] https://lore.kernel.org/git/1377988690-23460-1-git-send-email-felipe.contreras@gmail.com/
[4] https://lore.kernel.org/git/4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com/
[5] https://lore.kernel.org/git/5363BB9F.40102@xiplink.com/
[6] https://lore.kernel.org/git/20201204061623.1170745-1-felipe.contreras@gmail.com/
[7] https://lore.kernel.org/git/CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com/
[8] https://lore.kernel.org/git/xmqqppjyhnom.fsf@gitster.dls.corp.google.com/
[9] https://lore.kernel.org/git/5228A14B.3000804@bbn.com/
[10] https://lore.kernel.org/git/20130628174252.GF2232@serenity.lan/
[11] https://lore.kernel.org/git/5366db742d494_18f9e4b308aa@nysa.notmuch/
[12] https://github.com/felipec/git/commit/61e05c9798b3c74bab8b2d47ede4c12e8e305345
[13] https://lore.kernel.org/git/vpqbo3za8r9.fsf@anie.imag.fr/

Felipe Contreras (35):
  merge: improve fatal fast-forward message
  merge: split cmd_merge()
  fast-forward: add new builtin
  doc: fast-forward: explain what it is
  fast-forward: add advice for novices
  fast-forward: make the advise configurable
  fast-forward: add help about merge vs. rebase
  update: new built-in
  update: add options and usage skeleton
  update: add --ff option
  update: add --merge mode
  commit: support for multiple MERGE_MODE
  merge: add --reverse-parents option
  update: reverse the order of parents
  update: fake a reverse order of parents in message
  update: add --rebase mode
  update: add mode configuation
  update: add per-branch mode configuration
  pull: cleanup autostash check
  pull: trivial cleanup
  pull: trivial whitespace style fix
  pull: introduce --merge option
  rebase: add REBASE_DEFAULT
  pull: move configuration fetches
  pull: show warning with --ff options
  pull: add pull.mode
  pull: add per-branch mode configuration
  pull: add pull.mode=fast-forward
  pull: reorganize mode conditionals
  pull: add diverging advice on fast-forward mode
  pull: improve --rebase and pull.rebase interaction
  pull: improve default warning
  pull: advice of future changes
  FUTURE: pull: enable ff-only mode by default
  !fixup FUTURE: pull: enable ff-only mode by default

 .gitignore                             |   2 +
 Documentation/config.txt               |   4 +
 Documentation/config/advice.txt        |   2 +
 Documentation/config/branch.txt        |  10 ++
 Documentation/config/pull.txt          |   6 +
 Documentation/config/update.txt        |   5 +
 Documentation/git-fast-forward.txt     | 104 +++++++++++++++++
 Documentation/git-pull.txt             |  10 +-
 Documentation/git-update.txt           |  47 ++++++++
 Documentation/merge-options.txt        |   4 +
 Makefile                               |   2 +
 advice.c                               |  15 +++
 advice.h                               |   2 +
 builtin.h                              |   2 +
 builtin/commit.c                       |   7 +-
 builtin/merge.c                        |  59 +++++++---
 builtin/pull.c                         | 156 +++++++++++++++++--------
 builtin/update.c                       | 153 ++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  22 ++++
 fmt-merge-msg.c                        |  21 +++-
 fmt-merge-msg.h                        |   3 +-
 git.c                                  |   2 +
 rebase.c                               |  12 ++
 rebase.h                               |  13 ++-
 t/t4013-diff-various.sh                |   2 +-
 t/t5520-pull.sh                        | 123 +++++++++++++++++--
 t/t5521-pull-options.sh                |   4 +-
 t/t5524-pull-msg.sh                    |   4 +-
 t/t5553-set-upstream.sh                |  14 +--
 t/t5563-update.sh                      |  87 ++++++++++++++
 t/t5604-clone-reference.sh             |   4 +-
 t/t6402-merge-rename.sh                |  16 +--
 t/t6409-merge-subtree.sh               |   6 +-
 t/t6417-merge-ours-theirs.sh           |  10 +-
 t/t7600-merge.sh                       |  47 ++++++++
 t/t7601-merge-pull-config.sh           | 116 ------------------
 t/t7603-merge-reduce-heads.sh          |   2 +-
 37 files changed, 870 insertions(+), 228 deletions(-)
 create mode 100644 Documentation/config/update.txt
 create mode 100644 Documentation/git-fast-forward.txt
 create mode 100644 Documentation/git-update.txt
 create mode 100644 builtin/update.c
 create mode 100755 t/t5563-update.sh

-- 
2.32.0.36.g70aac2b1aa

