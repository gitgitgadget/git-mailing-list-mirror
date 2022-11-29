Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF619C46467
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 13:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiK2N6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiK2N6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 08:58:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896D018371
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:58:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id e13so19866212edj.7
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fc5cx3gQ1/ql+LntuteVlFGhKCWsk+s+aWRtoxCmmoo=;
        b=Q5V7GQn3RA/ezZFbnHr3xUOtr3vRn5x/Z2jRGmWuNhmaz2nU101yFGfDN0Xwq7OkhO
         weYfHu/OEAFxRj2QAdvVfp1V+SugtrDofXDm3WYLellrEhREMf2X5XcLEJ+xWwIrNkYi
         I4T9TBTc+6d7UzU0kLk3Wj4HBj+VphfKR+pDO7y9Sunz5ZpkWyS+X5q6dSyZkvQgCFT+
         jNOluDpqyLZn0hege5GKzTpeMLY0c6QltWk6QfGOY6bOFJ1hwNzeL/ppMfpShukiXqrA
         FXBRXVmRgwcfzYw1uS53mSH2hDiHIGtWgkjFLpSTIc8Oubg6iB1YPkpm2ul3sX+dta9M
         uucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fc5cx3gQ1/ql+LntuteVlFGhKCWsk+s+aWRtoxCmmoo=;
        b=bTA8+PHyttkA/ijkY1o4z3g1rHbZ46gPWnjpZiYv807c+HUir8VuRfYM79oTm7TSSH
         F9vHz9Hq0riNtNO/wRa+euUDoVCOL1+dYlwgyb/mGgZDb97nwAIcmuXvfmcUFvN4Q9G3
         5//6zOhJEnxRU5wR4bODq5AMysaswNjA29lzkrlLYUeEeIHK/bhB6mF++sHt1oHCqCpT
         XGFk4NWACdgv2v2vHKyzJSzpwyiliFAJ7ljh5/ACD3nmaUReBH6GGT89aKdkdDOFG7Xv
         WU00vLkNfqjzkQFB9BNMOrJzp9XhxZeaNE2hTvpYT0fax1OPiITYWGZN7tGrFYXk12lK
         czkw==
X-Gm-Message-State: ANoB5pl4MBD4zl0dtDOZGkT1Q0oyCb1W+jc5h6t8rjfsNwLMXc9OOJnn
        YLDs+ZMyuDIl/KnuM0qP0rY=
X-Google-Smtp-Source: AA0mqf4Tgxg0DujH7g3FCynNkMAIhJFm2RYShEPvDrUe6wlpzOHkQy0WV6t8gjmnuIFVKk9uDqyKPA==
X-Received: by 2002:a05:6402:206b:b0:46a:d5ed:e066 with SMTP id bd11-20020a056402206b00b0046ad5ede066mr17663326edb.335.1669730296842;
        Tue, 29 Nov 2022 05:58:16 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id d6-20020a1709061f4600b007c090da9eb4sm330083ejk.82.2022.11.29.05.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:58:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p017n-001Tsw-2V;
        Tue, 29 Nov 2022 14:58:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/5] pack-objects: simplify --filter handling
Date:   Tue, 29 Nov 2022 14:27:49 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
 <d7a86408-da5c-10ca-90e8-01bc7e268d3e@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <d7a86408-da5c-10ca-90e8-01bc7e268d3e@web.de>
Message-ID: <221129.8635a1kglk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 29 2022, Ren=C3=A9 Scharfe wrote:

First, I think 3/5 in this series looks really good in this iteration.

I think this is also worth cleaning up, but depending on when we expect
this to be queued maybe splitting these post-cleanups into their own
series would make sense?

