Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0783E1F453
	for <e@80x24.org>; Thu,  2 May 2019 20:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEBU3z (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 16:29:55 -0400
Received: from mout.web.de ([212.227.15.14]:59557 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfEBU3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 16:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1556828980;
        bh=2qNbZQUyCf0GiBQKCwapzvAipDWA9ZBW0GqrkhieWG8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MZKHmP9L2aJhbM0euLJYyZJNmAweWx2lGbZNu1uX3l164Wc9Umz/6F68E4uJFl+UQ
         XrDVuQiThpmmflW7i+FQsoW+SJjAnHtDBcBZ5P1GIfIbY7wS9r7x5gv7QJvqaphqCi
         OIgu++3JQE+yyMvE8P9s7r3c/flTZq+j6CqELHzE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.19.151]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6UmJ-1gWvlf13Jz-00yUXJ; Thu, 02
 May 2019 22:29:40 +0200
Subject: Re: [PATCH v2 3/4] archive: optionally use zlib directly for gzip
 compression
To:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <pull.145.git.gitgitgadget@gmail.com>
 <pull.145.v2.git.gitgitgadget@gmail.com>
 <4ea94a8784876c3a19e387537edd81a957fc692c.1556321244.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <927f1e99-baa3-2d8a-cb11-0aedef6adc5c@web.de>
Date:   Thu, 2 May 2019 22:29:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4ea94a8784876c3a19e387537edd81a957fc692c.1556321244.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XB1QxWcNeJt8eyfueKiob3wFbDjMNY78Aic4gU0YKfDmG1+f8bS
 /HzRHdLpAVmk7qnISm8tEq2jGCLrw/hveF2qKjZ1rofxSJ8jV1CD7V21ffPQUavLXf7d8ak
 DOXmSlPvBtQtJWF9bDIVmY3Bw8xhkdcA7kFEQodTps3loRDjHdtHXUDQ+K4RY4skHEIGVpk
 uoG3ykSWnbIFGKFTpM4wA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RIZByJM8oxk=:FHoiJXKvIPeU6ydPuc7UnH
 YfBuKM34Dcql6MMeM7538fkGtT/WXh9QtMGxYQFUee++kQOzQhDsXWOMw7SacWni2u/QsLwsn
 unNzlfN0tdXLpEIYz6sn7++aBuAhDml1IpIrP+XFXrLtYWEhG3st81kHLM0HFL+PVDj1jWVBs
 VfWZAYARzhJj1tuy9UsRAXYBEEu7lcOCuvScINi491ArtrgeOR/FutMw0idE0h0lyd7tSklAT
 KY8GuAbujcO4HsLY0AQn6tBAMB5YgbIhK9K7RX6oZxIiHbN70SMWxAJhg/J34y+D287MHB37r
 cSdVXx2+jaZ+pE3fkaWvaBgXe2QveDL3zkUXHXAaK66+9PWb7vWR+3p+hSVL7+9zWFjd5TLwr
 kRS+xs7hHHb+4e7HZzqYouW6nX+UuX7NFF2qfivFcRvjYQ4n1i5TM0weCCASbCgqBU+rxocMu
 J6dThpwndXZ4Vf9l/3b7d5fVDcx8ZlNgUp3oI0P7brN/YWFYH2QQdIsSw7SZ3MG8jojUW4DQn
 JnO1OQ/AjEuH09Q8PNufM/uCCzrIVZy4TrmdyYsFMYQoaAf6JtfHIDDotZE09DyaFtK+5jsVn
 m7svQx5rAKvKMSzhMKjNU2qw+CUIGRYUSUIZBuMk+HcLdvrGH3AN+6VRkKBljOEUiD2h2Nyt4
 1hsPi8kMmHqkTRKuOOQ0i/olY0zD/ajJNd8uYdZDLXHw1t2qyLZFsXrRurmsIO1DLseZZuP9Z
 tMjDns0XY+VquIad+qrxXFExIidZOqInAzOPynWmmPLDNLXKL0C0gEvgLyWmULY0ZqsPdK/fk
 mwDUF4ugzogClNS7BIUjU9Djl90XTGsbSVFJfL3ctYxghHyFqHOuBHJNVfPNTc7jaqH8u8IwH
 UhwtFsOUtcQe7ObTqJE3oflzqd6GxQ3ZFnsJLf075ZU7llnNFtoKWQpzgj6akq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.19 um 01:27 schrieb Rohit Ashiwal via GitGitGadget:
> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>
> As we already link to the zlib library, we can perform the compression
> without even requiring gzip on the host machine.
>
> Note: the `-n` flag that `git archive` passed to `gzip` wants to ensure
> that a reproducible file is written, i.e. no filename or mtime will be
> recorded in the compressed output. This is already the default for
> zlib's `gzopen()` function (if the file name or mtime should be
> recorded, the `deflateSetHeader()` function would have to be called
> instead).
>
> Note also that the `gzFile` datatype is defined as a pointer in
> `zlib.h`, i.e. we can rely on the fact that it can be `NULL`.
>
> At this point, this new mode is hidden behind the pseudo command
> `:zlib`: assign this magic string to the `archive.tgz.command` config
> setting to enable it.

Technically the patch emits the gzip format using the gz* functions.
Raw zlib output with deflate* would be slightly different.  So I'd
rather use "gzip" instead of "zlib" in the magic string.

And I'm not sure about the colon as the only magic marker.  Perhaps
throw in a "git " or "git-" instead or in addition?

> @@ -459,18 +464,40 @@ static int write_tar_filter_archive(const struct a=
rchiver *ar,
>  	filter.use_shell =3D 1;
>  	filter.in =3D -1;
>
> -	if (start_command(&filter) < 0)
> -		die_errno(_("unable to start '%s' filter"), argv[0]);
> -	close(1);
> -	if (dup2(filter.in, 1) < 0)
> -		die_errno(_("unable to redirect descriptor"));
> -	close(filter.in);
> +	if (!strcmp(":zlib", ar->data)) {
> +		struct strbuf mode =3D STRBUF_INIT;
> +
> +		strbuf_addstr(&mode, "wb");
> +
> +		if (args->compression_level >=3D 0 && args->compression_level <=3D 9)
> +			strbuf_addf(&mode, "%d", args->compression_level);

Using gzsetparams() to set the compression level numerically after gzdopen=
()
instead of baking it into the mode string feels cleaner.

> +
> +		gzip =3D gzdopen(fileno(stdout), mode.buf);
> +		if (!gzip)
> +			die(_("Could not gzdopen stdout"));
> +		strbuf_release(&mode);
> +	} else {
> +		if (start_command(&filter) < 0)
> +			die_errno(_("unable to start '%s' filter"), argv[0]);
> +		close(1);
> +		if (dup2(filter.in, 1) < 0)
> +			die_errno(_("unable to redirect descriptor"));
> +		close(filter.in);
> +	}
>
>  	r =3D write_tar_archive(ar, args);
>
> -	close(1);
> -	if (finish_command(&filter) !=3D 0)
> -		die(_("'%s' filter reported error"), argv[0]);
> +	if (gzip) {
> +		int ret =3D gzclose(gzip);
> +		if (ret =3D=3D Z_ERRNO)
> +			die_errno(_("gzclose failed"));
> +		else if (ret !=3D Z_OK)
> +			die(_("gzclose failed (%d)"), ret);
> +	} else {
> +		close(1);
> +		if (finish_command(&filter) !=3D 0)
> +			die(_("'%s' filter reported error"), argv[0]);
> +	}
>
>  	strbuf_release(&cmd);
>  	return r;
>
