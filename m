Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA721F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 02:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbeKXNkU (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 08:40:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61383 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeKXNkT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 08:40:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1E8523301;
        Fri, 23 Nov 2018 21:53:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hXDsXkV6SxmflAnp+CutvrmXIsw=; b=IEkdrx
        ebmdY/z4Mt+gRsar+j3/v61L2qWT5GdpUDKaRZmG5OzJo1/2yu19IdaFQYVLIGO+
        LOPTomxnKQ1VUPRC3FWXKWBOs4A0nRnTRYf4DbtNxOVYYpm6HqKHOalnHr5djpwC
        PQerGVPlggt4wRtWDiPhGC9NyDVrLK391R4BE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q3CTKZh7oqq08nN5mOCrFXitSMtxPXJG
        lZiNP7l26HW+oWxT6SgakK04BnsYJ4f5G6HIEBmoE74wGwGS628aVE+rG5ehaAwD
        U7ymwsgy7ZWPcMzObUOLm0lo5jN5Zavq0mP6iV2N7LaXnldJmmIpKOOmc+l5AKst
        D13xgholDXU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CAEBE232FF;
        Fri, 23 Nov 2018 21:53:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC848232FD;
        Fri, 23 Nov 2018 21:53:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] ref-filter: replace unportable `%lld` format
References: <pull.87.git.gitgitgadget@gmail.com>
        <617f1e7b084ff95f4cc7c5a4b7b70b9a5c0d1af1.1542888057.git.gitgitgadget@gmail.com>
Date:   Sat, 24 Nov 2018 11:53:31 +0900
In-Reply-To: <617f1e7b084ff95f4cc7c5a4b7b70b9a5c0d1af1.1542888057.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 22 Nov 2018
        04:01:00 -0800 (PST)")
Message-ID: <xmqqsgzr2nkk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21FCB162-EF94-11E8-BCC1-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `%lld` format is supported on Linux and macOS, but not on Windows.
> This issue has been reported ten days ago (Message-ID:
> nycvar.QRO.7.76.6.1811121300520.39@tvgsbejvaqbjf.bet), but the
> corresponding topic still advanced to `next` in the meantime, breaking
> the Windows build.
>
> Let's use `PRIdMAX` and a cast to `intmax_t` instead, which unbreaks the
> build, and imitates how we do things e.g. in `json-writer.c` already.

We seem to be already using PRIdMAX in 'master', so this is safe
thing to do and I will merge it directly to 'next', but the fact
that PRIdMAX is used without any fallback definition in
git-compat-util.h makes me suspect that we can now drop the fallback
for PRIuMAX.

Thanks.


> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ref-filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 3cfe01a039..69cdf2dbb5 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -897,7 +897,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
>  			v->s = xstrdup(type_name(oi->type));
>  		else if (!strcmp(name, "objectsize:disk")) {
>  			v->value = oi->disk_size;
> -			v->s = xstrfmt("%lld", (long long)oi->disk_size);
> +			v->s = xstrfmt("%"PRIdMAX, (intmax_t)oi->disk_size);
>  		} else if (!strcmp(name, "objectsize")) {
>  			v->value = oi->size;
>  			v->s = xstrfmt("%lu", oi->size);
