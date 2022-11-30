Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3576C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 11:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiK3LYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 06:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiK3LYB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 06:24:01 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8813D93E
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 03:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669807399; bh=xKPsC6YtZA5KNcpFyPhTY5gxzy86QwyfIVaTYx54eig=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PxKvAsjfPbg+kbJHgfXFm1G/qcRS4ZDOl/e9DRgQoBIOrTl9WNZdNsJ3uaRUcxA66
         zFcLqkCcZ3xeN5FV0RpTFYtgG5YN4uPCktwpS3BPiYfU5wdNIy/g3ZcuiJPoH85sph
         UxoCS5NY3ZiOiNGv4KW3z1fWBRNmiEtTCoB/qxte6YjmgXk/AaDGkffUHpFY1jH4f5
         PX7GRZ1s1tZLr50NoYRE8jNiofvKGB+UGJCoeIvwfHBnSBNU2zZhOabQch3VCwuixu
         em+3gG/RQhT8QTsfCH/Po3LznCy37LnyUqSGB5S8eq0B9nxG91DbCEF+dUSzd/zc4q
         8NABqt8jGXHow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOli-1pRrPn02MG-00TyHm; Wed, 30
 Nov 2022 12:23:19 +0100
Message-ID: <4fd82dc6-e0f8-0638-5b10-16bfef39a171@web.de>
Date:   Wed, 30 Nov 2022 12:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 4/5] pack-objects: simplify --filter handling
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
 <d7a86408-da5c-10ca-90e8-01bc7e268d3e@web.de>
 <221129.8635a1kglk.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221129.8635a1kglk.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PpLOebQKrJHWYk4Av20PEzuz0F1XN9v2LV/lzZ8kjlUzdbYbrF0
 5VPhgQZKRfP4glgHT5c0XHMup9/2ZnzwnBClPAow1viR+1DPZ2JLg0VQvVF2YZCvtMLjsRR
 ub5kwCZZhmWUrqIcZl8LsD+Wq7MHKmQNmYt+2FFXJrJ5tibei3MR8CZflaDrTk81Ckgk5DE
 rv/GbCVYp9Tfd9ewnifkg==
UI-OutboundReport: notjunk:1;M01:P0:BIKDmQMllFU=;zPN3AiPJHeukyiH2hX1dkIw9H35
 8fshT2gJhA2+3JuKB4jAhqaXMs6dTT051t6Ucjnh2YYM2T4UD+N0cLFBTQU1wSZnXuf8nfM3F
 3xG1o2i2mtB/dSk23jgMxhW3qsWOL1lTFY7bAg1emGkyvZDEJk7p7OLPJULseO51AdzjjyxTD
 2OL8kL4NoaDFPeUHFKS4zcs2n+BUWCS9xjIEM8Pgws1kbIU7oNs2wGavrgLCnWxLrN746xCDV
 q3g6BehZSyP2drqMvreXPUF2ZBWOPMtMR6KpiYAM7xCkwyPyW985EOUwEVprcQ2HFXKjZKycu
 glb/qJ2UEbT7KyEdaX0102RFTsVATBWDz0d54ncqHBQlOYA8qttys2l4XFDVF8/gPTRZdPTwb
 6A/G/wR563HRPCpt1D7Juo8yFs46RrfeaYmnxhbrwysdEW3z2LXqg80wz3oFSYTr9u6Of+Rqb
 GEbqHT+UvwjePzhKA/fP4kivx1EnXkQqurH64BKzryTH3H2OauuUY3FvQ4fH/di+dRxJVJsOd
 Y25M2nRiTgqShd4Iwsy6TU+nRK8LvBGB8pndZCIi2zNcEswwfYNA3BW8alXDjlza6gaD0XDn1
 Xai48DD5j+EnCRwdsmZhbygbm0UfRChjbowYWLokqcy8YqrhjFNfzURgPDcEnUw35fWWRFlj9
 xw811Mtru0/2XXs/FHOaLTxIMAbjhXWEv7/9aMuVNGRiAnhoLYxgLGWIyuj7kWTAB612IoO3Q
 aJGI38ODg7W960tYLWZmHPLV2X/CtxyTakuuoR36a/uBR6tqHw+PibsEyn1MYc8sN4g8heWgf
 KHeMmnKpdDXGSMwXKNMZZybUbi17smjDUZw2sjvAdR5M6LgAtI1yvfQBEVOXBx5doiuxNZXDG
 R6WJ78Vgj3tedLU4LFuOEdXCRslX5gZWGYnEC8vgEJfDkGd3/5UcK+puNIb7cHbv0CQ7DqHRZ
 q74ceqy6IHNk7a5F7e1Cd5cqg3w=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.11.22 um 14:27 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Nov 29 2022, Ren=C3=A9 Scharfe wrote:
