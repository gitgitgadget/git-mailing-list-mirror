Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C80C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 15:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C5161050
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 15:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhILPow (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 11:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhILPov (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 11:44:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF7C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 08:43:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z94so4212531ede.8
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5Y210EtAYNw9H9PtPHHFFnTtpnJM8VnKy7hT/GFHbGo=;
        b=EiLx2pvPZ6MzKLEba+KSnBHF3T7Y55x+D41aHdRHBQCmpFHh3bdX9Ng4iohGZ6/SxR
         Y476eQs2IdLDZMGdCJ/+U7dCsKQd3nzvsejk0YafwJKY+ir2r3DKIM3ARgwB3L/fcWX1
         xDBqtPfshCw2Fb0DNwN8VdZ1D58/Lbs5ymTgiDTOeZB22ndWj8AwFSt/o7yC63FwH92+
         mb/RX48iZyuCHe51fCHFW+um/O4x+p7asag2DlSCWV5KQNRiwCBcShELqvg0VqOxq1nN
         AI7r0Rf4WcTM0O5xUXMK+yewn4KBtKH+nfRUiwxWQp/gR/wi9qKzTV7DMqUB2e/kV2cC
         5Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5Y210EtAYNw9H9PtPHHFFnTtpnJM8VnKy7hT/GFHbGo=;
        b=PLaGKHHQN8HNywPx3EEateWruz2MBqhKJ/JbzeklZs7Qvz9a1MLEiu8QTrzxNdIE/8
         pxpLg7fMWlZCSFtsQrv91UuV1oyaV5+Ca0RSR1Rk3b8+/hsg0N756grIggKwc6r+iQVx
         feKOhsbOcFGYYkKcQESd/V14reGs7sGy+fwdiNeur+Ug/F9oO8FJtvqNWqyfStPa3wZL
         WM/ZG+m7rvPLWEP85QA3g4xJok4IvCaVvyHfuaQsi/UU4+d3Hdn8SL9NheIGVvBr4RJc
         BcN8IUKxzpVExWRLKgrxYU/+gtmdr8VsSoySxfMTtOqnYaaXP/EH54h2NiEWDp9FO3KR
         oeIQ==
X-Gm-Message-State: AOAM532xKaMKHWCKmR+aJXUN7nlXIeuQGNVtWurT+TV7+pyoWuMjlfSs
        g+NFukP/k/FnwKo2nDQJeSU=
X-Google-Smtp-Source: ABdhPJyb3frswqXAo2TkqAHg6bY7nonZi+z3//3bSBTqq2w+1jMlaX31ZUUd63cNH26jen6hDQ9MOA==
X-Received: by 2002:a05:6402:27c6:: with SMTP id c6mr8466408ede.111.1631461415448;
        Sun, 12 Sep 2021 08:43:35 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h2sm2518138edd.43.2021.09.12.08.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 08:43:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs mode
Date:   Sun, 12 Sep 2021 17:15:18 +0200
References: <cover.1631331139.git.me@ttaylorr.com>
 <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
 <87ee9va0ie.fsf@evledraar.gmail.com> <YTzYYfBGqG87O5mN@nand.local>
 <CAPig+cRAKJyzuMwPNdmC+BobrMjk5TF-o3Ort8R0E77ij=g6_A@mail.gmail.com>
 <YT1kDVBHtPhxc6Wk@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YT1kDVBHtPhxc6Wk@nand.local>
Message-ID: <87bl4x94ux.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 11 2021, Taylor Blau wrote:

> On Sat, Sep 11, 2021 at 10:08:44PM -0400, Eric Sunshine wrote:
>> On Sat, Sep 11, 2021 at 12:25 PM Taylor Blau <me@ttaylorr.com> wrote:
>> > On Sat, Sep 11, 2021 at 12:05:05PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> > > Before calling string_list_clear(). I.e. we didn't strdup(), but dur=
ing
>> > > free() we pretend that we did, because we did, just not in
>> > > string_list_append().
>> >
>> > Good catch. It's kind of gross, but the result is:
>> >
>> >  static void read_packs_from_stdin(struct string_list *to)
>> >  {
>> > -       struct strbuf buf =3D STRBUF_INIT;
>> > +       struct strbuf buf =3D STRBUF_INIT_NODUP;
>> >         while (strbuf_getline(&buf, stdin) !=3D EOF) {
>> >                 string_list_append(to, strbuf_detach(&buf, NULL));
>> >         }
>> > @@ -107,6 +107,11 @@ static int cmd_multi_pack_index_write(int argc, c=
onst char **argv)
>> >                 ret =3D write_midx_file_only(opts.object_dir, &packs,
>> >                                            opts.preferred_pack, opts.f=
lags);
>> >
>> > +               /*
>> > +                * pretend strings are duplicated to free the memory a=
llocated
>> > +                * by read_packs_from_stdin()
>> > +                */
>> > +               packs.strdup_strings =3D 1;
>> >                 string_list_clear(&packs, 0);
>>
>> An alternative is to do this:
>>
>>     struct strbuf buf =3D STRBUF_INIT;
>>     ...
>>     while (...) {
>>         string_list_append_nodup(to, strbuf_detach(&buf, NULL));
>>         ...
>>     }
>>     ...
>>     string_list_clear(&packs, 0);
>>
>> That is, use string_list_append_nodup(), which is documented as
>> existing precisely for this sort of use-case:
>>
>>     Like string_list_append(), except string is never copied.  When
>>     list->strdup_strings is set, this function can be used to hand
>>     ownership of a malloc()ed string to list without making an extra
>>     copy.
>>
>> (I mention this only for completeness but don't care strongly which
>> approach is used.)
>
> Thanks for a great suggestion; I do prefer using the existing APIs where
> possible, and it seems like string_list_append_nodup() was designed
> exactly for this case.

I think Eric's suggestion is better in this case, maybe all cases.

For what it's worth the alternate WIP approach I was hinting at is some
version of this:
https://lore.kernel.org/git/87bl6kq631.fsf@evledraar.gmail.com/

I might change my mind, but I think ultimately running with move of the
string_list_append_nodup() approach Eric points out is probably the
right thing to do.

I.e. it's the difference between declaring that a string list is "dup'd"
upfront, and whenever we insert into it we make sure that's the case one
way or another. Then when we clear we don't need to pass any options.

It does mean that instead of extra clear functions we need to have
*_nodup() versions of all the utility functions for this to work,
e.g. in trying to convert this now there's no
string_list_insert_nodup(), which would be needed.

Or maybe the whole approch of the string_list API is just a dead-end in
API design, i.e. it shouldn't have any "dup" mode, just nodup, if you
need something dup'd you xstrdup()-it.

