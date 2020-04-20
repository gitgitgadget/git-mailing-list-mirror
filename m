Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB22C54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3AB206F4
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FJrY9E/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTXJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:09:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59232 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTXJp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 19:09:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADF585A766;
        Mon, 20 Apr 2020 19:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oeXKvkC5zS1i
        0KH6iNGVzKn0n3I=; b=FJrY9E/jr1pgH/8ETTBMkT8mIXBxQNjontIKE5nBEAM8
        XZNOgXd8y5RYxf2UzYmJ24rg2Auh2ecEHBgA0gkVewFzxvPz1Q1NI1YPswesU2h4
        fj0VLlENyhLq754fOlJQAoxhFUB388p28CW8sgsvzLt60wcOx893mkfW/DL69x0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jDiJvz
        R/wCx+rrb4ahUGZxRHldAxzYuUCuNIp8QmsoIOTQpLCqGlQBNXJBCZ42rLytLy4w
        4VkpkiAyoGyNddOgMkZFHUjFPsiplfWmhOP7iCNcQOzp69ppDNMOu5Ze7ZypTbRP
        ROcWNxPfdoicdnx4/6RVYzOTubV0S5sAzs6Uc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A672B5A764;
        Mon, 20 Apr 2020 19:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BA005A763;
        Mon, 20 Apr 2020 19:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] osxkeychain: restrict queries to requests with a valid host
References: <20200420224310.9989-1-carenas@gmail.com>
Date:   Mon, 20 Apr 2020 16:09:42 -0700
In-Reply-To: <20200420224310.9989-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 20 Apr 2020 15:43:10 -0700")
Message-ID: <xmqqa735rbyh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04FA08D2-835C-11EA-8298-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> make sure that requests to this helper to get credentials return early =
if
> there is no host ord the host is empty.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  contrib/credential/osxkeychain/git-credential-osxkeychain.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.=
c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index bcd3f575a3..2264a88c41 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -69,6 +69,12 @@ static void find_internet_password(void)
>  	UInt32 len;
>  	SecKeychainItemRef item;
> =20
> +	/*
> +	 * Require at valid host to fix CVE-2020-11008
> +	 */

Just to clarify, you do not need this patch to "fix" it, as long as
you are running up-to-date Git, right?  In other words, this is more
like a belt-and-suspender protection, isn't it?

> +	if (!host || !*host)
> +		return;
> +
>  	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, &len, &buf, &item)=
)
>  		return;
