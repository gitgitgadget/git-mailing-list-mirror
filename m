Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B5C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 10:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228EF61263
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 10:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFBKHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhFBKHR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 06:07:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60016C061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 03:05:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l1so2988356ejb.6
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6E0IyXCPmw+Mq/q1fRDOo+c2tBPPNBwEY2E2b9apeqc=;
        b=PLVelddMfh1/bnPUKXLyc2fVqSlxF0c/oU0aGYM2T9GQJEdLxVAjLniJH93rXaBFbs
         e/GZliC94eVt0u5dNUMWCmXJfFWsKcqbKESPv5aIUC1GtC7IEmIo1eYrfi8UILxv42HJ
         zxuCxFiu6KFZySVjm5wDocnx17iDJFpNBJI97tOA0P5Vi00RjMoO5jnN8My4hU7YED36
         BseUqJIIh+kMEzF/MzodYz8ip4NBBLRyC5vPlVzrE3mKzWsbXaxdyFtQr2YIybrBVHXA
         EyYilePLuPQsmCPOJd0JpWAEAs13LRLG1JKw+lDNsQqOVPV67KGc6ccLhIzRpw8hVqrd
         imxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6E0IyXCPmw+Mq/q1fRDOo+c2tBPPNBwEY2E2b9apeqc=;
        b=hQ06FMqLU67J5Cjmg1UWIZ7tGBm005MMfV2t8wqJZLU9h1Rnt6/PfsEddWKiPKj8Zt
         IdRZR3lkTIQz0wNu2JtZIJy32fV+OhzZEn533P5NRVG4imwTCTXxkRrY2Xgb+FMn/pF9
         zpsGO/lo6GGKZyD3fICUi5bnwv7ITJ9PN4R50RrZqOvvMJ8I7TnEWlDEbqs98v70zUav
         lBq9+0WxHIswDuT4YPLke4Oq4n6KYMWiz+5DoHVk0f9G4hb+ELG7uIXdR8hxQT4XW+Xc
         uMTYtsJKV7YOqlHqf7N1ftGPalvFXrwscQ7JbZbgCDaP5zJ0D0+e9iTvNCW8+wppR1qH
         qCow==
X-Gm-Message-State: AOAM531/ZgnBotLCMxhskvsNcMGFvxrcEHf/c0XyslJUGBH/5Oho/+rd
        yk5ZoZkquadMh4ExNpLaCKQ1vVyqmws=
X-Google-Smtp-Source: ABdhPJzmRhozLQXcLpxgD9/WBZ3AlQOyLHCTyeOvvF38F4NnMLscFg+KovP/sU/lau6awZc9x8QJ5g==
X-Received: by 2002:a17:907:2136:: with SMTP id qo22mr12451211ejb.40.1622628332545;
        Wed, 02 Jun 2021 03:05:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p25sm8381192eja.35.2021.06.02.03.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:05:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/31] minimal restart of "config-based-hooks"
Date:   Wed, 02 Jun 2021 11:34:21 +0200
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <YLZ5H2Muh39Q4M5T@google.com>
 <179668e9-008a-0b70-a193-b0a479ba0146@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <179668e9-008a-0b70-a193-b0a479ba0146@gmail.com>
Message-ID: <87sg207f9w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 01 2021, Derrick Stolee wrote:

> On 6/1/2021 2:14 PM, Emily Shaffer wrote:
>> On Fri, May 28, 2021 at 02:11:02PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>>
>>> After suggesting[1] an another round that the config-based-hook
>>> topic[2] should take a more incremental approach to reach its end goal
>>> I thought I'd try hacking that up.
>
> I think sending this complete reorganization of a long-lived topic
> is not helpful, especially because the end-to-end diff is significant.
> This series has been extensively tested and incrementally improved
> for months, and it would be a waste to start over and lose all of that
> hardening.

Felipe already commented downthread on the end-to-end diff aspect of
this. I replied in
http://lore.kernel.org/git/871r9k8zui.fsf@evledraar.gmail.com with the
diff you're probably more interested in looking at.

