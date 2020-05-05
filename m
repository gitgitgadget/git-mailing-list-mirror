Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A58C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 06:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132AF20721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 06:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ovmhcwbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgEEGh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 02:37:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56382 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgEEGhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 02:37:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7D13DFD7F;
        Tue,  5 May 2020 02:37:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kPyt3V1zmgVU
        Nlqts/viRtPNY5I=; b=OvmhcwbzJ6NcT89OYOzf6td1vveX66rVqQmdn1D4HUmu
        nrvg9Nu57ivx/mYM9KwoZ+HuIJJizSts5yURkuCT0cdlv/MARTq2GbcjNynROfAC
        fnz44nqpriOcdTMu0pryTqlVrzZ4O7odAnw4ZiFh9MYyatV2x6rABBhhJEAgWMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=twtREo
        JWaX/gkzjbZqQxnj7g5T+MyWJtbWIYLTKtnOHiFhH49q8/8/9oudMUlRS1G7aN21
        P3ZgTLvy3l5Q7Hh3JgL7ky86KVk3ENBXMbgHZ3XhfBGI/s5ygGnX25p+kgrpu08U
        ZqcZRhp9p9tEs+yEvbIu0jNWBH0mVZt/jaA6o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0989DFD7E;
        Tue,  5 May 2020 02:37:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06787DFD7D;
        Tue,  5 May 2020 02:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH] builtin/receive-pack: avoid generic function name hmac
References: <20200505054630.5821-1-carenas@gmail.com>
Date:   Mon, 04 May 2020 23:37:18 -0700
In-Reply-To: <20200505054630.5821-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 4 May 2020 22:46:30 -0700")
Message-ID: <xmqqsggec2g1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DEB03CF6-8E9A-11EA-B4B6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> fabec2c5c3 (builtin/receive-pack: switch to use the_hash_algo, 2019-08-=
18)
> renames hmac_sha1 to hmac, as it was updated to (optionally) use the ha=
sh
> function used by git (which won't be sha1 in the future).
>
> hmac() is provided by NetBSD > 8 libc and conflicts as shown by :
>
> builtin/receive-pack.c:421:13: error: conflicting types for 'hmac'
>  static void hmac(unsigned char *out,
>              ^~~~
> In file included from ./git-compat-util.h:172:0,
>                  from ./builtin.h:4,
>                  from builtin/receive-pack.c:1:
> /usr/include/stdlib.h:305:10: note: previous declaration of 'hmac' was =
here
>  ssize_t  hmac(const char *, const void *, size_t, const void *, size_t=
, void *,
>           ^~~~

Including <stdlib.h> is allowed to contaminate the namespace this way?

At least
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stdlib.h.html
does not seem to list hmac() there.

> While the conflict, posses the question of why are we even implementing=
 our
> own RFC 2104 complaint HMAC while alternatives are readily available, t=
he
> simplest solution is to make sure the name is not as generic so it woul=
d
> conflict with an equivalent one from the system (or linked libraries); =
so
> rename it again to hmac_hash to reflect it will use the git's defined h=
ash
> function.

I do not mind renaming ours, as it is harder to get the <stdlib.h>
fixed on the NetBSD, but I would phrase s/equivalent/unrelated/ (or
even "irrelevant"), as it is clearly not an "alternative" that is
readily available outside NetBSD.  Otherwise we would have found
this a lot sooner (it used to be called hmac_sha1() and renamed to
hmac() in August last year).

> ---
>  builtin/receive-pack.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Missing sign-off.  The patch text is trivially correct.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 2cc18bbffd..b1d939e7ed 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -418,7 +418,7 @@ static int copy_to_sideband(int in, int out, void *=
arg)
>  	return 0;
>  }
> =20
> -static void hmac(unsigned char *out,
> +static void hmac_hash(unsigned char *out,
>  		      const char *key_in, size_t key_len,
>  		      const char *text, size_t text_len)
>  {
> @@ -463,7 +463,7 @@ static char *prepare_push_cert_nonce(const char *pa=
th, timestamp_t stamp)
>  	unsigned char hash[GIT_MAX_RAWSZ];
> =20
>  	strbuf_addf(&buf, "%s:%"PRItime, path, stamp);
> -	hmac(hash, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed)=
);
> +	hmac_hash(hash, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_=
seed));
>  	strbuf_release(&buf);
> =20
>  	/* RFC 2104 5. HMAC-SHA1-80 */
