Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB77C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 12:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiFXMsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 08:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiFXMsa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 08:48:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F271EAA
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 05:48:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g26so4492002ejb.5
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0tuC4UbVDIF/GZEEEJieer6bxgC+BdGrnFqFgv6vmAs=;
        b=FYrtQQhy0gUSyenoZozwiUUXv3LI+LBo4uoN4rXMQRuzLza4w9bRXmKHa0PQbKZxXw
         ZOLp1AWuMNQq61/kKcpoaftpis8mAYWKbreoXd7c0o5eC3asYnV7G1wlDr4HGgPd7y5x
         kRsVai+H/xf9sFSDMcvdYiTysyUhyzOrFQytXkFUeTvPVXcz1cgyyvHhML5sWvB/PMHr
         1YGOqHnGRLjiSiH13EWomdv2YtIXse2FRpAXxNTCmDE9IIRTOGF8hPfsmsAGeKQGvQgm
         WCX78sgryQyCM7+SeazbGa5tEAy3labhUAmfwowN+A63thWGKauQqR4nszgk3gvZMlB4
         vVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0tuC4UbVDIF/GZEEEJieer6bxgC+BdGrnFqFgv6vmAs=;
        b=0g8/tXSiHvuJ+l2P2RDBadPs0BzveVrNrv90bNVH0N8W7X1Fp/5SnIVWHkduKJ0QLV
         sGWBgCy/oDW0kiE1+SuKfxEo8qqslVM2ToOCvAVqeE1z4mVtMskBJ3qRs9MxEAehdOOm
         6mRQaSF+Xsg9U/KHSJ3EkeoE9sXm3wvLZBbUuPk7AoDr5Uyf1RfHt6wjiCxXV7jKsPff
         oquubMqZAN7a48Q6R25E2xh3bbmwDevPOssJVHVbn2kdo6F++utqRW3COG1R9qGpoxcD
         B1wvwU+4BCZrl7Xle+Jz2IdVvkSfGDtlfNrmfZ6rwCMbeqCtZ1GAm484r1ZZMRmo8Q0J
         z2wA==
X-Gm-Message-State: AJIora+6F48VSLiXzN2eWGNMohwcyTufmd9evq1X8TiaSEB5KBwCgaOg
        ZD3O7iLR/KsotldNX362VURZyIvAPrgPXg==
X-Google-Smtp-Source: AGRyM1ujlwg4aMApZoOZnaz3PsPGxhh18dRrR9cmVdtPlTW/Xdir/5xOwZdzTUz8Vwj+TXLd4gMVQQ==
X-Received: by 2002:a17:906:65c8:b0:713:ee3e:254d with SMTP id z8-20020a17090665c800b00713ee3e254dmr13523721ejn.0.1656074906322;
        Fri, 24 Jun 2022 05:48:26 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ci25-20020a170906c35900b006fe921fcb2dsm1075702ejb.49.2022.06.24.05.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 05:48:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4ijY-001IUY-0c;
        Fri, 24 Jun 2022 14:48:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 0/1] scalar: move to the top-level, test, CI and
 "install" support
Date:   Fri, 24 Jun 2022 13:59:36 +0200
References: <patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com>
        <cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com>
        <2f3067e1-43fb-26b3-83c4-6ca0722149a0@github.com>
        <220623.86k097js9k.gmgdl@evledraar.gmail.com>
        <c93c8e75-6c88-ac99-d8c3-1e2e7dd06ea3@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c93c8e75-6c88-ac99-d8c3-1e2e7dd06ea3@github.com>
Message-ID: <220624.86y1xmi5wo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 23 2022, Derrick Stolee wrote:

> On 6/23/2022 11:30 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Jun 23 2022, Derrick Stolee wrote:
>>=20
>>> On 6/23/2022 6:26 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> This one-patch series integrates the "scalar" command to the
>>>> top-level, meaning we build the "scalar" binary by default, and run
>>>> its tests on "make test" and in CI. We'll also build and test its
>>>> documentation. We now also have "install" support, both for the
>>>> program and its docs, but you'll need to:
>>>>
>>>>     make <install-target> INSTALL_SCALAR=3DY
>>>>
>>>> I'm sending this out now to avoid needless duplicate work.
>>>
>>> As mentioned on the list earlier, Victoria is taking over the
>>> remaining work to complete the Scalar project. Nothing has been
>>> sent to the list because we didn't want to cause a distraction
>>> from the release window.
>>=20
>> I was on the fence about sending this out, but given that the "CI"
>> thread was going on until the start of that window, and wanting to save
>> her the work of re-discovering the subtle issues with the integration
>> I'd already fixed I thought it was better ot send it out.
>
> The CI thread was halted not just because of the release window,
> but because of a change in who was doing the work and taking time
> to revisit the plan of record. This was communicated on-list [1].

