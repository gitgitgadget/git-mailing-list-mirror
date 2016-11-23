Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9361FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 17:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756998AbcKWRV3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 12:21:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57584 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756301AbcKWRV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 12:21:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 809D44BBB9;
        Wed, 23 Nov 2016 12:21:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h6KB2yVHy5bnxYrPcCpKWy9npW8=; b=fcbSqQ
        28Xt9oRDatPAvdNCE6En1NS/u7vjZv0lvXX46hX79ZA72rjqDV/BbEiiHjnNvSQo
        Wzbaohkkom0CILj0LH3UwTOPBwyMIw+2qLWrJPPXPIfC6VYTNlEvGuyJ31CeOQQv
        VlzSGX/dBEJ7o78VrsVgtHXAbyO0qzlWM6G3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W4wCvN9nClp3du6amfPq8PROVRJIeQFh
        sPDaSFXdpGgCcWYWDHywqBc9QS4zLnTE6Ax0LqMe9bmYctCRBJwMYN8Yf0PT249b
        iJZJWtDaz85wjvmHG0RpVL9Hc+Q3eiKl3sr/qbVWWhYn+xEbK18hL8C7G/vHHqz1
        wdUB+T2MC9A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 788BB4BBB8;
        Wed, 23 Nov 2016 12:21:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4B6B4BBB7;
        Wed, 23 Nov 2016 12:21:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] merge-recursive.c: use QSORT macro
References: <20161122123019.7169-1-pclouds@gmail.com>
        <20161122174946.jy5at4g7rifu3und@sigill.intra.peff.net>
Date:   Wed, 23 Nov 2016 09:21:25 -0800
In-Reply-To: <20161122174946.jy5at4g7rifu3und@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 22 Nov 2016 12:49:46 -0500")
Message-ID: <xmqqpolmm7sa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43F79A62-B1A1-11E6-8DD3-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Another possibility is:
>
>   df_sorted_entries.cmp = string_list_df_name_compare;
>   string_list_sort(&df_sorted_entries);
>
> It's not any shorter, but maybe it's conceptually simpler.

My first reaction to Duy's patch was: it is moronic for the
string-list API not to offer "I've done _append() to add many items
while avoiding the overhead of doing insertion sort all the time;
now I finished adding and I want the result sorted".

And then I looked at string-list.h and there it was ;-)

