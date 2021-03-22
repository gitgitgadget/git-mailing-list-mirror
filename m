Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCECAC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D2D61984
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCVSpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:45:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64810 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCVSpW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 14:45:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4FC9117D21;
        Mon, 22 Mar 2021 14:45:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O0XJa2cEIxT+3grfeAhRedAxEuA=; b=DQk/Bu
        7n17SWR3bk5to6dSFpfTiKoXYcH/TsrkFYCTM2xeMtVbpFIOJdVisgmehnnSAC+s
        E4AlbwPcXk1FZqfJRa3wurn07dgSzDQvceE60/CAS0GNDl3yMrcF1lxvHCPAMkPD
        BvkXNLhNriQWOlzeeaF8PNsNNpFdVIEXL2Ba4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fCTPX3r4Gx6931l43HDgDJzp4l3rCSFU
        ZiPPrD+nV/Qw7OF7nzg2aK+pX44T7FyLeKrKnXUm+edNuK2qSUolzmgVGiP1ApGL
        NOxIauSARjE3yXEPqbkrxZ7BJfZ9WgmLR14naRrWpymhp5LDg5iPHtllPQH2fYaP
        VxVQ6xigt1U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCA11117D20;
        Mon, 22 Mar 2021 14:45:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 12483117D1F;
        Mon, 22 Mar 2021 14:45:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
        <pull.911.v2.git.1616317134.gitgitgadget@gmail.com>
        <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
        <1722fbad-6ff3-444f-ad3f-59e37b640fc7@gmail.com>
        <xmqq1rc8cv01.fsf@gitster.g>
        <47e8a13f-ce96-f3f3-0f8e-efd685f58e60@gmail.com>
Date:   Mon, 22 Mar 2021 11:45:17 -0700
In-Reply-To: <47e8a13f-ce96-f3f3-0f8e-efd685f58e60@gmail.com> (Bagas Sanjaya's
        message of "Mon, 22 Mar 2021 13:01:58 +0700")
Message-ID: <xmqq5z1j6n9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C007D2F4-8B3E-11EB-BCA9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> I mean the error should be:
>
> ```
> error: @batman match multiple identities:
> 1) batman <email1>
> 2) batman <email2>
> ...
> n) batman <emailn>
>
> Please disambiguate by running "git commit --trailer" with full identity, like:
>     git commit --trailer="<someone> <<email>>" <options>...
>
> ```

Detecting error alone is probably prohibitively expensive, as it
takes you to scan _all_ commits down to the beginning of time to
pruve that a given pattern matches one and only one author ident.

Assuming that we would pay that cost (I doubt we would want to,
though), additional cost to show all possible hits would be small
and manageable, I think.

