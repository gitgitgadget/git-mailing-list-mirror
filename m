Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379CCC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6C92087E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KYslefOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390564AbgJLUAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:00:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58070 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388844AbgJLUAb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:00:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45BE1F86B1;
        Mon, 12 Oct 2020 16:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CU5gFnJ3uOcx
        m1BI1uLOt9Owh24=; b=KYslefOzfPA+gYECnjIvgcY0cX7Htfh1fmjwXOqFpx38
        UNXokKdmR3lfacK7lf6iT5yjhAxSIcZKn0eWnrrx21hgve1W7MkYXIYyJQRMo7gC
        iNilnNiL7LJXZr9goO1XcTHXQEIAQnrfdN3wOIO+CS5N8NsqzEKkvRWnloWCxKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wfkiap
        g59H0dzrEOyt/R9smwYsZkWOyRgK/iG9I5Vg9l7uQ43De/D2O7c/GC9eIQGm9bs/
        AJsYDmIAEcmKffvopad0eYiIkUBE0CYyP9Xuw9O/jQwD28doRv22+RpO9HVUv+SV
        cvbargUMyK54HT+iS1jAdwQp9y0fpmrgL10U0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E52EF86B0;
        Mon, 12 Oct 2020 16:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8CE3BF86AE;
        Mon, 12 Oct 2020 16:00:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching changes
References: <20201001120606.25773-1-michal@isc.org>
        <20201012091751.19594-1-michal@isc.org>
        <20201012091751.19594-3-michal@isc.org>
        <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet>
Date:   Mon, 12 Oct 2020 13:00:23 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 12 Oct 2020 13:20:13 +0200 (CEST)")
Message-ID: <xmqqo8l7nrjc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9102A1FC-0CC5-11EB-AB3B-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Micha=C5=82,
>
> On Mon, 12 Oct 2020, Micha=C5=82 K=C4=99pie=C5=84 wrote:
>
>> @@ -5203,6 +5207,22 @@ static int diff_opt_patience(const struct optio=
n *opt,
>>  	return 0;
>>  }
>>
>> +static int diff_opt_ignore_regex(const struct option *opt,
>> +				 const char *arg, int unset)
>> +{
>> +	struct diff_options *options =3D opt->value;
>> +	regex_t *regex;
>> +
>> +	BUG_ON_OPT_NEG(unset);
>> +	regex =3D xcalloc(1, sizeof(*regex));
>> +	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE))
>> +		die("invalid regex: %s", arg);
>> +	ALLOC_GROW(options->ignore_regex, options->ignore_regex_nr + 1,
>> +		   options->ignore_regex_alloc);
>> +	options->ignore_regex[options->ignore_regex_nr++] =3D regex;
>
> A slightly more elegant way would be to have `ignore_regex` have the ty=
pe
> `regex_t *` and use `ALLOC_GROW_BY()` (which zeroes the newly-added
> elements automagically).

It may be "elegant", but we we know if it is "correct" on
everybody's implementation of regex_t?

A struct like

	struct foo {
		char *str;
		char in_place_buffer[10];
	};

where str points at in_place_buffer[] only when it needs to point at
a very short string, and points at an allocated memory on heap, can
not be safely copied and used, and an array of such a struct breaks
when ALLOC_GROW_BY() needs to call realloc().  Keeping an array of
pointers to regex_t and growing it would not break even for such a
structure type.

Since we cannot rely on the implementation detail of regex_t on a
single platform, I'd rather not to see anybody suggest such an
"elegant" approach.

Thanks.
