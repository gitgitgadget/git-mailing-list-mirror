Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032EFC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 22:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbiFCWtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 18:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiFCWtA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 18:49:00 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6147332059
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 15:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654296506;
        bh=JujYlvwFXqTtUqrVYt63YrvXIdatfiwXc4ZjeSHPFq8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=N1WJGcwFXlKYYIoOLnFP6xFTZYdopx13vG+fTvye9aCLvz/5wjC+RGrdgNjqwPKlb
         WdH2O/igbMfERF4RVsCXJDGtyzkmIxzCis2rFSOtd/8FYg/tzrFkZO6ElvDMOFG6Ob
         3npUIiD7lz6e/Uo0cNxvpC5CcJlq5c0stDBD+eGU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QmF-1nyd0J2c69-001Nmq; Sat, 04
 Jun 2022 00:48:26 +0200
Message-ID: <6fec4a06-ac02-3de0-4517-6aa9314653a6@web.de>
Date:   Sat, 4 Jun 2022 00:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 04/15] diff-lib.c: don't dereference NULL in
 oneway_diff()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-04.15-3a287c19d7e-20220603T183608Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-04.15-3a287c19d7e-20220603T183608Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JedLb4S3Iv0Ou05YSPDweg8qXzgWg3Cjk9UQkCgq6mRefPx3xhZ
 FxKrWzUeswc+Vw9B3hXr4bY2XrXnsI6ILNVR/4vPAqTjXU3hFRWqFpj3N4e5tR4WXe1iYkZ
 1FsHhDetqg/bBxn+Kpnqz0C9HgelfBo+ErJf5ajTbowSYrWSEZBtJB5oKzww/AkiJ49gB+e
 T9pKCrLjsSF8NNBVi7cpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QsTx+x/4kJg=:zOO77/SFixNthDYA3xpMRS
 Ojdqj4bOLfMceOxyt/n59smdi2HipQCY4K2hR82Bjvpv96g1udLh8opHM3v+ZkznrkRYn47ah
 WAT33YgMEF4angwtWj5+h3llyHPPDBbpTxZiMnh5MoHDezJ/13L+Rgh01GFU5oikew1Gg0GUC
 TIm79nw+c6+CJ+tBVgQIT/14anadMyC8/JlyZAVgZmokZjjojlbl4xPSdPmFQ+dM4vvKWCasB
 OZgr+ixIqjmNPd26ROWH5nSUroflXb5cas4egXDVfMNHCPmTmHhCava03EltsXz2IJAK24Ay6
 P1zK6CKYM4EwDYcmsIV7GIv3wAwJMoYEO61mxS4BlIgj5tkBGGVN2O0UPU9Q6eHXFjoicmrxV
 t3IjUj4ggsuYMp+FLSpWG6lSA1PXBddukm1QV1ZwKFh4XSALhQv1IqdDw2TvGViaPmGDsmHVp
 u+lzRn5BGL17OpeqyUpEt8i4EMenwAQQ1f+lfqEMpbIPObV8Xh3VQDbuEdyJglz9G4aXQDJv6
 VVXDu+0VtnU3Xh/kepycLydhitMM7IOEsTfy6MBJFdy7PvxExXPkwre8kUtIV6jaf10HQo6q+
 DxiYAsuw9TAQYaYDyT6cKJks88TFZgZ8exlH1uMvKAUBERQsDCR0tVODqMD9VdJLZo5Z4F8De
 EtTURdMz4RGX3QuXmVH2WN7mBml8sqJ7vrhcPUHRI+qsbNEHm0o3ZNmyKYqsVta4RUBsYc7mK
 7oBaw9xO9KLHrdDBAZ6SxVH/l4yhwbZPyYl4hTstblmlzD9kNUpMeRGIx5czMHePTvyBWZOCi
 k1nVE3kdCRPjO4gxrnUHVEvzEHTCzSwupcGjYg3VCxjq+eZXM9BQyQ7EmotTWSI4vX+YBBTUD
 IUT2Z09HvIEN9Nb8EgaAmI8d3DFusu28vC2YhKF1ecAPlHm5iBo6GJwUfXV5DqmsxY0GC2xRS
 9u02rvHy6dIZ9Pzuzni+dnLvGgYkmUeR5v/6puBct0/7AXZa+/OjyztkkjEQCstVPhP/j9rx8
 TkidPHGvy/syDVt+b9026KozqP7ks9JhndSYO8j2PjSnGHonNEbAD+5HapCaxLpPzw7PpgKwY
 wDrnnm6stSkjGbVYKCSZrl9crDa89XJvzcX
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix a control flow issue dating back to d1f2d7e8ca6 (Make
> run_diff_index() use unpack_trees(), not read_tree(), 2008-01-19)
> where we'd assume "tree" must be non-NULL if idx was NULL. As
> -fanalyzer shows we'd end up dereferencing "tree" in that case in
> ce_path_match():
>
> dir.h:541:41: warning: dereference of NULL =E2=80=98ce=E2=80=99 [CWE-476=
] [-Wanalyzer-null-dereference]
>   541 |                               S_ISDIR(ce->ce_mode) || S_ISGITLIN=
K(ce->ce_mode));
>       |                                         ^
>   =E2=80=98oneway_diff=E2=80=99: events 1-2
>     |
>     |diff-lib.c:493:12:
>     |  493 | static int oneway_diff(const struct cache_entry * const *sr=
c,
>     |      |            ^~~~~~~~~~~
>     |      |            |
>     |      |            (1) entry to =E2=80=98oneway_diff=E2=80=99
>     |......
>     |  506 |         if (tree =3D=3D o->df_conflict_entry)
>     |      |            ~
>     |      |            |
>     |      |            (2) following =E2=80=98true=E2=80=99 branch...
>     |
>   =E2=80=98oneway_diff=E2=80=99: event 3
>     |
>     |  507 |                 tree =3D NULL;
>     |      |                      ^
>     |      |                      |
>     |      |                      (3) ...to here
>     |
>   =E2=80=98oneway_diff=E2=80=99: events 4-8
>     |
>     |  507 |                 tree =3D NULL;
>     |      |                      ^
>     |      |                      |
>     |      |                      (4) =E2=80=98tree=E2=80=99 is NULL
>     |  508 |
>     |  509 |         if (ce_path_match(revs->diffopt.repo->index,
>     |      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     |      |             |
>     |      |             (5) following =E2=80=98false=E2=80=99 branch (w=
hen =E2=80=98idx=E2=80=99 is NULL)...
>     |      |             (6) ...to here
>     |      |             (7) =E2=80=98tree=E2=80=99 is NULL
>     |      |             (8) calling =E2=80=98ce_path_match=E2=80=99 fro=
m =E2=80=98oneway_diff=E2=80=99
>     |  510 |                           idx ? idx : tree,
>     |      |                           ~~~~~~~~~~~~~~~~~
>     |  511 |                           &revs->prune_data, NULL)) {
>     |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~
>     |
>     +--> =E2=80=98ce_path_match=E2=80=99: event 9
>            |
>            |dir.h:535:19:
>            |  535 | static inline int ce_path_match(struct index_state *=
istate,
>            |      |                   ^~~~~~~~~~~~~
>            |      |                   |
>            |      |                   (9) entry to =E2=80=98ce_path_matc=
h=E2=80=99
>            |
>          =E2=80=98ce_path_match=E2=80=99: event 10
>            |
>            |  541 |                               S_ISDIR(ce->ce_mode) |=
| S_ISGITLINK(ce->ce_mode));
>            |      |                                         ^
>            |      |                                         |
>            |      |                                         (10) derefer=
ence of NULL =E2=80=98ce
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  diff-lib.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index ca085a03efc..8373ad7e3ea 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -506,6 +506,9 @@ static int oneway_diff(const struct cache_entry * co=
nst *src,
>  	if (tree =3D=3D o->df_conflict_entry)
>  		tree =3D NULL;

So here we have a D/F conflict in a oneway diff, i.e. a single tree.
That means if we discard the thing from the tree, then we still have
the conflicting thing from the index.  Meaning idx and tree cannot both
be NULL in that D/F conflict scenario.  Right?

>
> +	if (!idx && !tree)
> +		return 0;

That calms down the confused compiler, but would it perhaps be better to
BUG out at this point?  Or is there a valid state with both idx and tree
being NULL?

> +
>  	if (ce_path_match(revs->diffopt.repo->index,
>  			  idx ? idx : tree,>  			  &revs->prune_data, NULL)) {
