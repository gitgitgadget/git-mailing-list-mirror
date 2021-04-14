Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9E5C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 06:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D234611EE
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 06:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349233AbhDNGgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 02:36:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55004 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347967AbhDNGgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 02:36:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CFE9B2275;
        Wed, 14 Apr 2021 02:35:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WM6iJd752vDF
        VPILVJF+ZSswRBw=; b=Rd3k2wWIOuhSE2M0vHZt+Mp/G4tmOXexSwwqHzhDKzp2
        uhZ6SsFBMAGt8VGCFOhazz0YfUkbfkmvHxuzjTRjstXX6TBxZ5MktxSOTKllptZM
        p5sGwYCrojwLALPV4klVitnMdyyA1oMIkVyTHOsC27IxG09OAV/h0imfQwCAKWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eOJY0P
        LWNHUvFt1PDU3NOYSazOz6dzci0G2f5SyNi4W/OTiC4tIbhS45ERAQYBr/QYFeUw
        8ST4rYy9P9lco1GO0hCIXu2ZZgOcF2nJ7LqkWt5j7hYCdoESNxiPrlD6sM4ru1pj
        TtheR+A5naByO4gD3H39x5jPCoGSOhxlmhrho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 217F0B2273;
        Wed, 14 Apr 2021 02:35:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B40BB2272;
        Wed, 14 Apr 2021 02:35:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
        <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
        <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
        <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
        <87fszu2elw.fsf@evledraar.gmail.com>
        <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
        <874kg92xn0.fsf@evledraar.gmail.com>
Date:   Tue, 13 Apr 2021 23:35:49 -0700
In-Reply-To: <874kg92xn0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 14 Apr 2021 08:22:43 +0200")
Message-ID: <xmqqim4pz83e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8070F76-9CEB-11EB-A933-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Apr 13 2021, Matheus Tavares Bernardino wrote:
> ...
>>> >>         actual=3D"$pfx-diff.$test"
>>> >>
>>> >>         test_expect_$status "git $cmd # magic is ${magic:-(not use=
d)}" '
>>> >> +               test_when_finished "rm $actual" &&
>>> >
>>> > Nit: before these two patches, "$actual" was only removed when the
>>> > test succeeded. So, in case of failure, the failed output files wou=
ld
>>> > still be there for debugging. It might be interesting to keep this
>>> > behavior and only remove "$actual" at the end of the test.
> ...
> Ah, yes that's a problem we should solve, but I think we should not put
> off migration to test_when_finished because of that.
>
> The whole reason we use it is to clean up the work area for the next
> test.
>
> Thus if we do:
>
>     git something >expected &&
>     test_cmp expected actual &&
>     rm expected actual

Isn't it a poor example to use to argue for your particular change,
where $actual in the original is designed to be unique among tests,
in order to ensure that $actual files left after test pieces fail
would not interfere with the tests that come later?  IOW, there is
not a reason to remove $actual until the end of the test sequence,
is there?
