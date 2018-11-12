Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874291F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 03:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeKLNIh (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 08:08:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55075 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbeKLNIg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 08:08:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5282A109C90;
        Sun, 11 Nov 2018 22:17:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Jm191pioS5tS
        I12t6XEGFgvH6kg=; b=eDUGmar0S/tv9omRvqub+TSu+sENnapSofBqcWiS2vmU
        n4qJDEhHM69XRKtmW81bB6u0PUw0fb43c0vrNfNalVmvmYk7VFFroy3ndW+KOP4z
        9Uh9OpMUcrnubYnukc5vymSlgkEG7rWHus3SzhFA+dOqWr6JY5es7x28S3v0Z40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kSBD5Q
        9PF+yllD5fj2QbyHkPT4Y7MbahG2T3nI1hs1i7nr+clkRjfus33oNLs2eMLMq95v
        ezcgmWcnJlcy7yCGx5DnzsU39hrhplOJ6GxU5dDF5XpWe63EcD3aK7+EU2YPIeuo
        gCCdxr2pD5tRxeerDTdGt8UJBmoGomVLkc6FE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A841109C8F;
        Sun, 11 Nov 2018 22:17:28 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B586C109C8E;
        Sun, 11 Nov 2018 22:17:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "Stephen & Linda Smith" <ischis2@cox.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v4 3/3] range-diff: make diff option behavior (e.g. --stat) consistent
References: <20181107122202.1813-3-avarab@gmail.com>
        <20181109101803.3038-4-avarab@gmail.com>
        <CAPig+cTWgmApseaz4cZqUU4U1NJrcu3vq0FzVwHO6icT7nWcPw@mail.gmail.com>
Date:   Mon, 12 Nov 2018 12:17:26 +0900
In-Reply-To: <CAPig+cTWgmApseaz4cZqUU4U1NJrcu3vq0FzVwHO6icT7nWcPw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 11 Nov 2018 03:43:50 -0500")
Message-ID: <xmqqk1lj3ry1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7BA9F6D0-E629-11E8-92D0-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Nov 9, 2018 at 5:18 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
>> Make the behavior when diff options (e.g. "--stat") are passed
>> consistent with how "diff" behaves.
>> [...]
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> ---
>> diff --git a/range-diff.c b/range-diff.c
>> @@ -453,7 +453,8 @@ int show_range_diff(const char *range1, const char=
 *range2,
>> -               opts.output_format |=3D DIFF_FORMAT_PATCH;
>> +               if (!opts.output_format)
>> +                       opts.output_format |=3D DIFF_FORMAT_PATCH;
>
> I think this can just be '=3D' now instead of '|=3D' (to avoid confusin=
g
> the reader, even if it's functionally equivalent).

Hmph, could the condition in the future change to

	-	if (!opts.output_format)
	+	if (! (opts.output_format & DIFF_FORMAT_MASK))
			opts.output_format |=3D DIFF_FORMAT_PATCH

if we ever gain a new "output_format" bit that does not affect how
we show the diff in a major way, and that is on by default?  If so,
I think "|=3D" is more future-proof.  Otherwise, "=3D" is indeed more
clear way to spell the intention.









