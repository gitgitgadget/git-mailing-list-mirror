Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90239C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 01:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiGMBJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 21:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiGMBJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 21:09:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F047C48E0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 18:09:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j22so17304156ejs.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 18:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Sdnzk6ZfP5L0XH2fOUayrsbDiszJ8vLOAhD0tvWrvEs=;
        b=NdZoHnzLL4mgC1uZBtYnXx8JsNtI+Jm47TJ6FBlL9L4B5WnwTrKaberCKim/2nW3pc
         noFmbYjj6wfsPYwOIoJwYbZI234nq0Oe71BScm8tlknvkmHer1MNfpymkArW5xC2A6sd
         8xp8XIc//qiqAzbANOO3J1ypFu1qUqBsrEMCe2HBDeq8ODZMyDwFShAgECfINUxqHf5J
         OFrJH8JDwFrInkByaUe1ZbSzulFgUpdBFuQYOS9JaVSrYEEuWc7z4JOZQTs4RpjSMj1J
         vuvhoBgm/MjRYwMjG1gdZTT943we6/zQy9LRho39ROdpYcg/g+tR/AVqyndb6NSD90SP
         Ip4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Sdnzk6ZfP5L0XH2fOUayrsbDiszJ8vLOAhD0tvWrvEs=;
        b=wDaDbSIWjDXZBMYdDGDRe9N8FHDikIIymiKB74zp2jmSZnVgXSFLlYLfqTDBXW6S8T
         /mM+vFFYGdWVXnHubXuZQhgi1OOPyaxxNGJNWXOpP/shVvaEurQOTjrEnFwUm7UrrRNJ
         iqlqmhWliG/dzH7KB0CZ0oknHcnyULGainv2tDDrInNuCNdF4d1CcW96N7O5L0lPCruJ
         tN0thnuyhgzk+qJxHqQ4Xoev/tD2bSo+SxwLzFXUyFQefTkpyMheM48d/CmloFGqv89W
         1ErpHPZb9qGGs0CVHZfNf8Az0RHhxDG1s3iVSS7AHRFoj3d89DhEDxbK2vf+QRB1rOXq
         TBwg==
X-Gm-Message-State: AJIora/xDP8i8DK47q8Q+5KkyQHuwALmfkNAl6BEg6Zl/pNvoKJbzAj8
        AtU5AsQdTJ8fpmPQApXAzDI=
X-Google-Smtp-Source: AGRyM1tusjg3ngFzlcncsY8XVCV7earm/guhIzMbB7r8dwpcCJEhbrWW1evO/GEnjoaEZc1dzjsJZg==
X-Received: by 2002:a17:906:5055:b0:6ff:1dfb:1e2c with SMTP id e21-20020a170906505500b006ff1dfb1e2cmr923436ejk.200.1657674580747;
        Tue, 12 Jul 2022 18:09:40 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7dccd000000b00435a62d35b5sm6905831edu.45.2022.07.12.18.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:09:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBQsl-001cJG-2r;
        Wed, 13 Jul 2022 03:09:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] config: introduce discovery.bare and protected
 config
Date:   Wed, 13 Jul 2022 01:53:24 +0200
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
        <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
        <220701.861qv5d8v7.gmgdl@evledraar.gmail.com>
        <kl6lr134spi0.fsf@chooglen-macbookpro.roam.corp.google.com>
        <220709.86zghj8d6i.gmgdl@evledraar.gmail.com>
        <kl6lv8s25a80.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lv8s25a80.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220713.86v8s14y3w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 12 2022, Glen Choo wrote:

> Thanks for following up. I'm a concerned that this thread will be
> unproductive if all we're doing is reiterating our own opinions. I'm ok
> if the conclusion is "agree to disagree", but let's not spend too much
> time talking circles around one another (myself included, of course:)).

Yes, I have not been following up here to merely repeat what's been said
before, but...

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Jul 01 2022, Glen Choo wrote:
>>>> The "more narrow" and "more secure" go hand-in-hand, since if you work
>>>> on such servers you'd turn this to "always" because you want to read
>>>> such config, but then be left vulnerable to the actual (and muche rare=
r)
>>>> exploit we're trying to prevent.
>>>
>>> The point that we're not defending bare repo users is fair, but maybe
>>> the group we're trying to protect isn't really dedicated Git-serving
>>> servers. This exploit requires you to have a bare repo inside the
>>> working tree of a non-bare repo. So I think this is less of an issue for
>>> a server, and more for "mixed-use" environments with both regular and
>>> bare clones.
>>
>> Yes, but this is only something that's even a question because of an
>> artificial limitation your proposal here suffers from.
>>
>> I.e. in trying to detect nefarious repos where you've got "looks like
>> bare" content *tracked* in another repo you're conflating it with *any
>> bare repo*.
>>
>> And the only reason we're doing that seems to me to be a premature
>> optimization.
>
> Right, I hear you. Besides performance,[...]

