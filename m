Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9CEC433FE
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 12:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiAHM3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 07:29:04 -0500
Received: from mout.web.de ([212.227.17.12]:38905 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231653AbiAHM3D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 07:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641644913;
        bh=z4SEoA/WfqSVgBA/1LPAMlwy6hUyzNjIX9spjOTgi8k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ptyla7jlwnCkHFGnV4hgQYiwN5FRkJuZmg3YBWkwla/g+HCnwrUTpEcVq9fuN+Ewc
         KObNEMNlgY6RBL7jZgCASmfyIZ0ym0D2G5X2yHyul5qauRU/R6HMsErQddj4ykjIcL
         9eHF1TbckXGG9IgsPDLWT94xdOBaLgjpdtiIihSM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVJNd-1myqww0O07-00SXhY; Sat, 08
 Jan 2022 13:28:33 +0100
Message-ID: <8f9dd345-56c4-9a20-151b-e0e6d1a5b3fa@web.de>
Date:   Sat, 8 Jan 2022 13:28:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v8 1/6] unpack-objects: low memory footprint for
 get_data() in dry_run mode
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20220108085419.79682-2-chiyutianyi@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20220108085419.79682-2-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AlAmMOf5TsSrogWndiHvslqc0WWnQNcukR3Xt+ieb6/qsgHZ6t8
 dR+40bsR1Meq3jfxnONoA/Uy1XnPi5BK6LcTubQAToDVkZqHHOK5RSFZD4KU5sYUaad6by/
 seP/6Dyyb/bE2cReZZH+6kez7awEt+rclL7DHoVI2ZrRt1XvC8TBMCyqrYGAcVl5jCxUWix
 zwa/j+6ak29uHoPiFDgUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9wHo8wjSp8Y=:18XlzT4NnTU5zpVd3ttYkj
 1Pl0CSSKlzeL7u43R8y8p5QqoHw0bWMeNT6buY8JgvP6D7pZbZEii/IckVujYIjefppCCoZrm
 R/g0na2StS5YGAX0gF7vjfFMGnOUE3E3GBgrkv22Kt3B+GW+TrTpq2qknlEm0nCx2h7KlwcKY
 tvgmUNqEOywbHEPGtPrbMLUNAbn9lpX1ARgjW636aAm8BwllLN8Py8t1I0ctGw4TheTFErJb0
 qwMX4am0O6uFAAXdv1rQytI4koMHBXms1rJ5qD8+aGY5nIYC8sIfwKARoMryZmUQE64EHJL3l
 emuw9fQTqNbzalBO8jUHjjhhoq0PWYnT9hpZ8hbisZPlE7hYwpGpY22CU+AuH56v5WjRFdFTr
 Z2UmxK1XKGLstffSTpkXLNq0SWdvF1EJyk9+NOwWu0PZuqrkYXagK5aF4868NSYGs7ubLNNBp
 EJX+VobNC5VpDs3ZvyF8QJrh8mNY7yz1WIjkGknvfg0UudNBZMj3JSTCf424EFjIPpqjigPP5
 cw0r64kCxErFb3QHN04Vqtwj/2O1Oc0e3l+ltLuoMwWrc1efxKO+V5kHTWLcAjcOkwG+rqEMY
 qiIaGR+dFNTUY7eZg8uMZUCqP6GWAlz5Ht535DPck7f1nePvyoCkOQZZN7ANYMsJ16lSX1PoE
 BOnEHYX39lUBQlmkhRCdSVW3S2FGzmlEYP7ybXV7q22WQv+ORIy3yrd0yE1QGpbjx4GoEb7ax
 huZHwc1yjv8cmQmq0Q1nYv9FQf4xOBWPD7lp5z3mcLb2XjI5QdW/yT5oKd3tDvVS3UGrSUqCN
 IUdzP6ULX4qK4FrBpO51F2wCL3B7Pq8sdBQNRU5QQZnWvaoYWnTZRpFgWTF4Mrsz5zxrUNSCC
 iJ6mmbeE9lSTw5VViUZkkOmjcCVZRaJKR4KfUF59/n7jJCgWW2lWdw+BIsuRjshrep8GbdOHz
 dymhj/mZ3RC4lUME1rcnBAdYlaT3yU/Ff2VR/RGklYcmanMvba5fQA3rSCq3uaFdNM3vk8fcV
 rIWsv8XvA8fTt89jBijAP9sv2osSmIEgNs5PR1cULKMNzr9GdNc922QA6kNQlO3k05+l1Em1T
 cLTA8FbYo9D0Ok=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Am 08.01.22 um 09:54 schrieb Han Xin:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> As the name implies, "get_data(size)" will allocate and return a given
