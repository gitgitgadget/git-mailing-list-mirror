Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42DFC4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 10:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKTKOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 05:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKTKOD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 05:14:03 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D2D1D336
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 02:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668939229; bh=HrXBCWqECipdEYR7iTKtuLzwh1wWaQmnyAR0UoLzaoY=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=Nb+PvNtzkef3zN05wUBz1PMxI/tERL/XJb4EumgXivFHYwAbLuqmYJAm2vUMIXNgP
         2y/IP6Mg3PGLJTkCbcovRMbneOc/74e+pgmUhJxhizt3+nCgrFH/PZRVsgyaIdTuu3
         ZgirJOfMWp1irGG40UZtgws5Dky/ZprTSIMlfSk/VTyavHVInVf9kgLMb8179UfgJt
         1qfLl0A8Nuqm1BP+sgn9TLgrmA4Iu9hA4UMYtAlHDkUdNGnENWetG+D7XRAjSUE4FQ
         fiW3bIlK4X5Yq5s4xi0m28U+Q7ejrFskA8PzMgaHFxBRkeiuxVmJ3OVR2MaU05ni0l
         ToMuUQ0UpdDcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLifk-1of1vI3ttg-00HdYk; Sun, 20
 Nov 2022 11:13:48 +0100
Message-ID: <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de>
Date:   Sun, 20 Nov 2022 11:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct rev_info",
 don't leak"
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
In-Reply-To: <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y1QjA4fZgxEmvqOcrAyrAd/3fqkrT1CyQZEnrOT1X+N6EmrIofR
 xouyE1mA4IJ02idzoVPGN4NNbSvzMLOw+iXWm38jVaxF5yPi5ANRHq34TDdKQVkqOQ0IC2G
 1AuArAFoMeL+6dlXy5CBGRNEN0mrdqjZDvVyJPJ7YlzUtGp8UH+u4dNBtATEel/W419BA3y
 2i+HBnmWdetxNp+9qqtTA==
UI-OutboundReport: notjunk:1;M01:P0:jZiFHxPm4lo=;gq+tdJJZzDlbvPadWsJESQ98yfX
 aEDgykZcm0/2n95KPln6AfSEBRk1bsEgp7R8XLAw2AfpkZxRyKJJxy1OTMV0US8BJQm6JevZz
 b+m86fWt2LaBsgtElmTGDfEmGyRy3xqZ6l9apsIKf1L0jof5MpKeb4fu7FHv+8R7ET1HwN3nv
 6wA3ZCMN7rGkheKhoIQ/0onySgtWjRCOvRCOkyB+9KTz2fDo3SZwLr9XLu3Z42CpqX8KwhrC9
 X/oQwxsQ8bLsVuJegu2oI7m58JWqSsW1PFp4/OHOVQb6ZI57hnHSbHmHnmNdMRqAYIjgGLDwv
 LWwewH/9DiV4bxcu/KH0JH89HgN8iRtw432ai5xqLLsiSvIOmgE82Av+ULy23n5RQcYe3cPw4
 ZzLLg6dhizStDaVhZrQVWKG5PvNL0EGuNguMrfKppd9NdtRQqWg0ooJcsj3Sspybwwlt7ijLU
 IwDEKaWuAQn42BcsnpJyO0vT0gsKegwkMW6NaMG2As6ZiUu6AG+s9tfgin1FxhQT5/SRspGte
 HsCi0ZX6/T38gwxD33krXmSpdp+pnST7MnfTA2OuuCVKIJ+6l9ygblF3MjfsaAXA7q58UQ0B7
 3XQweGqiFdak4xAA8YzSKSARZEIn1PlyaYMpNU+h+2Gk5oG9oD0zihYyCF1hwmgMX8QllPIb+
 MpZuQ8kbFG/IWPG2c1QVeEPrAyDkOvkIeNn0c1dxCuVGysHAXQTHU/6ITsHKRUZJlGgfn2tWM
 923J+E/ci+4f6kUsJEJGPY8H/s0Z3zXdtnnr4RU6i0bS9wfkGBvqQ7UOhK/56+zyFZBYTJv3L
 2icM6CQ5uwYda4QZk9ZaBJWwVdOL+USxoVuz9WYkJiLwwjD28eo6YYB0TOuFLAabQibfd859G
 9Nvvb9aPlwYdVKix5blV0Y6XB9wiET12kPO9ZMmLH88ySqx93ok9zP31nw/Q0Os40GT25+u2H
 AZUqVw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.

5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't leak,
2022-03-28) avoided leaking rev_info allocations in many cases by
calling repo_init_revisions() only when the .filter member was actually
needed, but then still leaking it.  That was fixed later by 2108fe4a19
(revisions API users: add straightforward release_revisions(),
2022-04-13), making the reverted commit unnecessary.

5cb28270a1 broke support for multiple --filter options by calling
repo_init_revisions() for each one, clobbering earlier state and
leaking rev_info allocations.  Reverting it fixes that regression.
Luckily it only affects users that run pack-objects directly.  Internal
callers in bundle.c and upload-pack.c combine multiple filters into a
single option using "+".

