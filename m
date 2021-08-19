Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ACBC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 08:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7DE61139
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 08:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbhHSIJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 04:09:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:57883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236766AbhHSIJt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 04:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629360552;
        bh=0gWPU2cx+4A0s+mqm5YDEfqSlHQWzIKV+ulWP+mLoUc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LK6mw2GWkdbBgVlPpA3kY1DU3DBea5dRKjjkTSCdPnBamwQKMu3+5Ftzl/2sQDHya
         DdHc9AdRaO9zEXTAuzk4jkEUws0EPCFwbnNjGooBVJjqqyQI85vo0bQ1zdjMSwkFLK
         E9InyJf6MnCJzKPJpO0fAUTq8oatjZ8ckRdwU8Bk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7GS-1mMhXV0nUY-00BYTT; Thu, 19
 Aug 2021 10:01:23 +0200
Date:   Thu, 19 Aug 2021 10:01:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/8] unpack-trees: fix nested sparse-dir search
In-Reply-To: <10bcadb284e49419f9b4baf75e05f719ec395d98.1629206603.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108190950540.55@tvgsbejvaqbjf.bet>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <10bcadb284e49419f9b4baf75e05f719ec395d98.1629206603.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IKBtBNr4O9ci8+qmcAoNWTeNVkh643Mhk5EyHqKpYXEQADE5Qgt
 6MOfcQpc0T3TrP1utdsQ095SHhd4ylblLnvGOhBzoFTHREspS/0VFBml2XyN7h8kDzVMMHQ
 nbDD5gHe+qZRD8q+30jVThdYtuy/APFRgE/FT27LFlVxD10nA+xJQf+G6CvaR4u9wRrqjPO
 xlvNUoB/qXKiOqtyd6j6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mlbIan3BkZU=:cf/OWzbx8bGUaZMtQSemXn
 jsxkBEEvAnehHYpUuIhRkJHqorO6ibzFRZXly7s4aIIYqlEXBbLvpdGoPg9RrsDkwLQ3+1XLU
 4LJk3cBDjltXiKaWAR/feMkrQKuuCRITVZl9vA7bov9upvvKKGafJOWdy7c0UrpulXLaj4ppE
 dyqwuuztilAOLm8VoQmpdfmlbRzWPvpcJoon59atilD3A/M5TqByvz6P/Xy4lS3FMDmtFkFG5
 Fe021itMnO71rdplEkFMl5zh1JHG5GkJL1/H5WIcD+LrcRoSWm1v7HwH7cGKZFrvTUnAmOpml
 MOKrx+zJPFMhiUxx9bJlpwk2kRz57+HJQ7S83xVtS9JwkE92LyakxlF7qK0OJzzb46mEDA+xP
 7WoYzZY6RyJn77g7BPHxBNYm+5+GL+HamQGVespyvJe+xM+W0ReWkNx9WJ2uHQFoRj3Lsz2Ix
 p0LzgK7q2TsQFPEQJwjuiN40pGRNw0ePpbU9NHbk1tFWlTQL/Bt5Qx0+S5ZqU4k7u8gb81qOD
 TDvhBQ3ovNArBbRXL8XCo9SJ110aTk89OVcZELwz93+UbEakYLQM36frjq2AFUJJuX3jT0KsM
 8MdI9WL0cdxz4myoC2GX52Y05eG0TrMlsubB1XEoNNLVSgIF9MM7GEnwGz0nBII1L8DwSurlO
 oKb01ZQfw9U+PAF1oix3pPK84j7tqtNDHkbyq0w3HVN62c9SVrcHGXEQI5RFa47xrfe2vwJ2H
 wixO+a9QAHFT1MO5rmFmKnyeZ9wA1tH/LF6txyhFpDWaUBLD6rnhGrLlmobVOuYKPpm2PGLrz
 ehxoB3lQtmNizemwJfRMD60nGPrh6WQyqAAtmFsastICgCSkCN9CrEfu60fdnK60AjgyYYISX
 U2Z4yyWsA/WMi4ipIGGKGzxEfoqjfNU689CDnrf0woSicTEejomJMUPceQF/xN993INWhx5BS
 3Sy3C+0jBoO91fDDZIFyzVOTHyt03sWYq82F3tiP+Tk5GeeanqRDUfCMIBIqgtLtCfURcox3m
 +MGa7IbIAT0TKsXct/7O+hQT5iIujSbSdBlg3UWH8GWYl29eAbSGoFdfs/cbpP1fcvSSvQq5I
 uMXmubvU4G89s7bPNhNtZKwUO1LRJW1HRWcgrKtgI/HKv8KvyXrH6G6Bg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The iterated search in find_cache_entry() was recently modified to
