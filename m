Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75821C64E7B
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336CA21D40
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="SoUznxWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbgK1Vtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:51 -0500
Received: from mout.web.de ([217.72.192.78]:42041 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387599AbgK1Tts (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 14:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1606592876;
        bh=ZMr2oovc6Eg2zCL8XarS5/Cr2QLH3OD4eryTEpI2RW0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SoUznxWcmRMdtX3uG3il1JHM05V+RNgQYaJ7hLhxuJuParfPwbkuv9hGxs9fPKBN3
         QLHz8LTrOIicpjoPvXEJd28IdoOXrxf8n9Dl4KOfsRfGpA17umseNWuGvY+zg7monw
         uQ4//0Pwhjs1iE5akXvMUdaB4HAUbZkrQfYuGuSw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGQGF-1kzins1Z77-00GlgP; Sat, 28
 Nov 2020 11:08:33 +0100
Subject: Re: [PATCH v3 1/2] abspath: add a function to resolve paths with
 missing components
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
References: <20201127231916.609852-1-sandals@crustytoothpaste.net>
 <20201127231916.609852-2-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <374553d7-6027-0152-bf56-9395e8268fa9@web.de>
Date:   Sat, 28 Nov 2020 11:08:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127231916.609852-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eO7s15e2ZPC7HKjDnR5sfYag4pgzv7TNdmLe/TzPEDRsJ19t7GE
 NH1Suls59sK0ok61wtbao5S5r9vTngZL1r/44dfkSvGYGye96XdsNiKLeAiXrhZgDWWVJC3
 AcHgDcA0PldBOc0euz3HWYgaB8Fhhy0XaKGH9gUKGgCheibgVHgvEFNiXb0WsT0yQT25t+E
 gba5iHfzFTwuSG2aVNjXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sGobvVkZtyY=:GVRfQzFr3b8QVU6/BAxYdZ
 28Hl2cmtkazWVpWfwQUOBOxJGgmHTmWbhabR/0jTtfCjXwQIBGHWMJvfkG4nfg6VU3f887Gbv
 eGy1hH0cNg+wv0UMF+Ycwu/Nh47JcaBlb81+AMY8CSxfMyTIWF+XvvMD8ZR5W/4idj9FDFTfj
 FI2ebWqnvacBOYnzxvGvc6Z6B6CdotBmipwrtnZEbeQbFcwX/I/GIwcdOIDqigjnxr/z4nD7O
 JedEyp1C28U+2WfaQszwVW0SUegynCw7N0QA3fZYfMtJ2McGpJ41ABw/zPu9UnjQZuKVD07NR
 IFe6tPyL5gHZgRLq1IckfLxEFCms8YkoWzIs1ErCEJiNAoKXqUC8/q+pktPQEnoYHTedB0t7U
 mzEEOCy8kp56NHbV0zMMyJlrDsJ1gvxGMIG152CM4gkccPnn1yUXdM7FchS/+xzln6U4BAL+I
 pl+qmUMVYy8SjFgdC+xqq3uwJb2t4/uwZ8TTC+GxF+aq1Oh6YBjMtl/dzO0VeTWwZALijYjoD
 kkPLq3Yu3W2ZWzXXwrGY7ITJEzLClk9IQ7nT/o2wvn0quWNyP8qjcuNHQMlevb+uhljznCUof
 uHgoslwPjlrNtzp2OXoPPJ5NePyKIr+2TIz48wnI3qtAdANRG08W+Tw8+x9V7KEWpYZi2+6Qq
 SFsm6NTIIvedbKHQ1YSDtQgOBU/ucJZNc0fhNg2c8tg/O5gFAcU53sMVXwb5IAIK1TP3bDE1J
 JqUkXJoHKWdQUoM3Artho1Ktc3UDnw9pj9AOIAoskQdeJQHWYZKpod1vW4kCK5a6yO4M97/zU
 CZoLesFTuNrcq/znsbLV4IpYKRzBFXP6s3ORoMXh2ZUYtoBm4+ksIXpg77QSRfVXmKUsydMaN
 +LfCOd5ye0gUljDCEPMw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.11.20 um 00:19 schrieb brian m. carlson:
> We'd like to canonicalize paths such that we can preserve any number of
> trailing components that may be missing.  Let's add a function to do
> that, taking the number of components to canonicalize, and make
> strbuf_realpath a wrapper around it that allows just one component.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  abspath.c | 33 ++++++++++++++++++++++++++++++++-
>  cache.h   |  2 ++
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/abspath.c b/abspath.c
> index 6f15a418bb..1d8f3d007c 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -20,6 +20,7 @@ static void strip_last_component(struct strbuf *path)
>  	/* Find start of the last component */
>  	while (offset < len && !is_dir_sep(path->buf[len - 1]))
>  		len--;
> +
>  	/* Skip sequences of multiple path-separators */
>  	while (offset < len && is_dir_sep(path->buf[len - 1]))
>  		len--;

Stray change?

> @@ -66,6 +67,22 @@ static void get_root_part(struct strbuf *resolved, st=
ruct strbuf *remaining)
>  #define MAXSYMLINKS 32
>  #endif
>
> +/* Count non-contiguous directory separators, not including a trailing =
one. */
> +static int count_dir_separators(const char *s)
> +{
> +	int count =3D 0;
> +	int last_sep =3D 0;
> +	const char *p =3D s;
> +	while (*p) {
> +		int is_sep =3D is_dir_sep(*p++);
> +		if (is_sep && !last_sep)
> +			count++;
> +		last_sep =3D is_sep;
> +	}
> +	return count;
> +}

count_dir_separators("a/") returns 1; is this intended?  It seems to
contradict the "not including a trailing one" comment.

> +
> +

Nitpicking: Do we need both empty lines?

>  /*
>   * Return the real path (i.e., absolute path, with symlinks resolved
>   * and extra slashes removed) equivalent to the specified path.  (If
> @@ -80,6 +97,16 @@ static void get_root_part(struct strbuf *resolved, st=
ruct strbuf *remaining)
>   */
>  char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error)
> +{
> +	return strbuf_realpath_missing(resolved, path, 1, die_on_error);
> +}
> +
> +/*
> + * Just like strbuf_realpath, but allows specifying how many missing co=
mponents
> + * are permitted.  -1 may be specified to allow an unlimited number.
> + */
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path=
,
> +			      int missing_components, int die_on_error)
>  {
>  	struct strbuf remaining =3D STRBUF_INIT;
>  	struct strbuf next =3D STRBUF_INIT;
> @@ -128,8 +155,12 @@ char *strbuf_realpath(struct strbuf *resolved, cons=
t char *path,
>  		strbuf_addbuf(resolved, &next);
>
>  		if (lstat(resolved->buf, &st)) {
> +			int trailing_components =3D count_dir_separators(remaining.buf) +
> +						  (remaining.len !=3D 0);

Hmm, so you actually want to count path components, not separators.
Perhaps like this?

	static size_t count_components(const char *p)
	{
		size_t n =3D 0;
		while (*p) {
			while (*p && !is_dir_sep(*p))
				p++;
			while (is_dir_sep(*p))
				p++;
			n++;
		}
		return n;
	}

>  			/* error out unless this was the last component */
> -			if (errno !=3D ENOENT || remaining.len) {
> +			if (errno !=3D ENOENT ||
> +			    !(missing_components =3D=3D -1 ||
> +			      trailing_components < missing_components)) {
>  				if (die_on_error)
>  					die_errno("Invalid path '%s'",
>  						  resolved->buf);
> diff --git a/cache.h b/cache.h
> index c0072d43b1..ee4bc5ec04 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1320,6 +1320,8 @@ static inline int is_absolute_path(const char *pat=
h)
>  int is_directory(const char *);
>  char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error);
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path=
,
> +			      int missing_components, int die_on_error);
>  char *real_pathdup(const char *path, int die_on_error);
>  const char *absolute_path(const char *path);
>  char *absolute_pathdup(const char *path);
>

