Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD7D1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 22:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfHEWhJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 18:37:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62700 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfHEWhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 18:37:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14DF17C822;
        Mon,  5 Aug 2019 18:37:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n5/79YgffpA1LkyzDI2JjGr1VtI=; b=tYuz1b
        yS7dkabkLW/VaNZE/s/HzbH482ot8o64+FK64R4PCnopJ6NonkPOq6YRGHHzNBxi
        aWowAhdwPrzMSYhPnar1p/08AGfHcP1aSGp/dQj4X196bLOYcrj205eQ5H33AbTo
        94OtdF7tQeD6Asecu7PEh6n8Z5J0ZKOJyvm3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xcllg4GfaCpN47XUib2FNv4nFwD3mwKu
        e+/ihBwe2brPhcqfZt51a+X9MJTfmh6bvr0KONl5HTBH107NRxoBX/iFqCwXXCl2
        oBPmBYpsTWBVcKi1gwKuGPdP0YcXGXc2PRM8/uRSvy+NsBvQXdiKM50pESYD39qf
        PiXhQ03trIU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C5767C821;
        Mon,  5 Aug 2019 18:37:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 382FA7C820;
        Mon,  5 Aug 2019 18:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, lufia <lufia@lufia.org>
Subject: Re: [PATCH 3/6] GIT-VERSION-GEN: Use sed instead of expr
References: <pull.305.git.gitgitgadget@gmail.com>
        <df67a7e1d307d6a7a91ae1bba085959154006ed1.1564876327.git.gitgitgadget@gmail.com>
Date:   Mon, 05 Aug 2019 15:37:04 -0700
In-Reply-To: <df67a7e1d307d6a7a91ae1bba085959154006ed1.1564876327.git.gitgitgadget@gmail.com>
        (lufia via GitGitGadget's message of "Sat, 03 Aug 2019 16:52:11 -0700
        (PDT)")
Message-ID: <xmqqy307kzn3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D8E1CE4-B7D1-11E9-B513-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lufia via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: lufia <lufia@lufia.org>
>
> Plan 9 don't have expr(1).
>
> Signed-off-by: lufia <lufia@lufia.org>
> ---
>  GIT-VERSION-GEN | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index a0766f64ed..754d4486f5 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -26,7 +26,7 @@ else
>  	VN="$DEF_VER"
>  fi
>  
> -VN=$(expr "$VN" : v*'\(.*\)')
> +VN=$(echo "$VN" | sed 's/^v*//')

The expr utility is often a shell built-in, but sed is almost never
(as it is a lot more heavy-weight command).  It may not be a bad
idea to get rid of expr with a simple shell parameter expansion,
e.g.

	VN=${VN#v}

instead.

The original explicitly is prepared to see no 'v' at the beginning
(in which case it just passes VN intact), or more than one 'v's (in
which case all leading 'v's are stripped), while the shell parameter
expansion strips zero or one 'v' at the beginning.  So there is a
slight "regression" there, but I do not think it matters (certainly,
it was *NOT* my intention while writing the original to strip two or
more 'v's).  181129d2 ("For release tarballs, include the proper
version", 2006-01-09) snuck in the "all leading 'v's are stripped"
without sufficient explanation, but I do not think it was an attempt
to allow two or more 'v's.
