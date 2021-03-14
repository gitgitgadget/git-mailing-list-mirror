Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B6C433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2855F64E12
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhCNW6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:58:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59348 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCNW5X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 18:57:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3014BF682;
        Sun, 14 Mar 2021 18:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8kssEz/3JM9+
        A5eoWIK3zATOsUg=; b=UdBchq00qvuMwaIIDL1jpGMxUZMUrviHiPXa4O/KbjxN
        F9Xmo+jJGSNBBQ09NJuO/CJlp7FYHkKokV3nFvckh2T8hoHt7N+uKhFkPqGMw3kv
        W1lOUxStlCUNb/s3T1DZ54WtyIs0Ugvet5v5fv3b7gRZFfvkZkYVp+UHMa9W7U4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M7nbLC
        jSYXkPDG8xfd28peq/Im4h/LVFDCD/JZKHkDcPjls/e5rJkWF4zDVXDHN3Bes26h
        GnfiGX+26GzL8cCIgQ9K//F+anQ34Nl+CRrO2GVx5CY58Djp2y6sbyv3mr+ofpdO
        RpQ7AmgtQiDBFGwXd56oI/2XYPSzsAEzfntUg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AF9BBF681;
        Sun, 14 Mar 2021 18:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2937EBF680;
        Sun, 14 Mar 2021 18:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH v2 7/9] parse-options: convert bitfield values to use
 binary shift
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
        <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
        <2b03785bd4cb76285989aff259af57890ea9fe08.1615747662.git.gitgitgadget@gmail.com>
        <CAN0heSo_ArBrjSncvx==kw8K1DzH=0y2h-Q=B_364Ea0EURXxg@mail.gmail.com>
Date:   Sun, 14 Mar 2021 15:57:21 -0700
In-Reply-To: <CAN0heSo_ArBrjSncvx==kw8K1DzH=0y2h-Q=B_364Ea0EURXxg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 14 Mar 2021 21:25:57
 +0100")
Message-ID: <xmqqtupd2vji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2CB287A-8518-11EB-889C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>>  enum parse_opt_option_flags {
>> -       PARSE_OPT_OPTARG  =3D 1,
>> -       PARSE_OPT_NOARG   =3D 2,
>> -       PARSE_OPT_NONEG   =3D 4,
>> -       PARSE_OPT_HIDDEN  =3D 8,
>> -       PARSE_OPT_LASTARG_DEFAULT =3D 16,
>> -       PARSE_OPT_NODASH =3D 32,
>> -       PARSE_OPT_LITERAL_ARGHELP =3D 64,
>
> `PARSE_OPT_NEGHELP` is gone since acbb08c2e0b ("parse-options: remove
> PARSE_OPT_NEGHELP", 2012-02-28), which explains the jump here.
>
>> -       PARSE_OPT_SHELL_EVAL =3D 256,
>> -       PARSE_OPT_NOCOMPLETE =3D 512,
>> -       PARSE_OPT_COMP_ARG =3D 1024,
>> -       PARSE_OPT_CMDMODE =3D 2048
>> +       PARSE_OPT_OPTARG  =3D 1 << 0,
>> +       PARSE_OPT_NOARG   =3D 1 << 1,
>> +       PARSE_OPT_NONEG   =3D 1 << 2,
>> +       PARSE_OPT_HIDDEN  =3D 1 << 3,
>> +       PARSE_OPT_LASTARG_DEFAULT =3D 1 << 4,
>> +       PARSE_OPT_NODASH =3D 1 << 5,
>> +       PARSE_OPT_LITERAL_ARGHELP =3D 1 << 6,
>> +       PARSE_OPT_SHELL_EVAL =3D 1 << 7,
>> +       PARSE_OPT_NOCOMPLETE =3D 1 << 8,
>> +       PARSE_OPT_COMP_ARG =3D 1 << 9,
>> +       PARSE_OPT_CMDMODE =3D 1 << 10,
>>  };
>
> Those last few conversions close the gap and we end with 1024 rather
> than 2048. That "should" be ok, unless some piece of code relies on
> exact values here, or even their relations(!). Hopefully not? Might be
> worth calling out in the commit message that you're changing some
> values, if you're rerolling anyway. (Or you could leave 1<<8 unused to
> make this a true no-op, then use that value in the next patch. Anyway, =
I
> think this is safely in bikeshedding land.)

I think 8 vs 1<<3 is bikeshedding, but a patch that claims to
"convert bitfield flags to use binary shift" is supposed to be a
no-op, so it would highly be problematic to see such a hidden
renumbering happening at the same time.  Even if the existing code
or any code in flight only relies on the fact that these bits are
distinct and non overlapping.

Thanks for a sharp set of eyes.