...have been following up because it's still genuinely unclear to me
what data or design constraints led to this solution. I.e. in [1] you
noted ("[...]" interjection is mine):

	"I don't see how we could implement this [the "walk-up" method]
	without imposing a big penalty to all bare repo users[...]."

[Continued below]

> let me offer the perspective
> that I should have led with in the previous email. In this thread and
> the original "embedded bare repo" one [1], there is a huge diversity of
> opinion on what the default behavior should be, e.g.:

I read that thread over again, and some of the highlights were:

 * brian asking if we can't basically do the "walk up" method:
   https://lore.kernel.org/git/Yk9hONuCIVIq6ieV@camp.crustytoothpaste.net/

 * Taylor wondering how much we need to worry about this attack (among
   other things) & worrying about legitimate "bare repo" workflows being
   broken: https://lore.kernel.org/git/YloTQH35r2xVdPm1@nand.local/ &
   https://lore.kernel.org/git/Ylobp7sntKeWTLDX@nand.local/

But most importantly, here's something I hadn't noticed before:

 * Emily talking about the supposed slowness of the "walk up" method:
   https://lore.kernel.org/git/CAJoAoZkgnnvdymuBsM9Ja3+eYSnyohr=3DFQZMVX_uz=
Z_pkQhgaw@mail.gmail.com/

I.e.:

	"wantonly scanning up the filesystem for any gitdir above the
	current one is really expensive. When I tried that approach for
	the purposes of including some shared config between
	superproject and submodules, it slowed down the Git test suite
	by something like 3-5x."

Which I'm now 99.99% certain based on past context[2] is a misstatement
or misrecollection about an early version of
submodule.superprojectGitDir v.s. what setup.c would do.

I.e. that 3-5x slowness referred to git-submodule.sh shelling out to
"git rev-parse", it's not a reference to the expense of the few syscalls
we'd need to make to discover a parent git directory.

Did you hear about the directory walking being a performance concern
from Emily, or was it an independent discovery?

It seems as though this might have come about because of a
misrecollection about the git-rev-parse(1)/git-submodule.sh v.s. setup.c
performance with reference to submodule.superprojectGitDir, and that
we've now got a design that's optimized to avoid a performance problem
that doesn't exist, at the cost of accuracy.

And not to reiterate, but I think the performance isn't a concern
per-se, but rather that performance concerns seem to have driven one
design over another.

> - How do we detect an embedded bare repo (fsck check? walk up [and check
>   if it's tracked]?)
> - What to do when we detect one (ignore the config? block the repo?)
> - How to preserve workflows that rely on embedded bare repos (some kind
>   of (global|per-repo) exception list? allow the repo but not the
>   config?)
>
> And rightfully so! There are a lot of options here, so we want to make
> sure we get the defaults right. But at the same time that implies a
> pretty slow, difficult process.

I saw some implementation discussion about how we'd do this with fsck,
which is one thing, but I don't really see the trickyness or ambiguity
on the client side.

I.e. we know when we'd "find a repo", so that's the criteria we'd use to
ignore such a contained repo or not. The only trickyness seems to come
about if the approach we pick is one where we conflate embedded bare
repos v.s. non-embedded bare repos.

> On the other hand, I haven't seen nearly as much disagreement on "just
> refuse to work with bare repos" because it's so restrictive that it
> probably won't be the default. So it'll have no effect on most users,
> but still confers protection for the subset of users who can benefit
> from it. For those who want the problem fixed _today_ (e.g. my
> employer), this seems like simple, low-hanging fruit that buys time for
> us to find good default.
>
> FWIW, when time permits I'd be happy to work on that good default (which
> will probably be some variant of "walk up"), and to pay off the tech
> debt introduced by this implementation (I have some ideas about how we
> could improve the config API to achieve this [2]). Hopefully that helps
> allay some of your concerns?

It really just seems like a dead end to me, sorry.

I.e. we know what the security problem is, but the side-effects of this
approach are such that we'll probably never turn it on by default.

So that'll mean that the vast majority of users who could benefit from
the security mitigation won't even know about the config, or if they do
might not have it turned on.

And yes, we might end up with a better design later, but then we'll have
to still support this config mechanism, potentially deprecate it etc.

> [1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam=
.corp.google.com
> [2] https://lore.kernel.org/git/kl6lr13fi9qn.fsf@chooglen-macbookpro.roam=
.corp.google.com

1. https://lore.kernel.org/git/kl6lee1z8mcm.fsf@chooglen-macbookpro.roam.co=
rp.google.com/
2. https://lore.kernel.org/git/211109.86v912dtfw.gmgdl@evledraar.gmail.com/