> include a loop that searches backwards for a sparse directory entry that
> matches the given traverse_info and name_entry. However, the string
> comparison failed to actually concatenate those two strings, so this
> failed to find a sparse directory when it was not a top-level directory.
>
> This caused some errors in rare cases where a 'git checkout' spanned a
> diff that modified files within the sparse directory entry, but we could
> not correctly find the entry.

Good explanation.

I wonder a bit about the performance impact. How "hot" is this function?
I.e. how often is it called, on average?

I ask because I see opportunities to optimize in both directions: it could
be written more concisely (if speed does not matter as much), and it could
be made faster (if speed matters a lot). See below for more.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 5786645f315..df1f4437723 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1255,9 +1255,10 @@ static int sparse_dir_matches_path(const struct c=
ache_entry *ce,
>  static struct cache_entry *find_cache_entry(struct traverse_info *info,
>  					    const struct name_entry *p)
>  {
> -	struct cache_entry *ce;
> +	struct cache_entry *ce =3D NULL;

Makes sense: since you need to release the allocated memory, you can no
longer `return NULL` early, but have to break out of the loop and return
`ce`.

>  	int pos =3D find_cache_pos(info, p->path, p->pathlen);
>  	struct unpack_trees_options *o =3D info->data;
> +	struct strbuf full_path =3D STRBUF_INIT;
>
>  	if (0 <=3D pos)
>  		return o->src_index->cache[pos];
> @@ -1273,6 +1274,10 @@ static struct cache_entry *find_cache_entry(struc=
t traverse_info *info,
>  	if (pos < 0 || pos >=3D o->src_index->cache_nr)
>  		return NULL;
>
> +	strbuf_addstr(&full_path, info->traverse_path);
> +	strbuf_add(&full_path, p->path, p->pathlen);
> +	strbuf_addch(&full_path, '/');

This could be reduced to:

	strbuf_addf(&full_path, "%s%.*s/",
		    info->traverse_path, (int)p->pathlen, p->path);

But if speed matters, we probably need something more like this:

	size_t full_path_len;
	const char *full_path;
	char *full_path_1 =3D NULL;

	if (!*info->traverse_path) {
		full_path =3D p->path;
		full_path_len =3D p->pathlen;
	} else {
		size_t len =3D strlen(info->traverse_path);

		full_path_len =3D len + p->pathlen + 1;
		full_path =3D full_path_1 =3D xmalloc(full_path_len + 1);
		memcpy(full_path_1, info->traverse_path, len);
		memcpy(full_path_1 + len, p->path, p->pathlen);
		full_path_1[full_path_len - 1] =3D '/';
		full_path_1[full_path_len] =3D '\0';
	}

	[...]

	free(full_path_1);

It would obviously be much nicer if we did not have to go for that ugly
long version...

> +
>  	/*
>  	 * Due to lexicographic sorting and sparse directory
>  	 * entries ending with a trailing slash, our path as a
> @@ -1283,17 +1288,20 @@ static struct cache_entry *find_cache_entry(stru=
ct traverse_info *info,
>  	while (pos >=3D 0) {
>  		ce =3D o->src_index->cache[pos];
>
> -		if (strncmp(ce->name, p->path, p->pathlen))
> -			return NULL;
> +		if (strncmp(ce->name, full_path.buf, full_path.len)) {
> +			ce =3D NULL;
> +			break;
> +		}
>
>  		if (S_ISSPARSEDIR(ce->ce_mode) &&
>  		    sparse_dir_matches_path(ce, info, p))
> -			return ce;
> +			break;
>
>  		pos--;
>  	}
>
> -	return NULL;
> +	strbuf_release(&full_path);
> +	return ce;
>  }
>
>  static void debug_path(struct traverse_info *info)
> --
> gitgitgadget
>
>
