Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3B2C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FF2214AF
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V2zg5Ir6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgA1SPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:15:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51191 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgA1SPN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:15:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C32324337B;
        Tue, 28 Jan 2020 13:15:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iwaneeewfWbZx5CKNWhkcOIpvAM=; b=V2zg5I
        r6mNpLkgCFfVw/7/tRjcQuIyjlR4PRPm2xHINCN0hKUq4FnBLMwZkVBUdzvIBu1Y
        iByGIfxY2Y7odZw8dpcHVGaaZArmquazRGs2LqU/FSyET+JeJSNavnrEIGPg39KQ
        KYiRk2fDX0yhUud6apILJwv30tFGjvL2PCoZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KRy6Bg7Zoz0WfezOOgA1Ea6nmNZ065QF
        /PAJ7WMg4LNcZv9jUl/6KuV8I9bHsBK7ozmo9EVPH5cVDdJe3/dfLcDybFqor60H
        2IIJWoxvS6W5+Kk3DQz5DShFgRIx54bmIFLyWHdhTQB2RAngVdbXs5FCrcHuWOT/
        kGefAI7sg2o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8ABB43379;
        Tue, 28 Jan 2020 13:15:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14F3B43378;
        Tue, 28 Jan 2020 13:15:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 13/22] t5313: make test hash independent
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
        <20200125230035.136348-14-sandals@crustytoothpaste.net>
Date:   Tue, 28 Jan 2020 10:15:07 -0800
In-Reply-To: <20200125230035.136348-14-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 25 Jan 2020 23:00:19 +0000")
Message-ID: <xmqqpnf38n2s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E1CD888-41FA-11EA-A393-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Make this test hash independent by computing the length of the object
> offsets and looking up values which will hash to object IDs with the
> right properties.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t5313-pack-bounds-checks.sh | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
> index f1708d415e..8d805f845a 100755
> --- a/t/t5313-pack-bounds-checks.sh
> +++ b/t/t5313-pack-bounds-checks.sh
> @@ -38,16 +38,27 @@ munge () {
>  # for the initial, and another ofs(4*nr) past that for the extended.
>  #
>  ofs_table () {
> -	echo $((4 + 4 + 4*256 + 20*$1 + 4*$1))
> +	echo $((4 + 4 + 4*256 + $(test_oid rawsz)*$1 + 4*$1))
>  }
>  extended_table () {
>  	echo $(($(ofs_table "$1") + 4*$1))
>  }
>  
> +test_expect_success 'setup' '
> +	test_oid_init &&
> +	test_oid_cache <<-EOF
> +	oid000 sha1:1485
> +	oid000 sha256:4222
> +
> +	oidfff sha1:74
> +	oidfff sha256:1350
> +	EOF
> +'
> +
>  test_expect_success 'set up base packfile and variables' '
>  	# the hash of this content starts with ff, which
>  	# makes some later computations much simpler
> -	echo 74 >file &&
> +	echo $(test_oid oidfff) >file &&
>  	git add file &&
>  	git commit -m base &&
>  	git repack -ad &&
> @@ -140,10 +151,10 @@ test_expect_success 'bogus offset inside v2 extended table' '
>  	# an extended table (if the first object were larger than 2^31).
>  	#
>  	# Note that the value is important here. We want $object as
> -	# the second entry in sorted-sha1 order. The sha1 of 1485 starts
> +	# the second entry in sorted-sha1 order. The hash of this object starts

Micronit: "shorted-hash order", no?

>  	# with "000", which sorts before that of $object (which starts
>  	# with "fff").
> -	second=$(echo 1485 | git hash-object -w --stdin) &&
> +	second=$(test_oid oid000 | git hash-object -w --stdin) &&
>  	do_pack "$object $second" --index-version=2 &&
>  
>  	# We have to make extra room for the table, so we cannot
