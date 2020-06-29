Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D913FC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA1E2073E
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="a4Ju3Ckj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbgF3PBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:01:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:56611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbgF3PBP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593529261;
        bh=ufocMUWcIp5shYwPfRLjJCXAvNeU9aEbF4WdMi48BAI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a4Ju3Ckjy2YN4c57OK5owhRB92If0Lhe94gTMKHOb4nWj+mY9R2JLrdv3YXEnHbor
         UbX1zeryRku51W/8elDaEqYZWYhQZUXCB/th+LLzoliD0mbTmmtMduMoQ+/9Yq0H63
         aNnLPiKWDXqRClZPfiL+WGB75KwSiDrucHdTXXVM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.212.146]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1jhWJR1K7c-008paA; Tue, 30
 Jun 2020 17:01:01 +0200
Date:   Mon, 29 Jun 2020 17:11:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, j6t@kdbg.org,
        jonathantanmy@google.com, peff@peff.net,
        christian.couder@gmail.com, Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v2 2/2] hex: make hash_to_hex_algop() and friends
 thread-safe
In-Reply-To: <b47445fa1cef6d4523dd0ca336f7ee22bce89466.1593208411.git.matheus.bernardino@usp.br>
Message-ID: <nycvar.QRO.7.76.6.2006291646420.56@tvgsbejvaqbjf.bet>
References: <cover.1593208411.git.matheus.bernardino@usp.br> <b47445fa1cef6d4523dd0ca336f7ee22bce89466.1593208411.git.matheus.bernardino@usp.br>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3PpkaJz0y4lp21GXNhiB/BXEjcVrxMtgyyHw0xh9AIhwdLlbKkF
 HHMC/HAvTkntLuuAh0PbwNfoKmEK3DlCb5ig2yc43JdFoo1Qiln5TPXbhw6u/a46LoAWVQJ
 NOYRoAPFdVHVwVGlUhnGx5b1pMUldRTwbddHD1Qpl3XofkdYumjsO8e9LWGAu3H8h5lWWrD
 rMovKGC9w/PditzVdYB2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jaGwqMudt6Q=:paSFswF3VIeR34nUqAvM+S
 nlldJTmNjyx7GQTnemDQG/s6WqM9oJMbev1ngCXsBOQEN1JeyptUbR7Tai4H9vjyvq+nS5zrE
 JXysva5ea/kx+LQoVVOmyh1+wosA9POezr/rmZpZPHYmHugNWcWFe5sY76aSCA/1RjW6hYIXo
 aI1L/0MuZGX4cs7zdNOZrdOS2Y/z2hhT4F8mUS9kZUeUKDMB28Do4en9Ej+ILyolHHy9m4+XK
 8yk8t4dhTWD870r1tyRBaHiUjvWQ9HSBB99gQdZO5vISVxqARfObgA89tJBnlaEYjueyXH6A3
 ZIUN7Xxf35pWjtUCAMKk9GMMLZoKeSNrWBZ5jBrsJFS3Jr3j8atdy+MLFopEHgXJg5bWJ0Doz
 Tcg4E1WXCOjOkDBeNCsDDN9lTmRjksM+sp9bKKDaTdIwx2hsw6r50MFCeG+Mi3zplvib/XqXc
 +dXxhSkP6Py8AsjaC+vyz+vbnkD2nO0r8/LIxQYch3R2o9697LvPOwtKYE2wqVIs+fokwURvU
 KgneZ8id+q5Migt3NLCJuyVZc876F7g/IDN73l8wyiBAsXzxaTSVAEat67u7lFxHUqoMuS7jH
 94kZfkhYXJQrpjjmmbiO8Pgl6LjQrQirwIQpqDar16dM+TZwTUEoLGEpfmpWQLJhwMh1JqySo
 6HOdsHIp7Mmtxn2n7D/Ia2QdwaP6ou57SPPKsjnw6xXD2Rh+5hsQR7R7seMOLZaUKdY7zwsEv
 JJUs/+v0x/AACs6zuZnORQqzdLkYYPGUNJND7kz+xHCuh0VdtuWPZijrXvvQ1gvT1T8+so2O1
 aH1PuVzO/vgLGfsUqNyCiiKpDiKlThKUPbu5yOJQBLPI1QBz5rm7d6tFOp1FIEknWqM1rxVO0
 u14Xwpsghba0g6Ixo7MWLgEO+QyG7SNMfqEmaMg/AWGUhalkP9XEeID/Tsb4axxo42H0YYQvP
 sMn/00SIU3cT5DviaNgt3f58PqB62f2Wmvht24uxP8mgQrvzj1bT/80KsKBKL5vVcbo0pue9u
 ajwTmymZG4VDExgl7TocjVRykuuqAT5PUx990UzMyyHRNQM9F2oqTvc8wQYIgmfLaebpzJgY1
 gFEvothvPDCsoUR7lK7m3HCmxk6U+zYLQYyMVLIEzOcwOKIyljfQPpFgDGdEEdJFMv1A77RVd
 DoHacoxCfzEp8v/3UEFSNFt9KAh950K6knDEsOq7qLPXD7DDkyjSbO1buGLItY6BwpsQ8oxc8
 7nOUHbIM0jB5nutNqO2A2f9KTIB/xcQcVwLfqpQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

