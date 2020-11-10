Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E80DC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 20:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22F520665
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 20:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WiEqoH2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgKJUv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:51:27 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50349 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJUv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 15:51:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B4B610EB3C;
        Tue, 10 Nov 2020 15:51:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y5duRxN8YQ8Sq5O8yHQrqgWbUHo=; b=WiEqoH
        2vu7LrGjjkI0kCIxevHZ04i+VaFEPTRDQ8wNoqA+TZPWKzy2IHPQEhx6itYILxTf
        LCt9Yi5riGo78viXuAdgfoYl8q+TA8F/5mhwwzlsWTIpuwsFo1MvBsfcq1Dki7Sg
        MBKCGfAGNmT8Zs+7hm5DYFOQ113PG91FwRUIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lf62e0OTSgj3OmjWWKSQrFahiGWdMLZ6
        l2bHlKFv8i4ho6ASy3HmsyuDrsaiqOUwTbM3doPxOondcGhZRabjWMcquyX59/AW
        HYcIxTM7+tI+JU9nEHxgRuvG3g5F+N0Y7PR3aupZqu78ihmIg/uGHZy9DEt8crPf
        u+gn1PNbSQc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83B2710EB3B;
        Tue, 10 Nov 2020 15:51:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C804310EB12;
        Tue, 10 Nov 2020 15:51:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 1/2] t5411: refactor
 make_user_friendly_and_stable_output
References: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
        <20201110120135.42025-1-zhiyou.jx@alibaba-inc.com>
Date:   Tue, 10 Nov 2020 12:51:22 -0800
In-Reply-To: <20201110120135.42025-1-zhiyou.jx@alibaba-inc.com> (Jiang Xin's
        message of "Tue, 10 Nov 2020 20:01:34 +0800")
Message-ID: <xmqq7dqt6ilx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E711A54-2396-11EB-9D28-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
> index 521a347710..b7cca2d8fb 100644
> --- a/t/t5411/common-functions.sh
> +++ b/t/t5411/common-functions.sh
> @@ -42,7 +42,7 @@ create_commits_in () {
>  make_user_friendly_and_stable_output () {
>  	sed \
>  		-e "s/  *\$//" \
> -		-e "s/   */ /g" \
> +		-e "s/  */ /g" \
>  		-e "s/'/\"/g" \
>  		-e "s/	/    /g" \
>  		-e "s/$A/<COMMIT-A>/g" \
> @@ -52,5 +52,11 @@ make_user_friendly_and_stable_output () {
>  		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
>  		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
>  		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#" \
> -		-e "/^error: / d"
> +		-e "/^error: / d" | \
> +	if test $# -eq 0
> +	then
> +		cat
> +	else
> +		sed ${1+"$@"}
> +	fi
>  }

I may have suggested it, but looking at this implementation I'd have
to say it is not worth the extra process here.  The only reason why
I made the suggestion was that way we can make the single "sed"
invocation to do what we want.

If you need custom output for just two tests in 5411-0000, define
the custom one that wraps make_user_friendly_and_stable_output in
that single script like so:

    filter_out_remote_messages () {
	make_user_friendly_and_stable_output |
	sed -n -e ...
    }

and then use that ...


> diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
> index 2b04b49367..b3af3f59b0 100644
> --- a/t/t5411/test-0000-standard-git-push.sh
> +++ b/t/t5411/test-0000-standard-git-push.sh
> @@ -36,11 +36,10 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
>  		main \
>  		$B:refs/heads/next \
>  		>out 2>&1 &&
> -	make_user_friendly_and_stable_output <out |
> -		sed -n \
> -			-e "/^To / { s/   */ /g; p; }" \
> -			-e "/^ ! / { s/   */ /g; p; }" \
> -			>actual &&
> +	make_user_friendly_and_stable_output -n \
> +		-e "/^To / { p; }" \
> +		-e "/^ ! / { p; }" \
> +		<out >actual &&

... perhaps like

	filter_out_remote_messages <out >actual &&	

here?

> diff --git a/t/t5411/test-0001-standard-git-push--porcelain.sh b/t/t5411/test-0001-standard-git-push--porcelain.sh
> index 747307f8da..16ff2d5666 100644
> --- a/t/t5411/test-0001-standard-git-push--porcelain.sh
> +++ b/t/t5411/test-0001-standard-git-push--porcelain.sh
> @@ -37,16 +37,15 @@ test_expect_success "git-push --atomic ($PROTOCOL/porcelain)" '
>  		main \
>  		$B:refs/heads/next \
>  		>out 2>&1 &&
> -	make_user_friendly_and_stable_output <out |
> -		sed -n \
> -			-e "s/^# GETTEXT POISON #//" \
> -			-e "/^To / { s/   */ /g; p; }" \
> -			-e "/^! / { s/   */ /g; p; }" \
> -			>actual &&
> +	make_user_friendly_and_stable_output -n \
> +		-e "s/^# GETTEXT POISON #//" \
> +		-e "/^To / { p; }" \
> +		-e "/^! / { p; }" \
> +		<out >actual &&
>  	cat >expect <<-EOF &&
>  	To <URL/of/upstream.git>
> -	! refs/heads/main:refs/heads/main [rejected] (non-fast-forward)
> -	! <COMMIT-B>:refs/heads/next [rejected] (atomic push failed)
> +	!    refs/heads/main:refs/heads/main    [rejected] (non-fast-forward)
> +	!    <COMMIT-B>:refs/heads/next    [rejected] (atomic push failed)
>  	EOF
>  	test_cmp expect actual &&
>  	git -C "$upstream" show-ref >out &&
