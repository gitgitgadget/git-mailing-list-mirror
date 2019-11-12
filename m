Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182FB1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 06:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfKLGwr (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 01:52:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55182 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfKLGwp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 01:52:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E1EF1A5CA;
        Tue, 12 Nov 2019 01:52:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HhJ9z0EF6/AGFpnuzc6GWEfBc4E=; b=Z6gH/X
        fBraMAL3xFefCqdbofT1ugT2y55NlHB373YHLb810WyrkAkbZhNZX/jCv0Jlt6wt
        F18LhGk9JRk25wSC/bp3BbUvJy2sMNmubBYPzvdKTM/s/PeqwwrExBYT4UBT1J+r
        00JU8VWUCthUg+BpVai35gdvZIOX3X76Yhs3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C0+iMqNELGZNc5AZK+1ZsRrtCkZwI/LJ
        dvjz356u/4x4vuwQcujPmXKfZyl/I8nKx1J9UoT7wLiFkKqWRTBYn4CnvhT2jtZj
        NH0Duhic9GAKAHJbfxupGKjvJPHqOffOfvvrFjLHoe6CcrykEVgEm8nr9S5dkhOk
        CaUytg70f0g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 259911A5C8;
        Tue, 12 Nov 2019 01:52:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85C8A1A5C7;
        Tue, 12 Nov 2019 01:52:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 01/14] t: teach test_cmp_rev to accept ! for not-equals
References: <cover.1573152598.git.liu.denton@gmail.com>
        <cover.1573517561.git.liu.denton@gmail.com>
        <3c58df27c4b9f405bfc5c163e36a928a75ce8239.1573517561.git.liu.denton@gmail.com>
Date:   Tue, 12 Nov 2019 15:52:41 +0900
In-Reply-To: <3c58df27c4b9f405bfc5c163e36a928a75ce8239.1573517561.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 11 Nov 2019 16:13:41 -0800")
Message-ID: <xmqq5zjpfux2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06448AC6-0519-11EA-A2EF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +# Tests that its two parameters refer to the same revision, or if '!' is
> +# provided first, that its other two parameters refer to different
> +# revisions.
>  test_cmp_rev () {
> +	local op
> +	op='='
> +	if test $# -ge 1 && test "x$1" = 'x!'
> +	then
> +	    op='!='
> +	    shift
> +	fi

Not that it is all that important, but how about setting up comp_out
up here at the same time?  I.e.


	local op comp_out

	if ...
	then
		op="!=" comp_out="the same"
		shift
	else
		op="=" comp_out=different
	fi

That way, we can lose 7 lines down there, while spending only one
line up here, collecting all the things that conditional on '!' on
the command line in one place.

I would have named the message variable "$wrong_result" or
something, by the way, i.e. "two revisions point to $wrong_result
objects".

Thanks.  Will queue the whole thing.

>  	if test $# != 2
>  	then
>  		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
>  	else
>  		local r1 r2
>  		r1=$(git rev-parse --verify "$1") &&
> -		r2=$(git rev-parse --verify "$2") &&
> -		if test "$r1" != "$r2"
> +		r2=$(git rev-parse --verify "$2") || return 1
> +
> +		if ! test "$r1" "$op" "$r2"
>  		then
> +			local comp_out
> +			if "x$op" = 'x='
> +			then
> +				comp_out='different'
> +			else
> +				comp_out='the same'
> +			fi
>  			cat >&4 <<-EOF
> -			error: two revisions point to different objects:
> +			error: two revisions point to $comp_out objects:
>  			  '$1': $r1
>  			  '$2': $r2
>  			EOF
