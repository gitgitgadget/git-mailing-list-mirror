Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200A6C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D10613A7
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbhHXWWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:22:42 -0400
Received: from mout.web.de ([217.72.192.78]:51613 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235429AbhHXWWm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 18:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1629843700;
        bh=GHCwFHQTJCHOnF6/faxa7LLTVGEy3h6CICHJewH2AyE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KgqT0jp1wtf4QQzwsRMMMDDgCmQNKskIfnAenrfqeE22LhKPYeluQSNE1p/W6Vfpz
         q+6SapEaKTBY5nAWbqkQd1Mz9dx8Joq6YdcazYwHrYXX4Fcd2+fi/TlgGUPF32gNeY
         dP3pAz7QYN2fBScaaC3CZQrTZxxW+NHirZuDhlzo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LkhBY-1mqtcW0gSK-00aT1r; Wed, 25 Aug 2021 00:21:40 +0200
Subject: Re: [PATCH v4 05/10] unpack-trees: fix nested sparse-dir search
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
 <acdded0f762800392515c83aec2b276c62ad691c.1629841904.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <51c11512-fb71-277e-790b-88ae3d5a358f@web.de>
Date:   Wed, 25 Aug 2021 00:21:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <acdded0f762800392515c83aec2b276c62ad691c.1629841904.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wIBMvmIf3eXJ8w3G+lEkTKf1s1VSlwxzzR/uvX4WeSXHTbJgjBM
 pV2pJv1Y6I6Qei/0RC+2svK2ZHHF9utBnQdoJ4nH9K+u6K2YX6YYJSYJV1pcRGziEoTfPNK
 xRmT24PgCgwWwzqaGvIQdGSvsmgSBfZuf0W8x6tBZ+kIlfIzds2z5VWdIk2jhYoIDVNIxb7
 gL3+sNf7IEqXUfq8bB8mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l2d1V0dzo2Y=:JlHitYvl9OWEQxGJV4CE+g
 PkytOa8gtJYeT7ulGi3PrdWEjkEjkcxRZU89QLuJwDtPtTa68SNpL9Ft4pUIECNAZCYpub9uT
 7JRNHYkJUgoJBFeCxN7XVfAvbmAKEJl5tJqO5cHRYRc3vD6HnRfwuLXS0Paq50FJ4Mtpqpz4x
 JMiCrybNkkvT3/LP5lhwoililbBXeB2A5hStYwCxKeJ5IT94QcWPATuH3xgZn4KXh6gFgtabp
 ihDgo1+MJVGoYiX6BI2ffAQmEb2KprfJqOZRKQUPDM7TWMkCV2YpfHJi59XAwrDWu2qBbyhOL
 DHnRlnjiH2NQLPfmy3UNDHOYC9nOLLoV3pbDgfi+0Rw7zI1naP64gD4yZ2GrYWv0eYH486Itw
 YUvVvPF06J5Q72Q9G2giAziQn2U7jksUtTunWQZiNO9SaTfCqCX4s60Jqn6H7gu/co5eXEGb+
 14uAI2P0dTbE2ryuqWUXJtXMsP04gq8UfYAqmbyg6vuwBUQ4GMWjQCNJ+Fk3jYGIvv8zl6dOX
 VnrYeY//rq4CuSM+O8kGLWtdbdszqQKjLB6s494567jGMSQyF6WFQ+dwE8PQfdH7linTpP0dz
 IXsXp57RjCTflk31YL51uxU0f5HJvT+lA8IyteDfnxAGhkzOcfl4E0imo2dpRSiFYSJmtVgT6
 5ubP3aAKLBwvhyA/4iPBIDwCijjNNTL6c0Ed9FFsoq6e1nyJCr7EpETICNyixHuBhfsUaRpTh
 Ofe6daEfsDc0kDysyOppbIFXjX/MfPsohtOCdmIsf+6QekgVx88/U4h/A3HPnR5Zq34Gz0nep
 WkfiThWVoRjysR9MCFOG2l3T1boAiBhs5nEO7HpAozyQ/u2n5QcTkduUdPZtN4jmrzl0Bv9ay
 H+chweBTJxculrYy9zCiG1Pa8V1Mq2xBKHh0ZThTjXuftyntQuzSVrY55g77jDHwOMjDcxZTF
 UZSRdu769S5yksxR8xgWN6eO3iccLPAz7z6BlawGeBeQTEYCnP4gSF5G13oCLUWerEwVgWHLH
 +n9bm6VxfMnItAJ8OQhM8+7UTM1PDUgjtJTjizYu8PuF+jEUCyg77xMn7c6qsCKeisn1eztSB
 j9s/WqbJVD8BVD4pFpoIEFoRsy0UzjVxq//
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.08.21 um 23:51 schrieb Derrick Stolee via GitGitGadget:
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
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 5786645f315..47ef0cf4c53 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1255,7 +1255,8 @@ static int sparse_dir_matches_path(const struct ca=
che_entry *ce,
>  static struct cache_entry *find_cache_entry(struct traverse_info *info,
>  					    const struct name_entry *p)
>  {
> -	struct cache_entry *ce;
> +	const char *path;
> +	struct cache_entry *ce =3D NULL;
                              ^^^^^^^
This added initialization doesn't seem to be needed...

>  	int pos =3D find_cache_pos(info, p->path, p->pathlen);
>  	struct unpack_trees_options *o =3D info->data;
>
> @@ -1283,7 +1284,9 @@ static struct cache_entry *find_cache_entry(struct=
 traverse_info *info,
>  	while (pos >=3D 0) {
>  		ce =3D o->src_index->cache[pos];

... because ce is set here before it's used.

>
> -		if (strncmp(ce->name, p->path, p->pathlen))
> +		if (!skip_prefix(ce->name, info->traverse_path, &path) ||
> +		    strncmp(path, p->path, p->pathlen) ||
> +		    path[p->pathlen] !=3D '/')
>  			return NULL;
>
>  		if (S_ISSPARSEDIR(ce->ce_mode) &&
>
