Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A88C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37DE20735
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZOI1bDjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHUTRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:17:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60262 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgHUTRn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 15:17:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31EA0E3C6E;
        Fri, 21 Aug 2020 15:17:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xOpuzMX3ATrIVbbNX3ZW2Pi1y5s=; b=ZOI1bD
        jCC0E6H7UjZhZjaCy8HAetfp2gEYRNVlVab2lmiSQj/QFv5JngcSvUYlY/IkTTKy
        dIArNqPjdUkcEFgA9Yv+6g/2k6KBAjE7ElclYKFs6mQk9ROwdNFi5PpP9goKvQKU
        34ANrQkunkdFkxMHcX41oIfCtNP09BB0a74iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JHb8sOhyCR/FEATkKNc96F/sfVxAh/fp
        pVoixgYqQAxyUXcM9wz8lm9A1b+jPXmQZHFALfwIBE91jytp8pzR7/jDKlK7QCkR
        FscAnZ2d2+s04wDHe/n5DKdOAHHr1BwUKRZ/TRURfa+h69FpevG2ju9rh3/S5xX8
        c7pCr68GZkE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A937E3C6D;
        Fri, 21 Aug 2020 15:17:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F249E3C6B;
        Fri, 21 Aug 2020 15:17:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: 'contents:trailers' show error if `:` is missing
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
        <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
        <39aa46bce700cc9a4ca49f38922e3a7ebf14a52c.1598004663.git.gitgitgadget@gmail.com>
        <CAPig+cRxCvHG70Nd00zBxYFuecu6+Z6uDP8ooN3rx9vPagoYBA@mail.gmail.com>
Date:   Fri, 21 Aug 2020 12:17:36 -0700
In-Reply-To: <CAPig+cRxCvHG70Nd00zBxYFuecu6+Z6uDP8ooN3rx9vPagoYBA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 21 Aug 2020 12:56:56 -0400")
Message-ID: <xmqqeenz95bj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA007636-E3E2-11EA-9A4D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> ...an alternative would have been something like:
>
>     else if (!strcmp(arg, "trailers")) {
>         if (trailers_atom_parser(format, atom, NULL, err))
>             return -1;
>     } else if (skip_prefix(arg, "trailers:", &arg)) {
>         if (trailers_atom_parser(format, atom, arg, err))
>             return -1;
>     }
>
> which is quite simple to reason about (though has the cost of a tiny
> bit of duplication).

Yeah, that looks quite simple and straight-forward.

>> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
>> @@ -823,6 +823,15 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
>> +test_expect_success 'if arguments, %(contents:trailers) shows error if semicolon is missing' '
>
> s/semicolon/colon/

Definitely.

>
>> +       # error message cannot be checked under i18n
>
> What is this comment about? I realize that you copied it from other
> nearby tests, but I find that it muddies rather than clarifies.

Yup.  If a patch changes test_cmp with test_i18ncmp, the above
message belongs to its commit log message, but it is overkill to
have it as an in-line comment in every place where test_i18ncmp gets
used.

Thanks for a review.

>> +       cat >expect <<-EOF &&
>> +       fatal: unrecognized %(contents) argument: trailersonly
>> +       EOF
>> +       test_must_fail git for-each-ref --format="%(contents:trailersonly)" 2>actual &&
>> +       test_i18ncmp expect actual
>> +'
