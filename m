Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E194C43217
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiKKRP2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 11 Nov 2022 12:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiKKRPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 12:15:25 -0500
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C7F4B997
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 09:15:23 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id d123so3987582iof.7
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 09:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dO3z5u52dmYYcxK061UsspeM3L2nC1RyK+VpKCpOdOo=;
        b=M9SPBanHIDW1tIUWFWdUsD73X8QRHodI4zpH7gANiVxSu4C7hezYGz0m14RoFvQbEh
         fiipyVOJUjxcCx2p48iAdbwJx6mrTOV4uJJAyOL8TnThYzs9VNaGzxj3Z5/+HzQmKuaR
         Zg+pMHB9ovUILOvrKqYIONgqlNbqn2v7Nt5L1irQe8hM4hzX/RldffeS6Bbh6Cq3wRAu
         WyEWD+OkfxP+E4jNHam6k1oIR1PlQ7nW66ZDTM4uupGZFghoS4yBcXhE0G8D1rGYUHCM
         WXRxpQhQYZD6IVhLgL1Pde9MTOcvOtf/1UqumOqCXTxBC2D29ZBvY3+FsXOpB2+p9gYM
         CI9A==
X-Gm-Message-State: ANoB5pnv7XmVO1GdxyvCFq6eiRvvgsCVSCtfgSGlvvXgigsgrLKETNVJ
        YOv/40yGqfulc60UGkemnCSKlHuISatv6LPvjEtfl8aPzYg=
X-Google-Smtp-Source: AA0mqf6RJMhW+4ovVKc02XQf1HOFH+Zp2Xx5msAmR33d2mUJK5aUiYtEHq2+y2+yL2mSm/qHTKTFcfxki7TLLsKRKMc=
X-Received: by 2002:a05:6602:1856:b0:6d2:4c85:c7b2 with SMTP id
 d22-20020a056602185600b006d24c85c7b2mr1447249ioi.32.1668186923189; Fri, 11
 Nov 2022 09:15:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
 <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com> <de482cf9cf1c791418e4279523123580f330245b.1668152094.git.gitgitgadget@gmail.com>
 <221111.865yflo7p7.gmgdl@evledraar.gmail.com> <CAPig+cRwDeGyniiVGqmdMePgmR6GiYQOvNP+GUeT__zpuWV1Fg@mail.gmail.com>
In-Reply-To: <CAPig+cRwDeGyniiVGqmdMePgmR6GiYQOvNP+GUeT__zpuWV1Fg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 Nov 2022 12:15:12 -0500
Message-ID: <CAPig+cRCSg=iVLUmLG=W47ofojU56CcFsobNZK5z5h9LdzXs0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] chainlint: sidestep impoverished macOS "terminfo"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 11:44 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Nov 11, 2022 at 10:02 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > I also wonder to what extent this needs to be re-inventing
> > Term::ANSIColor, which has shipped with Perl since 5.6, so we can use it
> > without worrying about version compat, but that's another topic...
>
> Gah, why didn't I know about this sooner?! [...]
>
> Since it's been shipping with Perl for quite some time,
> Term::ANSIColor would be a much nicer solution; worth looking into.

In retrospect, I may have looked at Term::ANSIColor at the time but
decided to avoid it since it assumes the terminal understands ANSI
codes, and I was looking for a more general solution which respected
the terminal's capabilities as reported by "terminfo".

And, reading up on it now, I'm not finding much benefit to
Term::ANSIColor over what is already implemented in chainlint.pl.
Particularly disheartening is that (as far as I can tell)
Term::ANSIColor doesn't provide a way to interrogate whether or not it
is suitable to use ANSI codes with the terminal in question, but
instead makes a blanket assumption that the terminal supports ANSI
codes unconditionally.

So, I think the fixed-up colorizing as implemented by v2 of this patch
series is good enough for now. It can always be revisited later if
something warrants it.
