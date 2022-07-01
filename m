Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE25C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiGACML (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiGACMK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:12:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1095959277
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31c3e42485cso8902717b3.17
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=nKgjfqrmjy2KxydMLxgiwhDnT/WeQlhv670UqJ6yURU=;
        b=aALE/Zbu+4CMIpn+Utc5E2wFVyVxKTgU1ftSMcNLxL2DqjcyVVuMFX0pxhNGL0ao6E
         V4fd70VkiBUxFpUCW6EfHz+qdKy9KAMLrNB7xIhfBriUMY53JoTMK8YhMa/KqY0GRndH
         Lr67pqsNvBSzxz58p6tI3sp97xCTBXeOOvjj3cPsYGdY6gKFWIXukOb+jSLlMDvuPlwq
         0+xUE5GuYCtkdjmMaOadAxYfFvUF/k5NWy/DOQ8nT4Oe8wp1t2ofe8pYilunp02qHtjP
         zspd4sr5GVtaCnWntxO+3B0U3iG9bneh+qnaygfPVqYedbVlXOt2URQEAK0W5pvt5dzh
         j7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=nKgjfqrmjy2KxydMLxgiwhDnT/WeQlhv670UqJ6yURU=;
        b=1fusVY/YSNxjDUEqKx4USQy1M2QGGcVayAsQxaXDAP2LY2HSXzjxlE9mJu/8/eRu1U
         BGB6SaNGRKwNvwaOAe2CsHrv/hvtegPED+JuRyd9qE2BTu2gX6LnH6aSD+jZ26FVOoyT
         56deGd6D2OzgNIP5bzC+iI2UjkWX1nPfJnMILsmxAwX3cyrdNkIukFZtMrgDGodDEjJ4
         gNaCXq+0tYwFMDW8DJqUjkpCxVzlQRkUaEVrT9HzLHev4CBCnj1heAnfL8+5ip5lMtb7
         EcfLF9vXgkU+xEf1FjYUMMPXnCsXHwW009WE2GdCKwg3YhDenxR5s/JYckJaTF28rUI7
         mvuw==
X-Gm-Message-State: AJIora8Kty5ACLFwoWtgPH5RitMxPOsjGt2OWP0aFnEtMgEvpMqltxZG
        B5mmWj9Bp8EtqmzbDb/bZ9xQuftIDvwsJXsltGyZk0KvAlvHuIxVu7LtUsmH74S3nzKYwTJKUtt
        HXpQJhatf9BsTLOxJm3AxQHeTSlVD9/DCGDXn2BH3F8Kzd0GJD4b/c4PVLWjhaew=
X-Google-Smtp-Source: AGRyM1sjy2Bcn+UMRSPQdGdSGSyqGc7whk88wksv5QlyT+LQRwtdYGitlTtYTNcLU3cnA3759zLa5C7Nrvu5nQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:74d7:0:b0:317:7463:d852 with SMTP id
 p206-20020a8174d7000000b003177463d852mr14015756ywc.385.1656641528329; Thu, 30
 Jun 2022 19:12:08 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:11:50 -0700
In-Reply-To: <20220630221147.45689-1-chooglen@google.com>
Message-Id: <20220701021157.88858-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220630221147.45689-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 0/7] submodule: remove "--recursive-prefix"
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks again! As mentioned, I've taken the amendments =C3=86var posted in
[1] and fixed the bug mentioned there. The only things I've changed
were some punctuation and changing the base commit to upstream's
ab/submodule-cleanup (which is based off a slightly older 'master').

Note for Junio: this version is based on ab/submodule-cleanup.

=3D Description

This series is a refactor of "git submodule--helper update" that replaces
"--recursive-prefix" with "--super-prefix" (see Background). This was
initially motivated by:

 * Junio's suggestion to simplify the code [2] (in response to a memory lea=
k
   found by Johannes Schindelin [3]).
 * A desire to use the module_list API + get_submodule_displaypath() outsid=
e
   of builtin/submodule--helper.c (I expect to use this to check out
   branches in each submodule).

But it also happens to remove some overly complicated/duplicated code that
was literally converted from shell :)

=3D Background

