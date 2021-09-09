Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8839C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B6161059
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245505AbhIITeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:34:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62033 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245415AbhIITeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:34:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8C7D14037D;
        Thu,  9 Sep 2021 15:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GCY0EbCdYOzc
        FAbn/18u2cIKutloJH297z7rrwXHw4o=; b=RGObM53j1g/V6TaZhdogNgIJYvBZ
        PGYXYKdxCdPdsdXQ9ecfVIok9GuQnavbBJ/CpmErmHGZ89zXLKOhKHdmm9FzzTNN
        liT6LztL8UuejwWi55JlRjlahdUJLdOvP1CjVtoRT0QyTBaNKYWolS0zuQGfd0Vp
        nei7555WJ1rnnyQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B255914037C;
        Thu,  9 Sep 2021 15:32:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0518614037B;
        Thu,  9 Sep 2021 15:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 4/9] pack-write.c: rename `.idx` files after `*.rev`
References: <cover.1630461918.git.me@ttaylorr.com>
        <cover.1631157880.git.me@ttaylorr.com>
        <0fb2c25f5ad8bfdccd653f760b1c4beeb05273e7.1631157880.git.me@ttaylorr.com>
Date:   Thu, 09 Sep 2021 12:32:50 -0700
In-Reply-To: <0fb2c25f5ad8bfdccd653f760b1c4beeb05273e7.1631157880.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 8 Sep 2021 23:24:59 -0400")
Message-ID: <xmqqee9xzgrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B9281B1E-11A4-11EC-8525-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This still leaves the issue of `.idx` files being renamed into place
> before the auxiliary `.bitmap` file is renamed when in pack-object.c's
> write_pack_file() "write_bitmap_index" is true. That race will be
> addressed in subsequent commits.

OK.  I was about to suggest s/after .*rev/last/ on the title, but
the above makes it clear that we are not ready for such a title.

>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-write.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pack-write.c b/pack-write.c
> index 95b063be94..077710090e 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -491,9 +491,9 @@ void finish_tmp_packfile(struct strbuf *name_buffer=
,
>  				      pack_idx_opts->flags);
> =20
>  	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
> -	rename_tmp_packfile(name_buffer, idx_tmp_name, "idx");
>  	if (rev_tmp_name)
>  		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
> +	rename_tmp_packfile(name_buffer, idx_tmp_name, "idx");
> =20
>  	free((void *)idx_tmp_name);
>  }
