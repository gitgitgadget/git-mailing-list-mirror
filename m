Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC35C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E169564EF6
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 16:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBZQB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 11:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhBZQBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 11:01:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A43C061756
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 08:00:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c23so5138515edr.13
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 08:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GbuH98OV/J3Se2AN1jiBzBPYcwb9Uni4MVvgOUDYho4=;
        b=J0AjzmQasV1Vo//8wVu5oHc7YJ469qleGGZL7O8zRubAMEfoUctifC8LbNO0SKkug3
         hmp4H7nBcNV1OPn6VDJOE390uy+mXFG3zDgV8nN9sbjpp9ERQorxoNWNYegw4ci54jNJ
         FYm1Bq8450NedbpxQN6YBNk4cz1JVGekng9FzyXpkvJIPmhRxU2CpOi6TTfwHuxvAh+B
         zuRvn1odTsKPbeWHvn5UtbynOcY8NwPRIM9K9FWz1c6T1R3PzDh0VG557bxTdYsH01Es
         iYNApz3JiLmPO0z0nx7cN7OYpzvGen9TwcjUHUK3XbHr56FnTQB2FWLBkDfelI37+vrq
         DEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GbuH98OV/J3Se2AN1jiBzBPYcwb9Uni4MVvgOUDYho4=;
        b=bMf6vr3WFo9PDIuLJIgtXbQ0dbfQWcbA2yhrhPhdpHdQzUURtDHFs5l/vXDjMxHPrC
         RTk6joKIt4+ybmM6Jl65OZ0xi9sa5MOtHJlSh1heCMUILi/VNrf4gb8QajQE1YFDHwnT
         YG/toI3/ZLpjXWkqts1E0gEI3D3BcZp8Kyg8bXaOd8Jxj0tw4+/Kki1xpm3X1ryyQhWJ
         21GG723XYcbNkSrDq5/gieDcBGr9brmeY/tzC0FPIBXgv70HmGAY7AIbpm0zyRtTYy+x
         lYpLNP5tQqCu+RspqjAJlYHzu09pJZrAWUesyFxpOUpRe3ZJgACrRTRTckILBhER26zW
         0Grg==
X-Gm-Message-State: AOAM531Ed2rTw+zouHelP35U4LojSGsdZ0pNdIXfrEk5fEmq80TYLoo7
        Wyf8dkhuFhB/zlkLqkS6MJA=
X-Google-Smtp-Source: ABdhPJyWzRRWXMN2ruMEjPrkFfrrIGMULKsqVQvGPZ4nPMRVjs1jqtiPqdGxsZ+rEVtlmGwymGd7jQ==
X-Received: by 2002:aa7:ca57:: with SMTP id j23mr4193912edt.293.1614355226720;
        Fri, 26 Feb 2021 08:00:26 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bz20sm5629173ejc.28.2021.02.26.08.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 08:00:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] commit-graph: warn about incompatibilities only when
 trying to write
References: <pull.888.git.1614351036334.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.888.git.1614351036334.gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 17:00:25 +0100
Message-ID: <87r1l27rae.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 26 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In c85eec7fc37 (commit-graph: when incompatible with graphs, indicate
> why, 2021-02-11), we started warning the user if they tried to write a
> commit-graph in a shallow repository, or one containing replace objects.
>
> However, this patch was a bit overzealous, as Git now _also_ warns when
> merely checking whether there _is_ a usable commit graph, not only when
> writing one.
>
> Let's suppress that warning unless we want to write a commit-graph.

Ah, so that's what it's for, as I suspected :) Unfortunately...

> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     commit-graph: warn about incompatibilities only when trying to write
>=20=20=20=20=20
>     As pointed out by =C3=86var in
>     https://lore.kernel.org/git/87pn0o6y1e.fsf@evledraar.gmail.com, my
>     recent patch to trigger warnings in repositories that are incompatible
>     with the commit-graph was a bit too overzealous. Here is a fix for th=
at.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-888%2Fd=
scho%2Fwarn-a-little-less-if-commit-graph-is-skipped-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-888/dscho/=
warn-a-little-less-if-commit-graph-is-skipped-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/888
>
>  commit-graph.c          | 20 ++++++++++++--------
>  t/t5318-commit-graph.sh | 13 +++++++++++++
>  2 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 8fd480434353..245b7108e0d1 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -198,7 +198,7 @@ static struct commit_graph *alloc_commit_graph(void)
>=20=20
>  extern int read_replace_refs;
>=20=20
> -static int commit_graph_compatible(struct repository *r)
> +static int commit_graph_compatible(struct repository *r, int quiet)
>  {
>  	if (!r->gitdir)
>  		return 0;
> @@ -206,8 +206,9 @@ static int commit_graph_compatible(struct repository =
*r)
>  	if (read_replace_refs) {
>  		prepare_replace_object(r);
>  		if (hashmap_get_size(&r->objects->replace_map->map)) {
> -			warning(_("repository contains replace objects; "
> -			       "skipping commit-graph"));
> +			if (!quiet)
> +				warning(_("repository contains replace "
> +					  "objects; skipping commit-graph"));
>  			return 0;
>  		}
>  	}
> @@ -215,12 +216,15 @@ static int commit_graph_compatible(struct repositor=
y *r)
>  	prepare_commit_graft(r);
>  	if (r->parsed_objects &&
>  	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_par=
ent)) {
> -		warning(_("repository contains (deprecated) grafts; "
> -		       "skipping commit-graph"));
> +		if (!quiet)
> +			warning(_("repository contains (deprecated) grafts; "
> +			       "skipping commit-graph"));
>  		return 0;
>  	}
>  	if (is_repository_shallow(r)) {
> -		warning(_("repository is shallow; skipping commit-graph"));
> +		if (!quiet)
> +			warning(_("repository is shallow; skipping "
> +				  "commit-graph"));
>  		return 0;
>  	}
>=20=20
> @@ -652,7 +656,7 @@ static int prepare_commit_graph(struct repository *r)
>  		 */
>  		return 0;
>=20=20
> -	if (!commit_graph_compatible(r))
> +	if (!commit_graph_compatible(r, 1))

...doing this will cause "git gc --auto" to run into persistent
warnings. See a WIP patch-on-top in [1] below...

>  		return 0;
>=20=20
>  	prepare_alt_odb(r);
> @@ -2123,7 +2127,7 @@ int write_commit_graph(struct object_directory *odb,
>  		warning(_("attempting to write a commit-graph, but 'core.commitGraph' =
is disabled"));
>  		return 0;
>  	}
> -	if (!commit_graph_compatible(the_repository))
> +	if (!commit_graph_compatible(the_repository, 0))
>  		return 0;
>=20=20
>  	ctx =3D xcalloc(1, sizeof(struct write_commit_graph_context));
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 2ed0c1544da1..2699c55e9a93 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -741,4 +741,17 @@ test_expect_success 'corrupt commit-graph write (mis=
sing tree)' '
>  	)
>  '
>=20=20
> +test_expect_success 'warn about incompatibilities (only) when writing' '
> +	git init warn &&
> +	test_commit -C warn initial &&
> +	test_commit -C warn second &&
> +	git -C warn replace --graft second &&
> +	test_config -C warn gc.writecommitgraph true &&
> +
> +	git -C warn gc 2>err &&
> +	test_i18ngrep "skipping commit-graph" err &&
> +	git -C warn rev-list -1 second 2>err &&
> +	test_i18ngrep ! "skipping commit-graph" err

...I think it makes sense to have a "test_line_count =3D 1" here for these
sorts of warnings we know/suspect might come up N times if we don't
carefully tweak things.

I think (but have not tested) that we'll still write it 2 times if you
have the graph configured to write on fetch, and we end up also running
"gc" without gc.autoDetach.

In any case, here's a WIP patch to fix/demonstrate the bug here,
consider it to have my SOB (but no need to retain the authorship).

Obviously needs amending (e.g. the "0 &&" case, just to reproduce the
bug), and you might not want the s/int/enum/ cleanup while we're at it.

Also makes sense to add to add this case to the "gc --auto" test,
i.e. if we have writeCommitGraph=3Dtrue && a --depth=3D1 repo do we have no
gc.log at the end as we should.

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ecf85376050..73dacf927f9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1924,13 +1924,13 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
 	     the_repository->settings.fetch_write_commit_graph)) {
-		int commit_graph_flags =3D COMMIT_GRAPH_WRITE_SPLIT;
+		enum commit_graph_write_flags flags =3D COMMIT_GRAPH_WRITE_SPLIT | COMMI=
T_GRAPH_WRITE_WARNINGS;
=20
 		if (progress)
-			commit_graph_flags |=3D COMMIT_GRAPH_WRITE_PROGRESS;
+			flags |=3D COMMIT_GRAPH_WRITE_PROGRESS;
=20
 		write_commit_graph_reachable(the_repository->objects->odb,
-					     commit_graph_flags,
+					     flags,
 					     NULL);
 	}