When recursing into nested submodules, Git commands keep track of the path
from the superproject to the submodule in order to print a "display path" t=
o
the user, e.g.

  Submodule path '../super/sub/nested-sub': checked out 'abcdef'

For historical reasons, "git submodule--helper update" uses
"--recursive-prefix" for this purpose, but it should use "--super-prefix"
instead because:

 * That's what every other command uses (not just submodule--helper
   subcommands).
 * Using the "--super-prefix" helper functions makes the "git
   submodule--helper update" code simpler

=3D Patch organization

1/7 and 5/7 were contributed by =C3=86var (thanks!)

* Patches 1-2/7 makes sure that display paths are only computed using
  display path helper functions ([do_]get_submodule_displaypath()) and
  fixes some display paths that we never realized were broken.
* Patches 3-4/7 simplify and deduplicate some display path computations.
* Patch 5/7 removes SUPPORT_SUPER_PREFIX where it's not needed.
  * This doesn't affect correctness, but we want to do this eventually, so
    do it now to make 6/7 a bit cleaner.
* Patch 6/7 replaces "--recursive-prefix" with "--super-prefix", making
  do_get_submodule_displaypath() obsolete.
* Patch 7/7 removes do_get_submodule_displaypath().

=3D Series history

Changes in v4:
* Split patch 1 so that the missing test coverage is introduced in its
  own patch
* Fix a stale commit message in 1/6 (now patch 2/7)
* Use test_cmp instead of "grep -F"
* Style fixes and improvements

Changes in v3:
* None (resend of v2 because v2 accidentally included
  ab/submodule-cleanup)

Changes in v2:
 * Rebase onto ab/submodule-cleanup (previously master)
 * Cherry pick https://github.com/avar/git/commit/f445c57490d into 4/6
 * Style fixes in .c and tests

=3D Future work

At the end of this series, get_submodule_displaypath() can be moved to
submodule.h, which would make submodule.c:get_super_prefix_or_empty()
obsolete. I have a patch that demonstrates this (CI run: [4]), but I decide=
d
to keep this series more focused on "git submodule--helper update" so that
it's easier to review.

[1] https://lore.kernel.org/git/220701.865ykhdboc.gmgdl@evledraar.gmail.com
[2] https://lore.kernel.org/git/xmqq35g5xmmv.fsf@gitster.g
[3] https://lore.kernel.org/git/877a45867ae368bf9e053caedcb6cf421e02344d.16=
55336146.git.gitgitgadget@gmail.com
[4] https://github.com/chooglen/git/actions/runs/2572557584

Glen Choo (6):
  submodule--helper tests: add missing "display path" coverage
  submodule--helper update: use display path helper
  submodule--helper: don't recreate recursive prefix
  submodule--helper: use correct display path helper
  submodule--helper update: use --super-prefix
  submodule--helper: remove display path helper

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
  submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags

 builtin/submodule--helper.c | 86 ++++++++++---------------------------
 t/t7406-submodule-update.sh | 62 ++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 64 deletions(-)

Range-diff against v3:
1:  8c82518d33 ! 1:  1f2ef5f6a2 submodule--helper update: use display path =
helper
    @@ Metadata
     Author: Glen Choo <chooglen@google.com>
    =20
      ## Commit message ##
    -    submodule--helper update: use display path helper
    +    submodule--helper tests: add missing "display path" coverage
    =20
         There are two locations in prepare_to_clone_next_submodule() that
    -    manually calculate the submodule display path, but should just use
    -    do_get_submodule_displaypath() for consistency.
    -
    -    Do this replacement and reorder the code slightly to avoid computi=
ng
    -    the display path twice.
    -
    -    This code was never tested, and adding tests shows that both these=
 sites
    -    have been computing the display path incorrectly ever since they w=
ere
    -    introduced in 48308681b0 (git submodule update: have a dedicated h=
elper
    -    for cloning, 2016-02-29) [1]:
    -
    -    - The first hunk puts a "/" between recursive_prefix and ce->name,=
 but
    -      recursive_prefix already ends with "/".
    -    - The second hunk calls relative_path() on recursive_prefix and
    -      ce->name, but relative_path() only makes sense when both paths s=
hare
    -      the same base directory. This is never the case here:
    -      - recursive_prefix is the path from the topmost superproject to =
