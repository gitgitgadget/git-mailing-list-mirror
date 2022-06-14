Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C51C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 15:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbiFNPsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbiFNPsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 11:48:16 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5317E0C
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655221663;
        bh=jEkZlEdm8XjzYNDcTiV0Te5xDyGWVVHTzTWKUhuuuc4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Gk/HAPHWi8kGBDsv38+BET0fTW8Tf5UTGn7tZXwuE8Axbuq2DImejtOyehpW2nWMy
         L/s/ntIOf0crT0fP7QT49YIgIkxjJEpNc+aQ3LZXvqcpCj/afY0T40z42LSfdmDBjo
         lSm81dgQyKIglFwGbd0JWyseYiDwmrsUpoaxp4Vo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOm0r-1oMwEa1m6p-00Q2rV; Tue, 14
 Jun 2022 17:47:43 +0200
Message-ID: <28f6ec2a-1d94-b29a-4bfd-6a9e74c8edbf@web.de>
Date:   Tue, 14 Jun 2022 17:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] archive-tar: use internal gzip by default
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
 <d9e75b24-c351-e226-011d-5a5cc2e1c858@web.de> <xmqqk09k449y.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2206141109270.353@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <nycvar.QRO.7.76.6.2206141109270.353@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zH6d1II+L58ne3O6GKtuBsowgESwzRYqE9oUdt4j5wr7CeCUKw2
 kRKrflveUwFejOWOx/ILw8F6G2xhnE+L7eA2JVma9L+hgyyiiExpCiL9xdAIs07njB5pr2w
 E5f5mDsrNaGWkd3UzaSDrlUKY/yodyjVtgLMZnBdslQLAQlGek9FxTkIT9b1LLOvO56uP2j
 YXHo1fTJxiU4pJcHITsFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IE4FEz6C5v8=:kfZTR1ooyr2TGmPc++wX0a
 5kixUDYtg4vgTfri/ZxD2vySGETuCe8UcQ/930KWiZNKxLRDGq7Dlp+d+ABaae1qvjhLcFe9s
 0b06NXvmedMXf5D7dywKv6WVFDy3mgYgb41or/9a70DQhHPUvsdpvoTPUwg69lG7nSFR0d+Ro
 dUoWRHr6u9PKoDl4qHMq3gOPP+dYDMeAIGwUFHo/XSpcT7bUyAbe3LnBWZPOsVbLDJ2GodzkI
 upsdL3VNndfA0fWiIGcws4JlRdmhVIgCAhf0Q782xnoHx641T7uvXtgipRspFgoI2g1ijl22D
 3CHUobp/Wv1Ck7OvTkhxqQjLdBZjI+HwjkCytVFl2rAyMluUhgUFKh65b2Wn2cM+amE2mWLdb
 FU8xcqI5fLKFy9s0RVhQIfXaGYmGkWb3IBwLmiiZy/b+TrWHHIpWeMB1qYm/Z6Vhdc2SCd76Z
 xnVvyZ+O1CJbc5K8TX/Yohn+CHS4RpoyC3nl51XC5/m5D12HZfvLT+cF4YClbErCHwD33JBL+
 OWDhajDJZ5ezFEh77TAh4atRNuKHZ8TqmUyWL7467DK48iE7beuUzxqbyKNfJ3Yo7qi+8VO2v
 6Tq/44mrvVvw4MJGAuK7jZgxBYnZ5PjMqoZUT+a5nBpSnKHUUZCacamAV1OLb9XPtSKcbjTNs
 jvCREfJmvK4Gm7geP2wWw5k8RRLwmWkcfaO+DAxBTUqBucfzgouGF+AyFiTMwWEp+NEVOUqBv
 or17O3t1gRzCdqjqGgrqDhjOXwwDH6mnbXjjXUaIK7+tJWXPo5w9xVBLxJGEN5n7LMG5R+6v+
 LK7uuegy4u/ASyFT8ZCbo7KIHh4y6VNK0Aj9vmh0SY7IZOczglBMPXLuy2NWIYt5ZDnD1Fkl5
 lRAdnEltDpucBGnnhF83q3yPew4ZgBkXgsWCJtnJMp5G4s4ZIanFkaI5huv06/lZ170mELGu9
 NIFKi8AYtskI+ScQOlvuPLaEgNCG1GJD+kAlEQAe7yxwsQ08Eit/qDE1lo0RgRj4eKZW3G+wP
 nDEru6tH67gEtFEOFJ6Wv9oo/xY7Tbh9+t3gQCBowwc9PvaJd3cnJVGm4T/DfqJsVd9aYtYQo
 NN1uj0ukIPVyN2a6IeYRkvx/gHpBikQKr7d
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.06.22 um 13:27 schrieb Johannes Schindelin:
> Hi Junio,
>
> On Mon, 13 Jun 2022, Junio C Hamano wrote:
>
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> -test_expect_success GZIP 'git archive --format=3Dtar.gz' '
>>> +test_expect_success 'git archive --format=3Dtar.gz' '
>>>  	git archive --format=3Dtar.gz HEAD >j1.tar.gz &&
>>>  	test_cmp_bin j.tgz j1.tar.gz
>>>  '
>>
>> Curiously, this breaks for me.  It is understandable if we are not
>> producing byte-for-byte identical output with internal gzip.

Makes sense in retrospect, there's no reason the output of gzip(1) and
zlib would have to be the same exactly.  It just happened to be so on my
platform, so the tests deceptively passed for me.  I think we simply
have to drop those that try to compare compressed files made by
different tools -- we can still check if their content can be extracted
and matches.

