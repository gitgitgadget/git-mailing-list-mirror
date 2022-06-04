Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DFEC43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 21:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbiFDV2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 17:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiFDV2M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 17:28:12 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3919D10A
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 14:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654378066;
        bh=fec1qXA1WT1qJ8kdOF1CEkbt+Tp5H/hbc3wFLxVVeJc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qkJpM+IuKB8aXe/nGaDZlE5bREG9zriK/0boAURn9bSLhz9yAQ+DackVpFL1KGzK9
         ayJzC2MKSNjRyFmGpe9BJulMknomvSv5R9EArgkLsetT9HkFj6nMW2Xk6gVkpcn8KZ
         S0xS/ND2RyVyoZ1D8OR+CHwEpeYYUpnvP26GcaZ4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB07-1oJJA30vhZ-00VD2O; Sat, 04
 Jun 2022 23:27:46 +0200
Message-ID: <5db7bbf7-a6be-20c9-8233-92fbcb94a266@web.de>
Date:   Sat, 4 Jun 2022 23:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 08/15] strbuf.c: use st_add3(), not
 unsigned_add_overflows()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-08.15-2c4b7832144-20220603T183608Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-08.15-2c4b7832144-20220603T183608Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lAIxkYfYrOvKiAuN/CDH7j2iEWF80QuncemFRrX6tS7AmopDKJ/
 jTOShqMBezk6eNxh1Fq5x5MI/v0JT7igr8DpjQri1tGx4DD21SXu88pAdubEdggbdRRcxOK
 Rx+MO+x75vUdPKjGpKgYcoN0ANYc9z/gYAZqvfBxWYY6Wir5nqTeVX5vAsw8vTWa7EiJxij
 vD4DIK3UXG3QqWP9EZt0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MpK3fVrK6sk=:MIcKFv5H8vScvcM/20Q2rf
 mLLniyY719wYrQID997dO/OL4n8rPgzP2V1u5SrrIGDM2Ixdkd6zLMAScOedn/ppUjvbYVccE
 pZL4CUbUM52bH0qlmIqgKIW4wQnfw9au7mbUipv5EaH5dDWnl5/As7goUesRmkEYmpEgpDPEx
 d/bJoYPXM2CJ7YMYn81K4seNNseopP9SILrQIz2dXR1+x17YLki6KJqkqdUaBOqgGxn1josEC
 KlnoXVaV3kHsggFdtMOxJU08+TSvj4t+CKvV9fqO1Tk7lkWbsiLSA+wMjQNOuUiIgBncwYUi3
 SECZS534XZ5kgFRSIMzgXYT8qRixxN0lq90UpJPZoQwzptyOhnFSs/myGSlscw7xLk7RzJw/E
 MrC6+/MGohdgaYnarZ/D6dzVqVSWh/ZGuT6V/xYQcUIq/tzCW9t9M/HWL090vyEey6iA4IkxV
 uLUtip05Q+stgVh4pQVvJA8b0sPtZ0l+z2mrg06gxRb3b7NdxGUz6oo5hNLk4+Do3pFMIwTyz
 XegcUFGQhdGfi3en2Z8qj77vsCQZc+7MC4xQWc5LaKZbcf6pr6dgMqdLENSu22pWyKEOUhSYL
 hpncCkDytRBuglpjtsm4qSC1NeHTamH2YssAes+jpLJ45SZAB3uLWiRbhNqEbmtks/vzkzhRU
 oyZdLQoEL9JSlo9IhtQ42U+Np1YHmfREnAINLEtrrAnQx7VvDU5IvHYxbrSa4X8PA3WUJsZOK
 kjynsgWxE8mHeNGdOtg8R5fxtr1+etAF10bzS0UvslxM3eJP0S6Aa7aE1BZ0VxLy+IXyvXSFQ
 Goz7SFTLXrs/ACyfuIYWYR3hDlqgUvBs73cVqrVEdPsyef/5lKqUVYCOqfjR8KDeun/Jnf7/j
 islaoHf1SQSXgZ8grN/Sig9WkYvL6A6GSJuQ+zOZ7IN/ASiJ92k9oQPAvDDlHneXktZAPVxub
 9/qwLbuMvxYVpAs+Yn/v9vvOR+RM8UXDYftYOdXnIHRXPLXIZLlzURyoLGIev3qoZfZVybgbi
 ciOuKTAXiSMau7YfHCAFykeAAGnwH32VgGrN4jipt7FURvlayA1t8iAHSSRggs2oRzFZClywk
 AMxOzCKe30uh0Xjn7OoDwMME0ILXRVMFnCJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change the strbuf_grow() function to use st_add3() instead of doing
> its own unsigned_add_overflows() checks.  The overflow checking here
> was originally added in b449f4cfc97 (Rework strbuf API and semantics.,
> 2007-09-06) and adjusted in 1368f65002b (compat: helper for detecting
> unsigned overflow, 2010-10-10). Instead we compute a "sz" with
> st_add3().

Good idea.

> That was done at a time when the underlying xrealloc() in
> git-compat-util.h didn't use st_mult() yet, that has been the case
> since the later e7792a74bcf (harden REALLOC_ARRAY and xcalloc against
> size_t overflow, 2016-02-22).

How is that relevant?

> The only behavior change here should be the very obscure edge case
> that we'd previously die() in cases where we strictly didn't need to,
> as we'd check both "extra + 1" and "sb->len + extra + 1" for
> overflow. If we overflowed only on the latter but were doing the
> former we'd needlessly die() die.

st_add3 does the same checks.  What do you mean with "doing the former"?

> I don't think that difference
> mattered, but it's noted here for completeness.
>
> While we're at it add an inline comment about why we're adding 1 to
> the values, that's also explained in the API documentation in
> strbuf.h, but since we're using that magic constant here...
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  strbuf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 61c4630aeeb..f0a74d2bfb1 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -91,12 +91,12 @@ void strbuf_attach(struct strbuf *sb, void *buf, siz=
e_t len, size_t alloc)
>  void strbuf_grow(struct strbuf *sb, size_t extra)
>  {
>  	int new_buf =3D !sb->alloc;
> -	if (unsigned_add_overflows(extra, 1) ||
> -	    unsigned_add_overflows(sb->len, extra + 1))
> -		die("you want to use way too much memory");
> +	const size_t sz_buf =3D new_buf ? 0 : sb->len;

This is a change in behavior.  The one you meant above?  It ignores the
len value if alloc is zero.  Any len value other than zero is invalid in
that case.  Adding code to paper over this invalid state seems a waste.
And if a brave caller fiddled with len before calling strbuf_grow(), the
resulting allocation will now be shorter.  Hopefully nobody does that,
but it's not totally impossible.

We could report the issue instead with something like the following:

	if (new_buf && sb->len)
		BUG("unallocated strbuf has invalid len: %"PRIuMAX, (uintmax_t)sb->len);

I'd rather keep the old behavior.  But whatever we decide to do, I think
the st_add3 change deserves its own commit with no further change in
behavior.

> +	const size_t sz =3D st_add3(sz_buf, extra, 1 /* for \0 */);

I don't mind the added comment.

> +
>  	if (new_buf)
>  		sb->buf =3D NULL;
> -	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> +	ALLOC_GROW(sb->buf, sz, sb->alloc);
>  	if (new_buf && !sb->buf)
>  		BUG("for a new buffer ALLOC_GROW() should always do work!");
>  	if (new_buf)
