Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85309C07E9B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6F4613B2
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 14:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhGFOzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 10:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbhGFOzR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 10:55:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CC5C06139F
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 07:52:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m17so6782950edc.9
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=j7Gl9Ii4ySI999KyucsFWzClCA9gNkcWhfUNCZNbYBo=;
        b=MiWLsEzyKOjzcMYtOrSI5zg7HI3O/nXAD/DBVqgEVbf/HD8Zd2h4muy7bBl4l4Vxnl
         AttUkIDS/kmfTizSNaCY4D0SYwxq6qwcGXK+wDn1A/dCjIgY4718+Hsy1ZDYrNCd6tsP
         Pk96R0Zzizqn20J9BUt4fX6fKQ/VTwMw87vQsvyLZKv9OGh6oVpBCcHJtyINfmheoR/P
         4BB1UIwMVnhUUqVCuvm89AYe7K4vXX5UCJHFccjP/AHxn/HRZUYdBGeUQHjobglOMPUa
         36rBvXUZaSaCLg2mS6cTGWo61UW0wjNB6YqknOI669zydiQedpI7ZgzXjEtfITsYHREp
         9EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=j7Gl9Ii4ySI999KyucsFWzClCA9gNkcWhfUNCZNbYBo=;
        b=gonfBNUh9X6fu9NqEIuNMRmX3zX8GFLsQgpcE3Rqr7Rz0+KLH1/aX7Rns/0bgYJagN
         LOtzcuj7KCBe7b/omX5Jf6UYsHSj1wFkauREQxVkVEbaPgglYsUnEnmezwa2mTwYZpXP
         vMa6/RIeZRFRF4w3NDdlHbeyRSNVWT9hDvzYQlXodABf6Ec4TSUmh4u1kLYrUuEHSK1z
         jMpctJbb1WmrTWzG30ofYYPXtlBxjUBTGHbM/S55Jad7P457L8kw1OP2daDCMHCK+JeX
         +krp1HS6JD/MUucpDTmX7z1cIMW8zobirJOuP+rrvQ9MxnTZx6uT7MzZfBJX8bUNzYjH
         kl0Q==
X-Gm-Message-State: AOAM530aosihbSAqzCTfW4VNt32cw7nLaFsM44lSyDlyLnINsx1rxWPY
        oN3cEONF6CcVHkAo5FVpMXk=
X-Google-Smtp-Source: ABdhPJx6WvRgcCI+EHXTEv6fsbUVHhAyo0f52TkS8Y42rUpiBQUEJQGzbTB1KClcOVr4ctR7wfD9Tw==
X-Received: by 2002:aa7:dd57:: with SMTP id o23mr23580053edw.6.1625583154775;
        Tue, 06 Jul 2021 07:52:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n16sm7276794edr.60.2021.07.06.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:52:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
Date:   Tue, 06 Jul 2021 16:43:48 +0200
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
 <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com>
 <7ee36923-0806-4316-729c-8418df5b6555@gmail.com>
 <xmqqpmvwn1qp.fsf@gitster.g> <xmqqlf6kmup4.fsf@gitster.g>
 <CAMMLpeQG-eYgWTXyG0YzgN3U8QDASAtNFpxyXDFFPSVNzfw18g@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAMMLpeQG-eYgWTXyG0YzgN3U8QDASAtNFpxyXDFFPSVNzfw18g@mail.gmail.com>
Message-ID: <87mtqz5wb2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 05 2021, Alex Henrie wrote:

> On Mon, Jul 5, 2021 at 3:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> On Sun, Jul 04 2021, Alex Henrie wrote:
>>
>> > +int error_ff_impossible(void)
>> > +{
>> > +     error(_("Not possible to fast-forward, aborting."));
>> > +     return -1;
>> > +}
>>
>> Here's one, the idiom is just "return error", i.e it itself returns -1.
>
> That would indeed be simpler; thanks for pointing that out.
>
>> FWIW I'd consider doing:
>>
>>         /* earlier, static scope */
>>         static const char error_ff_impossible =3D N_("Not possible...");
>>         /* later, function scope */
>>             return error(error_ff_impossible);
>>
>> It's a small difference, but for translators who use the jump-to-source
>> while translating not having the indirection helps, and in this case
>> it's just used 3 times...
>
> Wouldn't jump-to-source take the user to the English text in advice.c
> either way? How does putting it in a static variable help?

Yes, sorry. I don't know what I was thinking there. What I said would
only apply if _() was used inline, nevermind.

>> > [...]
>> >       if (parent && parse_commit(parent) < 0)
>> >               /* TRANSLATORS: The first %s will be a "todo" command li=
ke
>> > @@ -2764,7 +2769,7 @@ static int populate_opts_cb(const char *key, con=
st char *value, void *data)
>> >       else if (!strcmp(key, "options.record-origin"))
>> >               opts->record_origin =3D git_config_bool_or_int(key, valu=
e, &error_flag);
>> >       else if (!strcmp(key, "options.allow-ff"))
>> > -             opts->allow_ff =3D git_config_bool_or_int(key, value, &e=
rror_flag);
>> > +             opts->fast_forward =3D git_config_bool_or_int(key, value=
, &error_flag) ? FF_ALLOW : FF_NO;
>>
>> Since we're on nits, we try to wrap at 80 characters.
>
> Thanks, I didn't know what the exact cutoff was.

It's not strictly adhered to, and depending on the code we'll have it be
longer (sometimes much so) if it helps the general readability,
e.g. long repetitive declarations or something. For this sort of thing
it's generally preferred.

> On Mon, Jul 5, 2021 at 10:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>> > Looking at origin/seen:builtin/pull.c we already check if we can
>> > fast-forward and unconditionally merge in that case irrespective of
>> > any '--rebase' option or pull.rebase config. It should be simple for
>> > pull to error out if '--ff-only' is given and we cannot fast-forward.
>>
>> Excellent.
>>
>> Even though teaching even more special case on the "git pull" side
>> makes me feel somewhat dirty, but I think it would be a small price
>> to pay, and the end result would save an useless fork whose sole
>> purpose is to make the integration step after fetch fail when "pull"
>> can easily tell, as you said, that it ought to fail, so overall it
>> would probably be a net win.
>
> Okay, so it sounds like I should just scrap this patch and try again,
> after "pull: cleanup autostash check" is in master, with a patch that
> only modifies `git pull` and not `git rebase`. (Unless someone more
> experienced wants to take over, which would be fine by me.)

I've just skimmed that whole part of the larger "what should we do"
discussion here, and don't really have an opinion, but I see Phillip
Wood replied to this downthread.

You can grab the branches Junio mentions in What's Cooking from
https://github.com/gitster/git.git, if you'd like to rebase on top of
Felipe's (or from the ML).

And if you fetch from it with:

    fetch =3D +refs/notes/amlog:refs/notes/amlog

And set:

    [notes]
            displayRef =3D refs/notes/amlog

You'll get mappings from the mails to the commits Junio applies.

(Note that they're not always 1=3D1 the same, even after ignoring Junio's
Signed-off-by header, he'll sometimes fix them up as he queues them,
might use a different base for "master" than you did etc.)
