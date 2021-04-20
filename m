Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2934C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 11:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7432561264
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 11:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhDTLC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhDTLC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 07:02:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D619C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 04:01:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u21so57643622ejo.13
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2wJfGvPbDXN9FzeCzpX7ypD1ClcCxBy0xuVVzh8hQPg=;
        b=YgCuEVfoepvjKTAacyQtXtAQYClcaKlG9uqCC6GCpJ31g4G+zXM07mAsLNAryZK4Lb
         U8Yskyc1IBNMgJDDw9wpi2Zvg95e1EHa+wBkgBYg71KyGC0cycYU6egSrZoNa1atOVz2
         mopQanB2EvlZjMJM2ok1AVD5FxsQMDSL0vpDL5fzomMJ6rkLfcM2vX8vhh3RFRVeqvqQ
         khUAucPXhRJOENbhV8GVd35kQp9btQZcapPhHcUGJnqV8XDm3v3oZIb849kSnPkPaUeE
         87StRyA7HuFlV7ExSfA0+QgUgifEpY01DiTvYyva0aiJFZvnDibPMAEKtuNmAZl1O4FX
         5lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=2wJfGvPbDXN9FzeCzpX7ypD1ClcCxBy0xuVVzh8hQPg=;
        b=pMarspi7ub8S5uSGcheubx9pcz4ZAuZuh2r4UVQLE3i+EEa7T/wwo19cpUH0f5kC0q
         L9Ti6SxgiuQiLe/D7Tg+2XkxcN1KGhZQotjrfQztWNi5U/BmfKemINdZQS7GQ4a6Q3qs
         /z+S3He+ofp/Xjntc9M0Hq0Yr+PE1UufaA6RiBow4yEvpV0ZDRMpz+ns0SX8RolFy8Ap
         JW+kUTku32JokPyOKa/y+9mIdwQhwhGe5HBoDmYrZFcO2DBUKtNPp9iP8ElrpnvzSUgT
         eTAbNddt/+fw4NXh7btyDh4MGTN2FyZ2sMfgdxATuJxP8lWyAXRf8AVVMp8xOLk/3GNf
         bP7A==
X-Gm-Message-State: AOAM5329H92+MgRuJBEhtNunbcV4lbI7SvlfBgUIZCVwQ7KcRYr0SIim
        Ey0GSDRzchTavDO65yKWpRA=
X-Google-Smtp-Source: ABdhPJyyIycQxvqoiYwktORMTkcF3u5SWM8O/RFPE8gZGt1ggYU+bJQDVL6EsWmRfWNYhymNQxr5AA==
X-Received: by 2002:a17:906:cc48:: with SMTP id mm8mr27904797ejb.58.1618916514096;
        Tue, 20 Apr 2021 04:01:54 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id mp36sm11801733ejc.48.2021.04.20.04.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 04:01:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Simon Ruderich <simon@ruderich.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 2/8] config: add new way to pass config via
 `--config-env`
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
 <470396d36f938f0070b8c849a85b1a30949056e3.1610453228.git.ps@pks.im>
 <87o8eeteyz.fsf@evledraar.gmail.com>
 <YHqeh9MeRDADviU0@coredump.intra.peff.net> <YH2hqhHh1eh+U+6h@tanuki>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YH2hqhHh1eh+U+6h@tanuki>
Date:   Tue, 20 Apr 2021 13:01:53 +0200
Message-ID: <87v98h2p9a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Patrick Steinhardt wrote:

> On Sat, Apr 17, 2021 at 04:38:31AM -0400, Jeff King wrote:
>> On Fri, Apr 16, 2021 at 05:40:36PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>=20
>> > Bonus points to anyone sorting out some of the existing inconsistencies
>> > when fixing this, i.e. --exec-path supports either the "=3D" form, or =
not,
>> > but various other skip_prefix() in the same function don't, seemingly
>> > (but I have not tested) for no good reason.
>>=20
>> I suspect just because it's more (per-option) work to support both
>> types, and nobody really cared enough to do so.
>>=20
>> > It seems to me that having a skip_prefix_opt() or something would be a
>> > good fix for this, i.e. a "maybe trim the last '=3D'" version of
>> > skip_prefix. Then we could just consistently use that.
>>=20
>> There's a similar situation in the revision parser (which does not use
>> our regular parse-options). There we have a parse_long_opt() helper
>> which does the right thing. We could use that more widely.
>>=20
>> I also wouldn't be surprised if we could leverage one of the
>> sub-functions of parse-options, but it might turn into a rabbit hole.
>> Converting the whole thing to the usual parse_options() might get
>> awkward, since many of the options operate at time-of-parse, not after
>> we've seen everything (I suspect many of them don't care either way, but
>> you're always risking subtle regressions there).
>>=20
>> > Or maybe there's some reason we don't want to be as lax as --exec-path
>> > with any other option...
>>=20
>> I can't think of one.
>>=20
>> -Peff
>
> `--exec-path` does two different things based on whether you pass a "=3D"
> or not: either you tell git where its binaries are, or you ask it where
> it thinks they're. It's still true for some (most?) of the other options
> though.

I don't know how I got those conflated, but FWIW I meant (or at least
think I did) the likes of --namespace[=3D], --git-dir[=3D] and
--work-tree[=3D] where the "=3D" is really optional, but otherwise the
option behaves the same.
