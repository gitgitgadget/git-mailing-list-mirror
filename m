Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF461F731
	for <e@80x24.org>; Thu,  8 Aug 2019 18:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbfHHSGD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 14:06:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56886 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbfHHSGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 14:06:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFCB46EDD3;
        Thu,  8 Aug 2019 14:06:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Qk1DgtOUVMAePNPMM/8l+iE0WY=; b=ttFfVd
        lJ6BTgwR0lHWyqkApf3quDa5jxAyNuL8R01YwMcgvEgDbQO2vMtk4zQgUEAeyDak
        LGCOE7Enj9NTjWJav8PZPT8f07lpDa39RsTNDC7PXzmMvf0KDcdOOBw2Sn2fwGy0
        CcWNvn8UUEePjNPwlmqAPtAL7ZyR41R0JykuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xoRLMX+9O/Tlk8YtGYIAIQ7RBmdYicXA
        Pkq8u4nD8iuisZ1xiE2mzgeGC4SyMbHv7wp1FiJV0P9dDcjOlCIo6D9QnvCSeG5T
        nmbZ+5XwsuiVssLMwtlwRlLQKMp7qHummqM31hHhLDyoBTIaAS2IvlRKgmm/oSt9
        cAJAhi70kSA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7B236EDD2;
        Thu,  8 Aug 2019 14:06:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C44086EDCC;
        Thu,  8 Aug 2019 14:05:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 5/7] quote: add sq_quote_argv_pretty_ltrim
References: <pull.298.git.gitgitgadget@gmail.com>
        <pull.298.v2.git.gitgitgadget@gmail.com>
        <5059776248b6686faaff37c97aa63d0212579cd8.1565273938.git.gitgitgadget@gmail.com>
Date:   Thu, 08 Aug 2019 11:05:55 -0700
In-Reply-To: <5059776248b6686faaff37c97aa63d0212579cd8.1565273938.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Thu, 08 Aug 2019
        07:19:02 -0700 (PDT)")
Message-ID: <xmqqh86rfs70.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C0E731E-BA07-11E9-85F6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create version of sq_quote_argv_pretty() that does not
> insert a leading space before argv[0].
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  quote.c | 11 +++++++++++
>  quote.h |  1 +
>  2 files changed, 12 insertions(+)

I am OK with the basic idea, but I am somewhat unhappy about this
particular patch for two reasons:

 - If we were to keep this as a part of proper API in the longer
   term, the current sq_quote_argv_pretty() should be rewritten to
   use this to avoid repetition (e.g. as long as !!*argv, add a SP
   and then call this new thing);

 - something_ltrim() sounds as if you munge what is passed to you
   and chop off the left end, but that is not what this does.

Now, what is the right name for this new thing?  What does it do?

It looks to me that it appends each element of argv[], quoting it as
needed, and with SP in between.  So the right name for the family of
these functions should be around "append", which is the primary thing
they do, with "quoted" somewhere.

Having made the primary purpose of the helper clearer leads me to
wonder if "do not add SP before the first element, i.e. argv[0]", is
really what we want.  If we always clear the *dst strbuf before
starting to serialize argv[] into it, then the behaviour would make
sense, but we do not---we are "appending".

As long as we are appending, would we be better off doing something
sillily magical like this instead, I have to wonder?

	void sq_append_strings_quoted(struct strbuf *buf, const char **av)
	{
		int i;

		for (i = 0; av[i]; i++) {
			if (buf->len)
				strbuf_addch(buf, ' ');
			sq_quote_buf_pretty(buf, argv[0]);
		}
	}

That is, "if we are appending to an existing string, have SP to
separate the first element from that existing string; treat the
remaining elements the same way (if the buffer is empty, there is no
point adding SP at the beginning)".

I may have found a long-standing bug in sq_quote_buf_pretty(), by
the way.  What does it produce when *src is an empty string of
length 0?  It does not add anything to dst, but shouldn't we be
adding two single-quotes (i.e. an empty string inside sq pair)?

> diff --git a/quote.c b/quote.c
> index 7f2aa6faa4..7cad8798ac 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -94,6 +94,17 @@ void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
>  	}
>  }
>  
> +void sq_quote_argv_pretty_ltrim(struct strbuf *dst, const char **argv)
> +{
> +	int i;
> +
> +	for (i = 0; argv[i]; i++) {
> +		if (i > 0)
> +			strbuf_addch(dst, ' ');
> +		sq_quote_buf_pretty(dst, argv[i]);
> +	}
> +}
> +
>  static char *sq_dequote_step(char *arg, char **next)
>  {
>  	char *dst = arg;
> diff --git a/quote.h b/quote.h
> index fb08dc085c..3b3d041a61 100644
> --- a/quote.h
> +++ b/quote.h
> @@ -40,6 +40,7 @@ void sq_quotef(struct strbuf *, const char *fmt, ...);
>   */
>  void sq_quote_buf_pretty(struct strbuf *, const char *src);
>  void sq_quote_argv_pretty(struct strbuf *, const char **argv);
> +void sq_quote_argv_pretty_ltrim(struct strbuf *, const char **argv);
>  
>  /* This unwraps what sq_quote() produces in place, but returns
>   * NULL if the input does not look like what sq_quote would have
