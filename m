Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45E420966
	for <e@80x24.org>; Thu, 30 Mar 2017 16:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934346AbdC3QRA (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 12:17:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56998 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933821AbdC3QQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 12:16:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BB636AB8B;
        Thu, 30 Mar 2017 12:16:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kom7N+Ot+85Md968DMmJ23j0INU=; b=ReMsKR
        BFM9G42GH5WODEWF7E9o6gu4xzh01MA28dIqqdvnQhuRqdD+/tqxxxbk/xTE/Y8m
        C3S74GmbncCWAm7Uk7uSQ6NnLNF3pFJNvJb2GbBeyT3arCUUyf/7OrWw2iSdtg7U
        aP9o/rQ4ftTJ6kuWP4eHyqnLgiVVO+a0bqIk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xQ6tyMUOn2iO/xnTUD/FAOllnxonzYgQ
        mOOrAAPntHStP2n0EvIhpPaVU3BtJCXVUejXydquslaOnwqiVwd4MZh4e4SHv3iz
        CJMkmH2Hw0UJz8IJXe4yGwmg7PHjvRzW8rznswlHhsS7OZkj7SD0xecUqFA1ZuOO
        Pq/7uNNtS4g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 145666AB8A;
        Thu, 30 Mar 2017 12:16:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 731486AB88;
        Thu, 30 Mar 2017 12:16:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/7] Makefile: optionally compile with both SHA1DC and SHA1_OPENSSL
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
        <7a2444f08dea1b2fe497ae7498eba44626414d29.1490397869.git.johannes.schindelin@gmx.de>
Date:   Thu, 30 Mar 2017 09:16:50 -0700
In-Reply-To: <7a2444f08dea1b2fe497ae7498eba44626414d29.1490397869.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sat, 25 Mar 2017 00:24:52 +0100
        (CET)")
Message-ID: <xmqq37du7n9p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B736920-1564-11E7-B039-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +#ifdef SHA1_DC_AND_OPENSSL
> +void (*SHA1_Init_func)(SHA_CTX_union *ctx) = (void *)SHA1DCInit;
> +void (*SHA1_Update_func)(SHA_CTX_union *ctx, const void *pointer, size_t size) =
> +	(void *)git_SHA1DCUpdate;
> +int (*SHA1_Final_func)(unsigned char sha1[20], SHA_CTX_union *ctx) =
> +	(void *)git_SHA1DCFinal;
> +
> +void toggle_sha1dc(int enable)
> +{
> +	if (enable) {
> +		SHA1_Init_func = (void *)SHA1DCInit;
> +		SHA1_Update_func = (void *)git_SHA1DCUpdate;
> +		SHA1_Final_func = (void *)git_SHA1DCFinal;
> +	} else {
> +		SHA1_Init_func = (void *)SHA1_Init;
> +		SHA1_Update_func = (void *)SHA1_Update;
> +		SHA1_Final_func = (void *)SHA1_Final;
> +	}
> +}
> +#endif

As I understand that this is a demonstration series, the approach
above is OK as an expedite way to illustrate one way how run-time
switching could be done.  The approach however is not very thread
friendly, though.

> diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
> index bd8bd928fb3..243c2fe0b6b 100644
> --- a/sha1dc/sha1.h
> +++ b/sha1dc/sha1.h
> @@ -110,10 +110,26 @@ void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
>   */
>  void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
>  
> +#ifdef SHA1_DC_AND_OPENSSL
> +extern void toggle_sha1dc(int enable);
> +
> +typedef union {
> +	SHA1_CTX dc;
> +	SHA_CTX openssl;
> +} SHA_CTX_union;

The use of union is a good ingredient for a solution.  I would have
chosen to do this slightly differently if I were doing it.

        typedef struct {
                int safe;
                union {
                        SHA1_CTX_SAFE safe;
                        SHA1_CTX_FAST fast;
                } u;
        } git_SHA_CTX;

        void git_SHA1_Init(git_SHA_CTX *ctx, int safe);
	void git_SHA1_Update(git_SHA_CTX *ctx, const void *, unsigned long);
	git_SHA1_Final(uchar [20], git_SHA_CTX *ctx);

where SHA1_CTX_FAST may be chosen from the Makefile just like we
currently choose platform_SHA_CTX.  SHA1_CTX_SAFE could also be made
configurable but it may be OK to hardcode it to refer to SHA1_CTX of
DC's.

As you already know, I am assuming that each codepath pretty much
knows if it needs safe or fast one (e.g. the one used in csum-file.c
knows it does not have to), so each git_SHA_CTX is told which one to
use when it gets initialized.
