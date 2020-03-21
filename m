Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA7AC4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 04:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D021E20732
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 04:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LhYo2JnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgCUExZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 00:53:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52201 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCUExZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 00:53:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63D194441B;
        Sat, 21 Mar 2020 00:53:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gs5YF1iXKLDf9mBEERGANtGGrPY=; b=LhYo2J
        nYRhTMhsjAOLfMGyK9acGkS+r6rnLIOgnHZwwTWKyY6dZyxbJ1hkSUI9QVL4vWeD
        bfAalFRI0RGS1DJvIYhb5pGrZa7bJ+gdd4TFC/EeVPze/do+7tfB17W3ZTtPhFtl
        5FNnfgHXt44H2xAhQeXfRXvxfeUOmUvfbqaww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gx6aYi3ejpo02AEbQTqUNL5Od76ND2TT
        7D2mjwIG/fLemHcqVV2YC1s5mhc1KGiZ+9QaPPlnhgk/Mfv11bKKeG8NTNHibSUE
        ugv/powlSGNpJIJUZb4KEXJJMsPsDi8dx7N4P3vP1sIOzEVOCKRm9VLTRvktktaX
        a2aqMlezXec=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BCFA4441A;
        Sat, 21 Mar 2020 00:53:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACDDE44415;
        Sat, 21 Mar 2020 00:53:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: allow short options to be stacked
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
Date:   Fri, 20 Mar 2020 21:53:21 -0700
In-Reply-To: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Sat, 21 Mar 2020 00:07:05 -0300")
Message-ID: <xmqqsgi29um6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3C58E82-6B2F-11EA-8F0F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> +parse_option () {
> +	local opt="$@"

I do not think there is any context in which var="$@" makes sense in
shell script (var="$*" is understandable, though).  

Did you mean opt=$1 here?

> +# Parse options while taking care to leave $@ intact, so we will still
> +# have all the original command line options when executing the test
> +# script again for '--tee' and '--verbose-log' below.

The phrase "below" no longer makes much sense after moving lines
around, does it?

> +store_arg_to=
> +prev_opt=
> +for opt
> +do
> +	if test -n "$store_arg_to"
> +	then
> +		eval $store_arg_to=\$opt
> +		store_arg_to=
> +		prev_opt=
> +		continue
> +	fi
> +
> +	case "$opt" in
> +	--*)
> +		parse_option "$opt" ;;
> +	-?*)
> +		# stacked short options must be fed separately to parse_option

Are you calling concatenated short options, e.g. "-abc", as
"stacked"?  It sounds like a very unusual phrasing, at least to me.

> +		for c in $(echo "${opt#-}" | sed 's/./& /g')
> +		do
> +			parse_option "-$c"
> +		done
> +		;;
> +	*)
> +		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
> +	esac
>  
>  	prev_opt=$opt
>  done

I am personally not very enthused (the line counts vs benefit does
not feel so great), but as long as it works correctly and
maintainable, I won't complain too much.
