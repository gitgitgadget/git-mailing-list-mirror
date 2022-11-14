Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C88C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 11:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiKNLnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 06:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbiKNLnL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 06:43:11 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437420347
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 03:43:09 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so27508181ejb.13
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 03:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iUj94Y9jZeG7MHO5jeAQDSuGnVYh7rkMas0a5IXAnzg=;
        b=IAZMtBIACf7vCF4h02WkypBWa4SEfiQ0Aj6CHo2TO7KR+a/iuyDdPH/xPNgJhDkCEZ
         Qkw0bk7SgUBiO2RjXpl4OcpnnSejpjogR23DDZmbzi4V+rZf94AmRVmuG2gqtZy9HzAo
         GQu6TeMzjPvGatn1ofvBKFR7/6pP6Z5KQk6HV/g49WRKX8YsUv2O4kIgsucdYPC/nhtm
         OS+bnBTnLliNzHG8Lnq3j0dpSiTyMuG88rxmto6aUipxAq0/MuxxJ/vqLV/5StIeOiPP
         q+8+JZ3/0d9vnJs8fCQdb6/fLmqq4o6K9M9Xz5piTvXj2Btk4Q05up1E3URxWjwe8fPT
         xL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iUj94Y9jZeG7MHO5jeAQDSuGnVYh7rkMas0a5IXAnzg=;
        b=qsGthtKbOHy8tVbcsol+2ct6MiACXi4ardfuHVCVh3VILDcgkLmXqUN1qs7ualSNUC
         xQM4X/eQBGlegZirEwVj0OCwQB5Q7NIwO+LebYT3SkpgEfpyrrGSGMTqrurPopaplJuF
         bhQFauwbrYPqevMRAkbmXTZbFstttLobxctU945wAltQ4ehAtKPIU1DfR404GWQV4OCV
         tb9fbWDIcIIhMdTc48xYlaaJW6mJxbYvxo3KdWkHqCd5l8vtRA5TFc77BzuxZ0VUxpLe
         IKBhepjyx5Y5Dpvl2aFx2cQdGd4U5Dm72zi87lHEkmgTbfLN8068t9jJmHM1ESu5Oh2L
         dVTw==
X-Gm-Message-State: ANoB5pktTIhLv2Sk1szndvojmQuNRU797cxdOD0FXtTWsx9Mcd2FNJ5G
        VgAqIcqI9gc3jrCqpQz3mpmXEfb3hH/bDA==
X-Google-Smtp-Source: AA0mqf4Gwl0k9aDyp3JaOYz5/4VIOsDNovdEnXvdbp/vP9T96sFGUpqdgKEmCH0LhituOu/QnkGq1g==
X-Received: by 2002:a17:906:3e03:b0:78d:8bcf:bb47 with SMTP id k3-20020a1709063e0300b0078d8bcfbb47mr10100367eji.525.1668426187536;
        Mon, 14 Nov 2022 03:43:07 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090632c300b0073c10031dc9sm4063562ejk.80.2022.11.14.03.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:43:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ouXrm-003A1P-1o;
        Mon, 14 Nov 2022 12:43:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
Date:   Mon, 14 Nov 2022 11:09:18 +0100
References: <20221109004708.97668-1-chooglen@google.com>
 <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221110.86zgcznjah.gmgdl@evledraar.gmail.com>
 <kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8nl1h19.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221111.86fsepmbhe.gmgdl@evledraar.gmail.com>
 <kl6lsfip0yfx.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6lsfip0yfx.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221114.86y1sdlq2d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 11 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Nov 11 2022, Glen Choo wrote:
>>
>>> Glen Choo <chooglen@google.com> writes:
>>>
>>>> Rereading this series and thinking about this some more, let's go with
>>>> your approach, primarily because it avoids global state.
>>>>
>>>> From this series, it seems that it's not that hard to make this change
>>>> and support whatever use cases we currently have.
>>>>
>>>> This does make it more tedious to add more "--super-prefix" in the
>>>> future, but that's a good push for us to do more things in-process
>>>> and/or be more principled about passing context objects through the ca=
ll
>>>> stack instead of relying on globals.
>>>>
>>>> Let me know what I can add to this effort besides reviewing :)
>>>
>>> Specifically, if you have other things on your plate, I'd be happy to
>>> pick up where where this RFC has left off.
>>
>> I was going to get around to re-rolling this in the next few days, but
>> I'd also be happy to have you beat me to it.
>
> Ah, well, I didn't mean that I was planning to work on this over the
> weekend, but I can certainly get to it on Monday. I meant something
> closer to "If you didn't want to think about git-submodule.sh for the
> next week or so, I can pick this up".
>
> Alternatively, I think it also makes sense if you want to reroll only
> the submodule--helper bits (1-7/8) to unblock your git-submodule.sh
> work, and I can prepare the rest of the "nuke --super-prefix" stuff on
> top of that. That should save you a context switch, and since I sent out
> [1], nuking --super-prefix shouldn't be urgent.
>
> If you don't really care any which way, I'll just re-roll this :)
>
> [1] https://lore.kernel.org/git/pull.1378.git.git.1668210935360.gitgitgad=
get@gmail.com

