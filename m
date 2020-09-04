Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F08C43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 20:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C2020E65
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 20:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sBIX9IfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgIDUTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:19:16 -0400
Received: from mout.web.de ([217.72.192.78]:39041 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbgIDUTB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 16:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599250719;
        bh=1PAHKN1vINOxHDdmnZQ8MYdlTyN25cXhUOMRbXkxUd8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sBIX9IfTC4arocrJtdkZtIvlTp6moMaVYZJWNY4mM5n9IJ2AMGAy4Hba4PG205wy5
         aCxyjShS1o5DdqHkYz4VY6cAUMbRAlW+fSAlj5Q61MHEGcyoFhsgxvF5bcMkwdKXSV
         ti874S4cMjVtIzblDApM3h9bizqCbCJczEj46viM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVu5c-1k3LxX1xVI-00X1wh; Fri, 04
 Sep 2020 22:18:39 +0200
Subject: Re: [PATCH v4 11/14] csum-file.h: introduce 'hashwrite_be64()'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
 <d7cbd4ca1a5dd63fb1d19ef97fac9765daa5ae03.1599172908.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bca1af61-e664-b89c-03f8-9481c670baf8@web.de>
Date:   Fri, 4 Sep 2020 22:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d7cbd4ca1a5dd63fb1d19ef97fac9765daa5ae03.1599172908.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rFULay4Xtb3Vs6vr31732aXIkXsU9x+2YNZNjsSkl4vGWeIIbLo
 ipEgWMQZUeo93UHt5ZXdD8dwK30+wcI4KOrMUiq/c4U/fJ+uSP63lJDFw4GM9bmeJN43XRO
 uYNT8DzRvTk3xUr+6cGYOgvByS42yH6frW4gb373ne3A0YYjCAsIcbHBdMU//kIZoj1ysTY
 COzaPG4k9eJltEnuFOzwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pTLRDK/z8os=:zu9sveU6/o98IoLCP3HHGt
 QQo62Uue4al0o5Hs+EgDDNnn3VjTlYJwZyKrIwmenzTA+4VDgCDZbDO6zkY/++iTqCDIkMaMz
 RUFm4XuW19EnWAU9MjPmrTHdsotLTQrKknYOact8Bos4me8inWgQvVkDuQ7zoJxdOA3RNINQw
 oDYaciDkzn47+ZwdTmJQMn5gfgcCFkM1aJBAL5gE42QEXFZSztvYr9INHKZ9HmWx+7FtrZuCO
 AL/bmsgbfRm1isZfbpTKyGh45NGJ6Hmq9y3eGYJ4cj/EuyetxboXdhAqp7qib6h9j19y1SQdy
 2hKLOkQKXFRNYJZwzMbfox0siXDAHxHg+Ht/9yOWjbYY0OR4/jnFmr+AI8vQg+HoaEOh9WR+4
 d4zlgbk/VjshqBEZEkOmxBgAO1XhLMYwtjs3EDIpe3TnuXIdOfEVz2ZhRM5fEcKIB5Sq0WkDc
 z7IjrbYS1UVLEv6eTW/Au4OL5KhKd9h+Xvbj0vU7TIACq4suIy+B7z6us+dIZ27KUUby8Pq/+
 N7OgZui0RbbI3oTeSRumu9w8nN4btRE2fB5epYYO4xVS7LK0IuutGoLnmJFAE87F4QV4Me6m6
 /3iKypzd7wPLeV39qS91kePersg6FGhh+9DRncLrHkqi57M+sDydRBO7o08iBbYQTnmZPHIST
 FdXnoA9r2v247LxpAV0IC5IG/BK5LT234PYPDoGA4RRxbCI9MVG+F1SagCXimPfXmpC5FUrr2
 9PtDgOuavz58E+xbTG8YUL1mQ1eabjmZLUeVvWHSzmW+6vUA5RZlcjcswGl6H03+87wv+T5Wx
 8+gs0TNWN/aYSEOHxhd9MMel7kUGJLRwlCeEOb1Jazkn8+j+4l0ZxA+F8u44CyD15D1fTP10s
 zuBRLqvhY7eNo2gJr6Kf+kO1AeFatwbW/NwmKYOPVrynyAgngkdb87bK7FSs9MVrzeZtquKOR
 WzjYvCV+TdUoyDjLGzK0H2OsSok3U0dUBAl5Ozvjn+FML18amXHcnUa5iNE6Q36uskYJzuydI
 uKmfoGMalg6LDoW1stCHCVwCfbQTTPlYkTCREec3odu3Vv0LyO2OBCAGNTkPWXJMWko/rzW2o
 NqFWJG19Lr4z2jeJQbI2Q81pWJ5A89ZD89UHJzi68nwDzhp15dyQxN7rSaTDdbEUuqaXlibyf
 ErShky9R91xlF9Jglv04ChNJABGk9ztK41KNpza2nuFyC+j+DnNRa/8q08d8OONxxdGyJsyt9
 aN1bkyyuChXQ/ohiK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.09.20 um 00:46 schrieb Taylor Blau:
> A small handful of writers who wish to encode 64-bit values in network
> order have worked around the lack of such a helper by calling the 32-bit
> variant twice.
>
> The subsequent commit will add another caller who wants to write a
> 64-bit value. To ease their (and the existing caller's) pain, introduce
> a helper to do just that, and convert existing call-sites.
>
> Suggested-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit-graph.c | 8 ++------
>  csum-file.h    | 6 ++++++
>  midx.c         | 3 +--
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 35535f4192..01d791343a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1791,12 +1791,8 @@ static int write_commit_graph_file(struct write_c=
ommit_graph_context *ctx)
>
>  	chunk_offset =3D 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
>  	for (i =3D 0; i <=3D num_chunks; i++) {
> -		uint32_t chunk_write[3];
> -
> -		chunk_write[0] =3D htonl(chunks[i].id);
> -		chunk_write[1] =3D htonl(chunk_offset >> 32);
> -		chunk_write[2] =3D htonl(chunk_offset & 0xffffffff);
> -		hashwrite(f, chunk_write, 12);
> +		hashwrite_be32(f, chunks[i].id);
> +		hashwrite_be64(f, chunk_offset);
>
>  		chunk_offset +=3D chunks[i].size;
>  	}
> diff --git a/csum-file.h b/csum-file.h
> index f9cbd317fb..b026ec7766 100644
> --- a/csum-file.h
> +++ b/csum-file.h
> @@ -62,4 +62,10 @@ static inline void hashwrite_be32(struct hashfile *f,=
 uint32_t data)
>  	hashwrite(f, &data, sizeof(data));
>  }
>
> +static inline void hashwrite_be64(struct hashfile *f, uint64_t data)
> +{
> +	hashwrite_be32(f, data >> 32);
> +	hashwrite_be32(f, data & 0xffffffffUL);
> +}
> +
>  #endif
> diff --git a/midx.c b/midx.c
> index e9b2e1253a..32cc5fdc22 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -789,8 +789,7 @@ static size_t write_midx_large_offsets(struct hashfi=
le *f, uint32_t nr_large_off
>  		if (!(offset >> 31))
>  			continue;
>
> -		hashwrite_be32(f, offset >> 32);
> -		hashwrite_be32(f, offset & 0xffffffffUL);
> +		hashwrite_be64(f, offset);
>  		written +=3D 2 * sizeof(uint32_t);

"2 * sizeof(uint32_t)" looks slightly out of sync with the hashwrite_be64(=
)
call now; "sizeof(uint64_t)" would be more fitting.

>
>  		nr_large_offset--;
>

There's also this potential caller:

midx.c=3D802=3Dstatic int write_midx_internal(const char *object_dir, stru=
ct multi_pack_index *m,
midx.c:981:             hashwrite_be32(f, chunk_ids[i]);
midx.c:982:             hashwrite_be32(f, chunk_offsets[i] >> 32);
midx.c:983:             hashwrite_be32(f, chunk_offsets[i]);

Not sure it's worth a reroll, though.

(I'd probably leave those conversions for a later series.)

Ren=C3=A9
