Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63460C4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 21:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjAAVQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 16:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAAVQz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 16:16:55 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00BDD85
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 13:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672607808; bh=YQ3RUvvVnchoMosJ8mLvj+wCGk2EhQrFNYXt7CLiqbw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=airkW54XeC9u+hkbZiPYOfDSWaDhaFRJmQXVCjz51yzXClyzu3SbNMDmzQpOMVFw0
         Ya+VrrcOYym8LOAsGAwAvTx13Erf6ckZ1GQBxLVimvvX1LkLS4rKqVfWYaw25dIvzQ
         FAOgqgTRrydvWvMQ1QasPpVMfCJGE/IKTsv3JroVWtp9W5MG2YJO2riVVJEQt1eljM
         WlbW5KFcZ3YpVK0L6kB9Wozfg62I76zBPTglx2ZaUy7Ez/V3iXSfIiw3UQ3H0w8SYu
         Ew+KHEs5ENB9MAarh8NL6ISb4t7FN5k/Y87npoSjPUTNGNGsPEwGVTJNiMl8Ir3FD6
         LXgk/DPOfACrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7aV-1pOMQx3ND5-00UbAt; Sun, 01
 Jan 2023 22:16:48 +0100
Message-ID: <a76ea021-2dee-7aed-c7a3-bbca017feb1b@web.de>
Date:   Sun, 1 Jan 2023 22:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: [PATCH v2 4/4] use DUP_ARRAY
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
 <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
In-Reply-To: <9bc1bd74-f72c-1b43-df7c-950815babb03@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0323dmfYNqvj8m2um8/jc9JJOuLCbzrf3lXLfRhf4ATxtCxo5H8
 Wa6DsJ2NMJi6BHCNcN9I0efYYbntic2tY3l/2MIPOKdGcRg2yJO3qIHyoop1wNklS+MzMtm
 eOJpAoZt2vNvdCmsk7eHvaGa3OXOTBxbkuMgL7w1c0r9FCpyjcvseGvfAOogATwDwmuzrag
 UuCfox5U4+eQ9o1Cemrxw==
UI-OutboundReport: notjunk:1;M01:P0:xLZbkCLEX4I=;fplwzwm1ziXYPiO3208pF3GEXOX
 8pGlOrE9w8oLoE4XYMKYYJ3V+hTecdPVwwVdh45IAPB1frkwQblbqg9Pe4TTZmrqrpgOT0w/w
 0sD8BQo6SQtjzIet2+pPzXoiw7seFUfSGZu8wz9v0DS9I/DZg/BLoYRmqt3qKUXpbhWobX+un
 9nHxvgq4GLo594Dieay0H0F+baxR9CkUSpvYjD7ZQ9AAjMih3fp5def/D2VpvbTd2UwhKxJDA
 DOkBTcg99NWPDEFSqjXrdAeC429p6yetGHsHCfQBewHbf5rqMvHqDZDVi+PM/qr+CMFAHERaE
 fWEKoBtfqHV+cEKIey4Jpvi+KtRLqzzcPpsqXaIiZ8pL1KiAtHJRj4mxOOcs9ErkpoWWlt/Wg
 jLE5Vhch8GKhXOA1d5o/BV38YqQwfz1JybQdAmOu0GVv0fCLEu+rmLUMMKsdjtkBh7w9aJKx7
 PUOOfQvLPy8HBVu+9d6JF+8XB5Qa7klbm24lXawhr7l9rMWjpvebbtaWaYMS+1hHJLpSPy+tM
 bhIV5X1MVIjIlhlYuXjmeLEC+CeXc1FKnGYttpQoQc1/vSY+9Xduhnsf3H7flTlyaFbKMKWxW
 HqLaWcKteW1KCUU41ooI81a6ZlFUptxcjDppu2sEWZ89msqmsCI1bX1S1VjtusMbE7+8U1fLs
 KIb+WPqoWpkzsvdg+DayJqZj2zyhP+dq45109XNtuMvjWZvKC5vUMcdzE+4gMs3QN3hwo6Oid
 pUwVjAXnG3qQT8xqObUyLAUvk0MYMu/qrZWFgjeeeAaqd+nP2qIhZnQ/n2swaOLaQFaAul07W
 7O//kjeE0ulobJXQfp6yUBuJZHSLE+SW5WMTotsG7+4OUulNSii9PPbCIplC4BZwcljd4DkfG
 2H19MiAiWxLEP1IswR5rlEJmLVWkflhN6/54rfeFyIHies7aL2y5vbbn52yFbL5b42KcPW78Z
 xPlqOA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a semantic patch for replace ALLOC_ARRAY+COPY_ARRAY with DUP_ARRAY
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