I am fine with the Windows changes (although I have to admit that I did
not find time to test things yet).

There is one problem in that I do not necessarily know that the memory is
released correctly when threads end; You will notice that the
`pthread_key_create()` shim in `compat/win32/pthread.h` does not use the
`destructor` parameter at all. The documentation at

	https://docs.microsoft.com/en-us/windows/win32/procthread/using-thread-lo=
cal-storage

is also not terribly clear _how_ the memory is released that was assigned
via `TlsSetValue()`. I notice that the example uses `LocalAlloc()`, but we
override `malloc()` via the `compat/nedmalloc/` functions, so that should
cause problems unless I am wrong.

Maybe there is an expert reading this who could jump in and help
understand the ramifications?

A couple more things:

On Fri, 26 Jun 2020, Matheus Tavares wrote:

> hash_to_hex_algop() returns a static buffer, relieving callers from the
> responsibility of freeing memory after use. But the current
> implementation uses the same static data for all threads and, thus, is
> not thread-safe. We could avoid using this function and its wrappers
> in threaded code, but they are sometimes too deep in the call stack to
> be noticed or even avoided.
>
> grep.c:grep_source_load_oid(), for example, uses the thread-unsafe
> oid_to_hex() (on errors) despite being called in threaded code. And
> oid_to_hex() -- which calls hash_to_hex_algop() -- is used in many other
> places, as well:
>
> $ git grep 'oid_to_hex(' | wc -l
> 818
>
> Although hash_to_hex_algop() and its wrappers don't seem to be causing
> problems out there for now (at least not reported), making them
> thread-safe makes the codebase more robust against race conditions. We
> can easily do that by replicating the static buffer in each thread's
> local storage.
>
> Original-patch-by: Fredrik Kuivinen <frekui@gmail.com>
> Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  hex.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/hex.c b/hex.c
> index da51e64929..4f2f163d5e 100644
> --- a/hex.c
> +++ b/hex.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "thread-utils.h"
>
>  const signed char hexval_table[256] =3D {
>  	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
> @@ -136,12 +137,49 @@ char *oid_to_hex_r(char *buffer, const struct obje=
ct_id *oid)
>  	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
>  }
>
> +struct hexbuf_array {
> +	int idx;

Is there a specific reason why you renamed `bufno` to `idx`? If not, I'd
rather keep the old name.

> +	char bufs[4][GIT_MAX_HEXSZ + 1];
> +};
> +
> +#ifdef HAVE_THREADS
> +static pthread_key_t hexbuf_array_key;
> +static pthread_once_t hexbuf_array_once =3D PTHREAD_ONCE_INIT;
> +
> +static void init_hexbuf_array_key(void)
> +{
> +	if (pthread_key_create(&hexbuf_array_key, free))
> +		die(_("failed to initialize threads' key for hash to hex conversion")=
);
> +}
> +
> +#else
> +static struct hexbuf_array default_hexbuf_array;
> +#endif
> +
>  char *hash_to_hex_algop(const unsigned char *hash, const struct git_has=
h_algo *algop)
>  {
> -	static int bufno;
> -	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
> -	bufno =3D (bufno + 1) % ARRAY_SIZE(hexbuffer);
> -	return hash_to_hex_algop_r(hexbuffer[bufno], hash, algop);
> +	struct hexbuf_array *ha;
> +
> +#ifdef HAVE_THREADS
> +	void *value;
> +
> +	if (pthread_once(&hexbuf_array_once, init_hexbuf_array_key))
> +		die(_("failed to initialize threads' key for hash to hex conversion")=
);
> +
> +	value =3D pthread_getspecific(hexbuf_array_key);
> +	if (value) {
> +		ha =3D (struct hexbuf_array *) value;
> +	} else {
> +		ha =3D xmalloc(sizeof(*ha));
> +		if (pthread_setspecific(hexbuf_array_key, (void *)ha))
> +			die(_("failed to set thread buffer for hash to hex conversion"));
> +	}
> +#else
> +	ha =3D &default_hexbuf_array;
> +#endif

This introduces two ugly `#ifdef HAVE_THREADS` constructs which are
problematic because they are the most likely places to introduce compile
errors.

I wonder whether you considered introducing a function (and probably a
macro) that transparently gives you a thread-specific instance of a given
data type? The caller would look something like

	struct hexbuf_array *hex_array;

	GET_THREADSPECIFIC(hex_array);

where the macro would look somewhat like this:

	#define GET_THREADSPECIFIC(var) \
		if (get_thread_specific(&var, sizeof(var)) < 0)
			die(_("Failed to get thread-specific %s"), #var);

and the function would allocate and assign the variable. I guess this
scheme won't work, though, as `pthread_once()` does not take a callback
parameter, right? And we would need that parameter to be able to create
the `pthread_key_t`. Hmm.

Ciao,
Dscho

> +
> +	ha->idx =3D (ha->idx + 1) % ARRAY_SIZE(ha->bufs);
> +	return hash_to_hex_algop_r(ha->bufs[ha->idx], hash, algop);
>  }
>
>  char *hash_to_hex(const unsigned char *hash)
> --
> 2.26.2
>
>
