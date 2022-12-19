Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C7C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 09:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiLSJbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 04:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLSJbs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 04:31:48 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2867DBCA4
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 01:31:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id x22so19960795ejs.11
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 01:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eq9m+4wuM3mVAiCnHBcbkaH+v+dunfVIPomfsULc9X0=;
        b=CCgYMfiUOu7Rzdm7FW3rK0r1FWl+jWvShYYxaLiORclyQFxV7u5I0Y35gns0H5hs7+
         20cM9z8M25w/28IctCc/y+TZLg0Zo5GsA9KqYq8JrwYRTAW9yvEX5OXgLyMZWJicUiRf
         +5no2dsxQYNvAlcMhbcLp6jh4O+xaOWr5uHmww6zs97ubcmACB86IfXN+sn0BoWdNofw
         cih/fHfnIVJhLeT0534SSWM488vB0hW0u/MsoYWZInc+JHxnZHBgyHU/D6Kgd0in1EbR
         iQw3220nSALUBJkbJ93xn201IppMHp7iJsSZu7fPTKgcGMjfevGxiuIU10nhFHFSA5L/
         F0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eq9m+4wuM3mVAiCnHBcbkaH+v+dunfVIPomfsULc9X0=;
        b=gMoE/YsAfUbdb2JI/e31VEGubayEfQbb4Tg76fG5v8KcuHW0cbT/Na9jls0S9vbiVT
         +ZsjuhXzEmMy2UYwicByWkzc3s75DAgjlV6HM5hgXyuA6hKPsh0+qhZhxBdgZBj64pPD
         OcuyBF6HSNQ9iqANAovnwxVRaCR+x9DejTyD1sZl0Ce9qUTDj2Otpc7ESpkEn5LEtyjc
         oKurD+dkp3UoGGQAej5ZIaZtRVUi+nPVIO0RzCtIuFY/b4r4daHOHRaO/U9Nqf7Camnl
         7Dn0bLuhK21lyd53YzTxuDM8jtIAKj7gLtyw+1wZPc8s+mlXLoX2145870trEjro/C3q
         dWqg==
X-Gm-Message-State: ANoB5pl7ZU5ZNxUlWsskuDgZXFQhrAs725gbFxSBbQmlacNtHx4r25mE
        FrJOJo8w1ln5ku0hfIV5JWw=
X-Google-Smtp-Source: AA0mqf5lYiZVh9QOiPLM3iBzRZA7nVffIZhOfoCy1G2HQjQMOHU5qdLRibGJ39OFlRfGIJ1vNjq0iQ==
X-Received: by 2002:a17:906:2442:b0:7ad:8f6f:806d with SMTP id a2-20020a170906244200b007ad8f6f806dmr34125459ejb.24.1671442305667;
        Mon, 19 Dec 2022 01:31:45 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id z1-20020a170906944100b007c491f53497sm4176846ejx.170.2022.12.19.01.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 01:31:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7CUq-006UjJ-1v;
        Mon, 19 Dec 2022 10:31:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/5] strvec: add a "nodup" mode, fix memory leaks
Date:   Mon, 19 Dec 2022 10:20:00 +0100
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
 <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
 <Y53AXmfabIvdkfZz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y53AXmfabIvdkfZz@coredump.intra.peff.net>
Message-ID: <221219.867cyn20zj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 17 2022, Jeff King wrote:

> On Thu, Dec 15, 2022 at 10:11:06AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This is an alternative to Ren=C3=A9's [1], his already fixes a leak in "=
git
>> am", and this could be done later, so I'm submitting it as RFC, but it
>> could also replace it.
>>=20
>> I think as this series shows extending the "strvec" API to get a
>> feature that works like the existing "strdup_strings" that the "struct
>> string_list" has can make memory management much simpler.
>
> I know this is kind of a surface level review, but...please don't do
> this. We have chased so many bugs over the years due to string-list's
> "maybe this is allocated and maybe not", in both directions (accidental
> leaks and double-frees).
>
> One of the reasons I advocated for strvec in the first place is so that
> it would have consistent memory management semantics, at the minor cost
> of sometimes duplicating them when we don't need to.
>
> And having a nodup form doesn't even save you from having to call
> strvec_clear(); you still need to do so to avoid leaking the array
> itself. It only helps in the weird parse-options case, where we don't
> handle ownership of the array very well (the strvec owns it, but
> parse-options wants to modify it).

Yes, just like "struct string_list" in the "nodup" mode.

I hear you, but I also think you're implicitly conflating two things
here.

There's the question of whether we should in general optimize for safety
over more optimila memory use. I.e. if we simply have every strvec,
string_list etc. own its memory fully we don't need to think as much
about allocation or ownership.

I think we should do that in general, but we also have cases where we'd
like to not do that, e.g. where we're adding thousands of strings to a
string_list, which are all borrewed from elsewhere, except for a few
we'd like to xstrdup().

Such API use *is* tricky, but I think formalizing it as the
"string_list" does is making it better, not worse. In particular...:

>> This does make the API slightly more dangerous to use, as it's no
>> longer guaranteed that it owns all the members it points to. But as
>> the "struct string_list" has shown this isn't an issue in practice,
>> and e.g. SANITIZE=3Daddress et al are good about finding double-frees,
>> or frees of fixed strings.
>
> I would disagree that this hasn't been an issue in practice. A few
> recent examples:
>
>   - 5eeb9aa208 (refs: fix memory leak when parsing hideRefs config,
>     2022-11-17)
>   - 7e2619d8ff (list_objects_filter_options: plug leak of filter_spec
>     strings, 2022-09-08)
>   - 4c81ee9669 (submodule--helper: fix "reference" leak, 2022-09-01)

...it's funny that those are the examples I would have dug up to argue
that this is a good idea, and to add some:

	- 4a0479086a9 (commit-graph: fix memory leak in misused
          string_list API, 2022-03-04)
	- b202e51b154 (grep: fix a "path_list" memory leak, 2021-10-22)

I.e. above you note "in both directions [...] leaks [...] and double
frees", but these (and the ones I added) are all in the second category.

Which is why I don't think it's an issue in practice. The leaks have
been a non-issue, and to the extent that we care the SANITIZE=3Dleak
testing is closing that gap.

The dangerous issue is the double-free, but (and over the years I have
looked at pretty much every caller) I can't imagine a string_list
use-case where we:

 a) Actually still want to keep that memory optimization, i.e. it
    wouldn't be better by just saying "screw it, let's dup it".
 b) Given "a", we'd be better off with some bespoke custom pattern over
    the facility to do this with the "string_list".

So I really think we're in agreement about 99% of this, I just don't see
how *if* we want to do this why we're better of re-inventing this
particular wheel for every caller.