>
> First, I think 3/5 in this series looks really good in this iteration.
>
> I think this is also worth cleaning up, but depending on when we expect
> this to be queued maybe splitting these post-cleanups into their own
> series would make sense?
>
>> pack-objects uses OPT_PARSE_LIST_OBJECTS_FILTER_INIT() to initialize th=
e
>> a rev_info struct lazily before populating its filter member using the
>> --filter option values.  It tracks whether the initialization is needed
>> using the .have_revs member of the callback data.
>>
>> There is a better way: Use a stand-alone list_objects_filter_options
>> struct and build a rev_info struct with its .filter member after option
>> parsing.  This allows using the simpler OPT_PARSE_LIST_OBJECTS_FILTER()
>> and getting rid of the extra callback mechanism.
>>
>> Even simpler would be using a struct rev_info as before 5cb28270a1
>> (pack-objects: lazily set up "struct rev_info", don't leak, 2022-03-28)=
,
>> but that would expose a memory leak caused by repo_init_revisions()
>> followed by release_revisions() without a setup_revisions() call in
>> between.
>>
>> Using list_objects_filter_options also allows pushing the rev_info
>> struct into get_object_list(), where it arguably belongs. Either way,
>> this is all left for later.
>
> I think what you're missing here (or not explaining) is that *the
> reason* for us not being able to return to a pre-5cb28270a1 state is
> that if we initialize with REV_INFO_INIT we'll first of all find that
> the "filter" isn't initialized, because it's not in that macro.

The parent of 5cb28270a1 used repo_init_revisions(), not REV_INFO_INIT
directly, so that macro is not a direct reason.

But you mean that in a world where struct rev_info can be sufficiently
initialized with a macro we could use it without allocations, avoiding
leaks?  And for pack-objects just the filter member is missing to reach
that goal?

> And even if it were there, the repo_init_revisions() will wipe away
> anything we add to it once we call repo_init_revisions(), which we'll
> need to do any "real" work with it.
>
> But if we're really going to refactor this properly let's stop beating
> around the bush and just connect those dots. So first, the only reason
> for why "filter" isn't there yet is because a recent topic would have
> conflicted with it, so if this is cherry-picked after 3/5 we'll have
> that: https://github.com/avar/git/commit/6b29069d72f.patch

That patch looks good.

> Then the below change on top of that could replace this 4/5 and
> 5/5. I.e. also the 5/5 because the only reason we need the
> "opt_lof_init" is because of this init-ing edge case.
>
> 	 builtin/pack-objects.c        | 32 +++++++-------------------------
> 	 list-objects-filter-options.c |  4 ----
> 	 list-objects-filter-options.h | 29 ++++++++++-------------------
> 	 revision.c                    | 19 +++++++++++++------
> 	 revision.h                    |  9 +++++++++
> 	 5 files changed, 39 insertions(+), 54 deletions(-)
>
> 	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> 	index c702c09dd45..d0c4c26f4e9 100644
> 	--- a/builtin/pack-objects.c
> 	+++ b/builtin/pack-objects.c
> 	@@ -4149,22 +4149,6 @@ static int option_parse_cruft_expiration(const s=
truct option *opt,
> 	 	return 0;
> 	 }
>
> 	-struct po_filter_data {
> 	-	unsigned have_revs:1;
> 	-	struct rev_info revs;
> 	-};
> 	-
> 	-static struct list_objects_filter_options *po_filter_revs_init(void *v=
alue)
> 	-{
> 	-	struct po_filter_data *data =3D value;
> 	-
> 	-	if (!data->have_revs)
> 	-		repo_init_revisions(the_repository, &data->revs, NULL);
> 	-	data->have_revs =3D 1;
> 	-
> 	-	return &data->revs.filter;
> 	-}
> 	-
> 	 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> 	 {
> 	 	int use_internal_rev_list =3D 0;
> 	@@ -4175,7 +4159,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
> 	 	int rev_list_index =3D 0;
> 	 	int stdin_packs =3D 0;
> 	 	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
> 	-	struct po_filter_data pfd =3D { .have_revs =3D 0 };
> 	+	struct rev_info revs =3D REV_INFO_INIT;
>
> 	 	struct option pack_objects_options[] =3D {
> 	 		OPT_SET_INT('q', "quiet", &progress,
> 	@@ -4266,7 +4250,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
> 	 			      &write_bitmap_index,
> 	 			      N_("write a bitmap index if possible"),
> 	 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
> 	-		OPT_PARSE_LIST_OBJECTS_FILTER_INIT(&pfd, po_filter_revs_init),
> 	+		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
> 	 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
> 	 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
> 	 		  option_parse_missing_action),
> 	@@ -4386,7 +4370,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
> 	 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
> 	 		unpack_unreachable_expiration =3D 0;
>
> 	-	if (pfd.have_revs && pfd.revs.filter.choice) {
> 	+	if (revs.filter.choice) {
> 	 		if (!pack_to_stdout)
> 	 			die(_("cannot use --filter without --stdout"));
> 	 		if (stdin_packs)
> 	@@ -4473,16 +4457,14 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
> 	 		read_cruft_objects();
> 	 	} else if (!use_internal_rev_list) {
> 	 		read_object_list_from_stdin();
> 	-	} else if (pfd.have_revs) {
> 	-		get_object_list(&pfd.revs, rp.nr, rp.v);
> 	-		release_revisions(&pfd.revs);
> 	+	} else if (revs.filter.choice) {
> 	+		repo_dynamic_init_revisions(the_repository, &revs, NULL);
> 	+		get_object_list(&revs, rp.nr, rp.v);
> 	 	} else {
> 	-		struct rev_info revs;
> 	-
> 	 		repo_init_revisions(the_repository, &revs, NULL);
> 	 		get_object_list(&revs, rp.nr, rp.v);
> 	-		release_revisions(&revs);
> 	 	}
> 	+	release_revisions(&revs);
> 	 	cleanup_preferred_base();
> 	 	if (include_tag && nr_result)
> 	 		for_each_tag_ref(add_ref_tag, NULL);
> 	diff --git a/list-objects-filter-options.c b/list-objects-filter-option=
s.c
> 	index 53396602380..ee01bcd2cc3 100644
> 	--- a/list-objects-filter-options.c
> 	+++ b/list-objects-filter-options.c
> 	@@ -290,10 +290,6 @@ int opt_parse_list_objects_filter(const struct opt=
ion *opt,
> 	 				  const char *arg, int unset)
> 	 {
> 	 	struct list_objects_filter_options *filter_options =3D opt->value;
> 	-	opt_lof_init init =3D (opt_lof_init)opt->defval;
> 	-
> 	-	if (init)
> 	-		filter_options =3D init(opt->value);
>
> 	 	if (unset || !arg)
> 	 		list_objects_filter_set_no_filter(filter_options);
> 	diff --git a/list-objects-filter-options.h b/list-objects-filter-option=
s.h
> 	index 7eeadab2dd0..470b86113ac 100644
> 	--- a/list-objects-filter-options.h
> 	+++ b/list-objects-filter-options.h
> 	@@ -108,30 +108,21 @@ void parse_list_objects_filter(
> 	 	const char *arg);
>
> 	 /**
> 	- * The opt->value to opt_parse_list_objects_filter() is either a
> 	- * "struct list_objects_filter_option *" when using
> 	- * OPT_PARSE_LIST_OBJECTS_FILTER().
> 	+ * The opt->value to opt_parse_list_objects_filter() is a "struct
> 	+ * list_objects_filter_option *".
> 	  *
> 	- * Or, if using no "struct option" field is used by the callback,
> 	- * except the "defval" which is expected to be an "opt_lof_init"
> 	- * function, which is called with the "opt->value" and must return a
> 	- * pointer to the ""struct list_objects_filter_option *" to be used.
> 	- *
> 	- * The OPT_PARSE_LIST_OBJECTS_FILTER_INIT() can be used e.g. the
> 	- * "struct list_objects_filter_option" is embedded in a "struct
> 	- * rev_info", which the "defval" could be tasked with lazily
> 	- * initializing. See cmd_pack_objects() for an example.
> 	+ * When it's the "filter" member of a "struct rev_info" make sure to
> 	+ * initialize it first with "REV_INFO_INIT" or repo_init_revisions()
> 	+ * before manipulating the "filter". When using "REV_INFO_INIT" to
> 	+ * lazily initialize a "struct rev_info" use
> 	+ * repo_dynamic_init_revisions() before using that "struct rev_info"
> 	+ * with the revisions API.
> 	  */
> 	 int opt_parse_list_objects_filter(const struct option *opt,
> 	 				  const char *arg, int unset);
> 	-typedef struct list_objects_filter_options *(*opt_lof_init)(void *);
> 	-#define OPT_PARSE_LIST_OBJECTS_FILTER_INIT(fo, init) \
> 	-	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
> 	-	  N_("object filtering"), 0, opt_parse_list_objects_filter, \
> 	-	  (intptr_t)(init) }
> 	-
> 	 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
> 	-	OPT_PARSE_LIST_OBJECTS_FILTER_INIT((fo), NULL)
> 	+	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
> 	+	  N_("object filtering"), 0, opt_parse_list_objects_filter }
>
> 	 /*
> 	  * Translates abbreviated numbers in the filter's filter_spec into the=
ir
> 	diff --git a/revision.c b/revision.c
> 	index 47817da209a..435c864d7cd 100644
> 	--- a/revision.c
> 	+++ b/revision.c
> 	@@ -1888,13 +1888,10 @@ static int add_parents_only(struct rev_info *re=
vs, const char *arg_, int flags,
> 	 	return 1;
> 	 }
>
> 	-void repo_init_revisions(struct repository *r,
> 	-			 struct rev_info *revs,
> 	-			 const char *prefix)
> 	+void repo_dynamic_init_revisions(struct repository *r,
> 	+				 struct rev_info *revs,
> 	+				 const char *prefix)
> 	 {
> 	-	struct rev_info blank =3D REV_INFO_INIT;
> 	-	memcpy(revs, &blank, sizeof(*revs));
> 	-
> 	 	revs->repo =3D r;
> 	 	revs->pruning.repo =3D r;
> 	 	revs->pruning.add_remove =3D file_add_remove;
> 	@@ -1914,6 +1911,16 @@ void repo_init_revisions(struct repository *r,
> 	 	init_display_notes(&revs->notes_opt);
> 	 }
>
> 	+void repo_init_revisions(struct repository *r,
> 	+			 struct rev_info *revs,
> 	+			 const char *prefix)
> 	+{
> 	+	struct rev_info blank =3D REV_INFO_INIT;
> 	+	memcpy(revs, &blank, sizeof(*revs));
> 	+
> 	+	repo_dynamic_init_revisions(r, revs, prefix);
> 	+}
> 	+
> 	 static void add_pending_commit_list(struct rev_info *revs,
> 	 				    struct commit_list *commit_list,
> 	 				    unsigned int flags)
> 	diff --git a/revision.h b/revision.h
> 	index 56c6b012abb..75982288db8 100644
> 	--- a/revision.h
> 	+++ b/revision.h
> 	@@ -417,6 +417,15 @@ struct rev_info {
> 	 void repo_init_revisions(struct repository *r,
> 	 			 struct rev_info *revs,
> 	 			 const char *prefix);
> 	+
> 	+/**
> 	+ * A subset of repo_init_revisions(), assumes that we've already
> 	+ * initialized with REV_INFO_INIT, and possibly manipulated the
> 	+ * members initialized therein.
> 	+ */
> 	+void repo_dynamic_init_revisions(struct repository *r,
> 	+				 struct rev_info *revs,
> 	+				 const char *prefix);
> 	 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
> 	 #define init_revisions(revs, prefix) repo_init_revisions(the_repositor=
y, revs, prefix)
> 	 #endif
>
> Now, that repo_dynamic_init_revisions() is rather nasty, but why is it
> that we need it in the first place? It turns out that this whole
> "dynamic init" business is only needed because we need to set
> "revs.repo" to "the_repository". So this on top passes all tests:
>
> 	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> 	index d0c4c26f4e9..190e2f8ee0e 100644
> 	--- a/builtin/pack-objects.c
> 	+++ b/builtin/pack-objects.c
> 	@@ -4458,10 +4458,12 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
> 	 	} else if (!use_internal_rev_list) {
> 	 		read_object_list_from_stdin();
> 	 	} else if (revs.filter.choice) {
> 	+		xsetenv("GIT_TEST_RI", "1", 1);
> 	 		repo_dynamic_init_revisions(the_repository, &revs, NULL);
> 	 		get_object_list(&revs, rp.nr, rp.v);
> 	 	} else {
> 	-		repo_init_revisions(the_repository, &revs, NULL);
> 	+		xsetenv("GIT_TEST_RI", "1", 1);
> 	+		repo_dynamic_init_revisions(the_repository, &revs, NULL);
> 	 		get_object_list(&revs, rp.nr, rp.v);
> 	 	}
> 	 	release_revisions(&revs);
> 	diff --git a/revision.c b/revision.c
> 	index 435c864d7cd..cd832499d22 100644
> 	--- a/revision.c
> 	+++ b/revision.c
> 	@@ -1893,6 +1893,9 @@ void repo_dynamic_init_revisions(struct repositor=
y *r,
> 	 				 const char *prefix)
> 	 {
> 	 	revs->repo =3D r;
> 	+	if (getenv("GIT_TEST_RI"))
> 	+		return;
> 	+
> 	 	revs->pruning.repo =3D r;
> 	 	revs->pruning.add_remove =3D file_add_remove;
> 	 	revs->pruning.change =3D file_change;
>
> And of course we can in turn simplify that to something like the
> CHILD_PROCESS_INIT macro we discussed the other day in another thread,
> i.e. just:
>
> 	struct rev_info =3D REV_INFO_INIT_VA(
> 		.repo =3D the_repository,
> 	};
>
> So then the whole intermediate repo_dynamic_init_revisions() will also
> go away, and I suspect many current users of repo_init_revisions() can
> be made to just use the macro.

Converting existing users of repo_init_revisions() to partial
initialization using a macro seems like a lot of work to determine if
that subset is sufficient.  Testing alone won't be enough.

A macro that initializes the struct fully would be easier to use.  One
obstacle is that repo and prefix are duplicated into embedded structs
(.repo, .pruning.repo, .grep_filter.repo, .diffopt.repo; .prefix,
.diffopt.prefix).  Another is .diffopt.parseopts, which includes
pointers to other .diffopt members, whose initialization requires the
name of the rev_info variable.

Why do we want to get rid of repo_init_revisions()?  Because it
allocates .diffopt.parseopts and we sometimes forget to release it,
especially in cases where we don't actually need it.  We can avoid
that by leaving the allocations to the code paths that parse diff
options.  That's actually easy (for now?) because only two places
customize the option list and they do it by concatenation.  Patch
below.

> Regarding 5/5: I know I asked in the previous iteration if we couldn't
> split that J.5.7 change from the rest, but the 4/5 here just leaves it
> as a loose end. I.e. we've already made the macro unused, so in 5/5
> we're just cleaning up already dead code.
>
> On reflection, I don't know if splitting it up is worth it after all,
> but if it's going to be made an atomic change it'll surely have to
> happen the other way around.
>
> E.g. now we take an arbtirary "intptr_t", but once you get rid of the
> callback mechanism we stop using it, so we've already done the J.5.7
> change.
>
> Maybe it's not possible to split it up after all. In any case the real
> valuable thing is to split it from the bug fix in 3/5. If it then goes
> away as part of some general refactoring...
>
> I'd also be fine with just having this series as-is at this point,
> depending on your appetite to continue hacking on this.
>
> I've been slowly working towards making the "struct rev_info"
> initialization less crappy, so the changes above could also be made in
> some eventual REV_INFO_INIT series...

Merging the introduction or removal of infrastructure with the first or
last use is sometimes nicer, e.g. if one part is small.  Here I slightly
prefer to keep the different concerns separate, i.e. to not merge patch
4 and 5, because 4 is big enough already and 5 being a trivial dead code
removal is a good thing in my eyes.


diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index e2a74efb42..757010069f 100644
=2D-- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -47,7 +47,7 @@ int cmd_range_diff(int argc, const char **argv, const ch=
ar *prefix)

 	repo_diff_setup(the_repository, &diffopt);

-	options =3D parse_options_concat(range_diff_options, diffopt.parseopts);
+	options =3D diff_parse_options_concat(range_diff_options, &diffopt);
 	argc =3D parse_options(argc, argv, prefix, options,
 			     builtin_range_diff_usage, PARSE_OPT_KEEP_DASHDASH);

diff --git a/diff-no-index.c b/diff-no-index.c
index 18edbdf4b5..0a240039a0 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -255,8 +255,7 @@ int diff_no_index(struct rev_info *revs,
 	};
 	struct option *options;

-	options =3D parse_options_concat(no_index_options,
-				       revs->diffopt.parseopts);
+	options =3D diff_parse_options_concat(no_index_options, &revs->diffopt);
 	argc =3D parse_options(argc, argv, revs->prefix, options,
 			     diff_no_index_usage, 0);
 	if (argc !=3D 2) {
diff --git a/diff.c b/diff.c
index 1054a4b732..ebf9154eaf 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4615,8 +4615,6 @@ static void run_checkdiff(struct diff_filepair *p, s=
truct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }

-static void prep_parse_options(struct diff_options *options);
-
 void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
@@ -4662,8 +4660,6 @@ void repo_diff_setup(struct repository *r, struct di=
ff_options *options)

 	options->color_moved =3D diff_color_moved_default;
 	options->color_moved_ws_handling =3D diff_color_moved_ws_default;
-
-	prep_parse_options(options);
 }

 static const char diff_status_letters[] =3D {
@@ -4821,8 +4817,6 @@ void diff_setup_done(struct diff_options *options)
 			options->filter =3D ~filter_bit[DIFF_STATUS_FILTER_AON];
 		options->filter &=3D ~options->filter_not;
 	}
-
-	FREE_AND_NULL(options->parseopts);
 }

 int parse_long_opt(const char *opt, const char **argv,
@@ -5419,7 +5413,8 @@ static int diff_opt_rotate_to(const struct option *o=
pt, const char *arg, int uns
 	return 0;
 }

-static void prep_parse_options(struct diff_options *options)
+struct option *diff_parse_options_concat(const struct option *extra,
+					 struct diff_options *options)
 {
 	struct option parseopts[] =3D {
 		OPT_GROUP(N_("Diff output format options")),
@@ -5689,22 +5684,24 @@ static void prep_parse_options(struct diff_options=
 *options)
 		OPT_END()
 	};

-	ALLOC_ARRAY(options->parseopts, ARRAY_SIZE(parseopts));
-	memcpy(options->parseopts, parseopts, sizeof(parseopts));
+	return parse_options_concat(extra, parseopts);
 }

 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
+	struct option *opts =3D diff_parse_options_concat(NULL, options);
+
 	if (!prefix)
 		prefix =3D "";

-	ac =3D parse_options(ac, av, prefix, options->parseopts, NULL,
+	ac =3D parse_options(ac, av, prefix, opts, NULL,
 			   PARSE_OPT_KEEP_DASHDASH |
 			   PARSE_OPT_KEEP_UNKNOWN_OPT |
 			   PARSE_OPT_NO_INTERNAL_HELP |
 			   PARSE_OPT_ONE_SHOT |
 			   PARSE_OPT_STOP_AT_NON_OPTION);
+	free(opts);

 	return ac;
 }
@@ -6513,7 +6510,6 @@ void diff_free(struct diff_options *options)
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
-	FREE_AND_NULL(options->parseopts);
 }

 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index fd33caeb25..f2ab97b8b4 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -394,7 +394,6 @@ struct diff_options {
 	unsigned color_moved_ws_handling;

 	struct repository *repo;
-	struct option *parseopts;
 	struct strmap *additional_path_headers;

 	int no_free;
@@ -539,6 +538,8 @@ int git_diff_ui_config(const char *var, const char *va=
lue, void *cb);
 #define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
 #endif
 void repo_diff_setup(struct repository *, struct diff_options *);
+struct option *diff_parse_options_concat(const struct option *extra,
+					 struct diff_options *options);
 int diff_opt_parse(struct diff_options *, const char **, int, const char =
*);
 void diff_setup_done(struct diff_options *);
 int git_config_rename(const char *var, const char *value);


