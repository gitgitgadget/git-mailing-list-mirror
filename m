Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB963C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB42160F23
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 13:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbhITNrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhITNq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 09:46:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A388C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 06:45:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c21so61175918edj.0
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4LowCqX5l4E3RGL+Fl3vXDiVcECb8ZYukrc3rGMnHW0=;
        b=NSo5LDHfYoVekTzl88LrZlVi7t3i45IBWwIRS6m4c419HXXOyPNpGaKWYyl68CtYuW
         GZWvNue3HM+IE8ucJvWcsNieEVyEzHXdPfCAtTLZ59SEzB+mZwKQt3Tx48+itJdmSQj6
         kQo1ePPIyxlTras3mYkTz4UHNutqP8UOqu707/Mw4EltJFSEVXPYcG6Q+WejOHUYubhg
         /89KHQUnr6ZAEd1ZTz4DrBTEHq70O5eMHnLec5SlOFCOMM5eh0bNVOepgEl/h/KUc7pD
         rk/NtVr4WmZFWrEeYIzKlMZ8+2hSFTjGBlag9tPgUqllLNQZ1BN6MaelaMom3JACeDWY
         hN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4LowCqX5l4E3RGL+Fl3vXDiVcECb8ZYukrc3rGMnHW0=;
        b=s0VqHTKmq8YhP18LROOQTsFVQNGWP4rqHEnJn3dJOJEphPdbzvy9ylicy2mk4Yq4Gz
         n6V2r95meuhiRVpKHd+0mniSEre2EBfMnXB15xDE+3n5e8eTOrnzH+GNyuURQtH75CKT
         rO8P6WvE7jYdGs+YwuHYlbbqeM5H5p62M7TS04Ov5D9E3Ynz111K5v01woGIQlKmmsOc
         GXPEFSBBwVJ/1fbRAbEzWQGUiigl/h5YPZ8lA0TolXKPNLo30B2olhv3gxK39M8BYIOI
         RhrWcEAqb8dT0Ite2CVh83mpZga6kNUL5+DIAeQN3s8mSvpjCLPgXRXM1/21876MFbfx
         YBSg==
X-Gm-Message-State: AOAM532Gx+ICBvlXPnmPVNN6FGHt5Qf8VKfWd7HG8W3qvv9AaTYF4Vyc
        xoVJVNwFbYINl0fvb6gEbvk=
X-Google-Smtp-Source: ABdhPJwEld4YmREvL1XhkLuqAr60NV4a5hD7OnxSey2XpCx79J8/8w2XRCO5UpfgKAPrawD8+1VYsw==
X-Received: by 2002:a05:6402:1508:: with SMTP id f8mr29169110edw.255.1632145512589;
        Mon, 20 Sep 2021 06:45:12 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r22sm6114527ejj.91.2021.09.20.06.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:45:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 3/6] commit-graph: turn on commit-graph by default
Date:   Mon, 20 Sep 2021 15:30:38 +0200
References: <pull.292.v3.git.gitgitgadget@gmail.com>
 <pull.292.v4.git.gitgitgadget@gmail.com>
 <651e2d526b2a3f6c63c64cfe1f049eef94d39c07.1565721461.git.gitgitgadget@gmail.com>
 <xmqq8rzsdqlq.fsf@gitster.g> <YUfjIjgk2IwcJNI8@camp.crustytoothpaste.net>
 <8841729f-9310-c393-caa9-4b209909ea5d@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <8841729f-9310-c393-caa9-4b209909ea5d@gmail.com>
Message-ID: <8735pzbbtk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Phillip Wood wrote:

> On 20/09/2021 02:25, brian m. carlson wrote:
>> On 2021-09-20 at 00:42:57, Junio C Hamano wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> diff --git a/repo-settings.c b/repo-settings.c
>>>> index 309577f6bc..d00b675687 100644
>>>> --- a/repo-settings.c
>>>> +++ b/repo-settings.c
>>>> @@ -2,6 +2,8 @@
>>>>   #include "config.h"
>>>>   #include "repository.h"
>>>>   +#define UPDATE_DEFAULT_BOOL(s,v) do { if (s =3D=3D -1) { s =3D v; }=
 }
