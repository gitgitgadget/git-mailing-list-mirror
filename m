Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7D3C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D419F613F9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhFQP5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhFQP5v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 11:57:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E633C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 08:55:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ji1so4540985ejc.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8TEVOLkZTN9iNxGszUwfiE8HefAAAvVGVsssfMe/H+s=;
        b=rVR6HErpa4ZjEisPaLuP0qjc637fhng+lBCiYUDOBB7I4h1ecJIXKrXWnYNRrmIOZy
         ImffSXoSt/v1nhjVgNN2qGk+vyn5YEOLvRcr2rVj+bbqUSTVg2Sxh1u3qbAf+Bfr5xOB
         ZdH+Ferd7On2IvUOdpVMZrTF6FDDVY1kIwwph74p3beTPGX9iG+Rgka9NoYcze8WosAz
         MiXX0d15oi/aFKbO4R64/6CsFD7vd8yq6/W1RpeS9dbU2soKnPdH0kaDw7kzPAKPrzee
         OIopxr6H7AJ7S6O9Ib+MJws2CigXEmcHr4+HtK7EbunzXgNXBrXFfRfQLjxDpnqS+VSw
         f2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8TEVOLkZTN9iNxGszUwfiE8HefAAAvVGVsssfMe/H+s=;
        b=VdRTTvLwopXI0QLhU6Suslae86MM8SM3TplHvQlA1XRPcGKgXCcUOzAm7I+pbVvMGG
         pJ9J7BubbvJ7YRw34Zyu8AaYmPMBl7hV/dfrd7zxGkhUWUKzwTp1Drc+MhceP4c6JRsU
         xwpAYaWPgm4Wh+JP2WRrnAh87UzAsILSnQhBPSiAspFolFmnp4y7aTie23/DYqGQC7C7
         8RRu/j2w73RE/UhYpa82XaUtIIDuKgfTkb3523ytnHbm+S0Ksy3Whw4xqUc5cmkI0VZG
         OF9ZOEMPMgwgS9eUM0E3QhH6k8m6qdoX/wc0xC5y4Tdd7VZSsyH3sV7QpDODMFmG2o2t
         hIdg==
X-Gm-Message-State: AOAM532oNSKHFz1lgCxmJkLjTPP48Eug74hLt0i6M/VU5BBjU8nrjnRx
        4WJ8sULKCwMxshjBPSR+r9k=
X-Google-Smtp-Source: ABdhPJzCsSnAJYxIgS/cX1Y7nuItvwT7T2DezPDFyjF1qI5fMCotMTJIVlEdKbMf59V1wo+deA1kDg==
X-Received: by 2002:a17:907:1c13:: with SMTP id nc19mr6126500ejc.168.1623945341648;
        Thu, 17 Jun 2021 08:55:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v8sm4604800edc.59.2021.06.17.08.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:55:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Date:   Thu, 17 Jun 2021 16:53:11 +0200
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com> <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g> <87bl85y15s.fsf@evledraar.gmail.com>
 <xmqqtulxnyhb.fsf@gitster.g>
 <5755690e-ef13-e12c-4b10-9cb303ae843a@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <5755690e-ef13-e12c-4b10-9cb303ae843a@gmail.com>
Message-ID: <87o8c4wkn7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 17 2021, Derrick Stolee wrote:

> On 6/16/2021 8:09 PM, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> ...
>>> The references to "gendered prounouns" etc. are gone, perhaps there's a
>>> good reason to re-include them, but the point of "isn't that issue
>>> solved by recommending an orthagonal approach?" is one of the many
>>> things Stolee hasn't been addressing in the threads related to this
>>> series.
>>>
>>> To me that whole approach is somewhere between a solution in search of a
>>> problem and a "let's fix it and move on". Not something we need
>>> explicitly carry in our CodingGuidelines forever.
>>=20
>> This I think is the crux of the differences between you two.  I'd
>> love to hear Derrick's response and eventually see a middle ground
>> reached.
>
> I disagree that removing gendered pronouns and updating the
> guidelines are orthogonal. At minimum, we shouldn't have
> guidelines that we do not follow, especially when they are
> small in number and we can fix them in a few patches.

