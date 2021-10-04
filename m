Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E2C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E55A611C0
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhJDOyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbhJDOye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 10:54:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB3C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 07:52:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r18so65796431edv.12
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nEbWOD8UVPN5+yhWDZrFEEi7fZQFOhACqTmjvDyrzks=;
        b=OW3HWPZssWXRQ2JADvSawCVh0HBsQ+U/PXQXJY9kCw5k4QasA9RYslEG1HTYr7ao86
         BcI2cRu4a/WOkbSktiQsTerk4U9VCKwVf2e0AkJnPxYassB6E0B/OWOQKOAS8yVIl5+0
         LSKznBVcpyn4+5YlGhjHzSOU5AaAlG2JSfx6S+3fe0vICIzNVXDYBJGQxN2zyqgTArzO
         oKkrD9mkg0wYCCe5rIarU/b6ID11ne3mvzYDiFTeZTa/FaZ7k2xWdAatjcWk5H1oFmOn
         bmLLagUtoqmoGdi4xRs04511h0dWhBG1kgj7U3MAU/TKyqM+7gzV9F6+N3yaaQt2eBnA
         QJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nEbWOD8UVPN5+yhWDZrFEEi7fZQFOhACqTmjvDyrzks=;
        b=cO1zBer9/BA5oq994o14RL1KkeYfMJ/dLAn/BDOpH0euufmpSuL8AIzkRO3rxiVb6Z
         aLJlbekopKaobP9IdbP943kyLkvUnTezgL9dZqQlccrZaz07f26R3X7cKHoI2iqS8XMK
         kc9Lf0zyK15iD03CfUy5wrLYegG8vQIGfhnk8ewqygRzGXpqUP/H1tClptyLYEJYhCPe
         VU3GUiuYVFWXfcmyPZZJolmkKnBwWQavvS8XUw2lVCt9NLARZIjZRPTCluJvj7dOE9a1
         ROVy8mXLtUycR4oOj5atpH1BWkazwZ1Fg96TjmmDp2g2urBxbh2azPWFnrOeXoUAYcet
         MNbg==
X-Gm-Message-State: AOAM532nwrl/v2bmBrqQ8T8KFob2KnYMVLXl7jIWC3NnJHmmg5wW5KFX
        SvReSXPzGWYrMe12VFiAM79rLiSkw6x+jA==
X-Google-Smtp-Source: ABdhPJx9bOEjjQEN9HtfH/GAXhaC2W74tDGz0wxec4TqPotMuNALl8fQi2IB0wx3/YD2iL8juyCCFw==
X-Received: by 2002:a05:6402:5194:: with SMTP id q20mr18531446edd.245.1633359049737;
        Mon, 04 Oct 2021 07:50:49 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j14sm7409760edl.21.2021.10.04.07.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:50:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/10] merge.c: avoid duplicate
 unpack_trees_options_release() code
Date:   Mon, 04 Oct 2021 16:50:23 +0200
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
 <patch-09.10-aa2bec76f6e-20211004T002226Z-avarab@gmail.com>
 <CABPp-BHqzRXxatAuMn8rNDPSuN5nAWJFVNziLL3+LS+YJ98V-w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BHqzRXxatAuMn8rNDPSuN5nAWJFVNziLL3+LS+YJ98V-w@mail.gmail.com>
Message-ID: <87tuhwn8s7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Elijah Newren wrote:

> On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> Refactor code added in 1c41d2805e4 (unpack_trees_options: free
>> messages when done, 2018-05-21) to use a ret/goto pattern, rather than
>> duplicating the end cleanup in the function.
>>
>> This control flow will be matched in subsequent commits by various
>> other similar code, which often needs to do more than just call
>> unpack_trees_options_release(). Let's change this to consistently use
>> the same pattern everywhere.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  merge.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/merge.c b/merge.c
>> index 2f618425aff..2e3714ccaa0 100644
>> --- a/merge.c
>> +++ b/merge.c
>> @@ -54,6 +54,7 @@ int checkout_fast_forward(struct repository *r,
>>         struct tree_desc t[MAX_UNPACK_TREES];
>>         int i, nr_trees =3D 0;
>>         struct lock_file lock_file =3D LOCK_INIT;
>> +       int ret =3D 0;
>>
>>         refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
>>
>> @@ -95,12 +96,14 @@ int checkout_fast_forward(struct repository *r,
>>
>>         if (unpack_trees(nr_trees, t, &opts)) {
>>                 rollback_lock_file(&lock_file);
>> -               unpack_trees_options_release(&opts);
>> -               return -1;
>> +               ret =3D -1;
>> +               goto cleanup;
>>         }
>> -       unpack_trees_options_release(&opts);
>>
>>         if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
>> -               return error(_("unable to write new index file"));
>> -       return 0;
>> +               ret =3D error(_("unable to write new index file"));
>> +
>> +cleanup:
>> +       unpack_trees_options_release(&opts);
>> +       return ret;
>>  }
>> --
>> 2.33.0.1404.g83021034c5d
>
> I would say 'meh'...but the commit message is downright confusing.  It
> suggests that subsequent commits, plural, will be modifying this code
> further.  There is only one more commit in this series, and looking
> ahead, it doesn't even touch this file.  So, there actually isn't any
> reason for these changes beyond what we see in this file, at least not
> for this series.  And as far as this series is concerned, I think it's
> actually less readable.  If there's a subsequent series that will use
> this and make further changes I could be convinced, but then I'd say
> this commit belongs as part of the later series, not this one.

Will fix, initially had these built-in fixes split into one commit per
built-in, but decided it was too verbose and squashed them all, and
didn't copyedit the commit message properly.
