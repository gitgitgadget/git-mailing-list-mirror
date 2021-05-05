Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA12FC433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9ACF61106
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhEETBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhEETBK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 15:01:10 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D0DC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 12:00:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id i26so3160150oii.3
        for <git@vger.kernel.org>; Wed, 05 May 2021 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eg9LLQZFCA4ZtRA5ComS/acA88uE8um0NxqWZAtnz8c=;
        b=FPNoX3BDN8+Cyf/DneJ6auwKqV7k4/cLuXBlcEDwhmFVms23//TrqgkhrnwVAnzGrU
         jaZHEFQMZAy5PrN+8GngTw2hsDCVtsY6F5Icec0nhwPH9GbTdwYsnYkbxD+Y3B/GrO9J
         EjizyzNSQYZR7SOINd8kqG5dxAgSIqbsrriORtOeARRArorUTDjWvxQeKPk/MfJgeVsF
         9DAH8Qes7lpkeRkwBf60QE5hcWIoQfDZe1Z4TKTtgbTe0cTdvRVCFm5MtNEtchrwkgDs
         C/sG0XIpT7BCUoXI47hwmGhN8zXsh31S9yuiyn+Bey8XLQvp0uI0lUmq+US2e5xW7xAl
         cW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eg9LLQZFCA4ZtRA5ComS/acA88uE8um0NxqWZAtnz8c=;
        b=MRyN66rgPHFJiEpgqqBqwc56MJNNe04xx50SggkJTx2tnBNmzaIcN45PkK54fRTQjD
         OsjTLijWcwfAk4bcmnwN8VO+IkTnkNdDsQSeXtHO8g+r1KrJStpV8gT64HGOZ/SVF6ks
         CuMF3/ElpN0iChczOTHwmrzlWl9K5SJIehRV4Mq2v7zmq4LdFZpKzSKdKGk3chB3rfqk
         zLY2tiVdExTCKN57roqX+FtfGYbs6ovM9wPMPeIVZJT4EIAsEk+RFBjI7wx2agQZjdnL
         rEBSspKHoEiTxX7sc7JunF8pNKfp8rr6xE+zyFZbeGo+jllhvVvznRBcU7HaYbRMuxK+
         duGA==
X-Gm-Message-State: AOAM531VI4hQM1vy+xRjztiJG1PIT/WYbHDUg6AwEkZ68z2jvMIthTc0
        coqULFFFVllUJLZvTIpogaNxF1A4n8lDuZdgkEclgA5DcGQJ6Mt9
X-Google-Smtp-Source: ABdhPJw0zOOZiK+yXhjnnP+c4BKk6n+B4xeMMVjXdRnqRC9a+NV+n6F4gV/EmhmNit/OO3kDALsP3EOif71oWx/ccG4=
X-Received: by 2002:a05:6808:1392:: with SMTP id c18mr8163868oiw.176.1620241213315;
 Wed, 05 May 2021 12:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEumJaDRvU8LP=q3PQ1z6-cg75DmbHE_7OXZVA+nm=-77pVLEg@mail.gmail.com>
 <YJLgmXS/fJm1BQb4@coredump.intra.peff.net> <CAPig+cTX179z5MrTvSmgYGzZdc4xz=2G_ffHsyVOXsKVHrL93w@mail.gmail.com>
 <CAEumJaCmcReO4ry7DP14zDg0R5L5QgULZpZmaqBY5g=EQD4U+Q@mail.gmail.com> <YJLla4gNEMS2yxCv@coredump.intra.peff.net>
In-Reply-To: <YJLla4gNEMS2yxCv@coredump.intra.peff.net>
From:   Theodor Negrescu <theodor.negrescu@gmail.com>
Date:   Wed, 5 May 2021 21:59:58 +0300
Message-ID: <CAEumJaA7NBm9Kdx7aCD1gavGguLmGcnvFcA52YvUk7g_FPzHZw@mail.gmail.com>
Subject: Re: BUG: Git path --config doesn't work with ~ symbol
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You're right, "notepad ~/test.txt" doesn't work either.
I figured out a workaround:
[alias]
    cfg = "!git config --file $(echo ~)/git-settings/.gitconfig "
However what confuses me is that I also have
[core]
    hooksPath = ~/git-settings/hooks
and that ~ works. So why doesn't it work in config --file?

On Wed, May 5, 2021 at 9:35 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, May 05, 2021 at 09:30:21PM +0300, Theodor Negrescu wrote:
>
> > I'm using powershell, but usually ~ works there. Typing "cd ~" would
> > work for example.
> > Also I tried using the command as an alias and it still didn't work.
>
> I don't know anything about powershell, but generally "cd" is a builtin
> to the shell (because it is impacting the shell's environment). So it
> may be that powershell "cd" expands "~" itself, but that the shell
> doesn't expand it for executed commands.
>
> There are some Windows folks who hang out on this list, so you may get a
> better response. But you might also ask in the Git for Windows mailing
> list:
>
>   https://groups.google.com/g/git-for-windows
>
> -Peff
