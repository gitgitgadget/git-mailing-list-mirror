Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6111F1F461
	for <e@80x24.org>; Wed, 24 Jul 2019 02:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfGXCK1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 22:10:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57552 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfGXCK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 22:10:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B8F6170B3D;
        Tue, 23 Jul 2019 22:10:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mawxc52XClAW
        gQNaud0qGsG/U58=; b=Sib3MxkaCyNUB5RD5B6wOjF4vwTZXTd12jP/SFIsxJGA
        t2YgoOBLuW1w+pQzmHbL2U1wAjkqXl2bdoUob8zh2LKK1b1NS9Srt03InF+ykerx
        cOxSIudL0pg5xk6e2lirk1L0n6w2iaha46ZytrxavDZZqM6DHWJt+obmqS0ZFQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wVqNrb
        MaLxACi8kzMmH56P5XD3aZ/p22Eko5QJLNtXsrVWYJ+9V9w9e9ZacOfqKmNSnQrx
        549OGstod0c/2jBJmZkSQB3rikp/8e2kp1PGecAFtcp9DzbqILklxRVzVXcoBpCn
        uK7qDL8CjVxa+y3tQH4d45vrpekwFrHHPSv3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 438EB170B3C;
        Tue, 23 Jul 2019 22:10:24 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5967170B3B;
        Tue, 23 Jul 2019 22:10:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: skip UTF8 checks explicitly
References: <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
        <20190722144350.46458-1-carenas@gmail.com>
Date:   Tue, 23 Jul 2019 19:10:22 -0700
In-Reply-To: <20190722144350.46458-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 22 Jul 2019 07:43:50 -0700")
Message-ID: <xmqqa7d4rxm9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 320F0A54-ADB8-11E9-914D-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Usually PCRE is compiled with JIT support, and therefore the code
> path used includes calling pcre2_jit_match (for PCRE2), that ignores
> invalid UTF-8 in the corpus.
>
> Make that option explicit so it can be also used when JIT is not
> enabled and pcre2_match is called instead, preventing `git grep`
> to abort when hitting the first binary blob in a fixed match
> after ed0479ce3d ("Merge branch 'ab/no-kwset' into next", 2019-07-15)
>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> V2: spelling fixes from Eric Sunshine

Good.  I was expecting fallouts like this from our recent push to
aggressively use pcre and that was why I merged ab/no-kwset before
I felt comfortable, so that we can have longer exposure.  It seems
to be paying off.

So with JIT, PCRE_NO_UTF8_CHECK is on by default, but without, we
need to give the option explicitly, and because it is on by default
in the JIT case, it would not hurt to explicitly pass it? =20

That makes perfect sense to me.

>  grep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index fc0ed73ef3..146093f590 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -409,7 +409,7 @@ static void compile_pcre1_regexp(struct grep_pat *p=
, const struct grep_opt *opt)
>  static int pcre1match(struct grep_pat *p, const char *line, const char=
 *eol,
>  		regmatch_t *match, int eflags)
>  {
> -	int ovector[30], ret, flags =3D 0;
> +	int ovector[30], ret, flags =3D PCRE_NO_UTF8_CHECK;
> =20
>  	if (eflags & REG_NOTBOL)
>  		flags |=3D PCRE_NOTBOL;
> @@ -554,7 +554,7 @@ static void compile_pcre2_pattern(struct grep_pat *=
p, const struct grep_opt *opt
>  static int pcre2match(struct grep_pat *p, const char *line, const char=
 *eol,
>  		regmatch_t *match, int eflags)
>  {
> -	int ret, flags =3D 0;
> +	int ret, flags =3D PCRE2_NO_UTF_CHECK;
>  	PCRE2_SIZE *ovector;
>  	PCRE2_UCHAR errbuf[256];
