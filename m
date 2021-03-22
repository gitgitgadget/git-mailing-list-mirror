Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0798CC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EA961990
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCVLte (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhCVLs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 07:48:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF32C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 04:48:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso3209281wmq.1
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnUHmtgaTDClfNdskY1lw1j3JGfu5bkW4RPjC5R7Vsk=;
        b=cNF6q1sVuStetBRA2ijV93TDVVyw/db9Op81BFrEtcsMQ3Yuppre630sCP0FSUOci/
         +x4p6L6m5u+YDpAbhaPDniFJNyEvz9yzyBDFkHi+8EpAs332la7k3c5FP9PL921XE2bh
         gVg0SLRL3ncUl7KGKjvA8oHykAOsAizch+oNJ0qc8hwrsrcbW8Dou0OTIKVlCRbyC1J4
         VUGN1dOCc/48FbN9iteK2njEffYNjUtQG4pAVkR+zIM5O0acbSbiiWxoSyg/U98k5i0Z
         DP8Eb4HaBwe5gwvhkN5xGRLgZVLejTZf1ZgSleZPRSHyYAT6iKOD0PqmA2qgP3fom0nV
         wnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnUHmtgaTDClfNdskY1lw1j3JGfu5bkW4RPjC5R7Vsk=;
        b=Oq/LJbDnQRha/q2FoFqRwA7A4N/TW4VVCNFI+gannzI2Wv87EFlnDj/DI8GvbdlWQW
         Q9VlQspNtyHoeGb9NYCJMGdlo/QwHsS1b+48hHWM0mJPknP4Js8RN4c3FlY/zygtYPUd
         5NKg4SFbMvNshK3Bja1sv1uXbwjq04rcxDO8raMJ/utxOr+7MBDDNYDtVIenuvjZmN6F
         ghVwwrweEiDCzmr/4220ovudmPHcM+LbnKweY4CmWoMRUx+U5tcL3eVGw3OgxUkaDSlY
         OpLOKt2NfOai+E4gYMUW79RcxPBrK/+7NJwii+vga4xtWUorhjNnuylTPbzfT60ndBDR
         QMzg==
X-Gm-Message-State: AOAM53028ifx/2r14gu8Ka1QSidB+Oz9SUV37zx3hsmHZY6Wi9+aLzah
        dmpTIreT0kEoGo7iwvVpecl/MfZbhy5jdg==
X-Google-Smtp-Source: ABdhPJyV5HDkdwonhOaaG/gepM6axZOjW/RFjSk+JLyTNvPy/y9gWGL4UvyScAOsukD1YImuI7Twew==
X-Received: by 2002:a7b:cb99:: with SMTP id m25mr16082164wmi.64.1616413736683;
        Mon, 22 Mar 2021 04:48:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm19768945wro.53.2021.03.22.04.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:48:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] rebase: don't override --no-reschedule-failed-exec with config
Date:   Mon, 22 Mar 2021 12:48:22 +0100
Message-Id: <cover.1616411973.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com>
References: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently started using rebase.rescheduleFailedExec=true and noticed
this bug in its implementation. It's conceptually a relatively simple
fix, but as noted in 3/3 rebase being a "start this operation, run
other command verbs later" has an unintuitive interaction with our
usual "command-line options override config".

!README FIRST!
Everthing after this line has no relevance to this series, it's just a
side musing on another (mis-)feature of --reschedule-failed-exec.
!/README FIRST!

There's another bug/misfeature I've noticed with
rebase.rescheduleFailedExec=true (although maybe it'll be argued by
someone that it's a feature). Let's say you run:

    git rebase -x false --reschedule-failed-exec HEAD~2

You'll now land in a state of (according to our helpful PS1 code, but
also the rebase state) of 2/4. Aside: Because you're rebasing 2
commits, we have 4 because of the 2x exec. So far so good and all of
that's expected.

But now when you do "git rebase --continue" we'll fail as expected,
but not as expected (at least I find it funny) bump the count to 3/5,
then 4/6, 5/7 etc.

With my "I just read the code" hat on this makes perfect sense. Every
time we process a TODO item we bump the count of processed items, and
under --reschedule-failed-exec we simply push the command that just
failed onto the list, hence the increasing done/TODO count when a
command fails.

But I don't see how it makes any sense to expose this as UI via "git
status" and __git_ps1. I asked git to process this item of 4 sequencer
TODO items. If I fail an item it makes more sense that I just don't
get past it, not that under the hood a new identical item is
rescheduled for me. Just don't advance past the current item!

Now if I've tried X times to make the "make test" pass for each commit
in my 3-commit series I'm going to be on item 10/12 or
whatever. There's no way to just look at that and see where I'm at in
the sequence.

As an aside it would arguably make more sense to report 1/3 instead of
2/6 for the first commit of 3 with a failing -x "make test", but you
can have X number of "exec" items and a manually edited list etc. 

So that's probably a no-go but at least once I'm used to it I know if
i'm on 4/6 I'm on commit 2/3, with --reschedule-failed-exec you'll
have no idea what 12/14 or whatever means for where you are in your
3-patch sequence, it has no relation to the TODO list you edited, just
rebase-merge's own internal state.

Getting back on topic: This just seems like needlessly exposing an
implementation detail, I also asked to "pick" a commit, but if that
item "fails" e.g. due to:
    
    $ git rebase --continue
    You must edit all merge conflicts and then
    mark them as resolved using git add

We don't push a new "pick" item on the list and inflate the count, so
why would we do that for "exec"? Just say the command failed, return
its non-zero status from "git rebase --continue", and don't advance.

Maybe it is useful to keep track of the N number of failures, and
e.g. report in __git_ps1:

    master|REBASE 2/6
    master|REBASE 2(tries: 1)/6
    master|REBASE 2(tries: 2)/6

Instead of the current:

    master|REBASE 2/6
    master|REBASE 3/7
    master|REBASE 4/8

To say I'm on 2/6, but that I've tried 3 times already and failed to
advance past it.

Anyway, I don't have patches for this side-report/rant. Looking at the
implementation it seemed more non-trivial than I was willing to
quickly fix.

We bump the count fairly early before we even get to there being an
"exec" item, to implement this proposed view of the world we'd need to
defer that (or go back and edit it once we see "failed exec" and that
we're using --reschedule-failed-exec).

I'm not familiar enough with the sequencer internals to know if trying
that would lead us down a path of e.g. having inconsistent or bad
state if we'd die in the middle of all of that.

Ævar Arnfjörð Bjarmason (3):
  rebase tests: camel-case rebase.rescheduleFailedExec consistently
  rebase tests: use test_unconfig after test_config
  rebase: don't override --no-reschedule-failed-exec with config

 Documentation/git-rebase.txt |  8 ++++++++
 sequencer.c                  |  5 +++++
 t/t3418-rebase-continue.sh   | 30 ++++++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.31.0.285.gb40d23e604f

