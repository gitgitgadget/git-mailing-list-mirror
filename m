Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7B0C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D1A6139A
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhEZXCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 19:02:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50899 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhEZXCV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 19:02:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 296E313951D;
        Wed, 26 May 2021 19:00:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ChL46OKTbntQ
        rvQyFYpLI393rUz3l1VfV5vj8EQsIQQ=; b=r4VHKer683IlUSE+eY8cRFoWACQp
        m7z9omTIM5ASdUCjKB51Dt+3O0180bEDZZD5764TMOXPi7FYA2GtPDJkbEl+cZKL
        a0kuT+A5uy9VySYfM3IX4BcFkd1gRSqSHhNBo3J/xRnttz9Qt3LhBDmBtr123De4
        KMxypShIK6/FFLA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21E9D13951C;
        Wed, 26 May 2021 19:00:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32AEE13951B;
        Wed, 26 May 2021 19:00:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: AIX failures on parallel checkout (new in v2.32.0-rc*)
References: <cover.1620145501.git.matheus.bernardino@usp.br>
        <667777053ab853ef2f94b7ba4ab39f7241d2b49c.1620145501.git.matheus.bernardino@usp.br>
        <87eedtmj7w.fsf@evledraar.gmail.com>
        <CAHd-oW6X4cwD_yLNFONPnXXUAFPxgDoccv2SOdpeLrqmHCJB4Q@mail.gmail.com>
Date:   Thu, 27 May 2021 08:00:44 +0900
In-Reply-To: <CAHd-oW6X4cwD_yLNFONPnXXUAFPxgDoccv2SOdpeLrqmHCJB4Q@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Wed, 26 May 2021 19:01:39
        -0300")
Message-ID: <xmqqa6ohayn7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 34909740-BE76-11EB-8088-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Hi, =C3=86var
>
> On Wed, May 26, 2021 at 3:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>     + test_checkout_workers 0 git -C various_sequential checkout --rec=
urse-submodules B2
>>     error: Your local changes to the following files would be overwrit=
ten by checkout:
>>             d
>>             h
>>             j
>>     Please commit your changes or stash them before you switch branche=
s.
>>     Aborting
>
> I requested an account on the GCC farm to debug this, and the problem
> seems to be that AIX's `cp -R` defaults to following symlinks instead
> of copying them. In the above error message, 'd', 'h' and 'j' are all
> symlinks which were followed when copying the test repo, so these
> paths indeed won't match what's in the index, which makes checkout
> abort.
>
> Fortunately, there is a POSIX option to force cp to copy the symlinks:
> '-P'. Adding this flag to the cp invocation at line 117 of t2080 makes
> all parallel checkout tests pass on AIX.
>
> We also already use `cp -R -P` in the test suite (at t7001), and
> without any prereq, so I guess all platforms we are testing git at do
> support this flag in cp. I'll send a patch adding the flag at t2080.

Thanks for a quick analysis.  Very much appreciated.

00764ca1 (test: fix t7001 cp to use POSIX options, 2014-04-11) only
mentions that "-R -P -p" is used now in place of "-a" that we used
to use (the latter of which is not POSIX).  Please highlight why we
want -P in the log message (i.e. we want to copy the link in these
tests because ...) for the fixing commit.

Thanks.