I just re-rolled it at
https://lore.kernel.org/git/cover-v2-00.10-00000000000-20221114T100803Z-ava=
rab@gmail.com/;
Mainly because I think just going for the "read-tree" fix directly instead =
of:

 1. Adding --super-prefix to "fetch" first, and reviewing any new
    side-effects that may have (i.e. your PR above).
 2. Concurrently, just the "submodule--helper" part of this RFC
 3. Finally, the "read-tree" part, and getting rid of "git
    --super-prefix", which would need to depend on both #1 and #2 above.

Will involve too much avoidable juggling, when getting rid of the global
directly isn't too hard to reason about, in which case we can skip #1
entirely.

Let me know what you think...

> Yeah, this plan makes sense. One thing I'd add is that I'd also use
> OPT__SUPER_PREFIX to handle "git fetch --submodule-prefix".

As noted in the CL above I included this because I see you're keen to
include it, but I'm personally a bit "meh" on it. I.e. it's just
renaming an existing unrelated option, although being able to use
OPT__SUPER_PREFIX() makes it slightly nicer.

As post-cleanups go I think removing the "submodule_prefix" from the
"struct repository" would make more sense, and maybe it's worth peeling
off the 10/10 to include in such a post-cleanup series? I.e. the below
on top of all of this works, and reduces allocations and cargo-culting
around the submodule API.

-- >8 --
Subject: [PATCH] repo & submodule API: stop carrying "repo->submodule_prefi=
x"

As this change shows the "submodule_prefix" field to "struct
repository" added in 96dc883b3cd (repository: enable initialization of
submodules, 2017-06-22) was only used by "ls-files" and "grep". Let's
have those two carry forward the "super_prefix" instead.

Having every user of "struct repository" needing to worry about this
created a mismatch in the API where e.g. "grep" would re-compute a
"name_base_len" which we knew before. Now we use a "struct strbuf" in
the "struct grep_opt" there instead, so we'll know the length
already. This simplifies "grep_cache()" and "grep_tree()".

We're also deleting cargo-culted code that the previous API foisted
upon us. In 605f0ec1350 (submodule: use submodule repos for object
lookup, 2018-12-14) the "Mark it as a submodule" code was added to
"open_submodule()", but the resulting xstrdup()'d "submodule_prefix"
was never used by anything.

Still, removing this field might not be a good move, as the
"super_prefix" might be a common enough case in the future, e.g. when
eventually migrating the "submodule--helper" users[1] to run
in-process.

As the "grep" example demonstrates I don't think that's the
case. There instead of xstrdup()-ing all the way down we're now
carrying a single "super_prefix" in the form of a "struct strbuf". As
we recurse we then append to it, and strbuf_setlen() it back when we
we recurse out of that submodule. This is similar to how e.g. the
"read_tree_at()" API works.

Doing it that way means that we have just one allocation, which in the
common case we might realloc() if we don't have enough room in the
"struct strbuf".

