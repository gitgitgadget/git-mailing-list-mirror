Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD932C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 04:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8015860232
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 04:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhJXEeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 00:34:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61139 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhJXEeU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 00:34:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A44E61006A7;
        Sun, 24 Oct 2021 00:31:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wr5h9VAss1ZLiK/8L38oC3auLlG1jIpHUKFCXz
        MgQ0k=; b=UDU2LEVcXNigrl3f22CGD0wmDNLVNisYmCWbCa2b1mVsgQf7GiG4XX
        vZavbRZlmKLnye/3XcZYtdfrfhDIRWFSWPDE3IaHHO7/6/V/rLuCOAvpQq3X5+ub
        CkZ8RkWO8GvKrSK6563z0dTNYNguYvO0x6/6Z1aYc945cwOZgz6eA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CCBC1006A6;
        Sun, 24 Oct 2021 00:31:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D7E81006A5;
        Sun, 24 Oct 2021 00:31:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/3] pretty.c: rename describe options variable to more
 descriptive name
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
        <20211024014256.3569322-2-eschwartz@archlinux.org>
Date:   Sat, 23 Oct 2021 21:31:57 -0700
In-Reply-To: <20211024014256.3569322-2-eschwartz@archlinux.org> (Eli
        Schwartz's message of "Sat, 23 Oct 2021 21:42:54 -0400")
Message-ID: <xmqqv91n6o1u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53AAE9CC-3483-11EC-A971-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Schwartz <eschwartz@archlinux.org> writes:

> It contains option arguments, not options. We would like to add option
> support here too.
>
> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
> ---
>  pretty.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index 73b5ead509..9db2c65538 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1216,7 +1216,7 @@ int format_set_trailers_options(struct process_trailer_options *opts,
>  
>  static size_t parse_describe_args(const char *start, struct strvec *args)
>  {
> -	const char *options[] = { "match", "exclude" };
> +	const char *option_arguments[] = { "match", "exclude" };

This renaming is more or less "Meh" without the other change in the
series that may (or may not) be helped with this step, but because I
haven't seen these later steps yet, I may sound too dismissive of
the change in this step.

Anyway, at least call that option_args[] to match the way the
function calls itself, not option_arguments[] that is a mouthful for
a mere implementation detail of local variable for a file-private
helper function.

Thanks.

>  	const char *arg = start;
>  
>  	for (;;) {
> @@ -1225,10 +1225,10 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
>  		size_t arglen = 0;
>  		int i;
>  
> -		for (i = 0; i < ARRAY_SIZE(options); i++) {
> -			if (match_placeholder_arg_value(arg, options[i], &arg,
> +		for (i = 0; i < ARRAY_SIZE(option_arguments); i++) {
> +			if (match_placeholder_arg_value(arg, option_arguments[i], &arg,
>  							&argval, &arglen)) {
> -				matched = options[i];
> +				matched = option_arguments[i];
>  				break;
>  			}
>  		}