>>>> while(0)
>>>> +
>>>>   void prepare_repo_settings(struct repository *r)
>>>>   {
>>>>   	int value;
>>>> @@ -16,6 +18,8 @@ void prepare_repo_settings(struct repository *r)
>>>>   		r->settings.core_commit_graph =3D value;
>>>>   	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
>>>>   		r->settings.gc_write_commit_graph =3D value;
>>>> +	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
>>>> +	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
>>>
>>>
>>> This is a "review comment" that is more than 2 years late X-<, but I
>>> noticed that this is used to muck with a structure that was
>>> initialized by filling it with \0377 bytes.
>>>
>>> +           /* Defaults */
>>> +           memset(&r->settings, -1, sizeof(r->settings));
>>>
>>> but the structure is is full of "int" and "enum", so apparently this
>>> works only on 2's complement architecture.
>> This statement is true, but are there systems capable of running Git
>> which don't use two's complement?  Rust requires two's complement signed
>> integers, and there's a proposal[0] to the C++ working group to only
>> support two's complement because "[t]o the author=E2=80=99s knowledge no=
 modern
>> machine uses both C++ and a signed integer representation other than
>> two=E2=80=99s complement".  That proposal goes on to note that none of M=
SVC,
>> GCC, or LLVM support other options.
>
> A similar proposal [1] is included in the draft of the next C standard
> [2]. As integer representation is implementation defined I believe
> this code has well defined behavior on 2's complement
> implementations. If an enum has no negative members then the compiler
> may choose an unsigned representation but even then the comparison to
> -1 is well defined.

That's informative, thanks.

> In this case I'm pretty sure the enums all have -1
> as a member so are signed. Using memset() to initialize the struct
> eases future maintenance when members are added or removed and seems
> to me to be a sensible design choice.

It's really not sensible at all in this particular case, as I think my
[1] which gets rid of the pattern convincingly argues.

I.e. the only reason it had a memset() of -1 after we'd already memset
it to 0 was because the function was tripping over itself and setting
defaults in the wrong order for no good reason.

I.e. it was doing things like (pseudocode);

    memset(&data, -1, ...)
    if_config_is_true_set("x.y", data.x_y);
    if (data.x_y =3D=3D -1)
        data.x_y =3D x_y_default();

When we can instead just do:

    data.x_y =3D x_y_default();
    set_if_cfg_key_exists("x.y", &data.x_y);

Which is how we e.g. handle options parsing, we have hardcoded defaults,
then read defaults from config, then set options, in that order.

We don't set options, then check if each value is still -1, if so read
config etc. Just read them in priority order, doing it any other way is
just make-work for something that's the equivalent of a simple
short-circuit || operation.

Anyway, there are other cases where we need to read something and
distinguish e.g. false/true from "unset", and there a -1,0,1 tri-state
serves us well.

But even in those cases what repo-settings.c was doing of memsetting the
entire struct to -1 (2's compliment aside) just makes for needlessly
hard to read code.

If we've got some members that need -1 defaults we should instead have
that in an *_INIT macro or equivalent. The pre-[1] repo-settings.c also
has code like this pseudocode:

    data.a_b =3D -1; /* default for a bi-state, not tri-state variable */
    set_if_cfg_key_exists("a.b", &data.a_b);
    if (data.a_b =3D=3D -1)
        data.a_b =3D 1; /* on by default */

Which, urm, you can just do as:

    data.a_b =3D 1; /* on by default */
    set_if_cfg_key_exists("a.b", &data.a_b);

I.e. the setup for things that never wanted or cared about being set to
-1 was complicated by them needing to un-set themselves from a -1
default they never wanted.

Thus the anti-pattern, yes set defaults for some members to -1, but not
the entire struct. The only value we should memset a whole bag-of-stuff
config struct to is 0, as that's the only sensible default & plays well
with other C semantics.

1. https://lore.kernel.org/git/patch-v3-4.5-28286a61162-20210919T084703Z-av=
arab@gmail.com/

>
> Best Wishes
>
> Phillip
>
> [1] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2412.pdf
> [2] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2596.pdf
>
>> Personally I am not aware of any modern processor which provides signed
>> integer types using other than two's complement.
>> [0]
>> http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0907r4.html
>>=20

