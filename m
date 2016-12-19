Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A4E1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbcLSX0I (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:26:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56816 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751499AbcLSX0H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:26:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F614596A7;
        Mon, 19 Dec 2016 18:26:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z+mQBtWUKh6DPRE8N0UmlmgGL4I=; b=HGY9PJ
        pYfDpaOwh5Oz6aOCjeEEwfFOK6Ifn5bibRI3knda3Km7kVpvNm2ZXtHB3ogdFxOg
        VKy9/PuJeB0GavhRRsOpO63FBUiZx0xvu2JVxmYc1Uj4U94gQyXOr5yVX2KchzcP
        9KvXkPENTD8BxO7JIylvrgvjVTZlE5KgKWGvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wSwdekI4o9F2wgnshoF866faqmUUfjgx
        ONuYbWQOW8HiKjoIH8cTdBx5IHvs0Q+IEdC+iHdnPUunMIU3Qr6g+vR7e/lk2fun
        Nq3rzwewn8Krc+cwvQHkkNtQubQrRBIEfTzTw5vx0guevdt2jyYNs9oZ/hq98trS
        tPBkAAWuA6o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97C57596A6;
        Mon, 19 Dec 2016 18:26:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17474596A5;
        Mon, 19 Dec 2016 18:26:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] mailinfo.c: move side-effects outside of assert
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
        <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
        <A916CED6-C49D-41D8-A7EE-A5FEDA641F4A@gmail.com>
        <d5690ac7-ff62-99b9-7e7e-929bd7f0433b@google.com>
        <xmqqbmw7ocoz.fsf@gitster.mtv.corp.google.com>
        <ebaf4c892a78bc3ae614a23d87f9c0f@58437222ff6db9ee7cbe9d1a5a1ad4e>
Date:   Mon, 19 Dec 2016 15:26:03 -0800
In-Reply-To: <ebaf4c892a78bc3ae614a23d87f9c0f@58437222ff6db9ee7cbe9d1a5a1ad4e>
        (Kyle J. McKay's message of "Mon, 19 Dec 2016 15:13:00 -0800")
Message-ID: <xmqqbmw7mrg4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 831B2B90-C642-11E6-A2EB-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyle J. McKay" <mackyle@gmail.com> writes:

>> OK.  So we do not expect it to fail, but we still do want the side
>> effect of that function (i.e. accmulation into the field).
>>
>> Somebody care to send a final "agreed-upon" version?
>
> Yup, here it is:

Thanks.

> -- 8< --
>
> Since 6b4b013f18 (mailinfo: handle in-body header continuations,
> 2016-09-20, v2.11.0) mailinfo.c has contained new code with an
> assert of the form:
>
> 	assert(call_a_function(...))
>
> The function in question, check_header, has side effects.  This
> means that when NDEBUG is defined during a release build the
> function call is omitted entirely, the side effects do not
> take place and tests (fortunately) start failing.
>
> Move the function call outside of the assert and assert on
> the result of the function call instead so that the code
> still works properly in a release build and passes the tests.
>
> Since the only time that mi->inbody_header_accum is appended to is
> in check_inbody_header, and appending onto a blank
> mi->inbody_header_accum always happens when is_inbody_header is
> true, this guarantees a prefix that causes check_header to always
> return true.
>
> Therefore replace the assert with an if !check_header + DIE
> combination to reflect this.
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Jeff King <peff@peff.net>
> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>
> Notes:
>     Please include this PATCH in 2.11.x maint
>
>  mailinfo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mailinfo.c b/mailinfo.c
> index 2fb3877e..a489d9d0 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -710,7 +710,8 @@ static void flush_inbody_header_accum(struct mailinfo *mi)
>  {
>  	if (!mi->inbody_header_accum.len)
>  		return;
> -	assert(check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data, 0));
> +	if (!check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data, 0))
> +		die("BUG: inbody_header_accum, if not empty, must always contain a valid in-body header");
>  	strbuf_reset(&mi->inbody_header_accum);
>  }
>  
> ---
