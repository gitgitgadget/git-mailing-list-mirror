Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8811F454
	for <e@80x24.org>; Fri,  8 Nov 2019 03:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfKHDYU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 22:24:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59355 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfKHDYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 22:24:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDAC396DC0;
        Thu,  7 Nov 2019 22:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jQBVS7Qp1lh9lntOMIGkteSaJos=; b=ulcoOm
        tRs09Xl/ckj4QmYSRikp8WQ7ezYG3i9nUzk4JIEwhyPjv0rSCYWTY1tQBsQHAEYW
        cl8GMxE6USh94IjM7mM/9Tc0D263hwSO9ljxhHbKE8IHKjvITmkl/iWd6aIX6Qhw
        QbibhjtUD6IiUyi8a4FeGwsfvn7auvaPNgZjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rwoV8DQ1C6tFvhqB+EHist0XzlxTFAMc
        s6su6bcaAPvcHsUMpLts3iIHHB+U35rY195jghtv2gJd/MmjvR+WvbdEJhW+Bwkm
        PRrYBElBsLbxkaUO70xnMMgywelEPJdEoE0gp/0pvGxWO68YnLCpmV4FTiWaG/gt
        63GI3hi5/4k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D86A696DBF;
        Thu,  7 Nov 2019 22:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 128F796DBC;
        Thu,  7 Nov 2019 22:24:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 01/14] t: teach test_cmp_rev to accept ! for not-equals
References: <cover.1571739459.git.liu.denton@gmail.com>
        <cover.1573152598.git.liu.denton@gmail.com>
        <0d0696f310a6f8e13ed480b1a1e91cdc2debaa20.1573152599.git.liu.denton@gmail.com>
Date:   Fri, 08 Nov 2019 12:24:12 +0900
In-Reply-To: <0d0696f310a6f8e13ed480b1a1e91cdc2debaa20.1573152599.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 7 Nov 2019 10:51:19 -0800")
Message-ID: <xmqqpni3nj8j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D941E6E-01D7-11EA-AE35-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Currently, in the case where we are using test_cmp_rev() to report
> not-equals, we write `! test_cmp_rev`. However, since test_cmp_rev()
> contains
>
> 	r1=$(git rev-parse --verify "$1") &&
> 	r2=$(git rev-parse --verify "$2") &&
>
> In the case where `git rev-parse` segfaults and dies unexpectedly, the
> failure will be ignored.

Good justification.  The last two lines are continuation of the
sentence that begins the proposed log message, so downcase "In" at
the beginning of the line.  Also, when we present the problem to be
solved at the beginning, it is customary to describe the status quo,
and "Currently, " is a noiseword that does not add much information,
so drop it.

> Rewrite test_cmp_rev() to optionally accept "!" as the first argument to
> do a not-equals comparison. Rewrite `! test_cmp_rev` to `test_cmp_rev !`
> in all tests to take advantage of this new functionality.

Good.

> -# Tests that its two parameters refer to the same revision
> +# Tests that its two parameters refer to the same revision, or if '!' is
> +# provided first, that its other two parameters refer to different
> +# revisions.

OK.

>  test_cmp_rev () {
> +	local inverted_op
> +	inverted_op='!='
> +	if test $# -ge 1 && test "x$1" = 'x!'
> +	then
> +	    inverted_op='='
> +	    shift
> +	fi

I'd rather avoid having to keep track of negation to reduce mental
burden.  How about using = by default and != when '!' was given
(which would be more natural to readers) and call it $op, and say
"if ! test $r1 $op $r2" where it is used?


>  	if test $# != 2
>  	then
>  		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
>  	else
>  		local r1 r2
>  		r1=$(git rev-parse --verify "$1") &&
>  		r2=$(git rev-parse --verify "$2") &&

If either of the calls fail, the assignment itself would fail, and
the &&-cascade would stop without executing the if statment below.

I see the "!" feature, but where is the promised "fix" for
segfaulting rev-parse?

Puzzled.


> -		if test "$r1" != "$r2"
> +		if test "$r1" "$inverted_op" "$r2"
>  		then
> +			local comp_out
> +			if "x$inverted_op" = 'x='
> +			then
> +				comp_out='the same'
> +			else
> +				comp_out='different'
> +			fi
>  			cat >&4 <<-EOF
> -			error: two revisions point to different objects:
> +			error: two revisions point to $comp_out objects:
>  			  '$1': $r1
>  			  '$2': $r2
>  			EOF
>  			return 1
>  		fi
>  	fi
>  }