> pack-objects uses OPT_PARSE_LIST_OBJECTS_FILTER_INIT() to initialize the
> a rev_info struct lazily before populating its filter member using the
> --filter option values.  It tracks whether the initialization is needed
> using the .have_revs member of the callback data.
>
> There is a better way: Use a stand-alone list_objects_filter_options
> struct and build a rev_info struct with its .filter member after option
> parsing.  This allows using the simpler OPT_PARSE_LIST_OBJECTS_FILTER()
> and getting rid of the extra callback mechanism.
>
> Even simpler would be using a struct rev_info as before 5cb28270a1
> (pack-objects: lazily set up "struct rev_info", don't leak, 2022-03-28),
> but that would expose a memory leak caused by repo_init_revisions()
> followed by release_revisions() without a setup_revisions() call in
> between.
>
> Using list_objects_filter_options also allows pushing the rev_info
> struct into get_object_list(), where it arguably belongs. Either way,
> this is all left for later.

I think what you're missing here (or not explaining) is that *the
reason* for us not being able to return to a pre-5cb28270a1 state is
that if we initialize with REV_INFO_INIT we'll first of all find that
the "filter" isn't initialized, because it's not in that macro.

And even if it were there, the repo_init_revisions() will wipe away
anything we add to it once we call repo_init_revisions(), which we'll
need to do any "real" work with it.

But if we're really going to refactor this properly let's stop beating
around the bush and just connect those dots. So first, the only reason
for why "filter" isn't there yet is because a recent topic would have
conflicted with it, so if this is cherry-picked after 3/5 we'll have
that: https://github.com/avar/git/commit/6b29069d72f.patch

Then the below change on top of that could replace this 4/5 and
5/5. I.e. also the 5/5 because the only reason we need the
"opt_lof_init" is because of this init-ing edge case.

	 builtin/pack-objects.c        | 32 +++++++-------------------------
	 list-objects-filter-options.c |  4 ----
	 list-objects-filter-options.h | 29 ++++++++++-------------------
	 revision.c                    | 19 +++++++++++++------
	 revision.h                    |  9 +++++++++
	 5 files changed, 39 insertions(+), 54 deletions(-)
=09
	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
	index c702c09dd45..d0c4c26f4e9 100644
	--- a/builtin/pack-objects.c
	+++ b/builtin/pack-objects.c
	@@ -4149,22 +4149,6 @@ static int option_parse_cruft_expiration(const stru=
ct option *opt,
	 	return 0;
	 }
=09=20
	-struct po_filter_data {
	-	unsigned have_revs:1;
	-	struct rev_info revs;
	-};
	-
	-static struct list_objects_filter_options *po_filter_revs_init(void *valu=
e)
	-{
	-	struct po_filter_data *data =3D value;
	-
	-	if (!data->have_revs)
	-		repo_init_revisions(the_repository, &data->revs, NULL);
	-	data->have_revs =3D 1;
	-
	-	return &data->revs.filter;
	-}
	-
	 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
	 {
	 	int use_internal_rev_list =3D 0;
	@@ -4175,7 +4159,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
	 	int rev_list_index =3D 0;
	 	int stdin_packs =3D 0;
	 	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
	-	struct po_filter_data pfd =3D { .have_revs =3D 0 };
	+	struct rev_info revs =3D REV_INFO_INIT;
=09=20
	 	struct option pack_objects_options[] =3D {
	 		OPT_SET_INT('q', "quiet", &progress,
	@@ -4266,7 +4250,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
	 			      &write_bitmap_index,
	 			      N_("write a bitmap index if possible"),
	 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
	-		OPT_PARSE_LIST_OBJECTS_FILTER_INIT(&pfd, po_filter_revs_init),
	+		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
	 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
	 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
	 		  option_parse_missing_action),
	@@ -4386,7 +4370,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
	 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
	 		unpack_unreachable_expiration =3D 0;
=09=20
	-	if (pfd.have_revs && pfd.revs.filter.choice) {
	+	if (revs.filter.choice) {
	 		if (!pack_to_stdout)
	 			die(_("cannot use --filter without --stdout"));
	 		if (stdin_packs)
	@@ -4473,16 +4457,14 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
	 		read_cruft_objects();
	 	} else if (!use_internal_rev_list) {
	 		read_object_list_from_stdin();
	-	} else if (pfd.have_revs) {
	-		get_object_list(&pfd.revs, rp.nr, rp.v);
	-		release_revisions(&pfd.revs);
	+	} else if (revs.filter.choice) {
	+		repo_dynamic_init_revisions(the_repository, &revs, NULL);
	+		get_object_list(&revs, rp.nr, rp.v);
	 	} else {
	-		struct rev_info revs;
	-
	 		repo_init_revisions(the_repository, &revs, NULL);
	 		get_object_list(&revs, rp.nr, rp.v);
	-		release_revisions(&revs);
	 	}
	+	release_revisions(&revs);
	 	cleanup_preferred_base();
	 	if (include_tag && nr_result)
	 		for_each_tag_ref(add_ref_tag, NULL);
	diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
	index 53396602380..ee01bcd2cc3 100644
	--- a/list-objects-filter-options.c
	+++ b/list-objects-filter-options.c
	@@ -290,10 +290,6 @@ int opt_parse_list_objects_filter(const struct option=
 *opt,
	 				  const char *arg, int unset)
	 {
	 	struct list_objects_filter_options *filter_options =3D opt->value;
	-	opt_lof_init init =3D (opt_lof_init)opt->defval;
	-
	-	if (init)
	-		filter_options =3D init(opt->value);
=09=20
	 	if (unset || !arg)
	 		list_objects_filter_set_no_filter(filter_options);
	diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
	index 7eeadab2dd0..470b86113ac 100644
	--- a/list-objects-filter-options.h
	+++ b/list-objects-filter-options.h
	@@ -108,30 +108,21 @@ void parse_list_objects_filter(
	 	const char *arg);
=09=20
	 /**
	- * The opt->value to opt_parse_list_objects_filter() is either a
	- * "struct list_objects_filter_option *" when using
	- * OPT_PARSE_LIST_OBJECTS_FILTER().
	+ * The opt->value to opt_parse_list_objects_filter() is a "struct
	+ * list_objects_filter_option *".
	  *
	- * Or, if using no "struct option" field is used by the callback,
	- * except the "defval" which is expected to be an "opt_lof_init"
	- * function, which is called with the "opt->value" and must return a
	- * pointer to the ""struct list_objects_filter_option *" to be used.
	- *
	- * The OPT_PARSE_LIST_OBJECTS_FILTER_INIT() can be used e.g. the
	- * "struct list_objects_filter_option" is embedded in a "struct
	- * rev_info", which the "defval" could be tasked with lazily
	- * initializing. See cmd_pack_objects() for an example.
	+ * When it's the "filter" member of a "struct rev_info" make sure to
	+ * initialize it first with "REV_INFO_INIT" or repo_init_revisions()
	+ * before manipulating the "filter". When using "REV_INFO_INIT" to
	+ * lazily initialize a "struct rev_info" use
	+ * repo_dynamic_init_revisions() before using that "struct rev_info"
	+ * with the revisions API.
	  */
	 int opt_parse_list_objects_filter(const struct option *opt,
	 				  const char *arg, int unset);
	-typedef struct list_objects_filter_options *(*opt_lof_init)(void *);
	-#define OPT_PARSE_LIST_OBJECTS_FILTER_INIT(fo, init) \
	-	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
	-	  N_("object filtering"), 0, opt_parse_list_objects_filter, \
	-	  (intptr_t)(init) }
	-
	 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
	-	OPT_PARSE_LIST_OBJECTS_FILTER_INIT((fo), NULL)
	+	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
	+	  N_("object filtering"), 0, opt_parse_list_objects_filter }
=09=20
	 /*
	  * Translates abbreviated numbers in the filter's filter_spec into their
	diff --git a/revision.c b/revision.c
	index 47817da209a..435c864d7cd 100644
	--- a/revision.c
	+++ b/revision.c
	@@ -1888,13 +1888,10 @@ static int add_parents_only(struct rev_info *revs,=
 const char *arg_, int flags,
	 	return 1;
	 }
=09=20
	-void repo_init_revisions(struct repository *r,
	-			 struct rev_info *revs,
	-			 const char *prefix)
	+void repo_dynamic_init_revisions(struct repository *r,
	+				 struct rev_info *revs,
	+				 const char *prefix)
	 {
	-	struct rev_info blank =3D REV_INFO_INIT;
	-	memcpy(revs, &blank, sizeof(*revs));
	-
	 	revs->repo =3D r;
	 	revs->pruning.repo =3D r;
	 	revs->pruning.add_remove =3D file_add_remove;
	@@ -1914,6 +1911,16 @@ void repo_init_revisions(struct repository *r,
	 	init_display_notes(&revs->notes_opt);
	 }
=09=20
	+void repo_init_revisions(struct repository *r,
	+			 struct rev_info *revs,
	+			 const char *prefix)
	+{
	+	struct rev_info blank =3D REV_INFO_INIT;
	+	memcpy(revs, &blank, sizeof(*revs));
	+
	+	repo_dynamic_init_revisions(r, revs, prefix);
	+}
	+
	 static void add_pending_commit_list(struct rev_info *revs,
	 				    struct commit_list *commit_list,
	 				    unsigned int flags)
	diff --git a/revision.h b/revision.h
	index 56c6b012abb..75982288db8 100644
	--- a/revision.h
	+++ b/revision.h
	@@ -417,6 +417,15 @@ struct rev_info {
	 void repo_init_revisions(struct repository *r,
	 			 struct rev_info *revs,
	 			 const char *prefix);
	+
	+/**
	+ * A subset of repo_init_revisions(), assumes that we've already
	+ * initialized with REV_INFO_INIT, and possibly manipulated the
	+ * members initialized therein.
	+ */
	+void repo_dynamic_init_revisions(struct repository *r,
	+				 struct rev_info *revs,
	+				 const char *prefix);
	 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
	 #define init_revisions(revs, prefix) repo_init_revisions(the_repository, =
revs, prefix)
	 #endif

Now, that repo_dynamic_init_revisions() is rather nasty, but why is it
that we need it in the first place? It turns out that this whole
"dynamic init" business is only needed because we need to set
"revs.repo" to "the_repository". So this on top passes all tests:
=09
	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
	index d0c4c26f4e9..190e2f8ee0e 100644
	--- a/builtin/pack-objects.c
	+++ b/builtin/pack-objects.c
	@@ -4458,10 +4458,12 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
	 	} else if (!use_internal_rev_list) {
	 		read_object_list_from_stdin();
	 	} else if (revs.filter.choice) {
	+		xsetenv("GIT_TEST_RI", "1", 1);
	 		repo_dynamic_init_revisions(the_repository, &revs, NULL);
	 		get_object_list(&revs, rp.nr, rp.v);
	 	} else {
	-		repo_init_revisions(the_repository, &revs, NULL);
	+		xsetenv("GIT_TEST_RI", "1", 1);
	+		repo_dynamic_init_revisions(the_repository, &revs, NULL);
	 		get_object_list(&revs, rp.nr, rp.v);
	 	}
	 	release_revisions(&revs);
	diff --git a/revision.c b/revision.c
	index 435c864d7cd..cd832499d22 100644
	--- a/revision.c
	+++ b/revision.c
	@@ -1893,6 +1893,9 @@ void repo_dynamic_init_revisions(struct repository *=
r,
	 				 const char *prefix)
	 {
	 	revs->repo =3D r;
	+	if (getenv("GIT_TEST_RI"))
	+		return;
	+
	 	revs->pruning.repo =3D r;
	 	revs->pruning.add_remove =3D file_add_remove;
	 	revs->pruning.change =3D file_change;

And of course we can in turn simplify that to something like the
CHILD_PROCESS_INIT macro we discussed the other day in another thread,
i.e. just:

	struct rev_info =3D REV_INFO_INIT_VA(
		.repo =3D the_repository,
	};

So then the whole intermediate repo_dynamic_init_revisions() will also
go away, and I suspect many current users of repo_init_revisions() can
be made to just use the macro.

Regarding 5/5: I know I asked in the previous iteration if we couldn't
split that J.5.7 change from the rest, but the 4/5 here just leaves it
as a loose end. I.e. we've already made the macro unused, so in 5/5
we're just cleaning up already dead code.

On reflection, I don't know if splitting it up is worth it after all,
but if it's going to be made an atomic change it'll surely have to
happen the other way around.

E.g. now we take an arbtirary "intptr_t", but once you get rid of the
callback mechanism we stop using it, so we've already done the J.5.7
change.

Maybe it's not possible to split it up after all. In any case the real
valuable thing is to split it from the bug fix in 3/5. If it then goes
away as part of some general refactoring...

I'd also be fine with just having this series as-is at this point,
depending on your appetite to continue hacking on this.

I've been slowly working towards making the "struct rev_info"
initialization less crappy, so the changes above could also be made in
some eventual REV_INFO_INIT series...

