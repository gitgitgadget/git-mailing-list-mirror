Return-Path: <SRS0=UM1m=AW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC761C433E2
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 00:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE11E20786
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 00:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o8k1ns1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgGKAnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:43:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55262 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgGKAnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 20:43:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3B08D3D2D;
        Fri, 10 Jul 2020 20:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RaS0k2qU7dP3APi3s6/817qYnQs=; b=o8k1ns
        1QWp6QmrV96eAWPLD2RNg1Vuum678FnP7AyXvVtKkbunFQPAj0P+7k9naC49N/h7
        ieem9KbhzqWq9IFU9AoajVhwnepRzAa205SbpG3O5q1kD6Iteo2W3DRr3WkYjXGu
        AK3ra3zVc9+08ck4Wuvxtn4n/GD70RV4I7ydM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X7GCVx69vqM8vHd6o4ihxhjakhVM6kGI
        UTXB7QXFNnk8rMf08mdEIbM5tl6EXzABofrMHBKwR1zxv44KWqVe8n6ggyozGNXo
        jT2NTCHahwog/72u7WndaCiGbOSDtCCZlgFXOttlle33Zb0WLR6foG7dIYOn9FT3
        1gAl252VoCM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7B00D3D2C;
        Fri, 10 Jul 2020 20:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 199E5D3D2B;
        Fri, 10 Jul 2020 20:43:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/38] t7063: make hash size independent
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
        <20200710024728.3100527-12-sandals@crustytoothpaste.net>
Date:   Fri, 10 Jul 2020 17:43:08 -0700
In-Reply-To: <20200710024728.3100527-12-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 10 Jul 2020 02:47:01 +0000")
Message-ID: <xmqqmu46rieb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E6C8F26-C30F-11EA-A7C0-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Use test_oid instead of hard-coding a fixed size all-zeros object ID.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t7063-status-untracked-cache.sh | 155 ++++++++++++++++--------------
>  1 file changed, 83 insertions(+), 72 deletions(-)

The stated objective does make sense, but ...


> -info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
> -core.excludesfile 0000000000000000000000000000000000000000
> +info/exclude $(test_oid exclude)
> +core.excludesfile $ZERO_OID
>  exclude_per_dir .gitignore
>  flags 00000006
> -/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
> -/done/ 0000000000000000000000000000000000000000 recurse valid
> -/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
> -/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
> +/ $(test_oid root) recurse
> +/done/ $ZERO_OID recurse valid
> +/dthree/ $ZERO_OID recurse check_only valid
> +/dtwo/ $ZERO_OID recurse check_only valid
>  two
>  EOF
> -	test_cmp ../expect ../actual
> +	test_might_fail test_cmp ../expect ../actual

Any "cmd" that is run under test_might_fail that is *not* used for
its side effect is suspect---e.g. "we would try to remove this file
as the test may have created it, but it is OK if the file does not
exist and removal fails" is sort-of understandable, but I am having
a hard time imagining in what situation it makes sense for a test to
say "these two files may have the same contents but it is OK if that
is not the case".  There are a few others in this patch.

Another topic in flight tightens the allowed usage of test_must_fail
and test_might_fail helpers, and that is how I found this (because
the tip of 'seen' does not pass the test), but regardless of that
tightening, I am not sure what this "these two files may or may not
be equal" is trying to achieve.

Thanks.