> Indeed, I can reproduce this, too. In particular, `j.tgz` and `j1.tar.gz=
`
> differ like this in my test run:
>
> -00000000  1f 8b 08 1a 00 2e ca 09  00 03 04 00 89 45 fc 83 |...........=
..E..|
> +00000000  1f 8b 08 1a 00 35 2a 10  00 03 04 00 89 45 fc 83 |.....5*....=
..E..|
>
> and
>
> -00000010  7d fc 00 f1 d0 ec b7 63  8c 30 cc 9b e6 db b6 6d |}......c.0.=
....m|
> +00000010  7d fc 00 54 ff ec b7 63  8c 30 cc 9b e6 db b6 6d |}..T...c.0.=
....m|
>
> According to https://datatracker.ietf.org/doc/html/rfc1952#page-5, the
> difference in the first line is the mtime. For reference, this is the
> version with `git -c tar.tgz.command=3D"gzip -cn" archive --format=3Dtgz
> HEAD`:
>
> 00000000  1f 8b 08 00 00 00 00 00  00 03 ec b7 63 8c 30 cc |............=
c.0.|
>
> In other words, `gzip` forces the `mtim` member to all zeros, which make=
s
> sense.

And that's what zlib does as well for me:

   $ ./git-archive --format=3Dtgz HEAD | hexdump -C | head -1
   00000000  1f 8b 08 00 00 00 00 00  00 03 ec bd 59 73 1c 49  |..........=
?Ys.I|

>
> The recorded mtimes are a bit funny, according to
> https://wolf-tungsten.github.io/gzip-analyzer/, they are 1975-03-17
> 00:36:32 and 1978-08-05 22:45:36, respectively...
>
> And the mtime actually changes all the time.
>
> What's even more funny: if I comment out the `deflateSetHeader()`, the
> mtime header field is left at all-zeros. This is on Ubuntu 18.04 with
> zlib1g 1:1.2.11.dfsg-0ubuntu2.
>
> So I dug in a bit deeper and what do you know, the `deflateHeader()`
> function is implemented like this
> (https://github.com/madler/zlib/blob/21767c654d31/deflate.c#L557-L565):
>
> 	int ZEXPORT deflateSetHeader (strm, head)
> 	    z_streamp strm;
> 	    gz_headerp head;
> 	{
> 	    if (deflateStateCheck(strm) || strm->state->wrap !=3D 2)
> 		return Z_STREAM_ERROR;
> 	    strm->state->gzhead =3D head;
> 	    return Z_OK;
> 	}
>
> Now, the caller is implemented like this:
>
> 	static void tgz_set_os(git_zstream *strm, int os)
> 	{
> 	#if ZLIB_VERNUM >=3D 0x1221
> 		struct gz_header_s gzhead =3D { .os =3D os };
> 		deflateSetHeader(&strm->z, &gzhead);
> 	#endif
> 	}
>
> The biggest problem is not that the return value of `deflateSetHeader()`
> is ignored. The biggest problem is that it passes the address of a heap
> variable to the `deflateSetHeader()` function, which then stores it away
> in another struct that lives beyond the point when we return from
> `tgz_set_os()`.

Ah, you mean the address of an automatic variable on the stack, but I
get it.  D'oh!

>
> In other words, this is the very issue I pointed out as GCC not catching=
:
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2205272235220.349@tvgsbejv=
aqbjf.bet/
>
> The solution is to move the heap variable back into a scope that matches
> the lifetime of the compression:
>
> -- snip --
> diff --git a/archive-tar.c b/archive-tar.c
> index 60669eb7b9c..3d77e0f7509 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -460,17 +460,12 @@ static void tgz_write_block(const void *data)
>
>  static const char internal_gzip_command[] =3D "git archive gzip";
>
> -static void tgz_set_os(git_zstream *strm, int os)
> -{
> -#if ZLIB_VERNUM >=3D 0x1221
> -	struct gz_header_s gzhead =3D { .os =3D os };
> -	deflateSetHeader(&strm->z, &gzhead);
> -#endif
> -}
> -
>  static int write_tar_filter_archive(const struct archiver *ar,
>  				    struct archiver_args *args)
>  {
> +#if ZLIB_VERNUM >=3D 0x1221
> +	struct gz_header_s gzhead =3D { .os =3D 3 }; /* Unix, for reproducibil=
ity */
> +#endif
>  	struct strbuf cmd =3D STRBUF_INIT;
>  	struct child_process filter =3D CHILD_PROCESS_INIT;
>  	int r;
> @@ -481,7 +476,10 @@ static int write_tar_filter_archive(const struct ar=
chiver *ar,
>  	if (!strcmp(ar->filter_command, internal_gzip_command)) {
>  		write_block =3D tgz_write_block;
>  		git_deflate_init_gzip(&gzstream, args->compression_level);
> -		tgz_set_os(&gzstream, 3); /* Unix, for reproducibility */
> +#if ZLIB_VERNUM >=3D 0x1221
> +		if (deflateSetHeader(&gzstream.z, &gzhead) !=3D Z_OK)
> +			BUG("deflateSetHeader() called too late");
> +#endif
>  		gzstream.next_out =3D outbuf;
>  		gzstream.avail_out =3D sizeof(outbuf);
>
> -- snap --

Good find, thank you!  A shorter solution would be to make gzhead static.

>
> With this, the test passes for me.
>
> Ren=C3=A9, would you mind squashing this into your patch series?
>
> Thank you,
> Dscho
