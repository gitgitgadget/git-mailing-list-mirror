Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C08FC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 17:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390566AbiDUR1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390505AbiDUR1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 13:27:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E633A2B251
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:24:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20DF7126EFB;
        Thu, 21 Apr 2022 13:24:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xpSJV89nfJYZ
        2jRRTAnnAilF98Zsn8vbKRJUUKbO8Bs=; b=F5aN3WptE6I84BKUDnaTh3e2HD5D
        7WNi24/u3yszT6e0N6CaF0WDdJCB9/WP2ldIDbkjBqWURHA6RqSObxSk0EQhQ/Se
        5SdF+kUnqhugbb7Aae10Et312m4wLBF4QbSe25UirCGvrGUpImEvBMTCu2lHUzsL
        vLDd8rqHMym9Vk8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 172D2126EF9;
        Thu, 21 Apr 2022 13:24:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73515126EF8;
        Thu, 21 Apr 2022 13:24:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <Yl9Hn0C0TwalASC0@google.com>
        <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
        <xmqqr15rr9k6.fsf@gitster.g>
        <CAJoAoZm7p32Hn=TLQeWUqp_nMjo_TQ2whR4F=cXk4c6PV1M5bA@mail.gmail.com>
        <xmqqilr3r7ki.fsf@gitster.g>
        <CAJoAoZnw6cNBwWpa5w-rhQ4p_zw6w6Q-NHzNeRKrrqPpDCjY2A@mail.gmail.com>
        <220421.86sfq67hlr.gmgdl@evledraar.gmail.com>
Date:   Thu, 21 Apr 2022 10:24:22 -0700
In-Reply-To: <220421.86sfq67hlr.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Apr 2022 14:03:12 +0200")
Message-ID: <xmqqsfq6jqnt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E308FAF4-C197-11EC-A21D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ... I.e. as a mechanism for
> mitigating mistakes and catching obscure edge cases just being more
> careful or having things sit in 'next' for longer has, I think, proved
> itself to not be an effective method (not just in this case, but a few
> similar cases).

I tend to agree.  Given that people do not discover possible
regression that will affect even after a change hits 'master',
cooking in 'next' alone would not be all that effective.

But that does not mean we shouldn't cook in 'next' at all.

Especially the previous cycle, I was experimenting with a tweak in
my workflow to have topics in 'next' to cook for one week and have
them graduate to 'master' unless we saw regression in a week.
Previously, I tended to keep topics on the larger side in 'next' and
we did see "oops we found this after the topic hit 'next' and here
is a fix-up" to them, which I think helped to catch bugs before it
broke 'master'.

> I'm not sure what the solution is exactly, but I'm pretty sure it
> involves more controlled exposure to the wild (e.g. shipping certain
> things as feature flags first), not deferring that exposure for long
> periods, which is what having things sit it "next" for longer amounts
> to.

To be fair, "is the hook invoked with its standard output stream
connected to the original standard output of the main process?" is
not something either of you cared while working on and reviewing the
changes, and releases based on 'next' $BIGCOMPANY have its users use
internally wouldn't have helped to catch this particular regression,
as the primary reason we didn't think of it as a problem is because
internal users of $BIGCOMPANY tend to be more monoculture than folks
in the wild.

So the fundamental solution would be to find a way to involve those
who found the regression after a release was done in the development
process at a much earlier stage.  I do not offhand know how to get
there.

It may be very hard for us to do with end-users, who typically have
only one instance of Git they use and a single valuable repository
they cannot subject to "experiments".  They may depend on certain
aspects of the behaviour of the current version, but they lack an
environment to try out our new version to see if we broke them.
They probably may not even be aware of what they are relying on,
just as we are unaware of their dependence.

But for toolsmiths who integrate their gears with Git, there may be
something we can do.  Perhaps we can start giving "works with Git"
badge out (we need to control its use with some kind of trademark
registration), to those who "maintain X that enhances Git" when they
regularly test their ware with 'next' or much earlier.  And when
they stop us before unleashing a possible regression by reporting
bugs early, give them a "star", so that their "works with Git *****"
logo can boast how much contribution in testing they are maing
upstream.

Or something like that, perhaps?
