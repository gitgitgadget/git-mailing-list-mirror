Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA28420248
	for <e@80x24.org>; Fri,  5 Apr 2019 10:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfDEKlk (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 06:41:40 -0400
Received: from mout.web.de ([212.227.15.3]:41195 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730283AbfDEKlk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 06:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554460891;
        bh=vtar5/stMkrPLkoRjMrsa0gtjNclkqjOBvQIYX3lqVs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=iNFEMO0uiHEae59ffqKIc0QS6hlnkMb7JQHaexj9tWeziml4mS9nrCRHgNwNSYObA
         h92WON/bDnWIBhdXkGCe6HoRJSUf/18IpivRi6PowLwBsdSHlynwkqauclEP6WhyRR
         pAb4jxJ6SdFiAe+vSWI5BZKXmGmjA1YKs8emXBXY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.22] ([79.203.21.163]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mg7Zl-1hX2Ss1xQb-00NPNx; Fri, 05
 Apr 2019 12:41:31 +0200
Subject: Re: [PATCH 05/12] http: simplify parsing of remote objects/info/packs
To:     Jeff King <peff@peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
 <20190404232704.GE21839@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Message-ID: <83129937-dcd0-f16e-c8aa-97eceec9769a@web.de>
Date:   Fri, 5 Apr 2019 12:41:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404232704.GE21839@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Jy/Vx+CVO6izkdtsLABEsg9g4vA9HOt0NvgA1N7NGFnTTD4z2t
 G1Y0l6pMsw/+fHCo71EpjZJBn7uzY7iXu6UcP2bfrUHriMeHqmmPebQByp4OTx49CS4YtoJ
 +ljol6maNlYBJfTuW4ma5his+Lt5aJc6fHoe5r74lIVBNErcFMW3qHf+xnXx0TB5UF0zx3g
 D/LTiTe5oQwP0FRVzqv/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IiVWAUBJKq8=:4YcML3/G2zsxLwmlr4+1mY
 0m0S4LS/74pI++OpK2ZZDJdXMQE2viwqC3ONSSdvTB8ISkDiGvPk5MwOZxSOU8c/QQBSXUI4F
 LTIw3evusCNSvmgAnmKNTwn4fARpkRWZbOVWp7zPCHaCbNdcguit1mHsFsTmZ5UP9DE3vjr18
 IkmLZb+O50IibScRJbTxlkQ+deml4K5UunutHLF+w+lv4gKVOXEiOWwOqNvj9ZwlMTbAu4rlm
 pTmhKyeJtpCOQJuItcZKFGFMFgPixbSY8cL0X8MdSzeiBWQ0cURTuoU4dLmiqWS5SbyQbQXU8
 oQCRgLmeeKKV8c8LdhV6HHQfqJJ4Mf2sgvLPjBnJcFJKnnn0u7ZRLXYhcMj0liDXpLefNVXce
 RQuVLIBCpJEUwLGkZTCEsATtJxA4jWccL4v8OrPIplXm4kwqkg58rs6nHj06VjZPL+ZZjIi3o
 p2GkQyIvlKeYx+dlWasE4sUVCPlf5+p+GIR/v+CXPKf+lpFAqDqw9ByP9/g/ahvIMf3SMrkJP
 NaYl2SEPsAJCJZwn6RlaoSuguS56uDl/P1wOXKeStW+SLA7MB5KKdnNbvOvNGtYk4HJ8VSHgJ
 kh7ce3Q8Dy8XknJgzT8a06kmTBpSJMspVIg+rTu+1yZ7NklqUnxNoR3EstTGRh7zwQzWHZFwp
 7henb4FmknKNACueMrk+Km5IZBqkzJQHMG28q2HwJVH/ggkVtENxfVyYRoHCpbDn20PXQPE0r
 1WUOV8JPPxzx3wSMQ8US2PGwC0SC4UdLf2S0Dcaz2hlh0G0gPdc0tLnBDua0xcWdlLhIDcRQz
 6qqV4708rT7SU4fOIuWJ5vymp9S8YcZ8AV2nRRIM+PLkql5EdCWLj109o9uILAi9ZGHU0UEai
 8xXmlUHtrOXty/GymydMcNoTYAgRG1IDJMoCpue8XewW21JH/CvX7YM7X+HAMf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.2019 um 01:27 schrieb Jeff King:
> We can use skip_prefix() and parse_oid_hex() to continuously increment
> our pointer, rather than dealing with magic numbers. This also fixes a
> few small shortcomings:
>
>   - if we see a 'P' line that does not match our expectations, we'll
>     leave our "i" counter in the middle of the line. So we'll parse:
>     "P P P pack-1234.pack" as if there was just one "P" which was not
>     intentional (though probably not that harmful).

How so?  The default case, which we'd fall through to, skips the rest
of such a line, doesn't it?

>
>   - if we see a line with the right prefix, suffix, and length, i.e.
>     matching /P pack-.{40}.pack\n/, we'll interpret the middle part as
>     hex without checking if it could be parsed. This could lead to us
>     looking at uninitialized garbage in the hash array. In practice this
>     means we'll just make a garbage request to the server which will
>     fail, though it's interesting that a malicious server could convince
>     us to leak 40 bytes of uninitialized stack to them.
>
>   - the current code is picky about seeing a newline at the end of file,
>     but we can easily be more liberal
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
>
> diff --git a/http.c b/http.c
> index a32ad36ddf..2ef47bc779 100644
> --- a/http.c
> +++ b/http.c
> @@ -2147,11 +2147,11 @@ static int fetch_and_setup_pack_index(struct pac=
ked_git **packs_head,
>  int http_get_info_packs(const char *base_url, struct packed_git **packs=
_head)
>  {
>  	struct http_get_options options =3D {0};
> -	int ret =3D 0, i =3D 0;
> -	char *url, *data;
> +	int ret =3D 0;
> +	char *url;
> +	const char *data;
>  	struct strbuf buf =3D STRBUF_INIT;
> -	unsigned char hash[GIT_MAX_RAWSZ];
> -	const unsigned hexsz =3D the_hash_algo->hexsz;
> +	struct object_id oid;
>
>  	end_url_with_slash(&buf, base_url);
>  	strbuf_addstr(&buf, "objects/info/packs");
> @@ -2163,24 +2163,17 @@ int http_get_info_packs(const char *base_url, st=
ruct packed_git **packs_head)
>  		goto cleanup;
>
>  	data =3D buf.buf;
> -	while (i < buf.len) {
> -		switch (data[i]) {
> -		case 'P':
> -			i++;
> -			if (i + hexsz + 12 <=3D buf.len &&
> -			    starts_with(data + i, " pack-") &&
> -			    starts_with(data + i + hexsz + 6, ".pack\n")) {
> -				get_sha1_hex(data + i + 6, hash);
> -				fetch_and_setup_pack_index(packs_head, hash,
> -						      base_url);
> -				i +=3D hexsz + 11;
> -				break;
> -			}
> -		default:
> -			while (i < buf.len && data[i] !=3D '\n')
> -				i++;
> +	while (*data) {
> +		if (skip_prefix(data, "P pack-", &data) &&
> +		    !parse_oid_hex(data, &oid, &data) &&
> +		    skip_prefix(data, ".pack", &data) &&
> +		    (*data =3D=3D '\n' || *data =3D=3D '\0')) {
> +			fetch_and_setup_pack_index(packs_head, oid.hash, base_url);
> +		} else {
> +			data =3D strchrnul(data, '\n');
>  		}
> -		i++;
> +		if (*data)
> +			data++; /* skip past newline */

So much simpler, *and* converted to object_id -- I like it!

Parsing "P" and "pack-" together crosses logical token boundaries,
but that I don't mind it here.

Ren=C3=A9