=20
diff --git a/builtin/gc.c b/builtin/gc.c
index 64f2b52d6e2..9109898eacb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -593,7 +593,7 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		if (!need_to_gc())
+		if (0 && !need_to_gc())
 			return 0;
 		if (!quiet) {
 			if (detach_auto)
@@ -689,10 +689,15 @@ int cmd_gc(int argc, const char **argv, const char *p=
refix)
 	}
=20
 	prepare_repo_settings(the_repository);
-	if (the_repository->settings.gc_write_commit_graph =3D=3D 1)
+	if (the_repository->settings.gc_write_commit_graph) {
+		enum commit_graph_write_flags flags =3D 0;
+		if (!quiet && !daemonized)
+			flags |=3D (COMMIT_GRAPH_WRITE_PROGRESS |
+				  COMMIT_GRAPH_WRITE_WARNINGS);
+=09=09=09=09
 		write_commit_graph_reachable(the_repository->objects->odb,
-					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
-					     NULL);
+					     flags, NULL);
+	}
=20
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
diff --git a/commit-graph.c b/commit-graph.c
index 245b7108e0d..8afc75b2dbe 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -198,7 +198,8 @@ static struct commit_graph *alloc_commit_graph(void)
=20
 extern int read_replace_refs;
=20
-static int commit_graph_compatible(struct repository *r, int quiet)
+static int commit_graph_compatible(struct repository *r,
+				   enum commit_graph_write_flags flags)
 {
 	if (!r->gitdir)
 		return 0;
@@ -206,7 +207,7 @@ static int commit_graph_compatible(struct repository *r=
, int quiet)
 	if (read_replace_refs) {
 		prepare_replace_object(r);
 		if (hashmap_get_size(&r->objects->replace_map->map)) {
-			if (!quiet)
+			if (flags & COMMIT_GRAPH_WRITE_WARNINGS)
 				warning(_("repository contains replace "
 					  "objects; skipping commit-graph"));
 			return 0;
@@ -216,13 +217,13 @@ static int commit_graph_compatible(struct repository =
*r, int quiet)
 	prepare_commit_graft(r);
 	if (r->parsed_objects &&
 	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_paren=
t)) {
-		if (!quiet)
+		if (flags & COMMIT_GRAPH_WRITE_WARNINGS)
 			warning(_("repository contains (deprecated) grafts; "
 			       "skipping commit-graph"));
 		return 0;
 	}
 	if (is_repository_shallow(r)) {
-		if (!quiet)
+		if (flags & COMMIT_GRAPH_WRITE_WARNINGS)
 			warning(_("repository is shallow; skipping "
 				  "commit-graph"));
 		return 0;
@@ -2127,7 +2128,7 @@ int write_commit_graph(struct object_directory *odb,
 		warning(_("attempting to write a commit-graph, but 'core.commitGraph' is=
 disabled"));
 		return 0;
 	}
-	if (!commit_graph_compatible(the_repository, 0))
+	if (!commit_graph_compatible(the_repository, flags))
 		return 0;
=20
 	ctx =3D xcalloc(1, sizeof(struct write_commit_graph_context));
diff --git a/commit-graph.h b/commit-graph.h
index f8e92500c6e..0d2a12a5e58 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -95,9 +95,10 @@ struct bloom_filter_settings *get_bloom_filter_settings(=
struct repository *r);
 enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_APPEND     =3D (1 << 0),
 	COMMIT_GRAPH_WRITE_PROGRESS   =3D (1 << 1),
-	COMMIT_GRAPH_WRITE_SPLIT      =3D (1 << 2),
-	COMMIT_GRAPH_WRITE_BLOOM_FILTERS =3D (1 << 3),
-	COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS =3D (1 << 4),
+	COMMIT_GRAPH_WRITE_WARNINGS   =3D (1 << 2),
+	COMMIT_GRAPH_WRITE_SPLIT      =3D (1 << 3),
+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS =3D (1 << 4),
+	COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS =3D (1 << 5),
 };
=20
 enum commit_graph_split_flags {