1. https://lore.kernel.org/git/cover-v2-00.10-00000000000-20221114T100803Z-=
avarab@gmail.com/
2. https://github.com/avar/git/tree/avar/grep-post-drop-prefix-cleanup

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 builtin/grep.c     | 18 ++++++++----------
 builtin/ls-files.c | 40 +++++++++++++++++++++++++---------------
 grep.c             |  6 +++---
 grep.h             |  2 ++
 repository.c       |  7 -------
 repository.h       |  7 -------
 submodule.c        |  3 ---
 7 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5fa927d4e22..69826daba26 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -437,6 +437,7 @@ static int grep_submodule(struct grep_opt *opt,
 	struct repository *superproject =3D opt->repo;
 	struct grep_opt subopt;
 	int hit =3D 0;
+	size_t oldlen =3D opt->super_prefix.len;
=20
 	if (!is_submodule_active(superproject, path))
 		return 0;
@@ -497,6 +498,7 @@ static int grep_submodule(struct grep_opt *opt,
 	add_submodule_odb_by_path(subrepo->objects->odb->path);
 	obj_read_unlock();
=20
+	strbuf_addf(&opt->super_prefix, "%s/", path);
 	memcpy(&subopt, opt, sizeof(subopt));
 	subopt.repo =3D subrepo;
=20
@@ -527,6 +529,7 @@ static int grep_submodule(struct grep_opt *opt,
 	} else {
 		hit =3D grep_cache(&subopt, pathspec, cached);
 	}
+	strbuf_setlen(&opt->super_prefix, oldlen);
=20
 	return hit;
 }
@@ -538,11 +541,8 @@ static int grep_cache(struct grep_opt *opt,
 	int hit =3D 0;
 	int nr;
 	struct strbuf name =3D STRBUF_INIT;
-	int name_base_len =3D 0;
-	if (repo->submodule_prefix) {
-		name_base_len =3D strlen(repo->submodule_prefix);
-		strbuf_addstr(&name, repo->submodule_prefix);
-	}
+	size_t name_base_len =3D opt->super_prefix.len;
+	strbuf_addbuf(&name, &opt->super_prefix);
=20
 	if (repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
@@ -618,11 +618,9 @@ static int grep_tree(struct grep_opt *opt, const struc=
t pathspec *pathspec,
 	struct name_entry entry;
 	int old_baselen =3D base->len;
 	struct strbuf name =3D STRBUF_INIT;
-	int name_base_len =3D 0;
-	if (repo->submodule_prefix) {
-		strbuf_addstr(&name, repo->submodule_prefix);
-		name_base_len =3D name.len;
-	}
+	size_t name_base_len =3D opt->super_prefix.len;
+
+	strbuf_addbuf(&name, &opt->super_prefix);
=20
 	while (tree_entry(tree, &entry)) {
 		int te_len =3D tree_entry_len(&entry);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4cf8a236483..c76a6be2fbe 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -216,10 +216,12 @@ static void show_killed_files(struct index_state *ist=
ate,
 	}
 }
=20
-static void show_files(struct repository *repo, struct dir_struct *dir);
+static void show_files(struct repository *repo, struct dir_struct *dir,
+		       const char *super_prefix);
=20
 static void show_submodule(struct repository *superproject,
-			   struct dir_struct *dir, const char *path)
+			   struct dir_struct *dir, const char *path,
+			   const char *super_prefix)
 {
 	struct repository subrepo;
=20
@@ -229,7 +231,7 @@ static void show_submodule(struct repository *superproj=
ect,
 	if (repo_read_index(&subrepo) < 0)
 		die("index file corrupt");
=20
-	show_files(&subrepo, dir);
+	show_files(&subrepo, dir, super_prefix);
=20
 	repo_clear(&subrepo);
 }
@@ -303,14 +305,19 @@ static void show_ce_fmt(struct repository *repo, cons=
t struct cache_entry *ce,
=20
 static void show_ce(struct repository *repo, struct dir_struct *dir,
 		    const struct cache_entry *ce, const char *fullname,
-		    const char *tag)
+		    const char *tag, const char *super_prefix)
 {
 	if (max_prefix_len > strlen(fullname))
 		die("git ls-files: internal error - cache entry not superset of prefix");
=20
 	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 	    is_submodule_active(repo, ce->name)) {
-		show_submodule(repo, dir, ce->name);
+		struct strbuf sp =3D STRBUF_INIT;
+
+		strbuf_addf(&sp, "%s%s/", super_prefix ? super_prefix : "",
+			    ce->name);
+		show_submodule(repo, dir, ce->name, sp.buf);
+		strbuf_release(&sp);
 	} else if (match_pathspec(repo->index, &pathspec, fullname, strlen(fullna=
me),
 				  max_prefix_len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
@@ -374,16 +381,17 @@ static int ce_excluded(struct dir_struct *dir, struct=
 index_state *istate,
 	return is_excluded(dir, istate, fullname, &dtype);
 }
=20
-static void construct_fullname(struct strbuf *out, const struct repository=
 *repo,
-			       const struct cache_entry *ce)
+static void construct_fullname(struct strbuf *out, const struct cache_entr=
y *ce,
+			       const char *super_prefix)
 {
 	strbuf_reset(out);
-	if (repo->submodule_prefix)
-		strbuf_addstr(out, repo->submodule_prefix);
+	if (super_prefix)
+		strbuf_addstr(out, super_prefix);
 	strbuf_addstr(out, ce->name);
 }
=20
-static void show_files(struct repository *repo, struct dir_struct *dir)
+static void show_files(struct repository *repo, struct dir_struct *dir,
+		       const char *super_prefix)
 {
 	int i;
 	struct strbuf fullname =3D STRBUF_INIT;
@@ -410,7 +418,7 @@ static void show_files(struct repository *repo, struct =
dir_struct *dir)
 		struct stat st;
 		int stat_err;
=20
-		construct_fullname(&fullname, repo, ce);
+		construct_fullname(&fullname, ce, super_prefix);
=20
 		if ((dir->flags & DIR_SHOW_IGNORED) &&
 			!ce_excluded(dir, repo->index, fullname.buf, ce))
@@ -422,7 +430,7 @@ static void show_files(struct repository *repo, struct =
dir_struct *dir)
 			show_ce(repo, dir, ce, fullname.buf,
 				ce_stage(ce) ? tag_unmerged :
 				(ce_skip_worktree(ce) ? tag_skip_worktree :
-				 tag_cached));
+				 tag_cached), super_prefix);
 			if (skipping_duplicates)
 				goto skip_to_next_name;
 		}
@@ -435,13 +443,15 @@ static void show_files(struct repository *repo, struc=
t dir_struct *dir)
 		if (stat_err && (errno !=3D ENOENT && errno !=3D ENOTDIR))
 			error_errno("cannot lstat '%s'", fullname.buf);
 		if (stat_err && show_deleted) {
-			show_ce(repo, dir, ce, fullname.buf, tag_removed);
+			show_ce(repo, dir, ce, fullname.buf, tag_removed,
+				super_prefix);
 			if (skipping_duplicates)
 				goto skip_to_next_name;
 		}
 		if (show_modified &&
 		    (stat_err || ie_modified(repo->index, ce, &st, 0))) {
-			show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			show_ce(repo, dir, ce, fullname.buf, tag_modified,
+				super_prefix);
 			if (skipping_duplicates)
 				goto skip_to_next_name;
 		}
@@ -874,7 +884,7 @@ int cmd_ls_files(int argc, const char **argv, const cha=
r *cmd_prefix)
 		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
 	}
=20
-	show_files(the_repository, &dir);
+	show_files(the_repository, &dir, NULL);
=20
 	if (show_resolve_undo)
 		show_ru_info(the_repository->index);
diff --git a/grep.c b/grep.c
index 06eed694936..10d52219229 100644
--- a/grep.c
+++ b/grep.c
@@ -791,9 +791,9 @@ void free_grep_patterns(struct grep_opt *opt)
 		free(p);
 	}
=20
-	if (!opt->pattern_expression)
-		return;
-	free_pattern_expr(opt->pattern_expression);
+	if (opt->pattern_expression)
+		free_pattern_expr(opt->pattern_expression);
+	strbuf_release(&opt->super_prefix);
 }
=20
 static const char *end_of_line(const char *cp, unsigned long *left)
diff --git a/grep.h b/grep.h
index 6075f997e68..d353bfa21ce 100644
--- a/grep.h
+++ b/grep.h
@@ -133,6 +133,7 @@ struct grep_opt {
 	 * t7814-grep-recurse-submodules.sh for more information.
 	 */
 	struct repository *repo;
+	struct strbuf super_prefix;
=20
 	int linenum;
 	int columnnum;
@@ -178,6 +179,7 @@ struct grep_opt {
 };
=20
 #define GREP_OPT_INIT { \
+	.super_prefix =3D STRBUF_INIT, \
 	.relative =3D 1, \
 	.pathname =3D 1, \
 	.max_depth =3D -1, \
diff --git a/repository.c b/repository.c
index 5d166b692c8..2f8581c517d 100644
--- a/repository.c
+++ b/repository.c
@@ -228,12 +228,6 @@ int repo_submodule_init(struct repository *subrepo,
 			goto out;
 		}
 	}
-
-	subrepo->submodule_prefix =3D xstrfmt("%s%s/",
-					    superproject->submodule_prefix ?
-					    superproject->submodule_prefix :
-					    "", path);
-
 out:
 	strbuf_release(&gitdir);
 	strbuf_release(&worktree);
@@ -261,7 +255,6 @@ void repo_clear(struct repository *repo)
 	FREE_AND_NULL(repo->graft_file);
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
-	FREE_AND_NULL(repo->submodule_prefix);
=20
 	raw_object_store_clear(repo->objects);
 	FREE_AND_NULL(repo->objects);
diff --git a/repository.h b/repository.h
index 6c461c5b9de..a08da26133c 100644
--- a/repository.h
+++ b/repository.h
@@ -120,13 +120,6 @@ struct repository {
 	 */
 	char *worktree;
=20
-	/*
-	 * Path from the root of the top-level superproject down to this
-	 * repository.  This is only non-NULL if the repository is initialized
-	 * as a submodule of another repository.
-	 */
-	char *submodule_prefix;
-
 	struct repo_settings settings;
=20
 	/* Subsystems */
diff --git a/submodule.c b/submodule.c
index 1e4eee3492b..1c5ef904a03 100644
--- a/submodule.c
+++ b/submodule.c
@@ -528,9 +528,6 @@ static struct repository *open_submodule(const char *pa=
th)
 		return NULL;
 	}
=20
-	/* Mark it as a submodule */
-	out->submodule_prefix =3D xstrdup(path);
-
 	strbuf_release(&sb);
 	return out;
 }
--=20
2.38.0.1471.ge4d8947e7aa

