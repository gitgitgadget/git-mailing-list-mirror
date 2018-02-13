Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A748C1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 20:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965705AbeBMUXB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 15:23:01 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:41375 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965610AbeBMUXA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 15:23:00 -0500
Received: by mail-io0-f194.google.com with SMTP id f4so22685452ioh.8
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DChTPlxn5JAy8QYLbS2OwMPsxu9XYsq2sXg9H7k8ly0=;
        b=Y9pRki34+HgaL4wBZLCqFgs57/p2n0EiGnn1auCeh6M4CTa9Ccwcxl6/AtOnjXXS9v
         aBhaYUpNmwDRZVZQLgJzvBusyImFGJYMFPAMwnIp6nFc55XDUktjsUL8R2V0NR7+htxY
         9I0WKU5Wp/VJQv4PZ6nRZddX8/H+kATFi6BC7kxbcePgm2aF0s/bKkbfUPh8yy4Bo3v9
         fMHUZV004RuTdjjsHPDgSM8K4PWvJipFJbjyQTwbhFj+FNgbUAC+vkpOZ8MQSbfOR3Rr
         Sfnxbhk6s/cxcY68Pv3CsjWbDtD2yT4xzvp3Fxf+oYsIMXGxhWIc+h7ub3B+E54EjSL/
         4Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DChTPlxn5JAy8QYLbS2OwMPsxu9XYsq2sXg9H7k8ly0=;
        b=fN9ne73RgMkvBseer+a+Fr4Cl3i47g4HYyzqGJz+lkXbf7rOrGVwi5lzz7gisWspjm
         2QFPWpxCue7PIICuVx7OfEXvCWUp1UKDeAfyol22dDMUEZNn2KWh54XmckAwOgd3bq37
         xLUGNYhqCtJGzOVBpbGx+z7JNaTlsBrvbWodmyIlHuRrLNkYSi33SMx/9zEVOLcBjryK
         5KLxrlkKOlHgtw/8FnAP9pKiOHO8omLXWdpj4i+JrmIlUmv0igsT8PCk4iUJbKI4okT1
         UE6DYWWE6APscCVtI4Qp7IMmbUjGGLZpAoYPCvi51PWV5ee/aK2BkWUoyZnKuEXDNsYX
         9ZEQ==
X-Gm-Message-State: APf1xPDEhDk77/u56NFV2RvsiD4aahJTounY7Ct7gfAu0NJIqGR1yyLP
        kw9SR6O3eJ2W/OSuej4VHoyvLk3PXnAtAMzPy9bGo/8a
X-Google-Smtp-Source: AH8x224JRbcBv242B98L0gNVyXlSmCp39r4Q1XwjxM1iNBvhMh2tBvENSk2Jpi6Y5ygdwqThX3kHGpSRo5LwzJ3vHYg=
X-Received: by 10.107.24.70 with SMTP id 67mr2751228ioy.15.1518553380131; Tue,
 13 Feb 2018 12:23:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.5.147 with HTTP; Tue, 13 Feb 2018 12:22:59 -0800 (PST)
From:   Psidium Guajava <psiidium@gmail.com>
Date:   Tue, 13 Feb 2018 18:22:59 -0200
Message-ID: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com>
Subject: git-rebase --undo-skip proposal
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git community,

I'd like to add a new feature in git-rebase: --undo-skip.
But first, I'd like to consult with the experts if it would be
beneficial for the project and if my line of tought is correct.

Imagine that you are working on a feature for a long time, but there
are multiple bug fixes happening at `master` branch at the same time.
After lots of commits on both ends, you decide to rebase your changes
on top of the current `master` branch.
After lots of conflict resolution steps, you mistakenly call
`git-rebase --skip` instead of `git-rebase --continue`, thus losing a
commit of your work, and possibly inserting bugs in your project.
The only solution for this right now would be to abort the current
rebase and start over.

It seems that a feature like this have been requested once on the mail list [1].

I propose the existence of --undo-skip on git-rebase's `$action` domain.

How I fixed it when that happened with me was (just after running the
wrong skip):

1. I figured I was making a rebase that used `git-am` as a backend.
2. In the rebase-apply directory I searched for the patch file with
the change I just skipped.
3. Found the `rebase-apply/next` file.
4. Wrote the number of the patch I skipped - 1 in rebase-apply/next.
5. run `git rebase --skip` again on the repository.

This made the lost patch appear again and I could `--continue` it this time.

I propose the addition of an action `--undo-skip`, that could be
called only after a wrongfully called `--skip`.
`git rebase --undo-skip`.
I would implemented it to do programatically what I did by hand when
that happened with me.

Here are my questions for you:
1. Would this be beneficial for the users?
2. For `rebase--am`, I would need to change `git-rebase--am.sh` file, correct?
3. Can I assume `builtin/am.c` will always store its information on
`$state_dir/next` and `$state_dir/$patchnumbers`?
4. How hard would it be to add that logic for `rebase--interactive`
and `rebase--merge` backends?

Also, a little unrelated with this issue:
5. What happened to the rewrite of rebase in C [2]? I couldn't find
any information after 2016.

[1] https://public-inbox.org/git/201311011522.44631.thomas@koch.ro/
[2] https://public-inbox.org/git/1457779597-6918-1-git-send-email-pyokagan@gmail.com/


Best Regards,
Gabriel Borges
