Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198C8C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 22:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiL3WDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 17:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiL3WDx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 17:03:53 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBCE1CFD6
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672437826; bh=LP2XrV3BS2X6qW0VoBU0te+OmGVIDTkXkHqlFTh3kQc=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=tGqHn/eLukXvD+oWLTIVvAkG00dNABxXVYP7KcFozRYea7MSZwhk+r9zIaLM1R7m8
         iYlkpBwM0ikEEe68d8uKNElKYh3SuWmEiVybjBNx1bikXWXDSFf/MSvCG9QPy+DLBO
         MmkcBaUVSID5tCGFr1mxXlt0AyNOgAItbgwTcsmsuPo4NVpkO7QjjkpBvQoKeSrxAB
         ayttyOo9T16Ak2Qehy5v2R1Do0PS0Q4jYnv2wrK36y0Gr0vNYhXhymc8gzbXvSutUi
         jBLImrXeV6Zgbr3Ajo/MyKiZqz0XcLA0GXdjHUaI57/AAhDj5I6ur3bx+t32Y59cwe
         7080MUjoHa0dQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzTPW-1oyGTi1FuC-00vWzy; Fri, 30
 Dec 2022 23:03:46 +0100
Message-ID: <3f8f6ae4-dc70-d1e6-682c-17d078f2c546@web.de>
Date:   Fri, 30 Dec 2022 23:03:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: [PATCH 3/3] use DUP_ARRAY
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
In-Reply-To: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wXRR8ljhkltKyhZB+1UoR8xZ+4aD7pYOEG3IOAueDDGDAC9CCYl
 dXDoA4fZQJDU7FirQX0I2gupqIqOi4M6oqwYO7DStxgzIyAoWD0iH6C6Zx4o8sIyhAho33I
 X8lq8g2Khf2Cm5yt0pMv+lrij0MwGMYuWlYz0XjG/i3sWXjVTHi8Gc+GEDZk9/vhcPK36J/
 4a6d8iqAkLfk7O2EBO5Pw==
UI-OutboundReport: notjunk:1;M01:P0:yNFxyBczBZo=;TbpwgBEA9VxhmbB/69YEwUYSByo
 SVs3/RRwAi2RJ+rHo187QoFAtvYeZ51H3m3178Nijo+Ech0fV/ft2/jfXV/SeWzKms2SVQ1Mt
 bBFCEyo6EsDvrEUbu9mPAPv2G/budCfNysIBaFaoEkAF03lQ8sqnSZHoZSK/cYbXpNbnPYmCD
 80IF6pXfcyDbRlJtP4ZCEObpLEPUiDAEU9Y/M/FPWmlmqm/KpzzYIqZdE4EjjZyp0kvCmiGIn
 cTRX/Rf6HAww4uO2YU15Hd83fslKI6wlCGFW6O6qGQzraEyljIgOURLSpCRhwlNLSMs1nA4MD
 vx8KORBvfehGIbuw0l8BuBt+eMbx+bX0FwzpTUjYtj5gjL5uIqME/IURIGNqejwJvbi5CSGIS
 rS7miTLcA3ayFLchMAl5yiVK49fbdyz5y0leH8F5gVTC1z4r6xy1hyd3zgot+ZQFooos9AM4B
 hkaAckuZivjPEekOX/ZckIVeuGRdzXOxh+5hqHH4iy5WzXFZS1w34Ci6NjNZ3KJSmj8xFTGK+
 aux9ZiE8jMJTJG9roV2eFybuC+aSCXzHd9f6Lnq+jHXydDyQjoh1Q5oLKRz7Eg450k7RlHXaw
 84lP0MSIJhaEW0ubE/oWSOh4+U89XlSuL2asafqk/RsrU3WxqS/JYXtUD5tnHjwal6MVe3DBj
 1TdQIgFB54CHDfL0xPCy7xlSsuI9eMNzrQKB29D1RLTVvelKNbraVuC6QKcRzHJ0ZxbXHZjOj
 H6gYYicY7rEIDbZloSBTcCLc6JEG2MpbRGp/TcsBewtifCAkSd6+9QPVYY6ucjyfUJxzu/BlU
 mBO4KrPeb8cGL8gCmx8pQdhvzoNI/lYzpXI1A+9td78xfFjZT2yVnBMEmXl0tHqR+nOcx2vA5
 VGJuXj6Ykdfmln+B7n/l73I/ayTXZ/Y/eeil/aXYRjE1t6tOBNnvVIxScVJNbBnMiUDYlpvYL
 3CfQrg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a semantic patch to replace ALLOC_ARRAY+COPY_ARRAY with DUP_ARRAY
to reduce code duplication and apply its results.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 attr.c                         | 3 +--
 builtin/am.c                   | 3 +--
 commit-graph.c                 | 3 +--
 commit-reach.c                 | 3 +--
 compat/mingw.c                 | 3 +--
 contrib/coccinelle/array.cocci | 7 +++++++
 parse-options.c                | 3 +--
 pathspec.c                     | 6 ++----
 8 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/attr.c b/attr.c
index 42ad6de8c7..e4e304a826 100644
=2D-- a/attr.c
+++ b/attr.c
@@ -599,8 +599,7 @@ struct attr_check *attr_check_dup(const struct attr_ch=
eck *check)

 	ret->nr =3D check->nr;
 	ret->alloc =3D check->alloc;
