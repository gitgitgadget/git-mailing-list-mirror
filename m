Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A686CC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8015E613CB
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhFQHgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:36:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51515 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFQHgb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 03:36:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D9F1B9DCF;
        Thu, 17 Jun 2021 03:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Q7sukTrB4Bfd
        ENrlKrqCCoeBw5fSP7bptfZAS5fGz+E=; b=RNX6HHGKDrTAqPyQPcmrsT0Z45ZI
        c+qKVoouVZAkxtgEfVNsEIV7t3X0R0YH7756FJfveleF810ps6pAI52+dcBUs9VW
        /qYWMO18v47Dx+QPNLq97T7epg7/CqB4wFQAWI4PY/EkC2lyR7kwTL1ZKpcRHFpk
        oAg8k6Zb+SG60RI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7595DB9DCE;
        Thu, 17 Jun 2021 03:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E71C0B9DCD;
        Thu, 17 Jun 2021 03:34:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/8] [GSOC] ref-filter: add %(raw) atom
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
        <abee6a03becb929ffb292648d1ef64e61b66d53d.1623496458.git.gitgitgadget@gmail.com>
        <875yydx8oo.fsf@evledraar.gmail.com>
Date:   Thu, 17 Jun 2021 16:34:22 +0900
In-Reply-To: <875yydx8oo.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 17 Jun 2021 09:10:34 +0200")
Message-ID: <xmqqpmwlkkqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6F731562-CF3E-11EB-95AE-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Beyond, `--format=3D%(raw)` cannot be used with `--python`, `--shell`,
>> `--tcl`, `--perl` because if our binary raw data is passed to a variab=
le
>> in the host language, the host language may not support arbitrary bina=
ry
>> data in the variables of its string type.
>
> Perl at least deals with that just fine, and to the extent that it
> doesn't any new problems here would have nothing to do with \0 being in
> the data. Perl doesn't have a notion of "binary has \0 in it", it alway=
s
> supports \0, it has a notion of "is it utf-8 or not?", so any encoding
> problems wouldn't be new. I'd think that the same would be true of
> Python, but I'm not sure.

During an earlier iteration long time ago, as we knew Perl is
capable of handling sequence of bytes including NUL, it was decided
to start more strict by rejecting binary for all languages, which
can later be loosened, to limit the scope of the initial
implementation.

>> +	git hash-object blob1 -w | xargs git update-ref refs/myblobs/blob1 &=
&
>> +	git hash-object blob2 -w | xargs git update-ref refs/myblobs/blob2 &=
&
>> +	git hash-object blob3 -w | xargs git update-ref refs/myblobs/blob3 &=
&
>> +	git hash-object blob4 -w | xargs git update-ref refs/myblobs/blob4 &=
&
>> +	git hash-object blob5 -w | xargs git update-ref refs/myblobs/blob5 &=
&
>> +	git hash-object blob6 -w | xargs git update-ref refs/myblobs/blob6 &=
&
>> +	git hash-object blob7 -w | xargs git update-ref refs/myblobs/blob7 &=
&
>> +	git hash-object blob8 -w | xargs git update-ref refs/myblobs/blob8
>
> Hrm, xargs just to avoid:
>
>     git update-ref ... $(git hash-object) ?

That's horrible.  Thanks for noticing.

We'd want to catch segfaults from both hash-object and update-ref.
One way to do so may be

	O=3D$(git hash-object -w blob1) &&
	git update-ref refs/myblobs/blob1 "$O"

Thanks for a review.