> size of memory. Allocating memory for a large blob object may cause the
> system to run out of memory. Before preparing to replace calling of
> "get_data()" to unpack large blob objects in latter commits, refactor
> "get_data()" to reduce memory footprint for dry_run mode.
>
> Because in dry_run mode, "get_data()" is only used to check the
> integrity of data, and the returned buffer is not used at all, we can
> allocate a smaller buffer and reuse it as zstream output. Therefore,
> in dry_run mode, "get_data()" will release the allocated buffer and
> return NULL instead of returning garbage data.
>
> Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  builtin/unpack-objects.c        | 39 ++++++++++++++++++-------
>  t/t5329-unpack-large-objects.sh | 52 +++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 11 deletions(-)
>  create mode 100755 t/t5329-unpack-large-objects.sh
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 4a9466295b..c6d6c17072 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -96,15 +96,31 @@ static void use(int bytes)
>  	display_throughput(progress, consumed_bytes);
>  }
>
> +/*
> + * Decompress zstream from stdin and return specific size of data.
> + * The caller is responsible to free the returned buffer.
> + *
> + * But for dry_run mode, "get_data()" is only used to check the
> + * integrity of data, and the returned buffer is not used at all.
> + * Therefore, in dry_run mode, "get_data()" will release the small
> + * allocated buffer which is reused to hold temporary zstream output
> + * and return NULL instead of returning garbage data.
> + */
>  static void *get_data(unsigned long size)
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
> @@ -124,8 +140,15 @@ static void *get_data(unsigned long size)
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
> +	if (dry_run)
> +		FREE_AND_NULL(buf);
>  	return buf;
>  }
>
> @@ -325,10 +348,8 @@ static void unpack_non_delta_entry(enum object_type=
 type, unsigned long size,
>  {
>  	void *buf =3D get_data(size);
>
> -	if (!dry_run && buf)
> +	if (buf)
>  		write_object(nr, type, buf, size);
> -	else
> -		free(buf);
>  }
>
>  static int resolve_against_held(unsigned nr, const struct object_id *ba=
se,
> @@ -358,10 +379,8 @@ static void unpack_delta_entry(enum object_type typ=
e, unsigned long delta_size,
>  		oidread(&base_oid, fill(the_hash_algo->rawsz));
>  		use(the_hash_algo->rawsz);
>  		delta_data =3D get_data(delta_size);
> -		if (dry_run || !delta_data) {
> -			free(delta_data);
> +		if (!delta_data)
>  			return;
> -		}
>  		if (has_object_file(&base_oid))
>  			; /* Ok we have this one */
>  		else if (resolve_against_held(nr, &base_oid,
> @@ -397,10 +416,8 @@ static void unpack_delta_entry(enum object_type typ=
e, unsigned long delta_size,
>  			die("offset value out of bound for delta base object");
>
>  		delta_data =3D get_data(delta_size);
> -		if (dry_run || !delta_data) {
> -			free(delta_data);
> +		if (!delta_data)
>  			return;
> -		}
>  		lo =3D 0;
>  		hi =3D nr;
>  		while (lo < hi) {

Nice!

> diff --git a/t/t5329-unpack-large-objects.sh b/t/t5329-unpack-large-obje=
cts.sh
> new file mode 100755
> index 0000000000..39c7a62d94
> --- /dev/null
> +++ b/t/t5329-unpack-large-objects.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2021 Han Xin
> +#
> +
> +test_description=3D'git unpack-objects with large objects'
> +
> +. ./test-lib.sh
> +
> +prepare_dest () {
> +	test_when_finished "rm -rf dest.git" &&
> +	git init --bare dest.git
> +}
> +
> +assert_no_loose () {
> +	glob=3Ddest.git/objects/?? &&
> +	echo "$glob" >expect &&
> +	eval "echo $glob" >actual &&
> +	test_cmp expect actual
> +}
> +
> +assert_no_pack () {
> +	rmdir dest.git/objects/pack

I would expect a function whose name starts with "assert" to have no
side effects.  It doesn't matter here, because it's called only at the
very end, but that might change.  You can use test_dir_is_empty instead
of rmdir.

> +}
> +
> +test_expect_success "create large objects (1.5 MB) and PACK" '
> +	test-tool genrandom foo 1500000 >big-blob &&
> +	test_commit --append foo big-blob &&
> +	test-tool genrandom bar 1500000 >big-blob &&
> +	test_commit --append bar big-blob &&
> +	PACK=3D$(echo HEAD | git pack-objects --revs test)
> +'
> +
> +test_expect_success 'set memory limitation to 1MB' '
> +	GIT_ALLOC_LIMIT=3D1m &&
> +	export GIT_ALLOC_LIMIT
> +'
> +
> +test_expect_success 'unpack-objects failed under memory limitation' '
> +	prepare_dest &&
> +	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &=
&
> +	grep "fatal: attempting to allocate" err
> +'
> +
> +test_expect_success 'unpack-objects works with memory limitation in dry=
-run mode' '
> +	prepare_dest &&
> +	git -C dest.git unpack-objects -n <test-$PACK.pack &&
> +	assert_no_loose &&
> +	assert_no_pack
> +'
> +
> +test_done