Sorry, I read that a few times and I'm still not sure I get it.

Do you mean by "we shouldn't have guidelines that we do not follow" that
we shouldn't engage in general tree-wide fixes unless we also have
documented guidelines to back them up?

Or that the tree-wide changes for existing occurrences cannot be
separated from having specific documented advice applicable to those
occurances, or...?

If it's the first we have a bunch of tree-wide fixes that don't result
in documented guidelines, e.g. we did a general replacement of http with
https links recently. See 6eda9ac9e5 (doc: use https links,
2021-02-05). That's generally considered a good idea, I don't think we
have a guideline, and I'd think we *probably* wouldn't need one for
reasons similar to what I'm maintaining here.

> The entire point of this series was to reach a decision about
> gendered pronouns so we can stop having arguments about them
> when they come up.

Where have we been having those arguments? A reverse search of the ML
for all time reverse ordered by date for the term shows the 20th result
as the greater topic of this thread:

    https://lore.kernel.org/git/?q=3Dpronouns&o=3D-1

You need to search a bit further to get to this thread, or the ~120th
result for "gendered". Much of the earlier is false positives, and
skimming it to the extent that it's code I'd say those cases would fall
squarely under more "be brief, be succinct, UIDs aren't people"
etc. advice:

    https://lore.kernel.org/git/?q=3Dgendered&o=3D-1

In that context your "so we can stop[...]" somewhat sounds like "take my
patches, or I won't stop talking about my patches" :)

> We should just be able to point to "here is
> the decision we made" and it's not enough to say "If you go
> look at the mailing list archive you can see that we removed
> all gendered pronouns so you shouldn't add them again."

And I'd probably agree with you if you were providing examples of how
this is really some ongoing confusion, or pointing out how specific
parts of the documentation, code, comments etc. that we're now aren't
going to have that problem solved as a byproduct of more generally
applicable style guide advice.

Can you point out specific hunks that you, me or Felipe have changed in
our respective patches on this greater topic that wouldn't implicitly be
covered under something like the advice I'm proposing upthread[1]?

> We need ways for contributors to self-discover these things.
> Anything less is doing a disservice to our fellow contributors.

We're in full agreement with that. I've often started writing some
documentation patch and genuinely forgotten what the general tone of our
documentation is.

Should I write "an option such as this", "this option", say "you can
do", or "a user might" etc? I've then gone paging through the
Documentation/ directory, and not being sure what's considered good
current practice, and what's historical.

So I think we absolutely need general advice on how we write our
documentation, their tone, how we talk about common things like CLI
switches, program interaction etc.

But here in 1/4 we have two doc hunks being changed, one from 2007, one
from 2013.

In 2/4 we've got 6 occurances in the whole tree. 2 are from Junio and
the last time he sinned in that particular area was 2013. 2 are from a
2019 GSOC intern adding "she", one more from Jeff King in 2015, and one
in 2014 from a person who last got a patch in git.git in in that same
year.

I'm avoiding naming that 2019 GSOC intern b.t.w. because I for one
wouldn't want to contribute to a project like git, do a search for my
name on lore.kernel.org/git/ and see this thread. I.e. see that my
addition of a pronoun referring to my gender in a comment has somehow
become something that must be eliminated ... in order to get people like
myself to feel like their contributions are more welcome.

That's less welcoming, not more. Just like this whole thread-at-large
started by pouncing on another non-native English speaker's recent and
obviously innocent use of the wrong pronoun in a commit message.

But I digress.

Going on, 3/4 are simple typos, and your original 4/4 is an implicit
suggestion that (by approximate line count) 5% of everyone's time spent
reading through CodingGuidelines is best spent reading about this
always-obscure-and-now-gone-from-the-tree "issue" addressed in the
previous 3 patches.

I'm suggesting that 5% of their time would be better spent on something
that clearly has direct applicability to the maintenance of existing
code and documentation, and the authoring of new works. I also think it
happens to gives you 100% of the end result you want in terms of what
code/docs we end up with in-tree.

1. https://lore.kernel.org/git/87bl85y15s.fsf@evledraar.gmail.com
