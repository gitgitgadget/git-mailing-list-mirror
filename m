Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85121F731
	for <e@80x24.org>; Thu,  8 Aug 2019 17:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404264AbfHHRWU (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 13:22:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62228 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHRWU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 13:22:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BB9916B492;
        Thu,  8 Aug 2019 13:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JmOrnC5G1VFZz40YDQjYqXvHLn8=; b=LLHl7v
        +a4ZpWpt4gw2SPPjba+iz/H8OVVuAU1Djit8PjAyBUbrhHc4sGEQyWMDfAXk9wIM
        6LrBrQ+8WY6/7g+YYsFnrKcXPvrxzGpaK3Z43brtjOvP5sfzEN78hegnTRGbZ+Dq
        g9sJLCkTDVBGU6nOtdWt9rVCSQq2Z4ZOtJO+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NHcrcgXPSozqBT+hZ3mkf2ejuV34UQSB
        aE36My48/YUzpNe8WKlmV4+yj0N9DU75JhOeW6AQ9zvF8Mr8amcKTXYZu7Qe8oDL
        VI3wok42l2n/WEO7cDAMQg/G326tP1UOcidq1LdTb9U1ROpQ24/MskAC9jAME+04
        Mnk2/q2bbLo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 437EE16B490;
        Thu,  8 Aug 2019 13:22:18 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E73F16B48F;
        Thu,  8 Aug 2019 13:22:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH bc/hash-independent-tests-part-4] t: decrease nesting in test_oid_to_path
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
        <20190628225928.622372-2-sandals@crustytoothpaste.net>
        <20190808065614.GA209195@google.com>
        <20190808093732.GA12257@sigill.intra.peff.net>
Date:   Thu, 08 Aug 2019 10:22:16 -0700
In-Reply-To: <20190808093732.GA12257@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 8 Aug 2019 05:37:33 -0400")
Message-ID: <xmqqo90zfu7r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 123F2B1E-BA01-11E9-810C-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 07, 2019 at 11:56:14PM -0700, Jonathan Nieder wrote:
>
>> But a dash bug[*] causes it to instead expand to
>> 
>> 	/3456789...
>> 
>> The stream of symbols that makes up this function is hard for humans
>> to follow, too.  The complexity mostly comes from the repeated use of
>> the expression ${1#??} for the basename of the loose object.
>
> Yeah, both seem like good reasons to change this (and the patch looks
> good to me).

Good spottig.  Thanks.

> +# Check whether the shell supports the "local" keyword. "local" is not
> +# POSIX-standard, but it is very widely supported by POSIX-compliant
> +# shells, and we rely on it within Git's test framework.
> +#
> +# If your shell fails this test, the results of other tests may be
> +# unreliable. You may wish to report the problem to the Git mailing
> +# list <git@vger.kernel.org>, as it could cause us to reconsider
> +# relying on "local".
>  test_expect_success 'verify that the running shell supports "local"' '
>  	x="notlocal" &&
>  	echo "local" >expected1 &&

Updated text reads well.  Leaving the test in is still a very good
idea.

Thanks.
