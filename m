Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748A820986
	for <e@80x24.org>; Tue, 27 Sep 2016 17:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933939AbcI0RgG (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 13:36:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51891 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755483AbcI0RgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 13:36:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7913E3FB9B;
        Tue, 27 Sep 2016 13:36:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TvG+Y/CNSSaHCdc9WrJOTiZT7Q0=; b=rAEe0z
        aCCaCngjS7QX9d24QadiPhux6S3X8/8JP+eZ+b7SNTm4muh/13lSw35pcBjMHDll
        MJ7z8vrWVZOf71te+KgKZxIGubo/dDEdnZmuHyp5tEvVgY5okIoC2wWGlw9i2r0c
        VgysroVf33brnfeMLudBnBkKHutSv0FfgGyHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p3kMx0Zpu7PuxXrHjRaFar5djZ8HyoYF
        gVsa1INSU0xtsx34+8AGPwIgShlsolIVaApG+NLV9Zb5Op2rjpkfMAADWz+jAa/P
        FFJ0RwGWY+tAHRp/nUxV7vudskDotun1tE/oNM54WmPFQjuWdhr1kDqDqY1mtcMK
        Bruzbp1Dgdg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 711B83FB99;
        Tue, 27 Sep 2016 13:36:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB75C3FB98;
        Tue, 27 Sep 2016 13:36:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>
Subject: Re: [PATCH v2 2/5] ref-filter: add function to print single ref_array_item
References: <20160926224233.32702-1-santiago@nyu.edu>
        <20160926224233.32702-3-santiago@nyu.edu>
Date:   Tue, 27 Sep 2016 10:35:59 -0700
In-Reply-To: <20160926224233.32702-3-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Mon, 26 Sep 2016 18:42:30 -0400")
Message-ID: <xmqqfuolp7nk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC01C5BC-84D8-11E6-839C-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> From: Lukas P <luk.puehringer@gmail.com>
>
> ref-filter functions are useful for printing git object information
> using a format specifier. However, some other modules may not want to use
> this functionality on a ref-array but only print a single item.
>
> Expose a format_ref function to create, pretty print and free individual
> ref-items.
>
> Signed-off-by: Lukas P <luk.puehringer@gmail.com>
> ---
> +void format_ref(const char *name, const unsigned char *sha1, const char *format,
> +		unsigned kind)
> +{
> +	struct ref_array_item *ref_item;
> +	ref_item = new_ref_array_item(name, sha1, 0);
> +	ref_item->kind = kind;
> +	show_ref_array_item(ref_item, format, 0);
> +	free_array_item(ref_item);
> +}
> +
>  /*  If no sorting option is given, use refname to sort as default */
>  struct ref_sorting *ref_default_sorting(void)
>  {
> diff --git a/ref-filter.h b/ref-filter.h
> index 14d435e..1ef7999 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -107,4 +107,8 @@ struct ref_sorting *ref_default_sorting(void);
>  /*  Function to parse --merged and --no-merged options */
>  int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
>  
> +/* Pretty-print a single ref */
> +void format_ref(const char *name, const unsigned char *sha1, const char *format,
> +		unsigned kind);

The fact that you felt a need for comment before its name is a
strong sign that the name is not sufficiently descriptive and
understandable for readers to tell what the function is for.

Would pretty_print_ref() or show_ref_pretty() better names, perhaps?