> It's also a but rushed that this comes only a day after the previous
> message recommending a reorganization. It would be best to at least
> give the original author an opportunity to comment on your idea before
> working on this.

I replied toth is as "When you get feedback in the form of restructured
patches[...]" in  https://lore.kernel.org/git/87y2bs7gyc.fsf@evledraar.gmai=
l.com/

As noted there I really don't see how sending "here's patches that
implement my suggestion" as opposed to "maybe xyz would be better" is
worse for anyone.

>>> So this is a proposed restart of that topic which if the consensus
>>> favors it should replace it, and the config-based hooks topic should
>>> be rebased on top of this.
>>=20
>> I'm not entirely sure what you're trying to achieve by sending this
>> series. It was my impression that the existing config-based-hooks topic
>> was close to being ready to submit anyway (since Junio mentioned
>> submitting it a couple revisions ago); rather than churning by reviewing
>> a different 31-patch topic, and then re-rolling and re-reviewing a
>> (reduced) config hook topic, wouldn't it be easier on everyone's time to
>> do a final incremental review on the existing topic and then start in on
>> bugfixes/feature patches afterwards?
>
> I completely agree here.

What do you think of the issues I raised in [1] ?

Emily's series isn't a pure internal refactoring of existing
functionality, but also an opinionated introduction of new user-facing
functionality.

Now, you may be 100% in agreement with the "opinionated" or
"user-facing" part of that, I'm personally somewhere around 80%.

But to me that clearly makes it a case where we need to as much as
possible get it right *before* it lands on master, because we can't just
incrementally tweak it after it lands without backwards compatibility
concerns. Soon after landing it'll be in a release, have users in the
wild etc.

By default that turns any suggestion of tweaking existing behavior from
a "oh that makes sense, let's fix it" into "well, that's unfortunate,
but it's existing/documented functionality used in the wild".

[2] goes on to mention a couple of other such issues (e.g. the --env
switch to "git hook run"), and this time around I've just been narrowly
focusing on any such issues in the not-config-base-hooks part of this
topic. I.e. the "no user-facing behavior changes yet" part I carved out
into a separate topic.

I'm not telling you which issues those are because I'd like you to tell
me, and then we'll compare notes afterwards. I bet <insert round of
beers at git dev summit or equivalent here> that they're not the same
list.

Anyway, I don't think you will, and I'm not entirely serious. But it's a
real rhetorical point about us being unlikely to come up with the same
result, and thus about the outstanding v9 series being too large to be
readily understood.

>> It would have been nice to see a more clear discussion of patch
>> organization sometime much sooner in the past year and a half since the
>> project was proposed[3], like maybe in the few iterations of the design
>> doc which included a rollout plan in July of last year[4]. To me, it
>> seems late to be overhauling the direction like this, especially after I
>> asked for opinions and approval on the direction before I started work
>> in earnest.
>
> I've also seen messages as early as January where =C3=86var mentioned
> wanting to review the series, but not finding the time to do so.
> It is reasonable to expect that contributors attempt such major
> reorganizations according to reviewers feedback, as long as the
> reviewers are timely about delivering that feedback.

I made a case in [2] for it not being too late.

For what it's worth (and some of which is noted in [2]) that's partially
because I for one have found it really hard to keep track of this
series.

Multiple re-rolls (including v8->v9) have some outstanding
discussion/feedback, some of which is addressed in a re-roll, but other
parts (as noted in my [2]) which aren't and are silently omitted.

I'm not blaming Emily for that, I think it's a rather inevitable result
of this thing just being too big to begin with and needing to be split
up.

But that's at least part of the story of feedback at such a late
time. Whenever I've looked at this topic I've spent quite a lot of time
doing that re-reading of past discussions / comparing with the newest
cover letter and noting any omissions etc. myself before even getting to
the point of reading the first patch, and I've sometimes just given up.

1. https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/=20
2. https://lore.kernel.org/git/87y2bs7gyc.fsf@evledraar.gmail.com/
