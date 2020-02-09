Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06961C3F68F
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 10:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25492080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 10:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gZOpq22q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgBIKXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:23:37 -0500
Received: from mout.web.de ([212.227.15.4]:39717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgBIKXh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 05:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581243810;
        bh=svToECR2XDt3Z/YGkf4errq7mCFsZXlQT0B9vTBWXzw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gZOpq22qJc6ecW7pFZQnWgjpEQomL1ei68FLRJMixMweGeb2E8+xMQXS9A3jpMx9u
         0HArsUQjp54CrvHxhJ/G+kmatq5Qe6HtZuaU5rNVph/KShenCZpSDSg6XP/oVyn+70
         D6WogZtjZyntuwa2atrto3JDHuTyknHb2VsjLof0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lfzwp-1jJaA51x3T-00pbY7; Sun, 09
 Feb 2020 11:23:30 +0100
Subject: Re: [PATCH] strbuf: add and use strbuf_insertstr()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
 <20200208230801.GA33529@syl.local>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b0fc55fd-2ed5-25c4-850e-4c69199e0db3@web.de>
Date:   Sun, 9 Feb 2020 11:23:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200208230801.GA33529@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NJvo4VTp4s9ipgi+s9XNrGkttMRRymwPO1iuFSuhPMntiK9J5bm
 5+GtDlfOyiqAPk/Lbyp0B1pKJKEIvcO0VJtBWmmyPe0Mn0TqCuCxCeKHbEP7MLlyhFap2pK
 WpLzPRb/fsUzwjftFuiK+68h8QvcsK6T2Cnu7jjFNIjtxNS1icL4LZL9qpQ4QsAYqhnsMQo
 4ARYz+9lUp1A/H4KBbTSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LOkGgD18m34=:vc5cdCDwJcJ3JppY2i+BYw
 Zbw2h9Tbtuk6XaRwvTTQ043RfdOKeMnxUHdBik14WR+Naoaffk/fprXvcoJ45nkyJBkyjISi+
 B2PXzmOURh2IORYF+++Y/nEKlGlV7qqGCBLe1r9Nm60kXIHDbSASumPEUvaoDg7gbX+X5rQ8s
 dxv5SHGKtCmhXocAhuQKwQS5JBpYeOoQy2QA3f1578lPUpkuVkqH8nBLss6t0fEH/QW7pY8bo
 2/vHqQOeqLTK3Xx+nkoxmIlAB14gNAbIgHGvKTuDuvbb0CLYKgDaprAYfJQQ8aUmJNr1AJ9Sq
 8SImbgWpcLKWHKiDFtMrKuQULrxknh4/VLW1T4cTxR9bnyTj/aN7tXCZlRYmQeIrvuczHhGdt
 NDl/mBMqn5/L0w78kmzf7uyqq6M6Bp+kGy3aMfCOlDbfFeQoXTWKFgziKe+ngm4cJJNwB7zYV
 Edb7GN+HRdIVbr9KzIe0j0umLBDCxgUNWpQABdeFPsPksmNWm5UtOqD+rN536MzEu2pEaENnt
 EBYpyzNy2Qgl+UYVbBmG0465gWULvltRvkKQ68lAoxKN5uHOdF8LutgvNX0sK/XdxWWxH3hdU
 R2Vg2sYx1jrkvHvH2rDLZj6HXCd7ZsNRDWdOF+FECTd83oWFpLP1qUnfT1GT8eCxdRniAcpQ/
 uYS5UBt+NNRomRZWtvXZP6uvN6Gx88h+X81J7XGscV4zr8cklRRM73hHEZgKwHH3i0Euvbeqf
 G8mV63/opQg5148uXUFqxcRRi67ZWhTLPwpcjulTXkgR1qr70at2WM2qWBJtTWv40+FAfNhMv
 w+c3WQUXZmaHAoWSfq8ODw6jpnQRIRquJPsXiYaaq/SWvKVKBNDtv9J7NwPoOeVS5Vy50o80E
 HI+VyVV9a0YojxziAwqxo8rHuOPdXNsDD9IBRXk7PPViokAPPW8fosv9ZbCxQnSpm45zjfkRe
 qfJIi0YfQl/uoqFQDshWDsLPcz5tM90aHLUNxvcEzj0pwn83a+FjKozY3Osrx2nl2YhllLLn+
 LQ2u1SgpQd+52beNvHHTaLjavVwzISZ3qQKsSC5JNUX7ELUDfGVTGKjP87f4HADDxqbXR7yVM
 gnGwdqQX2p+BiPBJO0D5yO7Ztt4rMZsciHebLCXpjTwfBd39g+ZMpi6DuVIcUWqPYmbjcyElB
 EzKey3RLyxoIk8teepVfOUQtT26yIngiIb9uChVXUtxLSAHO59Eoul3ZC74L3qsFaiaOzzD26
 icXiMu4T5Ij2SX595
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.20 um 00:08 schrieb Taylor Blau:
> Hi Ren=C3=A9,
>
> On Sat, Feb 08, 2020 at 08:56:43PM +0100, Ren=C3=A9 Scharfe wrote:
>> Add a function for inserting a C string into a strbuf.  Use it
>> throughout the source to get rid of magic string length constants and
>> explicit strlen() calls.
>>
>> Like strbuf_addstr(), implement it as an inline function to avoid the
>> implicit strlen() calls to cause runtime overhead.
>
> This all looks quite reasonable to me. Did you have a specific
> motivation in mind when writing this patch, other than to get rid of
> having to call strlen on the same argument like:
>
>   strbuf_insert(&buf, pos, x, strlen(x))
>
> ? Not that this needs more motivation than that, I'm just curious.

No, that's it.

> I looked through 'git grep strbuf_insert(', and only noticed one spot
> that I could be updated with 'strbuf_insertstr' in mailinfo.c:
>
> diff --git a/mailinfo.c b/mailinfo.c
> index c535dec2e9..543962d40c 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -570,7 +570,7 @@ static int check_header(struct mailinfo *mi,
>     len =3D strlen("Content-Type: ");
>     strbuf_add(&sb, line->buf + len, line->len - len);
>     decode_header(mi, &sb);
> -		strbuf_insert(&sb, 0, "Content-Type: ", len);
> +		strbuf_insertstr(&sb, 0, "Content-Type: ");
>     handle_content_type(mi, &sb);
>     ret =3D 1;
>     goto check_header_out;

Right.  Missed that one because the strlen() call is not in side the
strbuf_insert() invocation.

Ren=C3=A9
