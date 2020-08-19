Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD3BC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F865214F1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dzYgfafZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgHSRbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:31:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60674 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgHSRbi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:31:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C0E2F3FF6;
        Wed, 19 Aug 2020 13:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4cNhEgyy0MM6nfiOHtrYVmbfq0M=; b=dzYgfa
        fZIAo34FxtyeVT9NiVh+0PwB6cFckZm4FVicke3pNlIYk1pSpEECi1+S25obUpD4
        xenLy0/xvBVo/e1wnaZhKhE2UZaYnwB6sQ7lDj69Uw3OGl3tph+kUmFkpQaZ4mS9
        mKQELlOXLGE+N3KLqpn0mWh6mmy8ff+whc1eI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A1uoqmfxjBk/iBT8XCrIBuH1+IEYOPBn
        IarKCG2D2ztrXzSCwCDf2PHn+hbi8D0Ng9H9TeJ1SNuObRa+dX3uJD/ksSyOt0M1
        iOodDBYAPE5M0GaF1JWV1z6pYD6fvHH5PaZa7XJjW+UECKQgFy2D+LWGBeO0+ASt
        dSxfmadD/3Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6D03F3FF5;
        Wed, 19 Aug 2020 13:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 22DCEF3FF3;
        Wed, 19 Aug 2020 13:31:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/2] t6300: unify %(trailers) and %(contents:trailers) tests
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
        <bd0bb8d0ef0936866c2a957e5391424a7481a33c.1597841551.git.gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 10:31:30 -0700
In-Reply-To: <bd0bb8d0ef0936866c2a957e5391424a7481a33c.1597841551.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Wed, 19 Aug 2020 12:52:30
        +0000")
Message-ID: <xmqq1rk2v8y5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D28F4FFC-E241-11EA-B187-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index a83579fbdf..495848c881 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -776,60 +776,39 @@ test_expect_success 'set up trailers for next test' '
>  '
>  
>  test_expect_success '%(trailers:unfold) unfolds trailers' '
> -	git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
>  	{
>  		unfold <trailers
>  		echo
>  	} >expect &&
> +	git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
> +	test_cmp expect actual &&
> +	git for-each-ref --format="%(contents:trailers:unfold)" refs/heads/master >actual &&
>  	test_cmp expect actual
>  '

Hmph, what is this one doing?  Ah, OK, trailers:unfold is tested as
before (just the steps to prepare 'expect' and 'actual' got swapped),
and because the same expectation holds for contents:trailers:unfold,
we can test it at the same.   Makes sense.

>  test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
> -	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
> -	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >reverse &&
> -	test_cmp actual reverse &&
>  	{
>  		grep -v patch.description <trailers | unfold &&
>  		echo
>  	} >expect &&
> +	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
> +	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >reverse &&
> +	test_cmp actual reverse &&
> +	test_cmp expect actual &&

This uses different pattern.  It may be cleaner to test one side at
a time, as we have prepared the 'expect' that should be the same for
both, and compare with the expected pattern one at a time; that would
eliminate the need for 'reverse', too.  I.e.

	{
		grep -v patch.description trailers | unfold && echo
	} >expect &&
	git for-each-ref ... only,unfold ... >actual &&
	test_cmp expect actual &&
	git for-each-ref ... unfold,only ... >actual &&
	test_cmp expect actual &&

> @@ -839,14 +818,7 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
>  	fatal: unknown %(trailers) argument: unsupported
>  	EOF
>  	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
> -	test_i18ncmp expect actual
> -'
> -
> -test_expect_success '%(contents:trailers) rejects unknown trailers arguments' '
> -	# error message cannot be checked under i18n
> -	cat >expect <<-EOF &&
> -	fatal: unknown %(trailers) argument: unsupported
> -	EOF
> +	test_i18ncmp expect actual &&
>  	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
>  	test_i18ncmp expect actual
>  '

Doesn't this highlight a small bug, where an end-user request for an
unknown %(contents:trailers:unsupported) is flagged as an error
about %(trailers)?  Is it OK because we expect that users who use
the longer %(contents:trailers) to know that it is a synonym for
%(trailers) and the latter is the official way to write it?

Thanks.
