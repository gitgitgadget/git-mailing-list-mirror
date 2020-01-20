Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96D8C33CAA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 22:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9019A217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 22:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SBcwfRFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgATWUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:20:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:43377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgATWUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 17:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579558826;
        bh=C2DMovIIFu6Is+hpDrKzk3AU1uwi+E8apRl1rHE5Xhs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SBcwfRFxLH3BPnMgSu599BovBzkhbLnJTQPOsA5msHLURhe4OrmcnXX0sjqKxobPJ
         iQL6VHsNP0oaf8OA2w7DlACAXRVtetYkNBU/Tk16Qin7lRZsirMtiOLh2ET+rtljAX
         cTRYbGf4vK+b7Ql9DtknCCdLPitVL5o5b/MdpNEs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1psI-1ivsKQ0ynw-002FB3; Mon, 20
 Jan 2020 23:20:26 +0100
Date:   Mon, 20 Jan 2020 23:20:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 09/29] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
In-Reply-To: <20200120143800.900-10-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001202313130.46@tvgsbejvaqbjf.bet>
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-10-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+ZrfdYNuMOFGKX8lE3p0hLOWqXfIKW9GaKmM8atx1uUXntST6FP
 QCJKuWqJpOz8CVgv+ryKcocIzovaIizRVlIJjUXzrhpZLzcTVTTmHD8pjAzTBn5mmml0GtN
 cJx5RYZxJ3XdMl1NNYGR52wKNfNq6GlNXk0HKh2WKHEGhTRW5ejxYh4NCBOArO+NgPhHrgp
 8mwMphzPL9DKpKRxK/dRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oSxyBWbQTOo=:rnkKQoYzFYpXGy0sAP7gkv
 YQiAHAenLaNWbV1HZpcFMINIs4QVjQmp2aBILdBMrOzUim4qLTgJymoji5q8b7bfCB6P0X6+p
 8ahxyqG5axgveD5gI7W/XWbgUUK41R12H34R7nlWcJx0KfAbu6f32r1x/pMc1FTxlGLsqu3jY
 dPAUSZBBhwfMkk+dMZaEcOavU4lnw3YdG7o9eZcOa9xcsMQ8JI71qS6yW2FyQuyyM77d6BPmV
 D8jQTImMNhOnyRN3FteFAw8ZeC/r88k2jmpibYUc6S0GlX8wzku773Y5UCTH9scv/0iY6ZTwO
 01vwRzmkyPApqhkyfMlmOO/u9nJnsuQNVDlMOM2uKAMKJxhTqF/J1GPl7ejHTAxMS2vtc7/tc
 OtCpkmWEZk/ADvPPNmwsILBATD6//aCIsRW3sC6v2wIdmi8B6YRrlnpMJkWgLGR5Y9UoN59uS
 7TDOUX8k7WOCVhtM0Kv73SMINso8e4VkAEgOi/mwNk6TGIOHqstX8C7t/PRq3MCCT24rF/aS+
 tn0n2hHaMGPBCIsVo76dJHpMt4+Wrkjx/MUasxt9lxpuH7TGjcyimnH09G1Bec6bj7JQ1xDFP
 wChdzONJGUnAo577yURr8wt6wJHgeX4zOzyMbLHjVE/+DEseLJ0c3CVm8FpYv5qi1r34Q0D4j
 uNb98pgNQkmLH+XVd5Ln+1pvx9vhyvBxLI1xU/b7RaS9smshY9gO5saLTsXKIEmO3dqXGqs1e
 /okLnOFZBFz/qmdUY7j3B2rWyxgqz+6HFd8XLI8rePvj+L7PuwyW9mVUf1L9JB0xkbev0XS8s
 3G3BgNPTxqpxmfzbMih66Sj5BXFt0fbdob74BMHRl1DM7SlPf/D2fEwVm2v9NXOpr4c5dlw1+
 XsUlq/5NKZNJysuojCP/+u/D2bB/56wy3FwlHi59ubh2Pe/Cdw+Yy+TaQmlbEha2Ca7dQUtgm
 ynSmho/AYbvx02JLZpaOCyzvJIQOSZu6+jUZkVquRxQvV1v64MljIOMwWCuEgopP+qhrFD9Yf
 31CTZJkYr4xU6kICqkH4ejgSkuKoCBZ09Pm6oH26BPGe6PsvrhrI5hi3q08va2IHrmPIUuBcc
 w68eMQSUhPDu9n1XwvfS5mrTWug6YIbCXkQa6+LjOxrMyjaEt4Zo5m7FaNmR2HH6aj8DwbtLj
 W6h+bO+UdumYMf877DWaeBl0LxkW7Gnxw4LXXPQVb33ITJ4bW0Tnwl4hc97Dh2/+UE2NIsx0f
 9uinGaf7eStP4vZorIHGby6iFrnDk+bbLdLQGbakQ+ufmQ9L5cy9TN9iBcHY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 20 Jan 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Since we want to get rid of git-bisect.sh it would be necessary to