Part of this is me reading between the lines, but as mentioned in the CL
I thought it had more to do with the bug I pointed out on the CI
series's 2/2.

> [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2206132246010.353@tvgsb=
ejvaqbjf.bet/
>
> The point is that the end goal is still "Get Scalar out of contrib/"
> but the questions that are still being worked out are things like:
>
> 1. _When_ do we integrate Scalar into CI?
> 2. _When_ do we move Scalar out of contrib/?
> 3. _When_ do we implement the remaining Scalar features?
>
> All three of these questions depend on what the final result will
> look like, and Victoria is still working on developing her own
> opinion on that before presenting it to the list in a complete
> form.
>
> Your patch here is interrupting that process.

Coordination & collaboration can be difficult, but generally speaking we
try to use the ML as a means to decide how topics move forward, and for
coordination.

In this case I understand that there was off-list discussion about how a
part of the codebase should be moving forward among a group of
co-workers who contribute to git.

I don't think there's anything wrong with that, but this really seems
like an overly hostile response to someone who wasn't part of that
process.

Especially as I'm not insisting that I be the one to drive anything
forward on the scalar topic, I think it makes much more sense that it's
Victoria.

This patch is just offered as a way to help that effort along. Perhaps
she'd ack it as-is, find it useful as it reveals some edge cases she
didn't know about, or drop it and go for some other approach. Whatever
gets us to the end-goal sooner than later is fine by me.

Once you "git rm" the scalar Makefile there's not really a lot of ways
you can go other than something approximating the upthread patch. Given
that some of the edge cases are tricky I deemed it worthwhile to share
it.

>>> Victoria is taking time to incorporate your previous thoughts on
>>> how Scalar is built and its location in the codebase and create
>>> a complete narrative of how to get from our current state to that
>>> point.
>>=20
>> I wasn't sure she was even aware of it, and given that the WIP patch I
>> saw in my "git fetch" was pretty much a subset of the upthread v1 it
>> seemed that there was needless duplicate work going on.
>>=20
>> It seemed clear that that WIP patch was attempting to head in the same
>> direction, but hadn't yet discovered some of the hurdles with
>> e.g. documentation building & installation that I'd fixed
>> already. There's also the CMake integration, which I finished up for
>> this v2.
>
> Poking around in people's forks to discover what they have as WIP
> is not a good measurement of what work is being done or not. A lot
> of mental energy is being spent in this area.
>
> Saying "What I see in this person's fork isn't good enough" is not
> a reason to move forward on your own. WIP work is WORK IN PROGRESS
> and is not assumed to be complete or up to expectation for review
> on the list.

I'm not saying that, but "you seem to be trying to do X, and may or may
not be aware of a past patch that does X, here is is in case it help!.

>> FWIW I have this local change queued on top of this v2, it's all
>> cosmetic, but probably a good idea.
>
> Please stop motivating current patches by work that you have been
> playing with in your local tree. You do this frequently but it is
> not helpful.

After I submit patches to the ML I tend to "bump" the branch I sent it
from, that range-diff was against the submitted v2 to local changes I
applied afterwards, having missed some spots in the initial submission.

I'm not clear on what part of this you're taking issue with...

>> The $(SCALAR_SOURCES) bit is something I missed, but which Victoria
>> didn't in her WIP patch (I stole it from there).
>
> You also mention this in your cover letter (but is notably absent from
> the patch itself).

...yes, hence the "local change queued on top" above, it's a minor
detail I noticed after submitting the patch.

> I can only attribute your insistence here as a lack of respect for
> your fellow contributors. [...]

I really think that's unhelpful. Let's try to assume some mutual good
intent. I think I've explained my motivations above.

> [...]There is no rush for this to happen immediately, so the only
> reason is that you don't trust that it would be done correctly without
> you submitting the work.

Some of the edge cases in the Makefile integration are subtle. I trust
that someone looking at it would probably discover those eventually. I
think it took me about a day of poking around, much of which was a slow
ping-pong with the CI. So someone with a local Windows box could do it
faster.

But if I'd have gotten a patch from my future self with all the learned
edge cases beforehand I'd have appreciated, so I figured I'd send it in.
