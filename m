Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD7FC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 21:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0669960FEB
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 21:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhGKVoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 17:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKVoT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 17:44:19 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D672C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 14:41:31 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so16602880otp.6
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0DgCzNGxWuUO+igC5QB9VZdFzmYmVDKV3NLttkWkswA=;
        b=f/Gl2T7ccUKasqz4FIqjNwYT8Gdthi0uwYz49a+rNS5FcaKEEnGw+7FCBiQsWNZgJR
         4DEsCtXzdBFJQAmAgxRXhBv83BsmZBzeIGog53DHl4fx6mZ5S0E8YnHXLnwJvclOMEdQ
         aNPAnARmxYhP1pY1r9ajsBN4UwpgSQ4L29Kk4fWO4amTyQuGCmFcWOfvAjS4Iu3dKqt4
         o9OLs4cUo3uswNcpVLbFCkXJoLJfLbbhd662mmfVeYOp47U4YNawkKaLJJSrY8Gu1Hxr
         A8nBZx+6unVxru2xwUmzx0QsCK6IYyromjugtF9U3qb/hz3sYWzvbg9QFNgqWtIjpOaJ
         OvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0DgCzNGxWuUO+igC5QB9VZdFzmYmVDKV3NLttkWkswA=;
        b=KMEcVj2xuKnYdPiUCHeUjHqFGdmKdg4YJHLfaVl7n35Qu8psNhyD4HKD0XvkRcErS7
         cqwjD2oIkb5mlCX0cPXLJ0OCrsaqyuI+ynTlGiANgnX8VFIJa065A6jMVcCfnDtK2nsv
         fYARdw/q68ADrjptJynI7V3oNh/JFmIAELrNCFnjAKRU/P+joKGFOBoHRq+rvDS0QX0e
         cDknngJABaChZWAb0PW38Y8zNcHcPfjiQNV4ZRtcV3igmdewwKicaa5UgYUvrncseTB7
         ZRsNUhrsGc01nwOf+IDNoJBL3aykgLsxzFxBDx+IT89hGOqbQIyhvDHKDcyKDNB87VgO
         B8Fg==
X-Gm-Message-State: AOAM533FUCinZfkiBDMlnVKNGX/P091pOlKkuosXWHib6fIXxL1LdMuy
        OegTNs8G+FLRQ6NouCZ/dyc=
X-Google-Smtp-Source: ABdhPJyB3IDMs9Uto1gE/doqeqKv8C7RESjN5xaAN4evPUl1Wx/OMWM7Z/OjYTDYVRPfd7J78xTw8Q==
X-Received: by 2002:a9d:64d4:: with SMTP id n20mr36091931otl.10.1626039690437;
        Sun, 11 Jul 2021 14:41:30 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id y26sm671567oot.7.2021.07.11.14.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 14:41:29 -0700 (PDT)
Date:   Sun, 11 Jul 2021 16:41:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60eb6588c6ef2_a2044208b0@natae.notmuch>
In-Reply-To: <CAMMLpeRwpxEe5qJumwXa5hyjeUBrTRDU3-1OSHDNc=UiNqN48w@mail.gmail.com>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <60eb259e1a75d_974bf20895@natae.notmuch>
 <CAMMLpeRwpxEe5qJumwXa5hyjeUBrTRDU3-1OSHDNc=UiNqN48w@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Sun, Jul 11, 2021 at 11:08 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Alex Henrie wrote:
> > > The warning about pulling without specifying how to reconcile divergent
> > > branches says that after setting pull.rebase to true, --ff-only can
> > > still be passed on the command line to require a fast-forward. Make that
> > > actually work.
> >
> > I don't know where that is being said, but it's wrong: --ff-only is
> > meant for merge only.
> >
> > > --- a/builtin/pull.c
> > > +++ b/builtin/pull.c
> > > @@ -1046,9 +1046,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> > >
> > >       can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
> > >
> > > -     if (rebase_unspecified && !opt_ff && !can_ff) {
> > > -             if (opt_verbosity >= 0)
> > > -                     show_advice_pull_non_ff();
> > > +     if (!can_ff) {
> > > +             if (opt_ff) {
> > > +                     if (!strcmp(opt_ff, "--ff-only"))
> > > +                             die_ff_impossible();
> >
> > As I've mentioned multiple times already, this is wrong.
> >
> > The advice clearly says:
> >
> >   You can also pass --rebase, --no-rebase, or --ff-only on the command
> >   line to override the configured default per invocation.
> >
> > With your patch now this is even less true:
> >
> >   git -c pull.ff=only pull --rebase
> 
> I think it's an improvement over the current situation. --no-rebase
> does not override pull.ff=only, so it makes sense that --rebase does
> not override pull.ff=only either.

I disagree, but that's not the point, the point is that now the advice
message is wrong since --rebase doesn't override pull.ff=only.

Additionally the documentation is inaccurate too because at no point
does pull.ff mention anything about rebase:

pull.ff::
	By default, Git does not create an extra merge commit when merging
	a commit that is a descendant of the current commit. Instead, the
	tip of the current branch is fast-forwarded. When set to `false`,
	this variable tells Git to create an extra merge commit in such
	a case (equivalent to giving the `--no-ff` option from the command
	line). When set to `only`, only such fast-forward merges are
	allowed (equivalent to giving the `--ff-only` option from the
	command line). This setting overrides `merge.ff` when pulling.

-- 
Felipe Contreras