> convert those exit() calls to return statements so that errors can be
> reported.
>
> Emulate try catch in C by converting `exit(<positive-value>)` to
> `return <negative-value>`. Follow POSIX conventions to return
> <negative-value> to indicate error.
>
> Turn `exit()` to `return` calls in `check_good_are_ancestors_of_bad()`.
>
> Code that turns -11(early success code) to 0 from
> `check_good_are_ancestors_of_bad()` has been moved to
> `cmd_bisect__helper()`.
>
> Handle the return value in dependent function `bisect_next_all()`.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  bisect.c                 | 42 ++++++++++++++++++++++++++--------------
>  builtin/bisect--helper.c | 12 ++++++++++--
>  2 files changed, 37 insertions(+), 17 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 367258b0dd..2b80597a1d 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -865,9 +865,10 @@ static int check_ancestors(struct repository *r, in=
t rev_nr,
>   *
>   * If that's not the case, we need to check the merge bases.
>   * If a merge base must be tested by the user, its source code will be
> - * checked out to be tested by the user and we will exit.
> + * checked out to be tested by the user and we will return.
>   */
> -static void check_good_are_ancestors_of_bad(struct repository *r,
> +
> +static int check_good_are_ancestors_of_bad(struct repository *r,
>  					    const char *prefix,
>  					    int no_checkout)
>  {
> @@ -876,8 +877,15 @@ static void check_good_are_ancestors_of_bad(struct =
repository *r,
>  	int fd, rev_nr, res =3D 0;
>  	struct commit **rev;
>
> -	if (!current_bad_oid)
> -		die(_("a %s revision is needed"), term_bad);
> +	/*
> +	 * We don't want to clean the bisection state
> +	 * as we need to get back to where we started
> +	 * by using `git bisect reset`.
> +	 */
> +	if (!current_bad_oid) {
> +		res =3D error(_("a %s revision is needed"), term_bad);
> +		goto done;
> +	}

Why not just return here? Ah, there is a `filename` that was allocated...
it is too bad that we have a mailing-list based review, as the hunk
context simply cannot be extended in a mail.

Personally, I think it would be nicer to split the definition of
`filename` from its declaration and move it _after_ this conditional code,
so that we can `return` right away.

However, there is a more pressing issue than that: `die()` exits with exit
code 128, so in keeping with the idea to hand down negative exit codes as
return values, should we not assign `res =3D -128` here?

>
>  	/* Check if file BISECT_ANCESTORS_OK exists. */
>  	if (!stat(filename, &st) && S_ISREG(st.st_mode))
> @@ -893,18 +901,20 @@ static void check_good_are_ancestors_of_bad(struct=
 repository *r,
>  	if (check_ancestors(r, rev_nr, rev, prefix))
>  		res =3D check_merge_bases(rev_nr, rev, no_checkout);
>  	free(rev);
> -	if(res)
> -		exit(res =3D=3D -11 ? 0 : -res);
> -
> -	/* Create file BISECT_ANCESTORS_OK. */
> -	fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> -	if (fd < 0)
> -		warning_errno(_("could not create file '%s'"),
> -			      filename);
> -	else
> -		close(fd);
> +
> +	if (!res)
> +	{

We usually put the `{` on the same line as the `if` condition (like you
did in the `if (!current_bad_oid)` line above.

The rest looks reasonable. Thank you,
Johannes

> +		/* Create file BISECT_ANCESTORS_OK. */
> +		fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> +		if (fd < 0)
> +			warning_errno(_("could not create file '%s'"),
> +				      filename);
> +		else
> +			close(fd);
> +	}
>   done:
>  	free(filename);
> +	return res;
>  }
>
>  /*
> @@ -975,7 +985,9 @@ int bisect_next_all(struct repository *r, const char=
 *prefix, int no_checkout)
>  	if (read_bisect_refs())
>  		die(_("reading bisect refs failed"));
>
> -	check_good_are_ancestors_of_bad(r, prefix, no_checkout);
> +	res =3D check_good_are_ancestors_of_bad(r, prefix, no_checkout);
> +	if (res)
> +		return res;
>
>  	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
>  	revs.limited =3D 1;
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 826fcba2ed..5e0f759d50 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -666,7 +666,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>
>  	switch (cmdmode) {
>  	case NEXT_ALL:
> -		return bisect_next_all(the_repository, prefix, no_checkout);
> +		res =3D bisect_next_all(the_repository, prefix, no_checkout);
> +		break;
>  	case WRITE_TERMS:
>  		if (argc !=3D 2)
>  			return error(_("--write-terms requires two arguments"));
> @@ -713,5 +714,12 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  		return error("BUG: unknown subcommand '%d'", cmdmode);
>  	}
>  	free_terms(&terms);
> -	return !!res;
> +	/*
> +	 * Handle early success
> +	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_n=
ext_all
> +	 */
> +	if (res =3D=3D -11)
> +		res =3D 0;
> +
> +	return res < 0 ? -res : res;
>  }
> --
> 2.21.1 (Apple Git-122.3)
>
>
