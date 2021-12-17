Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B3BC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 21:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhLQVWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 16:22:24 -0500
Received: from mout.web.de ([212.227.17.12]:33475 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhLQVWY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 16:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1639776124;
        bh=JaoGLS2eYdrFXU6q8fmf/nBoEhppuHc/oP5GD0W/q9Y=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=rPUPHvY/7niP0D5+qmWGf/JHIn2qMWykAmsYUF6F5d5/Eo9fASmPYpjs8FhIBVVUO
         xTemQA5ylfkvTd4GbBp/0wegj8+k9/LqfyduKvJuciRv+q7a6ThY9e6psFqx00K6Mk
         cFYO1hPcKziYnfK3eACV20DGcaAYAVbvMQ4m6F/I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX1L-1mFKjx1JQL-00jO84; Fri, 17
 Dec 2021 22:22:04 +0100
Message-ID: <39ac2d4c-e153-3369-f93f-4d8124f35b87@web.de>
Date:   Fri, 17 Dec 2021 22:22:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v6 5/6] unpack-objects.c: add dry_run mode for get_data()
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211210103435.83656-1-chiyutianyi@gmail.com>
 <20211217112629.12334-6-chiyutianyi@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20211217112629.12334-6-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aA3ofnxHHXfDDbD8iQZODnxlSghJCiby8stTxP1/f2PbpUFCTj6
 QZLUWAp20OWn0KJeyuqmrdyHx/vOTPTcclAnONKZKegqU/rASe+brxOWCnE0MIpnIje3MG2
 xp4fdY5FpYtI84h6kXjHSaQ/F71Y4wWc9BxtZoXP95UMKW+87dNkVhRG8dzwFI/uELMkhpm
 X2bpKmtOEa90EEvRBJnKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Foz4Z9QqxbI=:mK6NLObXM2x9XmcydhYGwd
 yRHFX7uh6rVfAhUDP73qTpZaJhnlM61QAVKEZtKmGHuOM4Pvg/ycFqWAmFpHnUO7mo4/gaL1T
 UyCMFdNxwVkxswS08J5qndR3E95wXlDMnny2Ku2bMlc0+ZaZPepLQ3YWjuNPGG7WN1VSttFtC
 Wov6IhD1Fp1fZwss7nx8As4eysOThP/RTpYcXQuyZF+HcLjU25/4/Y/lvxUlCvZrk/UFT6Qop
 lSi5/S5/nxWtwrItlK9bn7FOO9GkvbUr16zEtlTHwU308iPJsonSO7gY8HEzMTXh4DAKbIVNs
 RqsaMD/KRbDfTW9VWUH4/4ewvxqxt7eoK71kT/h4eYquaAaOWiqrR8pA5AwiBDJgLoHz5epU2
 a7GkdnZLWtKJEL/PRHw+y3ThTTIBB3eKcTJQBipPVJWkDQ0MVE5ucXCVfNGE6h3Y3PhwY/Fhh
 ODLiafNNsm/cV53oxid2iwJupxlY3P9yBAurBFjhhNh/TvGZ1mjBIHoVk2eXuTbwbhakdUMBQ
 KMeboyag08GTILN+5wIQutdUFYP/Gus4kJhuOMTpWbwn1kXIhbEgoYWYVWiCV5ZKa6owZk0zQ
 oJgLTjPbtS7v8rCvMqiZmfjpPcZqxXJyohLjmJgBlLMh9V6c8jYG12W7t0x91QV4/zHJFKIUQ
 9p5tgpr1/GRRQwtoJ3b8sscN+cCnUn6D4vmY9FgkS6/XJE7B8bqzZAneKyRMZjVl2guu/Sr8U
 AoanHHv7BS8M93W+ENPO+AU/BY+1ISCeyPgWAqJNbzWoOMNwbcEyUQZqe5dGIG5vqGWa6NGHV
 7Q1fgEgBxibhXBO++b/iMU6J8fqVW1FP8TqCPMYf6FwEu5MKOv1ZkCPxe2fFKTz/jAlDdD5YX
 Dx2LS5OFqu4Xsmzl6KA/oqMIoN7yKal/ZN0BgbgH8vN77DOmXKQcxDg5K5cnfL/btrGj5YhmQ
 024VaG6YnUeRhpbYlU3sZgJhth2aagvlwumD9tI3SfjuJ10h1k7/RkQ7qXQ9hesNykq/6VdcW
 UXKDAIADiN1D4imWiwbYG4IoLSTBBwNxua8SD0rtkkOF7uLvDYdvbxDZTmNmOEoIAJ2Q2xfAP
 cxIr96M6XdMmco=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.12.21 um 12:26 schrieb Han Xin:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> In dry_run mode, "get_data()" is used to verify the inflation of data,
