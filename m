Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BF8C35240
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 09:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3C92071A
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 09:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cDjGMCUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgAZJj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 04:39:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:47143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgAZJj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 04:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580031561;
        bh=cHhd6uX04Y59iy7gvUwvm8c9MiCZrFPnMz70OhxmNZQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cDjGMCUmRWNORdxVpnqrdmsZvGmovjgMjXxkEAPGwXCnadmKRnPSofK8W4iZm9aqm
         K6/2mt69h4neCynph+jZmctWjytKMi1NtBCYThzEl+K6qYmJ1Qcv7kz/X6i8SHgKug
         2dLeSJnS4Hf8JlkTCRE8zpwa7NeTYT/3FQlbDt2Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fIW-1iyN991t5G-007BFl; Sun, 26
 Jan 2020 10:39:21 +0100
Date:   Sun, 26 Jan 2020 10:39:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] grep: ignore --recurse-submodules if --no-index is
 given
In-Reply-To: <pull.540.git.1580000298097.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001261036570.46@tvgsbejvaqbjf.bet>
References: <pull.540.git.1580000298097.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HqG6AqsxzrS/y72Xv/mWSBpR3ldMA1jxiCSAFxZ+Ig+Cw76KYbh
 o//nDijRsLEyX0fyc404hLh3xL6O1yZpuS7jXhMlIR3U+ep4Y8KLjsrLCsHBkuXOW41a/tv
 2DO2SJugXaKIWWRdrxjHiHxTdRL+PfwnSrj3pKwkziimwZqk+EFkBgZ96ax0AArrgBXTRQ3
 owmjc4uFkrd1cZxHk9Pig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J769mfsavhA=:W0YaBrgGc3b/YarKpz1kii
 rzN82An8kE2J7SGQFY7WzAnSORXdHbgKOVG+EdshaI/YJ4BHwsnfyNQ0j9Z7lkUNvC6qZgxag
 MnTwGmrfnn0HGv0eHIwreoJHTaaRcqazHWIpQsW8JV5eLf/cNvKrvuEFqLHLMGVv9CzE33dzS
 szcwOISBq8tjyEzWCYJVC8OJcqilARNmzxWZZiwcRl4Ab+YNMtptxKpCVm7xkzzzTcY463eLN
 JjEgTZ4Hq0tRkVyOGy7mDAyzFU6bU+yTVNbB+3lnUceFEp7mgE99TTqqX6+KDE1IYuuefTR0n
 XlDG55Q6Z1QdGjlELFYa7NXmNl/HurXEtE4O5hZtTxEN/+HC64rcz/tGJ8zbGW0mBk6T6lVWu
 Ag0LaDb398xrtQtwRiUFerJFXNDFZR/1Q0sc1SPJoBvwvpNFTLXZCeJD3bU7VTkkb9CF5zZiA
 ZcKAyc/NOnt/q5iTadkasKqUUIO4yVOiavEEEyJMc0JTlcJvReTTLSREQ7QHq+Yp7AZ25dghS
 HhaNOu5EjRsyOfDXC2y0xUaNR9XlmMVmYArQX8Us2Xm2d3MknRDT4s+udG/Lq/aYX1qYVfTd2
 dlpCvi5oERlT0FiHV4CSxQuwN1LUpCNLSwYM2K8RmbhYU68deoHG+vVFZAehe6YivtQLbFxxI
 P+yXvcmGUqpNU6ZGLso22L9ojr5y9X0zkly9+4p7ucc3B5pT7hLr1BsC8OmoSw3Ft7wTdgmnu
 oFVKPNOUSp09+yEeFHvcreMEdc5RERovUP64J1F7Px4IM4Lc/+Rcsbx801zGveHgSmkAqwgbC
 pVJTWxXw71Tr7P3m/Yv8bd4qg7r4tBuifSjVtCD0gQyvhFbgXpCGsdfmKnVWUoetceZ2xOnS1
 x5MNCS5QOckh3xtUx3pMkp4qjgGnmB4Ui0S1LF8QH+aHd6Vf9YtzmBePKvgEzkiWz0BqOE6Oe
 HNncG5fhnKIYQ69I38BknJNVZWH4NeU+gveLEoHTtvYZ4V76X0W788EFGDJD/dWZA0GGOf3Gb
 sAK+HEKA07bc2G4yTCqnQ0YPqKC/3bwiMfOJm2vsKp/rFoWbpyOOI6KiwfsEGpRjHZrJLrw1O
 DaOv8pKXAUV+CHuL1zsnM+hJR4ZNvShcyIYRfjv+QOmenlSrNUlghPQJ3dmXXESvB3gnpATMF
 vL+NVWVbyGd7oTnZ5cC3XlgcxD1cEqPFY0NZ4v62MnNiRQdqg4A+hqyd89HozMyF10MID1O5E
 q15q36qqrjFgOcgHK
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Sun, 26 Jan 2020, Philippe Blain via GitGitGadget wrote:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Since grep learned to recurse into submodules in 0281e487fd
> (grep: optionally recurse into submodules, 2016-12-16),
> using --recurse-submodules along with --no-index makes Git
> die().
>
> This is unfortunate because if submodule.recurse is set in a user's
> ~/.gitconfig, invoking `git grep --no-index` either inside or outside
> a Git repository results in
>
>     fatal: option not supported with --recurse-submodules
>
> Let's allow using these options together, so that setting submodule.recu=
rse
> globally does not prevent using `git grep --no-index`.
>
> Using `--recurse-submodules` should not have any effect if `--no-index`
> is used inside a repository, as Git will recurse into the checked out
> submodule directories just like into regular directories.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>

