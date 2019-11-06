Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D011F454
	for <e@80x24.org>; Wed,  6 Nov 2019 12:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfKFMMJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 07:12:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57549 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfKFMMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 07:12:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32A062EAD8;
        Wed,  6 Nov 2019 07:12:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1P/k18oko/S/
        LVP7kYX1twHp0c8=; b=NcfW3l8LnLCzzcPUHNa7N1gfAixPDOJTftkNlHgHurKs
        CVae1mtqqfGndIDMQOvvWKGWM9Ts0fg2JGyhGn7Y8rw0QmWDB2BR5dqz7nj//r3h
        lCOoXgJQlESDm498L5r8a4Sru597tVlMJnsQfjJ76LNOdy2vkMB1dahCLJmAezI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L2P/G5
        JvMP6pCOcyBpF4+IVNtN7m9/59LHMMN3bsC3WQE0WBlSmDv0g8CngE0JdmiPKt2Z
        x437jOqk4TjeU6wz/Z5uQz+faEsq0XcbLbcFKrq4wTOaRPyIMLRZTKXVqIyYZq7M
        8iG8NNa+pmWqnQr60gu3ixySOiLflhVw5Zl6M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A6AB2EAD7;
        Wed,  6 Nov 2019 07:12:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72FEE2EAD6;
        Wed,  6 Nov 2019 07:12:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] remote-curl: unbreak http.extraHeader with custom allocators
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
        <pull.453.v2.git.1573034695.gitgitgadget@gmail.com>
        <3168ba2c9eadcf0cd7e4f2533c9306b5d2c627d0.1573034695.git.gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 21:12:04 +0900
In-Reply-To: <3168ba2c9eadcf0cd7e4f2533c9306b5d2c627d0.1573034695.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 06 Nov 2019
        10:04:55 +0000")
Message-ID: <xmqq7e4dtd9n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A65FF728-008E-11EA-A164-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 93b980e58f5 (http: use xmalloc with cURL, 2019-08-15), we started to
> ask cURL to use `xmalloc()`, and if compiled with nedmalloc, that means
> implicitly a different allocator than the system one.
>
> Which means that all of cURL's allocations and releases now _need_ to
> use that allocator.
>
> However, the `http_options()` function used `slist_append()` to add any
> configured extra HTTP header(s) _before_ asking cURL to use `xmalloc()`=
,
> and `http_cleanup()` would release them _afterwards_, i.e. in the
> presence of custom allocators, cURL would attempt to use the wrong
> allocator to release the memory.

s/allocator/de&/; perhaps, even though it is clear enough from the
context, so it is probably OK as is.

> A na=C3=AFve attempt at fixing this would move the call to
> `curl_global_init()` _before_ the config is parsed (i.e. before that
> call to `slist_append()`).
>
> However, that does work, as we _also_ parse the config setting

s/does work/does not work/; presumably?

> `http.sslbackend` and if found, call `curl_global_sslset()` which *must=
*
> be called before `curl_global_init()`, for details see:
> https://curl.haxx.se/libcurl/c/curl_global_sslset.html
>
> So let's instead make the config parsing entirely independent from
> cURL's data structures. Incidentally, this deletes two more lines than
> it introduces, which is nice.

Yeah, string_list_clear() is more concise than curl_slist_free_all(),
and we have already been copying one list to another anyway, so we
lucked out ;-)

The patch looked good to me, too.
