Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7580AC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E1220777
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 20:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jfCz6s5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgCUUHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 16:07:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56894 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgCUUHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 16:07:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49660BF540;
        Sat, 21 Mar 2020 16:07:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s7+kY39S5Q4v06O0m1XiKxFEz4k=; b=jfCz6s
        5yEsJ7vIxScP3IL+EzepdCTFTYNarP7Dve+YcWia28dFvFskXL9R3rwX1ACA4S9J
        GhNgBM+WJyNH9pCMd61dyhIG0kHup6NH6cd2Fgcmvoi//4zJ+8/uhqjvauiz0j1P
        AffI2QM7k0EPuHTuOVfHtKBAiTWv5H76Y8QWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RzbJ2ZtSz6KLR6S4mRDaVBgH4GlWdmfY
        5hs5LrAog67+6IZKz5Nc2IW38P/xXAGIkpCHIkAQZ5583byNB3WnrTrR1nPxG1Rl
        dyd0dsJB7Sb1oaWyZbkPRiuTxXui0Wxub7tk1FaYh8Tu4Xe339TPSgWt6LXspAfr
        WUDG1AxBMXU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 406EEBF53F;
        Sat, 21 Mar 2020 16:07:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86856BF53C;
        Sat, 21 Mar 2020 16:07:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Johannes.Schindelin@gmx.de, j6t@kdbg.org, peff@peff.net
Subject: Re: [PATCH v2] test-lib: allow short options to be bundled
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
        <7a6a8197dcd58e8690892d03cb904dd1eec5d7c1.1584818457.git.matheus.bernardino@usp.br>
Date:   Sat, 21 Mar 2020 13:07:39 -0700
In-Reply-To: <7a6a8197dcd58e8690892d03cb904dd1eec5d7c1.1584818457.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Sat, 21 Mar 2020 16:57:31 -0300")
Message-ID: <xmqqtv2h8oac.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EC980B0-6BAF-11EA-BC48-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> - Added a check for bundles containing more than one "option that
>   requires args" (e.g. '-rr'), in which case we error-out. We could
>   interpret '-rr 1 2' as 'run tests 1 _and_ 2', but the unbundled
>   format, '-r 1 -r 2', is not currently interpreted like that (the last
>   just overrides the previous). So, for simplicity, let's only forbid
>   such bundles for now.

Makes sense.  I think this is the best we can do at this moment.

> +opt_required_arg=
> +# $1: option string
> +# $2: name of the var where the arg will be stored
> +mark_option_requires_arg ()
> +{

"{" on the same line, just like you did for parse_option below.

> +	if test -n "$opt_required_arg"
>  	then
> +		echo "error: options that require args cannot be bundled" \
> +			"together: '$opt_required_arg' and '$1'" >&2
> +		exit 1
>  	fi
> +	opt_required_arg=$1
> +	store_arg_to=$2
> +}
> +
> +parse_option () {
> +	local opt="$1"
> ...
> +	case "$opt" in
> +	--*)
> +		parse_option "$opt" ;;

I think J6t's suggestion to the previous round still has merit here.

> +	-?*)
> +		# bundled short options must be fed separately to parse_option
> +		opt=${opt#-}
> +		while test -n "$opt"
> +		do
> +			extra=${opt#?}

Take the rest of the string after stripping the first one in $extra ...

> +			this=${opt%$extra}

... and then strip that tail part from the end, which would give the
first letter in $this.

> +			opt=$extra

And the next round will use the remainder after taking $this out
of the bundled options from the front.

Makes sense.

> +			parse_option "-$this"
> +		done

Thanks
