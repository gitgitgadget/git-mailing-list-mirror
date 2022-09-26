Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FACC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 09:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiIZJcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 05:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiIZJcR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 05:32:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D549C140DE
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:31:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c30so6996023edn.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=o084KP3lHF/CNVC4PisZHEca5zMVTdcuKegOg7MqOv8=;
        b=iQs4+BVtCGFndQVek9G0494L+0FwVfB6jSbuffbuMtMuPcUudkKNOS6u7NuznE6EHX
         QSxrDdrr+DWRPWuLGWmXodvhN8OOwbsyuNNaLUTIUYP4QGq/KGzP4PJWR5mfPQ7pjrMv
         GlX7entM+wV28lo19LuYQWfMsgdHM4K40N6A+uQkfsa4G1qKcP0h5i8Ln6Wr78gtQ50A
         xom0Rg7S8Ra1Icb7g4SUAYYvDA6sAI4Unnqahe6EEx57zyr6CyKNPm1L8cMK33+/O0bG
         DfKjNPZpxyT6AbW6LvOdHhLqAl9WFKrdD4VAzi+4wGY6ThMm4wZfcBWxdh9Zy7FRKnrC
         A/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=o084KP3lHF/CNVC4PisZHEca5zMVTdcuKegOg7MqOv8=;
        b=8Nj+WLZDxhRIbEWZRspXHA61q04N5+L17fjXMx2OODHsnLCRcpCw/jz97tC6vPeQKv
         IdRGr101p20wTFzwofNqNcPVX10IeFmoVaoLRvZ/YcaiYZYtxgLsAPR4uOHqKvDA+HR/
         n2pYNq9c9kc8chUbamQm/VRyBLkxa5RSXFW0CJerYFM3ywIG0dKRGomxh1erQ/nvksLi
         RpbusQzqOseNDoJN6HTNpEU42vwHZxQ6PKFW7OZ6kh6R6YSB1Qv3xasNUT2odBBXNerJ
         1cNqhbusnBw4EgMXKqSwmfxYtP7ilqvc2WY9tRnXaJfQDOgNRpy//TZ0BTHidTR+AKNO
         w/XA==
X-Gm-Message-State: ACrzQf13pH3NPwIeNNaMS2y89FsmEI60LcJuKZ2R00sP4hyel4MzZG5Y
        Sq9jBuOS/a15lb7Qb8IkzaE=
X-Google-Smtp-Source: AMsMyM5+XpnqBk7DOqgVYrPMt4pQyTFmwHXXGdVczHQb6KpPSSQ0bPQZxGdMkVuD/hHeD2eXN6YGNA==
X-Received: by 2002:a05:6402:1e96:b0:451:129e:1a2c with SMTP id f22-20020a0564021e9600b00451129e1a2cmr21806663edf.60.1664184682312;
        Mon, 26 Sep 2022 02:31:22 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id x14-20020a05640226ce00b004544bdd56a4sm11296442edd.89.2022.09.26.02.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:31:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ockSO-003ocD-33;
        Mon, 26 Sep 2022 11:31:20 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Florine W. Dekker" <florine@fwdekker.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
Date:   Mon, 26 Sep 2022 11:14:04 +0200
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
        <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
        <f13bc5aa-dadd-a895-eeca-79bd77c5363b@fwdekker.com>
        <220919.86mtav60wi.gmgdl@evledraar.gmail.com>
        <YyiIkMcADVu+Qbht@tapette.crustytoothpaste.net>
        <220920.86edw65ngv.gmgdl@evledraar.gmail.com>
        <xmqqh71065mw.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqh71065mw.fsf@gitster.g>
Message-ID: <220926.86leq632jb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I think it would be irresponsible of us to provide a feature that looks
>> as though it can in any way mitigate those concerns.
>>
>> If you're someone that's worried about being harassed if someone makes
>> the link from your previous identity Y to your current identity X where
>> you already have Y as part of a public git history. The right answer is
>> to not submit a change to the .mailmap to explicitly connect the two.
>
> While I agree with the sentiment "You are in control if your three
> names appear to refer to the same person" (and "On the Internet
> nobody knows you're a dog"), I wish the world were so black and
> white.
>
> Many people change their names over the course of their life, and
> some do not want the linkage to their past revealed.  Many of them
> have nothing to be ashamed of themselves but do so due to risk of
> discrimination, while some of them may do so to hide inconvenient
> facts about their past.  While I have no sympathy to the latter, [...]

Just on the "no sympathy for the latter" I just want to point out that
this topic is a subject of fundimental disagreement between how EU & US
legislature views this, re the recent "right to be forgotten"
developments in EU law as they relate to "directory" searches[1].

> I do not think it is unreasonable for the folks in the former camp to
> also want recognition for the achievement made under their old as
> well as their current identity.  And "pretend you have nothing to do
> with that identity you used in the past life" goes directly against
> the idea of taking credit for what you did in the past.
> [...]
> As the expertise you demonstrated under your old name will not
> help others find you as an expert in an area, until your new name
> starts being associated with your newly earned recognition, it is
> also a loss for the development community.

Indeed, I think that most people who change their name for whatever
reason on a project they contributed to before & after that change will
probably want a .mailmap entry.

I was narrowly responding to the "harassment" aspect of this. I.e. that
it's a fundimental aspect of how our object graph & git is currently
implemented that you'll be giving someone "both names" as it were.

I think that if some users want their name not to be trivially
discoverable by e.g. grepping we could cater to that & other use-cases
with something like optional URI encoding.

But I think it's equally important that we don't present something that
looks like a strong password hash to a novice user (the sha256-ing), but
which due to the party reading the data already having "both names" can
be trivially brute-forced in the time it takes to run a "git log --all
--use-mailmap", or equivalent.

I also think it's important that we keep .mailmap something where we're
explictly giving *other people* the "both names", and for ourselves &
third-party systems make it easy to use the data.

I pointed out in previous discussions how e.g. the sha-256 proposal
would require rev walking & "brute forcing" for some workflows, such as
scraping a .mailmap to insert into a relational DB, in order to make the
same association there (and I've implemented a system like this at a
past job).

I wonder to what extent concerns about the deadname use-case would be
mitigated if we added support for a .git/info/mailmap, similar to
.git/info/exclude. I.e. we now have mailmap.file, but not a way to
suppliment an in-repo .mailmap. This would help the users who want to
avoid seeing their own "deadname", but which would also like to avoid
making the association to their new name part of the public record.

1. https://en.wikipedia.org/wiki/Right_to_be_forgotten