5cb28270a1 introduced OPT_PARSE_LIST_OBJECTS_FILTER_INIT.  It relies on
being able to faithfully convert function pointers to object pointers
and back, which is undefined in C99.  The standard mentions this ability
as a common extension in its annex J (J.5.7 Function pointer casts), but
avoiding that dependency is more portable.  The macro hasn't been used
since, OPT_PARSE_LIST_OBJECTS_FILTER is enough so far.

So revert 5cb28270a1 fully to fix support for multiple --filter options
and avoid reliance on undefined behavior.  Its intent is better served
by the release_revisions() call added by 2108fe4a19 alone -- we just
need to do it unconditionally, mirroring the unconditional call of
repo_init_revisions().

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/pack-objects.c                 | 31 +++++---------------------
 list-objects-filter-options.c          |  4 ----
 list-objects-filter-options.h          | 24 +++-----------------
 t/t5317-pack-objects-filter-objects.sh |  2 +-
 4 files changed, 10 insertions(+), 51 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 573d0b20b7..3e74fbb0cd 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4149,21 +4149,6 @@ static int option_parse_cruft_expiration(const stru=
ct option *opt,
 	return 0;
 }

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
-	repo_init_revisions(the_repository, &data->revs, NULL);
-	data->have_revs =3D 1;
-
-	return &data->revs.filter;
-}
-
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list =3D 0;
@@ -4174,7 +4159,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 	int rev_list_index =3D 0;
 	int stdin_packs =3D 0;
 	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
-	struct po_filter_data pfd =3D { .have_revs =3D 0 };
+	struct rev_info revs;

 	struct option pack_objects_options[] =3D {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -4265,7 +4250,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 			      &write_bitmap_index,
 			      N_("write a bitmap index if possible"),
 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
-		OPT_PARSE_LIST_OBJECTS_FILTER_INIT(&pfd, po_filter_revs_init),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
 		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
 		  option_parse_missing_action),
@@ -4284,6 +4269,8 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)

 	read_replace_refs =3D 0;

+	repo_init_revisions(the_repository, &revs, NULL);
+
 	sparse =3D git_env_bool("GIT_TEST_PACK_SPARSE", -1);
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
@@ -4385,7 +4372,7 @@ int cmd_pack_objects(int argc, const char **argv, co=
nst char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration =3D 0;

-	if (pfd.have_revs && pfd.revs.filter.choice) {
+	if (revs.filter.choice) {
 		if (!pack_to_stdout)
 			die(_("cannot use --filter without --stdout"));
 		if (stdin_packs)
@@ -4472,16 +4459,10 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
 		read_object_list_from_stdin();
-	} else if (pfd.have_revs) {
-		get_object_list(&pfd.revs, rp.nr, rp.v);
-		release_revisions(&pfd.revs);
 	} else {
-		struct rev_info revs;
-
-		repo_init_revisions(the_repository, &revs, NULL);
 		get_object_list(&revs, rp.nr, rp.v);
-		release_revisions(&revs);
 	}
+	release_revisions(&revs);
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
 		for_each_tag_ref(add_ref_tag, NULL);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 5339660238..ee01bcd2cc 100644
=2D-- a/list-objects-filter-options.c
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

 	if (unset || !arg)
 		list_objects_filter_set_no_filter(filter_options);
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 7eeadab2dd..64af2e29e2 100644
=2D-- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -107,31 +107,13 @@ void parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg);

-/**
- * The opt->value to opt_parse_list_objects_filter() is either a
- * "struct list_objects_filter_option *" when using
- * OPT_PARSE_LIST_OBJECTS_FILTER().
- *
- * Or, if using no "struct option" field is used by the callback,
- * except the "defval" which is expected to be an "opt_lof_init"
- * function, which is called with the "opt->value" and must return a
- * pointer to the ""struct list_objects_filter_option *" to be used.
- *
- * The OPT_PARSE_LIST_OBJECTS_FILTER_INIT() can be used e.g. the
- * "struct list_objects_filter_option" is embedded in a "struct
- * rev_info", which the "defval" could be tasked with lazily
- * initializing. See cmd_pack_objects() for an example.
- */
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
-typedef struct list_objects_filter_options *(*opt_lof_init)(void *);
-#define OPT_PARSE_LIST_OBJECTS_FILTER_INIT(fo, init) \
-	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
-	  N_("object filtering"), 0, opt_parse_list_objects_filter, \
-	  (intptr_t)(init) }

 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
-	OPT_PARSE_LIST_OBJECTS_FILTER_INIT((fo), NULL)
+	OPT_CALLBACK(0, "filter", fo, N_("args"), \
+	  N_("object filtering"), \
+	  opt_parse_list_objects_filter)

 /*
  * Translates abbreviated numbers in the filter's filter_spec into their
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects=
-filter-objects.sh
index 25faebaada..5b707d911b 100755
=2D-- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -265,7 +265,7 @@ test_expect_success 'verify normal and blob:limit pack=
files have same commits/tr
 	test_cmp expected observed
 '

-test_expect_failure 'verify small limit and big limit results in small li=
mit' '
+test_expect_success 'verify small limit and big limit results in small li=
mit' '
 	git -C r2 ls-files -s large.1000 >ls_files_result &&
 	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&
=2D-
2.38.1
