Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001E0C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F506103D
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbhIITrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:47:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55395 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245698AbhIITrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:47:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FFBBDF287;
        Thu,  9 Sep 2021 15:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iwrCTPwiIZPu
        C8tHN37J9aCjhXwD2IWUl7rPj+Q7IeM=; b=ds5c9+bKFuS6yb1osE2aVKYSujkA
        gfiwUON0zJvPqdqKuchq3RU8wNKJtIXPF5psKffn5qxhs+7U4QQS4tPV+3G06lFr
        9NQS5sPljW098QrM3bRSAertji7IodSQmIkOHJ0uBMLQWvMLcwbEpqC4rCmSg/JP
        riBvDjOMYv0qCcA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86B5DDF285;
        Thu,  9 Sep 2021 15:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18C3DDF284;
        Thu,  9 Sep 2021 15:45:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 7/9] builtin/index-pack.c: move `.idx` files into place
 last
References: <cover.1630461918.git.me@ttaylorr.com>
        <cover.1631157880.git.me@ttaylorr.com>
        <8d67a715014b9daa9a6ca3a77be647e733324522.1631157880.git.me@ttaylorr.com>
Date:   Thu, 09 Sep 2021 12:45:53 -0700
In-Reply-To: <8d67a715014b9daa9a6ca3a77be647e733324522.1631157880.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 8 Sep 2021 23:25:13 -0400")
Message-ID: <xmqqy285y1la.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8B50002E-11A6-11EC-ACAF-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In a similar spirit as preceding patches to `git repack` and `git
> pack-objects`, fix the identical problem in `git index-pack`.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/index-pack.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index cd4e85f5bb..bf294d9083 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1523,11 +1523,11 @@ static void final(const char *final_pack_name, =
const char *curr_pack_name,
> =20
>  	rename_tmp_packfile(&final_pack_name, curr_pack_name, &pack_name,
>  			    hash, "pack", from_stdin);
> -	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
> -			    hash, "idx", 1);
>  	if (curr_rev_index_name)
>  		rename_tmp_packfile(&final_rev_index_name, curr_rev_index_name,
>  				    &rev_index_name, hash, "rev", 1);
> +	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
> +			    hash, "idx", 1);

Good.
