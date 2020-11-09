Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C20C4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 13:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BFA2068D
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 13:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GCqEtLey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgKINz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 08:55:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:56341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgKINz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 08:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604930146;
        bh=qaB+a+PBN47OPns8rJZsWJotc1qebs3ks+p0MMsJWoI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GCqEtLeylQIWgmyNowcr/gJDwLgg7lObuRlmQEqE1DGVwY+WA9z9dBIEEvCOob+k0
         Tfy7E28LH+P+F2pw5IwWuGTDL+8+YkRZ4JNcvWOLjv0xS/zq2wVADgtQmJyas9iNCd
         cOBNCT3RAH4VKuXA0c9cMex1ymA5hvKVEFEbPQg0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17UQ-1kAAOW2pTe-012bL6; Mon, 09
 Nov 2020 14:55:46 +0100
Date:   Mon, 9 Nov 2020 14:55:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] abspath: add a function to resolve paths with
 missing components
In-Reply-To: <20201009191511.267461-2-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2011091442190.18437@tvgsbejvaqbjf.bet>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net> <20201009191511.267461-2-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+Wbo9v44xecxPObugdvW1EJU7ZGPvHtqKwqceocTqNBsOIQGmBI
 Zzk3N3OZrzPQYMobDaUm7Mbkadbk3zDa8n5upJG3p8NdahEeB/+e3NWLncwVxm+0+lTocEN
 2ju/BQ2pvqJQelPIqnIAbxoQBvnxchze7xDTSuQsas7CH4Nzb9lX+5OIQf4n0pyWZjBjh3e
 Ph5mIhkAvQUEHAPKTIGJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aiLycerWk/s=:qaJPWKhPvAGzh/fmLVKeCk
 twau1opKxjsLGg2q/I7JaIbxKfUs8FSmNE0D03Xq0CcujjOBQt1iKzW/kyI8pn73xHSQ4H0Hz
 Y7AW1VgULK65HzoHnYOn8FJx1leQjLWU82QBmWQMTGqqx7FH9TcZx2dNBc9f/fMRjUCGYAsBe
 XRCT9G1pB3u4UDW0ofV+96IdYg3YJNYcLwmI2S4O7ubitHYAdrzB9z3z6rS9oET6FFv1cDhL8
 DOI++RwEgkZueOP6+eScsE4v3EnEjYWGQvuPjZc+Bo/iDX5k9zIJEdoikzaCT9iGVy9PZNmN2
 ujQPaGYHkAtgCeg71ApnE7wQFyWCU9+03dlHDTIUzwjf4VCv7KV0o0jGv1HXTkYsN/+Mmb8gz
 VXWu2QO+z+U1KRWMPO9cdxLhKahv697tQsEDIgtQFxahnwm3E+AO+mPE5HhDJL4yAw6aU06u1
 36TaOzjha3DeKWTS3h499gl+52M2aWVVh+KNB7Wup2cQBiHdFOtzwU+hbpxZz+sTT3VGAdBoD
 DCRhwiuKyLRkhiGEtTOqHSO0D33+wIL/CkM33P8KoeNqF8XSs8kQTX0gxej1hWOaN7zmG+8EE
 6KJy8hT0XqQZpU99eKICa5lDs2NfZE2tHbPQFP4sCD2kCY+YCLefkOr76dcqg4cAZIWKgVmWc
 VwvK8Kcb5aIDDcqg0i7ZEITvIqWCYZEqX1MkJM74sal1rYU7zYM6hdfjayMkTPjbGc5CJXzLd
 HdrWxoLlXDkUCIGXjg2KaBkIXclNCGYojBMfOR8+smVfqGTRWd7AGxCxGTh1D9kBLTHhIz3B/
 6ZW7xpDiF3oJOc5D0fXo8e9EPniOgNT26WQQAy1LFEzH0R3QZTKEQ/CfgvmOxDg4yroMkr4Nk
 x5jwXY9jtsmv1jsePomBhjiSZRbvMNZzZZspRmcho=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, 9 Oct 2020, brian m. carlson wrote:

> We'd like to canonicalize paths such that we can preserve any number of
> trailing components that may be missing.  Let's add a function to do
> that that calls strbuf_realpath to find the canonical path for the
> portion we do have and then append the missing part.  We adjust
> strip_last_component to return us the component it has stripped and use
> that to help us accumulate the missing part.
>
> Note that it is intentional that we invoke strbuf_realpath here,
> repeatedly if necessary, because on Windows that function is replaced
> with a version that uses the proper system semantics for
> canonicalization.  Trying to adjust strbuf_realpath to perform this kind
> of canonicalization with an additional option would fail to work
> properly on Windows.  The present approach is equivalent to
> strbuf_realpath for cases where the path exists, and the only other
> cases where we will use this function the additional overhead of
> multiple invocations is not significant.

Thank you for being so considerate. Yes, on Windows, we use (wherever
possible) a shortcut that tells us the canonicalized path of existing
entries.

Technically, it is not `strbuf_realpath()` that we override, but we take a
shortcut _in_ that function. That's semantics, though.

More importantly, we recently fixed a bug in our code to allow for a quirk
in the `strbuf_realpath()` function: `strbuf_realpath()` allows the last
path component to not exist. If that is the case, now it's time to try
without last component.