-	ALLOC_ARRAY(ret->items, ret->nr);
-	COPY_ARRAY(ret->items, check->items, ret->nr);
+	DUP_ARRAY(ret->items, check->items, ret->nr);

 	return ret;
 }
diff --git a/builtin/am.c b/builtin/am.c
index dddf1b9af0..eee06bbb6c 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -1489,8 +1489,7 @@ static int run_apply(const struct am_state *state, c=
onst char *index_file)
 	 * apply_opts.v keeps referencing the allocated strings for
 	 * strvec_clear() to release.
 	 */
-	ALLOC_ARRAY(apply_argv, apply_opts.nr);
-	COPY_ARRAY(apply_argv, apply_opts.v, apply_opts.nr);
+	DUP_ARRAY(apply_argv, apply_opts.v, apply_opts.nr);

 	opts_left =3D apply_parse_options(apply_opts.nr, apply_argv,
 					&apply_state, &force_apply, &options,
diff --git a/commit-graph.c b/commit-graph.c
index a7d8755932..c11b59f28b 100644
=2D-- a/commit-graph.c
+++ b/commit-graph.c
@@ -1594,8 +1594,7 @@ static void compute_bloom_filters(struct write_commi=
t_graph_context *ctx)
 			_("Computing commit changed paths Bloom filters"),
 			ctx->commits.nr);

-	ALLOC_ARRAY(sorted_commits, ctx->commits.nr);
-	COPY_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);
+	DUP_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);

 	if (ctx->order_by_pack)
 		QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
diff --git a/commit-reach.c b/commit-reach.c
index c226ee3da4..2e33c599a8 100644
=2D-- a/commit-reach.c
+++ b/commit-reach.c
@@ -245,8 +245,7 @@ static int remove_redundant_with_gen(struct repository=
 *r,
 	 * min_gen_pos points to the current position within 'array'
 	 * that is not yet known to be STALE.
 	 */
-	ALLOC_ARRAY(sorted, cnt);
-	COPY_ARRAY(sorted, array, cnt);
+	DUP_ARRAY(sorted, array, cnt);
 	QSORT(sorted, cnt, compare_commits_by_gen);
 	min_generation =3D commit_graph_generation(sorted[0]);

diff --git a/compat/mingw.c b/compat/mingw.c
index d614f156df..ddc5dd0377 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1396,8 +1396,7 @@ static wchar_t *make_environment_block(char **deltae=
nv)
 			p +=3D s;
 		}

-		ALLOC_ARRAY(result, size);
-		COPY_ARRAY(result, wenv, size);
+		DUP_ARRAY(result, wenv, size);
 		FreeEnvironmentStringsW(wenv);
 		return result;
 	}
diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.coc=
ci
index aa75937950..27a3b479c9 100644
=2D-- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -94,3 +94,10 @@ expression n !=3D 1;
 @@
 - ptr =3D xcalloc(n, \( sizeof(*ptr) \| sizeof(T) \) )
 + CALLOC_ARRAY(ptr, n)
+
+@@
+expression dst, src, n;
+@@
+-ALLOC_ARRAY(dst, n);
+-COPY_ARRAY(dst, src, n);
++DUP_ARRAY(dst, src, n);
diff --git a/parse-options.c b/parse-options.c
index a1ec932f0f..fd4743293f 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -702,8 +702,7 @@ static struct option *preprocess_options(struct parse_=
opt_ctx_t *ctx,
 	if (!nr_aliases)
 		return NULL;

-	ALLOC_ARRAY(newopt, nr + 1);
-	COPY_ARRAY(newopt, options, nr + 1);
+	DUP_ARRAY(newopt, options, nr + 1);

 	/* each alias has two string pointers and NULL */
 	CALLOC_ARRAY(ctx->alias_groups, 3 * (nr_aliases + 1));
diff --git a/pathspec.c b/pathspec.c
index 46e77a85fe..e038481dc4 100644
=2D-- a/pathspec.c
+++ b/pathspec.c
@@ -681,8 +681,7 @@ void copy_pathspec(struct pathspec *dst, const struct =
pathspec *src)
 	int i, j;

 	*dst =3D *src;
-	ALLOC_ARRAY(dst->items, dst->nr);
-	COPY_ARRAY(dst->items, src->items, dst->nr);
+	DUP_ARRAY(dst->items, src->items, dst->nr);

 	for (i =3D 0; i < dst->nr; i++) {
 		struct pathspec_item *d =3D &dst->items[i];
@@ -691,8 +690,7 @@ void copy_pathspec(struct pathspec *dst, const struct =
pathspec *src)
 		d->match =3D xstrdup(s->match);
 		d->original =3D xstrdup(s->original);

-		ALLOC_ARRAY(d->attr_match, d->attr_match_nr);
-		COPY_ARRAY(d->attr_match, s->attr_match, d->attr_match_nr);
+		DUP_ARRAY(d->attr_match, s->attr_match, d->attr_match_nr);
 		for (j =3D 0; j < d->attr_match_nr; j++) {
 			const char *value =3D s->attr_match[j].value;
 			d->attr_match[j].value =3D xstrdup_or_null(value);
=2D-
2.39.0