the
    -        current submodule
    -      - ce->name is the path from the root of the current submodule to=
 its
    -        submodule.
    -      so, e.g. recursive_prefix=3D"super" and ce->name=3D"submodule" p=
roduces
    -      displayname=3D"../super" instead of "super/submodule".
    -
    -    [1] I verified this by applying the tests to 48308681b0.
    +    manually calculate the submodule display path. As discussed in the
    +    next commit the "Skipping" output isn't exactly what we want, but
    +    let's test how we behave now, before changing the existing behavio=
r.
    =20
         Signed-off-by: Glen Choo <chooglen@google.com>
    -
    - ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int prepare_to_clone_next_submo=
dule(const struct cache_entry *ce,
    - 	const char *update_string;
    - 	enum submodule_update_type update_type;
    - 	char *key;
    --	struct strbuf displaypath_sb =3D STRBUF_INIT;
    - 	struct strbuf sb =3D STRBUF_INIT;
    --	const char *displaypath =3D NULL;
    -+	char *displaypath;
    - 	int needs_cloning =3D 0;
    - 	int need_free_url =3D 0;
    -=20
    -+	displaypath =3D do_get_submodule_displaypath(ce->name,
    -+						   suc->update_data->prefix,
    -+						   suc->update_data->recursive_prefix);
    -+
    - 	if (ce_stage(ce)) {
    --		if (suc->update_data->recursive_prefix)
    --			strbuf_addf(&sb, "%s/%s", suc->update_data->recursive_prefix, ce->=
name);
    --		else
    --			strbuf_addstr(&sb, ce->name);
    --		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
    -+		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
    - 		strbuf_addch(out, '\n');
    - 		goto cleanup;
    - 	}
    -=20
    - 	sub =3D submodule_from_path(the_repository, null_oid(), ce->name);
    -=20
    --	if (suc->update_data->recursive_prefix)
    --		displaypath =3D relative_path(suc->update_data->recursive_prefix,
    --					    ce->name, &displaypath_sb);
    --	else
    --		displaypath =3D ce->name;
    --
    - 	if (!sub) {
    - 		next_submodule_warn_missing(suc, out, displaypath);
    - 		goto cleanup;
    -@@ builtin/submodule--helper.c: static int prepare_to_clone_next_submo=
dule(const struct cache_entry *ce,
    - 					      "--no-single-branch");
    -=20
    - cleanup:
    --	strbuf_release(&displaypath_sb);
    -+	free(displaypath);
    - 	strbuf_release(&sb);
    - 	if (need_free_url)
    - 		free((void*)url);
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
    =20
      ## t/t7406-submodule-update.sh ##
     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update =
--filter sets partial clone settings' '
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update -=
-filter sets
     +	# because of its unmerged state
     +	test_config -C top-cloned submodule.middle.update !true &&
     +	git -C top-cloned submodule update --recursive 2>actual.err &&
    -+	grep -F "Skipping unmerged submodule middle/bottom" actual.err
    ++	cat >expect.err <<-\EOF &&
    ++	Skipping unmerged submodule middle//bottom
    ++	EOF
    ++	test_cmp expect.err actual.err
     +'
     +
     +test_expect_success 'submodule update --recursive skip submodules wit=
h strategy=3Dnone' '
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update -=
-filter sets
     +	test_commit -C top-cloned/middle/bottom downstream_commit &&
     +	git -C top-cloned/middle config submodule.bottom.update none &&
     +	git -C top-cloned submodule update --recursive 2>actual.err &&
    -+	grep -F "Skipping submodule ${SQ}middle/bottom${SQ}" actual.err
    ++	cat >expect.err <<-\EOF &&
    ++	Skipping submodule '\''../middle/'\''
    ++	EOF
    ++	test_cmp expect.err actual.err
     +'
     +
      test_done
-:  ---------- > 2:  146b88eaa3 submodule--helper update: use display path =
helper
2:  102ada974d ! 3:  a744640cd3 submodule--helper: don't recreate recursive=
 prefix
    @@ builtin/submodule--helper.c: static void update_data_to_args(struct =
update_data
     -	if (update_data->recursive_prefix)
     -		strvec_pushl(args, "--recursive-prefix",
     -			     update_data->recursive_prefix, NULL);
    -+	if (update_data->displaypath)
    -+		strvec_pushf(args, "--recursive-prefix=3D%s/",
    -+			     update_data->displaypath);
    ++	if (update_data->displaypath) {
    ++		strvec_push(args, "--recursive-prefix");
    ++		strvec_pushf(args, "%s/", update_data->displaypath);
    ++	}
      	if (update_data->quiet)
      		strvec_push(args, "--quiet");
      	if (update_data->force)
3:  b6dda65084 =3D 4:  0b45f2ff2b submodule--helper: use correct display pa=
th helper
4:  aa5d389bb8 =3D 5:  963c8ba07b submodule--helper: remove unused SUPPORT_=
SUPER_PREFIX flags
5:  4dcfb9889f ! 6:  a777fcf905 submodule--helper update: use --super-prefi=
x
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
      	enum submodule_update_type update_default;
      	struct object_id suboid;
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submo=
dule(const struct cache_entry *ce,
    -=20
    - 	displaypath =3D do_get_submodule_displaypath(ce->name,
    - 						   suc->update_data->prefix,
    --						   suc->update_data->recursive_prefix);
    -+						   get_super_prefix());
    -=20
    - 	if (ce_stage(ce)) {
    - 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
    + 	char *key;
    + 	struct update_data *ud =3D suc->update_data;
    + 	char *displaypath =3D do_get_submodule_displaypath(ce->name, ud->pre=
fix,
    +-							 ud->recursive_prefix);
    ++							 get_super_prefix());
    + 	struct strbuf sb =3D STRBUF_INIT;
    + 	int needs_cloning =3D 0;
    + 	int need_free_url =3D 0;
     @@ builtin/submodule--helper.c: static void update_data_to_args(struct=
 update_data *update_data, struct strvec *
      {
      	enum submodule_update_type update_type =3D update_data->update_defau=
lt;
     =20
     -	strvec_pushl(args, "submodule--helper", "update", "--recursive", NUL=
L);
     -	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
    - 	if (update_data->displaypath)
    --		strvec_pushf(args, "--recursive-prefix=3D%s/",
    -+		strvec_pushf(args, "--super-prefix=3D%s/",
    - 			     update_data->displaypath);
    + 	if (update_data->displaypath) {
    +-		strvec_push(args, "--recursive-prefix");
    ++		strvec_push(args, "--super-prefix");
    + 		strvec_pushf(args, "%s/", update_data->displaypath);
    + 	}
     +	strvec_pushl(args, "submodule--helper", "update", "--recursive", NUL=
L);
     +	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
      	if (update_data->quiet)
6:  109c55236d ! 7:  d47ea17cc2 submodule--helper: remove display path help=
er
    @@ builtin/submodule--helper.c: static void init_submodule(const char *=
path, const
      	sub =3D submodule_from_path(the_repository, null_oid(), path);
     =20
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submo=
dule(const struct cache_entry *ce,
    + 	enum submodule_update_type update_type;
    + 	char *key;
    + 	struct update_data *ud =3D suc->update_data;
    +-	char *displaypath =3D do_get_submodule_displaypath(ce->name, ud->pre=
fix,
    +-							 get_super_prefix());
    ++	char *displaypath =3D get_submodule_displaypath(ce->name, ud->prefix=
);
    + 	struct strbuf sb =3D STRBUF_INIT;
      	int needs_cloning =3D 0;
      	int need_free_url =3D 0;
    -=20
    --	displaypath =3D do_get_submodule_displaypath(ce->name,
    --						   suc->update_data->prefix,
    --						   get_super_prefix());
    -+	displaypath =3D
    -+		get_submodule_displaypath(ce->name, suc->update_data->prefix);
    -=20
    - 	if (ce_stage(ce)) {
    - 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
     @@ builtin/submodule--helper.c: static int update_submodule(struct upd=
ate_data *update_data)
      {
      	ensure_core_worktree(update_data->sm_path);

base-commit: 5b893f7d81eb7feb43662ed8663e2af76a76b4c8
--=20
2.37.0.rc0.161.g10f37bed90-goog