In a sense, this is a 1-level version of your infinite-level
`strbuf_realpath_missing()` function.

An idea that immediately crosses my mind is whether that level could be
something we want to pass directly into `strbuf_realpath()` as a parameter
(it would be 1 to imitate the current behavior and -1 for the
infinite-level case). What do you think? Does that make sense?

In any case, I think this `_missing()` functionality should be implemented
a bit more tightly with the `strbuf_realpath()` function because of the
logic that already allows the last component to be missing:

                if (lstat(resolved->buf, &st)) {
                        /* error out unless this was the last component */
                        if (errno !=3D ENOENT || remaining.len) {
                                if (die_on_error)
                                        die_errno("Invalid path '%s'",
                                                  resolved->buf);
                                else
                                        goto error_out;
                        }

See https://github.com/git/git/blob/v2.29.2/abspath.c#L130-L138 for the
exact code and context.

Seeing as we _already_ have some code to allow for _some_ missing
component, it should be possible to extend the logic to allow for
different levels (e.g. using `count_slashes()` if we want to allow more
than just the last component to be missing).

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  abspath.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
>  cache.h   |  1 +
>  2 files changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/abspath.c b/abspath.c
> index 6f15a418bb..092bb33b64 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -11,8 +11,12 @@ int is_directory(const char *path)
>  	return (!stat(path, &st) && S_ISDIR(st.st_mode));
>  }
>
> -/* removes the last path component from 'path' except if 'path' is root=
 */
> -static void strip_last_component(struct strbuf *path)
> +/*
> + * Removes the last path component from 'path' except if 'path' is root=
.
> + *
> + * If last is not NULL, the last path component is copied to last.
> + */
> +static void strip_last_component(struct strbuf *path, struct strbuf *la=
st)
>  {
>  	size_t offset =3D offset_1st_component(path->buf);
>  	size_t len =3D path->len;
> @@ -20,6 +24,10 @@ static void strip_last_component(struct strbuf *path)
>  	/* Find start of the last component */
>  	while (offset < len && !is_dir_sep(path->buf[len - 1]))
>  		len--;
> +
> +	if (last)
> +		strbuf_addstr(last, path->buf + len);
> +
>  	/* Skip sequences of multiple path-separators */
>  	while (offset < len && is_dir_sep(path->buf[len - 1]))
>  		len--;
> @@ -118,7 +126,7 @@ char *strbuf_realpath(struct strbuf *resolved, const=
 char *path,
>  			continue; /* '.' component */
>  		} else if (next.len =3D=3D 2 && !strcmp(next.buf, "..")) {
>  			/* '..' component; strip the last path component */
> -			strip_last_component(resolved);
> +			strip_last_component(resolved, NULL);
>  			continue;
>  		}
>
> @@ -169,7 +177,7 @@ char *strbuf_realpath(struct strbuf *resolved, const=
 char *path,
>  				 * strip off the last component since it will
>  				 * be replaced with the contents of the symlink
>  				 */
> -				strip_last_component(resolved);
> +				strip_last_component(resolved, NULL);
>  			}
>
>  			/*
> @@ -202,6 +210,40 @@ char *strbuf_realpath(struct strbuf *resolved, cons=
t char *path,
>  	return retval;
>  }
>
> +/*
> + * Like strbuf_realpath, but trailing components which do not exist are=
 copied
> + * through.
> + */
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path=
)
> +{
> +	struct strbuf remaining =3D STRBUF_INIT;
> +	struct strbuf trailing =3D STRBUF_INIT;
> +	struct strbuf component =3D STRBUF_INIT;
> +
> +	strbuf_addstr(&remaining, path);
> +
> +	while (remaining.len) {
> +		if (strbuf_realpath(resolved, remaining.buf, 0)) {
> +			strbuf_addbuf(resolved, &trailing);
> +
> +			strbuf_release(&component);
> +			strbuf_release(&remaining);
> +			strbuf_release(&trailing);
> +
> +			return resolved->buf;
> +		}
> +		strip_last_component(&remaining, &component);
> +		strbuf_insertstr(&trailing, 0, "/");
> +		strbuf_insertstr(&trailing, 1, component.buf);

Not that it matters a lot, but this could be written shorter via

		strbuf_insertf(&trailing, "/%s", component.buf);

But as I said above, I think we should be able to fold the logic _into_
`strbuf_realpath()` (even if this makes my job harder to maintain the
Windows-specific shortcut).

Thanks,
Dscho

> +		strbuf_reset(&component);
> +	}
> +
> +	strbuf_release(&component);
> +	strbuf_release(&remaining);
> +	strbuf_release(&trailing);
> +	return NULL;
> +}
> +
>  char *real_pathdup(const char *path, int die_on_error)
>  {
>  	struct strbuf realpath =3D STRBUF_INIT;
> diff --git a/cache.h b/cache.h
> index c0072d43b1..e1e17e108e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1320,6 +1320,7 @@ static inline int is_absolute_path(const char *pat=
h)
>  int is_directory(const char *);
>  char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error);
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path=
);
>  char *real_pathdup(const char *path, int die_on_error);
>  const char *absolute_path(const char *path);
>  char *absolute_pathdup(const char *path);
>