> and the returned buffer will not be used at all and will be freed
> immediately. Even in dry_run mode, it is dangerous to allocate a
> full-size buffer for a large blob object. Therefore, only allocate a
> low memory footprint when calling "get_data()" in dry_run mode.

Clever.  Looks good to me.

For some reason I was expecting this patch to have some connection to
one of the earlier ones (perhaps because get_data() was mentioned),
but it is technically independent.

>
> Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  builtin/unpack-objects.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 4a9466295b..c4a17bdb44 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -96,15 +96,21 @@ static void use(int bytes)
>  	display_throughput(progress, consumed_bytes);
>  }
>
> -static void *get_data(unsigned long size)
> +static void *get_data(unsigned long size, int dry_run)
>  {
>  	git_zstream stream;
> -	void *buf =3D xmallocz(size);
> +	unsigned long bufsize;
> +	void *buf;
>
>  	memset(&stream, 0, sizeof(stream));
> +	if (dry_run && size > 8192)
> +		bufsize =3D 8192;
> +	else
> +		bufsize =3D size;
> +	buf =3D xmallocz(bufsize);
>
>  	stream.next_out =3D buf;
> -	stream.avail_out =3D size;
> +	stream.avail_out =3D bufsize;
>  	stream.next_in =3D fill(1);
>  	stream.avail_in =3D len;
>  	git_inflate_init(&stream);
> @@ -124,6 +130,11 @@ static void *get_data(unsigned long size)
>  		}
>  		stream.next_in =3D fill(1);
>  		stream.avail_in =3D len;
> +		if (dry_run) {
> +			/* reuse the buffer in dry_run mode */
> +			stream.next_out =3D buf;
> +			stream.avail_out =3D bufsize;
> +		}
>  	}
>  	git_inflate_end(&stream);
>  	return buf;
> @@ -323,7 +334,7 @@ static void added_object(unsigned nr, enum object_ty=
pe type,
>  static void unpack_non_delta_entry(enum object_type type, unsigned long=
 size,
>  				   unsigned nr)
>  {
> -	void *buf =3D get_data(size);
> +	void *buf =3D get_data(size, dry_run);
>
>  	if (!dry_run && buf)
>  		write_object(nr, type, buf, size);
> @@ -357,7 +368,7 @@ static void unpack_delta_entry(enum object_type type=
, unsigned long delta_size,
>  	if (type =3D=3D OBJ_REF_DELTA) {
>  		oidread(&base_oid, fill(the_hash_algo->rawsz));
>  		use(the_hash_algo->rawsz);
> -		delta_data =3D get_data(delta_size);
> +		delta_data =3D get_data(delta_size, dry_run);
>  		if (dry_run || !delta_data) {
>  			free(delta_data);
>  			return;
> @@ -396,7 +407,7 @@ static void unpack_delta_entry(enum object_type type=
, unsigned long delta_size,
>  		if (base_offset <=3D 0 || base_offset >=3D obj_list[nr].offset)
>  			die("offset value out of bound for delta base object");
>
> -		delta_data =3D get_data(delta_size);
> +		delta_data =3D get_data(delta_size, dry_run);
>  		if (dry_run || !delta_data) {
>  			free(delta_data);
>  			return;

