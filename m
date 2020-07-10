Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062D4C433E2
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EB920748
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vN7v449P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGJUYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:24:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52781 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJUYa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 16:24:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AAD16B7BD;
        Fri, 10 Jul 2020 16:24:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tuNtzW2wMXqCxlI5YZQpL1LXwHM=; b=vN7v44
        9PshP2+RWiCOdptOnaq2Ar1/VFntyo/ecX92m9dxJPeTWZBuW4fr+/YNOvUZEgjk
        /+1uPIHnOnzUaycM1raZhc8BLihgtLEzoF+Iuh5UyguP/9Nerp9iIJz9LzjV5fdr
        dOwHQqgPvqZg+auxP1AJKuBZhT85fLOYobayk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mgHsbxes7m8M/JZ9ftWdHdiQIY6dR59x
        ZIEpT64I70+yc2kCkMrobhFmAbNUoVw9fHguJ37YrVw+ZpdfT5BFbqBoGaNvMaX1
        0h7Mpzpbsqyt84ZqTPEuEqSpkjK6ze5UdFDmwQ3c01wEI10YikFK76m7PJ9eM+EK
        32a+zg7/6cQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F0AB6B7BC;
        Fri, 10 Jul 2020 16:24:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECBB06B7BB;
        Fri, 10 Jul 2020 16:24:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 2/3] t6300: test refs pointing to tree and blob
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200710164739.6616-1-chriscool@tuxfamily.org>
        <20200710164739.6616-3-chriscool@tuxfamily.org>
Date:   Fri, 10 Jul 2020 13:24:26 -0700
In-Reply-To: <20200710164739.6616-3-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 10 Jul 2020 18:47:38 +0200")
Message-ID: <xmqq7dvbt8xx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59EA3C76-C2EB-11EA-B0EB-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Adding tests for refs pointing to tree and blob shows that
> we care about testing both positive ("see, my shiny new toy
> does work") and negative ("and it won't do nonsensical
> things when given an input it is not designed to work with")
> cases.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t6300-for-each-ref.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Nice addition.  Thanks.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index da59fadc5d..e9f468d360 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -650,6 +650,25 @@ test_atom refs/tags/signed-long contents "subject line
>  body contents
>  $sig"
>  
> +test_expect_success 'set up refs pointing to tree and blob' '
> +	git update-ref refs/mytrees/first refs/heads/master^{tree} &&
> +	git update-ref refs/myblobs/first refs/heads/master:one
> +'
> +
> +test_atom refs/mytrees/first subject ""
> +test_atom refs/mytrees/first contents:subject ""
> +test_atom refs/mytrees/first body ""
> +test_atom refs/mytrees/first contents:body ""
> +test_atom refs/mytrees/first contents:signature ""
> +test_atom refs/mytrees/first contents ""
> +
> +test_atom refs/myblobs/first subject ""
> +test_atom refs/myblobs/first contents:subject ""
> +test_atom refs/myblobs/first body ""
> +test_atom refs/myblobs/first contents:body ""
> +test_atom refs/myblobs/first contents:signature ""
> +test_atom refs/myblobs/first contents ""
> +
>  test_expect_success 'set up multiple-sort tags' '
>  	for when in 100000 200000
>  	do
