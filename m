Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE6C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 08:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B20611C1
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 08:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhKDIqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 04:46:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:40703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhKDIqS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 04:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636015408;
        bh=WC3ru3WDcNedFYx7n7Z/AcDqhUCiK2NDXBiGINAlS7U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hLY8wtfc/v6cP7enueyvnOSzaCoCmQAj9eLI3R2Wklet/WFJqA3ZTlcpCFVvnYR0v
         jxfzPzZrJ5fut5t2JBTfyWEwLz0WSNJQuZwo9C6sUCJ8uBPRub+/0ys4C+n0+q/9Fv
         sn+yjEVBFT6A3n+1BxQA4Tl2SYJgR1z6MY2ZpBik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQkK-1mVGiG07JQ-00vM5m; Thu, 04
 Nov 2021 09:43:28 +0100
Date:   Thu, 4 Nov 2021 09:43:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email,
        eschwartz@archlinux.org, Carlo Arenas <carenas@gmail.com>,
        Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] async_die_is_recursing: work around GCC v11.x issue
 on Fedora
In-Reply-To: <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111040823270.56@tvgsbejvaqbjf.bet>
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com> <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:93Zb4f0nZ8ZUYeiRMvrvPDnhqqddLcTdqKGveMdbJL4u1Q0C6fc
 DVqLZXWh6brl4zS+t8Un1KSHPi+dB4xuHkqU/3Iet+HNLWA3dzYViJE2pCTGyAjHAaAiYdQ
 sq//ij6TigLMhZSsuw+Yvh3xT9NjFoviFQIxGB9Bgn0qqEcPIniTR/xJJ7UrjWr/gp3SxV/
 IKeGFq1otEV5yQJEiMjxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XreK6dXF24Y=:mFm6xDu4pYYzYiqO6IYjY+
 5lfwNGNse504c2bv9FiP2dc7fb+e8unmw47YWVX7qeEmn9vNFRdD/jm+bzLUNyEv5WMu6NPrY
 kPokrqYrf30tZYKvwzJDzUqCZfxEkR6wTKw7IQyMxWvweoV3Ryt0bMJBuURMRB5lz4TGVWPvo
 TiH1dQElgNgAAMFVBQSrw/G//lgdO3jg6f3OerT9czBjM9iXre1BcSd3wJiqCwF3EUOMXoyNh
 IvBdSRRmwsgEhtdUV45z1mT8mYOXn5vUtVVvREmpZxKtEUJhzp7AsJack6weO1b7qM58HAEte
 K1dPJVOzUMNKPbGkxmikIxKDfA9lJs7qBi8Yr1h/D2m/3bYb3oXW1ndy//PnuuwsNyd+extv9
 Tk46IrVAbc4w45oJTTY3K89CWicdUYpsc8MWJvxuFpjs9i410PgvZMGPhCj6uQ1Y+UidxeC0q
 G9RizJm1ME73pz02fcGQVK1iIWdYbDEjS87RUFjb82RR/+sRjKrNI2olhEl1+gzWwdmUwzaW4
 lpeyNx5n0Ttf0EzQM1o8Gvcf/kKsPZ0SmkFN0UdR2x3x8dht8+xoBaKLWKeJbn59qavhtIElO
 iy0IUGoCbP80piiEpjaocGlgTseubhmRoEaDWO/WXih++Q6Xr20qf1hU16GvBkttMSV9A6rO4
 3xPMlm5qLJpH3xhZhBEMq00sT0UHjfy5BJ7FLDw/bplv4PjanZNxt5wIGT01ORMSz9xUqAeQR
 jB5ekX14g9qoVvfMhPNxnMTSTXl2XZmwJbQHXKXyE/WxucxCKq3ZZbxB72FoxmlCaLZmUBYlk
 KRVS4R/TxhOCQ0oaY/TSREbAqL/FLavNIfdix6XHhd4OxwRiPMrNBjsoQJUVqvdTeRqVVbBV0
 FR9ejLFlGvXeFmqFO2gXae8MwBcTRYqhIxOLugwDUQ7VW7puoczqVuR7xofUtqZYXw89GIlup
 lsz/brAr6kwxiNrUDJzhnVbjXOkYlRyZK/X3uJwalSCBBM0RtMuX+BAftnIfVbtWSi80r0say
 NAkh9ehxpMiAKKuJ+YKT7nDDZ2FR6j4yiXZ2rVZAxUGv2NxodU+rIJT8KJuD3QEIbyA2grsKA
 aoCQ/N6qRFWQyI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

excellent work! The patch looks very good to me. I just want to add a
little context below, and thank you _so much_ for letting me sleep while
you tie it all up in a neat patch.

On Thu, 4 Nov 2021, Victoria Dye via GitGitGadget wrote:

> [...] This image includes a version of `glibc` with the attribute
> `__attr_access_none` added to `pthread_setspecific` [1], the
> implementation of which only exists for GCC 11.X - the version included
> in the Fedora image. The attribute requires that the pointer provided in
> the second argument of `pthread_getspecific` must, if not NULL, be a
> pointer to a valid object.

My initial reading last night was that the `none` mode means that the
pointer does not have to be valid, but you're right, the documentation at
https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html
clearly spells it out:

	Unless the pointer is null the pointed-to object must exist and
	have at least the size as denoted by the size-index argument. The
	object need not be initialized. The mode is intended to be used as
	a means to help validate the expected object size, for example in
	functions that call __builtin_object_size.

Which means that yes, `(void *)1` was incorrect and _had_ to be changed.
The patch is therefore a fix, not a work-around (contrary to my initial
impression).

So then I got puzzled by this while sleeping: why does it fail on Fedora,
when it does _not_ fail in Git for Windows' SDK (where we also recently
upgraded to GCC v11.x, thanks to the hard work of the MSYS2 project)?

My best guess is that my GCC (which is v11.2.0) and Fedora's GCC (which is
v11.2.1 plus the usual Fedora customization) behave slightly differently
with respect to that optional `size-index` argument:
`pthread_setspecific()` is essentially declared without a `size-index`, so
I guess GCC v11.2.1 probably defaults to `size-index =3D 1`.

> diff --git a/run-command.c b/run-command.c
> index 7ef5cc712a9..f40df01c772 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1099,7 +1099,7 @@ static NORETURN void die_async(const char *err, va=
_list params)
>  static int async_die_is_recursing(void)
>  {
>  	void *ret =3D pthread_getspecific(async_die_counter);
> -	pthread_setspecific(async_die_counter, (void *)1);
> +	pthread_setspecific(async_die_counter, &async_die_counter); /* set to =
any non-NULL valid pointer */

This looks good! To make the intention even clearer, we could change the
line above to `int ret =3D !!pthread_getspecific(async_die_counter);`, but
as we are _really_ late in the -rc cycle, I am very much in favor of
leaving out such clean-ups that do not fix any bug.

Again, thank you so much for your hard work, it was fun debugging this
with you,
Dscho

>  	return ret !=3D NULL;
>  }
>
>
> base-commit: 876b1423317071f43c99666f3fc3db3642dfbe14
> --
> gitgitgadget
>
