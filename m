Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531041F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 04:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeK1Prj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 10:47:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54906 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1Pri (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 10:47:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0457412318F;
        Tue, 27 Nov 2018 23:47:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=X8hDrPS2Mel7
        /M5nFYfdSja43Js=; b=ST/qqs0gGas7VoG6nce1TJeVsNBVE1sl1nP63f2pDsLf
        gBRi6cF7uqSzMazKNSUYqJqM8IRIivc3FvZQmgH5IbTMFSv0rdVYewtZypUQtsmu
        tfCZJp+YbFTVTMNsko06MhUsW4CNgcHFZgQx1XqMzz6VdnGIfmd2Q0NQGD9m9Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MAVVYK
        epAunphlQkqYySXI0W2uHwEg5zDTeJCFpnE+TuJEvsW6vt+9JMX5uJXuHQnXGKDZ
        RgIosOXXdRYVq6KR9tlzBNseYJcRVDHFz/lRr7eNn8xWz2I0PzwgfpDyT5xbRQTt
        m9xkrP1otZQ/W161a10V58bNi5JcIlbnU82mI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F04F912318E;
        Tue, 27 Nov 2018 23:47:20 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68A5712318D;
        Tue, 27 Nov 2018 23:47:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: Re: [PATCH v2 1/7] parse-options: allow parse_options_concat(NULL, options)
References: <20181120174554.GA29910@duynguyen.home>
        <20181127165211.24763-1-pclouds@gmail.com>
        <20181127165211.24763-2-pclouds@gmail.com>
Date:   Wed, 28 Nov 2018 13:47:19 +0900
In-Reply-To: <20181127165211.24763-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 27 Nov 2018 17:52:05 +0100")
Message-ID: <xmqqk1kxst9k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0908EA8-F2C8-11E8-8C8B-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> There is currently no caller that calls this function with "a" being
> NULL. But it will be introduced shortly. It is used to construct the
> option array from scratch, e.g.
>
>    struct parse_options opts =3D NULL;

Missing asterisk somewhere?

>    opts =3D parse_options_concat(opts, opts_1);
>    opts =3D parse_options_concat(opts, opts_2);
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  parse-options-cb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 8c9edce52f..c609d52926 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -126,7 +126,7 @@ struct option *parse_options_concat(struct option *=
a, struct option *b)
>  	struct option *ret;
>  	size_t i, a_len =3D 0, b_len =3D 0;
> =20
> -	for (i =3D 0; a[i].type !=3D OPTION_END; i++)
> +	for (i =3D 0; a && a[i].type !=3D OPTION_END; i++)
>  		a_len++;
>  	for (i =3D 0; b[i].type !=3D OPTION_END; i++)
>  		b_len++;
