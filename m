Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E9C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 20:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550F0604D2
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 20:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhKBUuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 16:50:24 -0400
Received: from mout.web.de ([212.227.17.12]:50323 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230293AbhKBUuX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 16:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635886058;
        bh=LjMp2V8E8KXLw2rkkyrPk+u01UiyKG4BJABeqlMLz9A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EkpPJWeNiRDXL6njvl6I2hUjZJK0CtvKmUALL7emYfaV9afmyKvDK1Qltchtid2XW
         vKuy2OK9gFho/g45fhZoaX71+zhomxKraT2HhmVDAzkpowWmE+qpnyX+tZ2UEAKbHi
         dtz9dlz49FvJgNAbr+IFodY0mmDaK4/wXwsh5T3U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyDph-1meLsN2ikn-015bet; Tue, 02
 Nov 2021 21:47:38 +0100
Date:   Tue, 2 Nov 2021 21:47:37 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v4 8/8] clean/smudge: allow clean filters to process
 extremely large files
Message-ID: <20211102204737.3wzphfcd6ne3sj2n@tb-raspi4>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
 <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
 <41fda423982d99847d3879f5ea1eb3570ae9eab6.1635867971.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41fda423982d99847d3879f5ea1eb3570ae9eab6.1635867971.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:4k/4ExCjPhWXI8+yNNXibyig83JfG4UgwAAtG2zwqlTwgwOsnb8
 k1/NsQLi9b/eHBuqOHTEXQ+8oo6hfjUIYKnDa2db3iLVEwGN0gG4oAPV/J25MCJ9cBdEqXG
 XbyfDO0m2ufxYQqy9891nXPYBOlbQRaVCoCGWaC7Rpqw8fHhQf4fm8yHM3sRI32LEUX+xQ4
 A7m0nhcBfv6vtXhmZO7sA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3mTLhBAd+Kg=:WGfacwUTaNbTKEYiEXcGb6
 qvp6ysDOMZ4Mjxr0RojRdGT14Pz03iajDsHuh9QAZRtcHlXF9NhNuANqGvPoc/09/Jc+1YkWg
 skmyoAQVub/+7rcFhoHTX6OWgsDSNzr/M9fswwxXn9EXxMKWk9GDTsY8PgETjIhOzPDgK4CTY
 j19cSkzzzp9yV+sR0zHTMBZPlyaJugNE4eYXwORBTqEoMUyLCFh+CNqHGPYP46uJ11eLoXyGF
 aO8tGXkDYBDcA5LzbkHSjhbO9lBSoQsXMUcdSGJGf5rYItUZQptwjYBabGgZ2ALBggCqb1gVq
 tzrdAtKR+2LYZTPd2z2kmVC6rSUiX93ebsws5SzU7VA/JAkLAtx8rdca9jSd3gFCJx183V9Sy
 w0t1W1NiTmUHSIYM0WgH6GADk7Hskfv/YVflTyltapld/9CTz9k/lvLdJqjl1vQmrZxz0yFa1
 baQYBUK5vSZZbLLk2senGyvar5qCSGdgBT+DiGYH+PnuZgo/8F3zON8s+oOA6Uhq8rM/w4a5C
 txmrYUdJE0DNlWvuHX6jdMo+mn2ONq8kPOvQnyLMrBW+u+YLA42tPVIH89Iks8q3eirjoyYWT
 3Mh0KuoXBegav9k1OtwnsZqrDRizcPJVtzOMQ/lSfsrJPbz16Jq3E77AxgLZG+1256ZpcX5Ga
 4QG+c0aaB5hq7BKdMotmB8r26Y7BHRF/0G2Imta70LJQ7VpKQpEk1Q6xEiZbaJKEJfabZ03O5
 fCfwUn6TnsNHK1qOOi+eBM57Lrfokl+hDPielUHOJNJqOADPqgacQ7u0BDFAeOBP8QxY09HPH
 bGKFotDM1oWGUiz9Ve6724G5vjHkjB9lJl4sjmISCupW+RPQ//Nh+1FEQKy+oe1I+ZboS1glV
 EWBUsVXDL+YlhWDDizVfcY2DcmSNZydU8jg41eZVO46O5B/1vCjfgMmCXgkTndsFDaTx8r9EM
 Hdsx3C3o9qZ6IQrTnoNRx7VaBKJglYm1/4Q5gITc3rdx1Aklq3qL9RAelLNKsZFifvP/bSfId
 VOInqx92eLJyNvHdh2r2+6qJ0oLE/6adv3F5QrPuPCIbX7FHdGbYrZq6Kc49ZlLpO5tO22NtJ
 pfV7w45YD6HJu8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 03:46:11PM +0000, Matt Cooper via GitGitGadget wro=
te:
> From: Matt Cooper <vtbassmatt@gmail.com>
>
> The filter system allows for alterations to file contents when they're

Some nit-picking:
looking at
https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes
we can read
"...substitutions in files on commit/checkout."

Should we use this wording here as well ?


> moved between the database and the worktree. We already made sure that
> it is possible for smudge filters to produce contents that are larger
> than `unsigned long` can represent (which matters on systems where
> `unsigned long` is narrower than `size_t`, most notably 64-bit Windows).
> Now we make sure that clean filters can _consume_ contents that are
> larger than that.
>
> Note that this commit only allows clean filters' _input_ to be larger
> than can be represented by `unsigned long`.
>
> This change makes only a very minute dent into the much larger project
> to teach Git to use `size_t` instead of `unsigned long` wherever
> appropriate.
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  convert.c                   |  2 +-
>  t/t1051-large-conversion.sh | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/convert.c b/convert.c
> index fd9c84b0257..5ad6dfc08a0 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -613,7 +613,7 @@ static int crlf_to_worktree(const char *src, size_t =
len, struct strbuf *buf,
>
>  struct filter_params {
>  	const char *src;
> -	unsigned long size;
> +	size_t size;
>  	int fd;
>  	const char *cmd;
>  	const char *path;
> diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
> index e6d52f98b15..042b0e44292 100755
> --- a/t/t1051-large-conversion.sh
> +++ b/t/t1051-large-conversion.sh
> @@ -98,4 +98,15 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_I=
S_64BIT \
>  	test "$size" -eq $((5 * 1024 * 1024 * 1024 + $small_size))
>  '
>
> +# This clean filter writes down the size of input it receives. By check=
ing against
> +# the actual size, we ensure that cleaning doesn't mangle large files o=
n 64-bit Windows.
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> +		'files over 4GB convert on input' '
> +	test-tool genzeros $((5*1024*1024*1024)) >big &&
> +	test_config filter.checklarge.clean "wc -c >big.size" &&
> +	echo "big filter=3Dchecklarge" >.gitattributes &&
> +	git add big &&
> +	test $(test_file_size big) -eq $(cat big.size)
> +'
> +
>  test_done
> --
> gitgitgadget
