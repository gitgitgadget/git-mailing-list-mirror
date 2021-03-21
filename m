Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A0C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164EB6192C
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 17:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCURNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:13:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58075 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhCURNY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 13:13:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 769CE11A692;
        Sun, 21 Mar 2021 13:13:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=D/iPNgxCYw+D
        dORROALOeCvUlME=; b=YPVKPvFruXpyhwcPy+P78d2MVjfa5OJqng2hHTLFsQzw
        DXlWN2H0Hj7wT446As07II1cgzbvGZYY5mx1SUjk8X8GNC5b3DyFAZMbaf5XKB46
        n2ZmUNyTsVjUCf+93zJW65iN1AH9vUVfmPa4pGCwH5d2iasTtJlfPYjI/9HBbgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=a23NVx
        STvfMwTOX4HoTHTmFVkDeMQe92U/dCtJGsMIuWAeQizF2o0GXCfwb0m0VD9Bu0UM
        c4Q6y4p9lpzLJmJDFYOtpB/Og/MiLVQ2s1QVETMAFOJzXhAmFCJ7N6hxBYiC0T4T
        e4VbyE4mPSorVQ7XMJWxLMDIymC52Yo5+4OX0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D9B811A690;
        Sun, 21 Mar 2021 13:13:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A111311A67A;
        Sun, 21 Mar 2021 13:13:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 00/29] tree-walk: mostly replace "mode" with "enum
 object_type"
References: <20210316155829.31242-1-avarab@gmail.com>
        <cover.1616282533.git.avarab@gmail.com> <xmqqtup5cnlu.fsf@gitster.g>
        <87wnu0r8tq.fsf@evledraar.gmail.com>
Date:   Sun, 21 Mar 2021 10:13:19 -0700
In-Reply-To: <87wnu0r8tq.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 21 Mar 2021 13:26:57 +0100")
Message-ID: <xmqqlfagbfbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BCFB6BB0-8A68-11EB-89FF-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Yes, that would be a serious regression. I agree that all these
> functions/callbacks etc. should have a way to get at the mode bits.
>
> I'm adding "enum object_type", not removing the "mode" parameter in
> read_tree_fn_t. This function (which is in "seen" as 03316f20347
> (sparse-index: implement ensure_full_index(), 2021-03-16)) works just
> fine in combination with this series.
>
> The other APIs modified here all retain the ability to give you the mod=
e
> bit, they (the tree-walk.h changes) just optionally give you the option
> of getting just the type (or just the path), and as it turns out most
> users of the API can be converted over to that.

I have a vague feeling that such an approach may be still repeating
the same mistake.

If the original premise is that "unsigned mode" bit can be abused to
feed impossible values like 0100653 to the system and the code
should catch it, ...

> The current codebase will allow you to stick arbitrary mode bits in
> trees, ...

... then I would understand it if the approach is to introduce a
distinct type that enumerates all possible mode bit values (and
nothing else), and have the compiler validate the callchain, so that
nobody can pass bogus mode bits (and when reading mode bits fields
in existing objects, the one that converts from the series of octal
bytes to that distsinct type would notice and complain).  And we've
already seen from this particular breakages that the "distinct type"
appropriate to be used for that purpose is not "enum object_type".
It is not expressive enough to enumerate all possible mode bit
values (besides, an enum is interchangeable with an int, so there
isn't much protection we would be getting from the compiler---we
could use a small struct of a new type, and have one static const
instance for each possible mode bit combination, I guess, but the
point here is that insisting on using "enum object_type" seems to be
the source of the problem).

I am afraid that it is even worse to pass both object type and
"unsigned mode" together.  It would still leave room for a bug to
pass nonsense mode bits, which we said we wanted to catch in our
original mission statement.  In addition, we now have a new room for
a bug, which is to pass an inconsistent pair of object type and mode
to the callchain.  Somebody would need to say "yuck, we got a mode
100644 but the type says TREE" now, in addition to validating if the
mode is sensible, which we should be doing somehow, no?

So, I am not sure how these changes are making anything better.

> ... I had a
> summary of this in v1, but should probably have provided a recap[1].

Oh, absolutely.  When we iterate, we should be welcoming to those
who missed earlier iterations.

