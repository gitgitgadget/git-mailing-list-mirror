Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48853C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 15:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2648261278
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 15:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGEPts (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhGEPtq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 11:49:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A14EC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 08:47:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s18so3564267pgg.8
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endorphin.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=j1jSxaGhV0pNh6Zs/BxdHmjG5doyClkjOipZEXJpN34=;
        b=JQgboGtfOOthmVG1zS33zYJXEWLAx+Xf/YajOBIUdQULnxvoawmy6+x1CAZIxBCU2G
         Jofa+2m/WiRsiEmNplGu497MdAMHl7L6nFRKr/TslA/mKlVDO8kem78oTWUtTd8henyw
         j+zMVXpHMUtGSzxQdSgBS7nuKwVwywnZ2TC4LOKF4KuZWXqs71Vxz4RMRglToWHgMy3q
         HOOUR0ka62hHpYCtnJX3SHfUg9U+GeOToHwX91PmHreJr0WsDNRlsKZRGAwY4lE98Udz
         aV/TOBAcKnK8ZjgXSpL5l46I6ZQiFWdAUkvZ0vCWLDPWysc1vsCpcyWfKhJGz1vt+wfV
         jXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j1jSxaGhV0pNh6Zs/BxdHmjG5doyClkjOipZEXJpN34=;
        b=lpFxrxX/lFedSaU4ZC5xhS6kwDDTyQztHj3J02zFC1kCFMoeutyKIezmHzBOdHHBae
         mhXApXIpTuKx2VnlMfl8IIGWHq80sDo+ooLHrtWGNmObGFig7CIfgdZVhENEvYX1/Obz
         AAxJY0e0WTml9V8sU8q13AeN8/+RID9Iw/U/1oyWpkK91x6R06H19kfJ6P4vY7HgH7xp
         GcZ0yAJywFEJ0cr/7yEERS5qqRjc+Q+BrVC3VzbLpb3bn2+ptd+NBMbTN27NpbgVKtyf
         3PE0j/662DpXJ2nvOKJcSuErUpKCyAiTAfBhZV65uccPdABofgWfGoDucrbyEJwTTPxw
         ecQQ==
X-Gm-Message-State: AOAM531JYrFN3yxg4+lePnuNiv8wXvah3V5JcL5EPXFj8eqL7rnQZ9Pd
        sD+YfmWKr5aDZGi/lsroDgdtIviSRm6NCFq32rKcYlFgD1pBjkP8
X-Google-Smtp-Source: ABdhPJwit4SmoEJDtYvSXJR6u+NxEgnloQ3skPvDEDdSBg1U4XAx7Gjxs0GMXKHGqaYdTzuDGGzAASPRKs7F/9ex/3Q=
X-Received: by 2002:aa7:8d01:0:b029:311:47d0:f169 with SMTP id
 j1-20020aa78d010000b029031147d0f169mr2798861pfe.78.1625500028743; Mon, 05 Jul
 2021 08:47:08 -0700 (PDT)
MIME-Version: 1.0
From:   Clemens Fruhwirth <clemens@endorphin.org>
Date:   Mon, 5 Jul 2021 17:46:58 +0200
Message-ID: <CAG6gW_uHhfNiHGQDgGmb1byMqBA7xa8kuH1mP-wAPEe5Tmi2Ew@mail.gmail.com>
Subject: git pull --set-upstream segfaults on branchless repo.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Run "git pull origin nixos-unstable --rebase --set-upstream"
on a repo that had no branch set, e.g. when running "git branch" gave
"* (no branch)"

What did you expect to happen? (Expected behavior)
Pull from upstream and set upstream.

What happened instead? (Actual behavior)
Segfault with the following trace:
(gdb) bt
#0  0x000000000044a8c9 in do_fetch (transport=0x2557920,
rs=rs@entry=0x7ffd42335c00) at builtin/fetch.c:1568
#1  0x000000000044ac61 in fetch_one (remote=<optimized out>,
argc=1110662144, argv=0x7ffd42335fc8,
    prune_tags_ok=<optimized out>, use_stdin_refspecs=0) at builtin/fetch.c:1892
#2  0x000000000044af15 in cmd_fetch (argc=0, argv=0x7ffd42335fc8,
prefix=0x0) at builtin/fetch.c:1992
#3  0x0000000000406354 in run_builtin (p=0x70d3e0 <commands+960>,
argc=argc@entry=5, argv=argv@entry=0x7ffd42335fc0)
    at git.c:453
#4  0x00000000004065c3 in handle_builtin (argc=5, argv=0x7ffd42335fc0)
at git.c:704
#5  0x0000000000407c4a in run_argv (argcp=argcp@entry=0x7ffd42335e8c,
argv=argv@entry=0x7ffd42335e80) at git.c:771
#6  0x00000000004080a4 in cmd_main (argc=<optimized out>,
argc@entry=6, argv=<optimized out>,
    argv@entry=0x7ffd42335fb8) at git.c:902
#7  0x00000000004c614c in main (argc=6, argv=0x7ffd42335fb8) at common-main.c:52
(gdb) p branch
$1 = (struct branch *) 0x0

What's different between what you expected and what actually happened?
Not segfault

Anything else you want to add:

Dropping the "--set-upstream" makes the segfault go away. Looking at
builtin/fetch.c around L1568 I see,

        if (set_upstream) {
                struct branch *branch = branch_get("HEAD");
                [..]
                if (source_ref) {
                        if (!strcmp(source_ref->name, "HEAD") ||
                            starts_with(source_ref->name, "refs/heads/"))
                                install_branch_config(0,
                                                      branch->name, //
<- SEGFAULT HERE
                                                      transport->remote->name,
                                                      source_ref->name);
                        [..]
              }
        }

It's rather clear that branch is just NULL from the gdb session above,
and the branch->name dereference fails.
It might be useful to catch branch == NULL.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.31.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /nix/store/kxj6cblcsd1qcbbxlmbswwrn89zcmgd6-bash-4.4-p23/bin/bash
uname: Linux 5.12.12 #1-NixOS SMP Fri Jun 18 08:02:52 UTC 2021 x86_64
compiler info: gnuc: 10.3
libc info: glibc: 2.32
$SHELL (typically, interactive shell): /var/run/current-system/sw/bin/zsh


[Enabled Hooks]

(Please cc me on replies, not subscribe to the mailing list).
-- 
Fruhwirth Clemens http://clemens.endorphin.org
