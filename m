Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81036C07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AB761029
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 00:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGUAFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 20:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGUAEv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 20:04:51 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B269C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:45:29 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o72-20020a9d224e0000b02904bb9756274cso583167ota.6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 17:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8wEwAv9wKMsC9/C9taGHPwwNX0Jjyq1W+cR5/2pDd0=;
        b=Gb3jEX3DDvaip1CY7CG4RKiVtbMjv91E8lr2FbjIO2E8R6e7aRdfUuNwrC8C763peA
         jhwlO1/fJr4NaQgn8XWaOU4WLKww03eNlBQAaI/Lu61BW1toAYYMUOm57UofRqA/11JU
         T/c3E5+ORUoFAuKFEI1M9bqITMuFu8xV5NEJLXGsdtNkGYtcRwuVSlMTupiuV82Y1SmZ
         FzcP2Y8IOc3HrqTxKv++nMekiHGdI2Gj88C+iauZ01SE4GNminqo/JJ7VdDPWo53Q/7H
         kYbjehnemmIT9M9Dl3u9oF9+dexzAIOq9V6eY7WomGZigd0C43OJVnemwmNDSvdO4qzb
         OWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8wEwAv9wKMsC9/C9taGHPwwNX0Jjyq1W+cR5/2pDd0=;
        b=q2ZbRp3A7yuVxs+ff4zdWvTP/R+Jri+Vzv1TtuYKmrtgCUiQTeCiFYI+6nglg4fg20
         +qC4y5/nMfiTo2tX2XFy5xG6ckvtwZDanoyTPy6emj6nNqHnvr/aSbR9OY5WQIcP6YRi
         bjdlhPznZVbjdIWvMFTwId/aUn5IA68E6I0Lbf8Dapm0iaSCyknNjGz1wjGIuV55KV+r
         QbefBDrByPcvxuPJwkt9PECj3OGDRaBEUfGVnJUBWjJpMQE26qr+uAWznnEJJ5HdtK6r
         MxfudvZP7TZZ8Lq/idN+vt+zlOXq/1dQR50SMb9EJHSj+A7oOvw8bFiddYBX4l/HPuM9
         2pCw==
X-Gm-Message-State: AOAM532dXCfxQGcrca+F6jsmS3hbIjWpV/3fgRe+Y+Qn5JNX7J83AmG8
        RvKUKxtfip0AN3dwRuEqtayMCsomPeeNgywNrRE=
X-Google-Smtp-Source: ABdhPJwXcn3hIPNYwlP5cuW3YQQAKlWFpx7pv476xtg9KppEcW/JH8VBrvLFKTMLSXtiSsGMFiJR+cuKxoF0kHzBnGs=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr20814282ots.162.1626828328845;
 Tue, 20 Jul 2021 17:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <329802382bfa24241c2333bd38284aa77e3eb9f0.1626536508.git.gitgitgadget@gmail.com>
 <xmqq4kcoh97y.fsf@gitster.g>
In-Reply-To: <xmqq4kcoh97y.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Jul 2021 17:45:18 -0700
Message-ID: <CABPp-BFk--NUdSy2OpF1XfJhkrWu_ucFSxZxnu7M5gy1HHdwSg@mail.gmail.com>
Subject: Re: [PATCH 2/9] t7601: add tests of interactions with multiple merge
 heads and config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 4:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +test_expect_failure 'Multiple heads does not warn about fast forwarding' '
> > +     git reset --hard c1 &&
> > +     git pull . c2 c3 2>err &&
> > +     test_i18ngrep ! "Pulling without specifying how to reconcile" err
> > +'
>
> This does not look like "warning about fast-forwarding".
>
> But more importantly, are we sure we want to expect this outcome?
>
> We are at c1 and try to integrate with c2 and c3 at the same time,
> neither of which is a descendant of c1.
>
> We know that the only possible action is to create an octopus in
> this case, and that it is pretty much fundamental (i.e. it is not
> like "rebase" with further development will be able to handle this
> case).  I however do not know if it is also obvious to total newbies
> who haven't even chosen between merge and rebase.  I can see them
> complaining "why didn't I get asked to choose between rebase and
> merge" if we went ahead and created an octopus merge, especially the
> ones who would choose pull.rebase=yes once they learned Git a bit
> more.

That's a fair point; I'll modify the test accordingly (and update the
description).

> > +test_expect_success 'Cannot fast-forward with multiple heads' '
> > +     git reset --hard c0 &&
> > +     test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
> > +     test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
> > +     test_i18ngrep "Not possible to fast-forward, aborting" err
> > +'
>
> This one looks sensible to me.
>
> > +test_expect_success 'Cannot rebase with multiple heads' '
> > +     git reset --hard c0 &&
> > +     test_must_fail git -c pull.rebase=true pull . c1 c2 c3 2>err &&
> > +     test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
> > +     test_i18ngrep "Cannot rebase onto multiple branches." err
> > +'
>
> This one, too.
>
> Thanks.
