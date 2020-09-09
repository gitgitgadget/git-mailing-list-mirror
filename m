Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C6C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D0621D7E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 22:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DcG8LwQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgIIWWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:22:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54528 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIIWWT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 18:22:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22586F19CA;
        Wed,  9 Sep 2020 18:22:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KvMCHAzQwWrP
        Nvszmjh9rEugFPw=; b=DcG8LwQdaZZW2t3PoXNfy0dI+/w40eYeKFlmIzZRw6If
        Ie+GX1rykb0FRIyMegE1iciWnpjtoNoXX77irUcpHgZP3Hv7pzFQrMwg63r0zmFq
        T+M1W11l/2BcwdceccdEZ/dNa5yrVB5EGOutfjon4IEH0rpjN/2AeeN01N0bq94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sn72He
        eCZqRmGkT5I5eJpsIf50O/MEDW2eIgOfSUeVxYxkDrMe4Ou1ElQ52D/WT3oyOu2R
        qoD+jXnceT/SFpd0BXZ7xgJKA4PkcX3v/bLwa45hDDctqhpWWeJnJEq/agQ4+AKu
        d3DkN+Zkc749i28RjNvfEvB36kE7UNF5y+ORM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1BB28F19C9;
        Wed,  9 Sep 2020 18:22:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 62D89F19C8;
        Wed,  9 Sep 2020 18:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Fong <patrickf3139@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug report] git status doesn't escape paths of untracked files
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
        <20200908011756.GG241078@camp.crustytoothpaste.net>
        <xmqq5z8p12ds.fsf@gitster.c.googlers.com>
        <xmqq4ko8yxp9.fsf@gitster.c.googlers.com>
        <3a72c5f2-35cc-a865-d5f2-02706c48d8ec@web.de>
Date:   Wed, 09 Sep 2020 15:22:12 -0700
In-Reply-To: <3a72c5f2-35cc-a865-d5f2-02706c48d8ec@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 8 Sep 2020 23:06:50 +0200")
Message-ID: <xmqqa6xytwtn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E9A1F46A-F2EA-11EA-B536-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> I don't particularly like how this print* function takes a printf
> format, but doesn't interpret its remaining arguments like printf does.

Yes.  I think the more elaborate one that pushes the logic down to
quote_path() I posted earlier is much cleaner in this regard.

>>  - I am undecided if I like that the helper formats and also prints;
>>    I was hoping I can come up with a pure formatting helper that
>>    does not do I/O but it seems to be hard to arrange for the
>>    current callers.
>
> How about something like this then?

Thanks.  I kind of like the fact that it is isolated compared to the
"push the logic down to quote_path()" approach.

But it also is a double edged sword.  It makes it harder for other
codepaths to quote a path with SP in it by mistake, but if it turns
out to be a good longer term thing to quote a path with SP in it,
it makes it harder to do so.

> diff --git a/wt-status.c b/wt-status.c
> index ff43932402..e0711aff04 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1829,19 +1829,19 @@ static void wt_longstatus_print(struct wt_statu=
s *s)
>  		wt_longstatus_print_stash_summary(s);
>  }
>
> -static void print_cquoted(const char *fmt, const char *path, const cha=
r *prefix)
> +static const char *cquote(const char *in, const char *prefix, struct s=
trbuf *out)
>  {
> -	struct strbuf onebuf =3D STRBUF_INIT;
> -	const char *one;
> -
> -	one =3D quote_path(path, prefix, &onebuf);
> -	if (*one !=3D '"' && strchr(one, ' ')) {
> -		strbuf_insertstr(&onebuf, 0, "\"");
> -		strbuf_addch(&onebuf, '"');
> -		one =3D onebuf.buf;
> -	}
> -	printf(fmt, one);
> -	strbuf_release(&onebuf);
> +	struct strbuf sb =3D STRBUF_INIT;
> +	const char *rel =3D relative_path(in, prefix, &sb);
> +	int need_quotes =3D *rel !=3D '"' && strchr(rel, ' ');

relative_path() does not quote, so "begins with a dq" is not a good
test to see "if we were to pass this string to quote_c_style(), would
we get it back quoted already so we won't have to surround the
result with an extra pair of dq ourselves?".

> +	strbuf_reset(out);
> +	if (need_quotes)
> +		strbuf_addch(out, '"');
> +	quote_c_style(rel, out, NULL, 0);
> +	if (need_quotes)
> +		strbuf_addch(out, '"');
> +	strbuf_release(&sb);
> +	return out->buf;
>  }