My initial reaction to this patch was: "but why would you try to combine
`--recurse-submodules` with `--no-index`?". The `submodule.recurse`
reference made me think again, though.

And then it hit me: by `--no-index`, what we _really_ mean to say is:
ignore that this _might_ be tracked in Git. And that obviously means that
there cannot be any submodules to recurse into, as far as `git diff
=2D-no-index` is concerned.

So I think your patch makes a ton of sense.

Thanks,
Dscho

> ---
>     grep: ignore --recurse-submodules if --no-index is given
>
>     Since grep learned to recurse into submodules in 0281e487fd (grep:
>     optionally recurse into submodules, 2016-12-16), using
>     --recurse-submodules along with --no-index makes Git die().
>
>     This is unfortunate because if submodule.recurse is set in a user's
>     ~/.gitconfig, invoking git grep --no-index either inside or outside =
a
>     Git repository results in
>
>     fatal: option not supported with --recurse-submodules
>
>     Let's allow using these options together, so that setting
>     submodule.recurse globally does not prevent using git grep --no-inde=
x.
>
>     Using --recurse-submodules should not have any effect if --no-indexi=
s
>     used inside a repository, as Git will recurse into the checked out
>     submodule directories just like into regular directories.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-540%2F=
phil-blain%2Fgrep-no-index-ignore-recurse-submodule-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-540/phil-=
blain/grep-no-index-ignore-recurse-submodule-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/540
>
>  Documentation/git-grep.txt         |  3 ++-
>  builtin/grep.c                     |  4 ++--
>  t/t7814-grep-recurse-submodules.sh | 11 ++++++++++-
>  3 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index c89fb569e3..ffc3a6efdc 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -96,7 +96,8 @@ OPTIONS
>  	Recursively search in each submodule that has been initialized and
>  	checked out in the repository.  When used in combination with the
>  	<tree> option the prefix of all submodule output will be the name of
> -	the parent project's <tree> object.
> +	the parent project's <tree> object. This option has no effect
> +	if `--no-index` is given.
>
>  -a::
>  --text::
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 50ce8d9461..d5f089dd41 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1115,8 +1115,8 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
>  		}
>  	}
>
> -	if (recurse_submodules && (!use_index || untracked))
> -		die(_("option not supported with --recurse-submodules"));
> +	if (recurse_submodules && untracked)
> +		die(_("--untracked not supported with --recurse-submodules"));
>
>  	if (!show_in_pager && !opt.status_only)
>  		setup_pager();
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-s=
ubmodules.sh
> index 946f91fa57..828cb3ba58 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -345,7 +345,16 @@ test_incompatible_with_recurse_submodules ()
>  }
>
>  test_incompatible_with_recurse_submodules --untracked
> -test_incompatible_with_recurse_submodules --no-index
> +
> +test_expect_success 'grep --recurse-submodules --no-index ignores --rec=
urse-submodules' '
> +	git grep --recurse-submodules --no-index -e "^(.|.)[\d]" >actual &&
> +	cat >expect <<-\EOF &&
> +	a:(1|2)d(3|4)
> +	submodule/a:(1|2)d(3|4)
> +	submodule/sub/a:(1|2)d(3|4)
> +	EOF
> +	test_cmp expect actual
> +'
>
>  test_expect_success 'grep --recurse-submodules should pass the pattern =
type along' '
>  	# Fixed
>
> base-commit: bc7a3d4dc04dd719e7c8c35ebd7a6e6651c5c5b6
> --
> gitgitgadget
>
