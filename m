Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68963C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 18:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhLISxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLISxb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 13:53:31 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBCDC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 10:49:57 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id iq9-20020a17090afb4900b001a54412feb0so4354215pjb.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 10:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=4WeO1eN3TDE4fh/vFsHFKN7IPo1L5SC1b2RJyZ41TNo=;
        b=BvnjAioe8NU9/923hisMjPLsFTVJdCthfiwoC1uBbbCsG8ka7CmNyfzYeoBmqNoG1/
         AkcrXhhZ0BO2KBEgDHs3MVLH8J5OOGvEZub8sv9TVbWu4mfIi2oajHQ0q73t5BbLgDBQ
         Ty+NwA2j/ziYQPYzpvAjEk3UOmShSP9cryN0UV0IOCZTjnVHOXSw1BUOHRDOX8htU91s
         CqYx0RKOh7TwH3lzs9ermXKWs4qJZpf+yQhhRBTx9m0LPBbNKQiO3rPH6W+l2uFv1+Sz
         fl+crR+gD4JTtBWV4c+J5gWcF8Y5dwgCrEv2k9HfrLhYHgqCRBY8wW9ZqGZ/jzCPh5RW
         p2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=4WeO1eN3TDE4fh/vFsHFKN7IPo1L5SC1b2RJyZ41TNo=;
        b=Tdqy80AqNJ6Hfx7x5uSoQWgxelf+2/znTTpAspqjeQFHk9gKTla1j+ySoNSzRJFkeh
         5QyIrwaTJrx9fL3/w9XiR5K7Mdx7ryKn0aCuv+W8dZ6h286ojHk+gMyylm04BIw3qlwJ
         HbwlbeD1R52+t80bFR6Tl/3HXzp1dwCbuhV2+iAJNxwUgXKTH8ozsRQl327+y58R6KsF
         J5SuacI99gkeYABu6b2W7DlRGfDjByHNwNtN70dLtAV1zyxaV1I4YWrwZg/q9UK2hktx
         rD7tBFg3kanWI4e70q0ITdvae68T+Rx6EmCEviSOQXjgLl7ft8a16Q3p0kBINnNR7tx/
         RLDQ==
X-Gm-Message-State: AOAM530c+rX/SpeEo1OMFp8UHQBgBpQKXtqMwZDS827wjk8c8qOebcEo
        1e5M+N7ftZdkfpiB6jsktIlHu1MaheqIbZUlJ2mPhQVVoXlH82VzHrvRhIV/XSe7drxpqeN7O4R
        GvejvCbnzGZ7LlksJIXuL+WT1rZYluD7FQhcT7VpQN57X8nrUI/41X7mAcxGP3TQ=
X-Google-Smtp-Source: ABdhPJyL/S6Jg6pO3O7ZDNXgHmqlAN7M70nQwumB0v1DuuIzS7iGgnIByDCmF2365xJpOVujYMCdTQhTolJoQQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1905:b0:4a8:2f86:3f18 with SMTP
 id y5-20020a056a00190500b004a82f863f18mr13581474pfi.52.1639075796744; Thu, 09
 Dec 2021 10:49:56 -0800 (PST)
Date:   Thu,  9 Dec 2021 10:49:23 -0800
In-Reply-To: <20211206215528.97050-1-chooglen@google.com>
Message-Id: <20211209184928.71413-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211206215528.97050-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 0/5] implement branch --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodule branching RFC:
https://lore.kernel.org/git/kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.=
google.com/

Original Submodule UX RFC/Discussion:
https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

Contributor Summit submodules Notes:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211148060.56@tvgsbejvaqbj=
f.bet/

Submodule UX overhaul updates:
https://lore.kernel.org/git/?q=3DSubmodule+UX+overhaul+update

This series implements branch --recurse-submodules as laid out in the
Submodule branching RFC (linked above). If there are concerns about the
UX/behavior, I would appreciate feedback on the RFC thread as well :)

This series is based off js/branch-track-inherit.

This version is functionally identical to v2. I've only addressed
feedback around code organization, i.e. the the merge conflict with
js/branch-track-inherit and making patch 1 easier to review. Thus, some
discussions on [1] are still unaddressed.

Patch 5 is an optional cleanup of the questionable exit codes that Junio
found [1]. I wasn't able to figure out the intent of the original
authors, so it is mostly a best-guess at the right exit code. It doesn't
cause any tests to fail, but this wasn't covered by tests to begin with.

Changes since v2
* Rebase onto js/branch-track-inherit. This series should continue to be
  the case going forward.
* Patch 1 has a smaller diff because the introduction of
  validate_branch_start() no longer changes the function order thanks to a
  forward declaration. This artificial forward declaration is removed in a
  patch 2 (which can just be squashed into patch 1).
* Optional cleanup: fix questionable exit codes in patch 5.

Changes since v1:
* Move the functionality of "git branch --dry-run" into "git submodule-help=
er create-branch --dry-run"
* Add more fields to the submodules_of_tree() struct to reduce the
  number of allocations made by the caller [2]. Move this functionality
  to patch 3 (formerly patch 4) and drop patch 1.
* Make submodules_of_tree() ignore inactive submodules [3]
* Structure the output of the submodules a bit better by adding prefixes
  to the child process' output (instead of inconsistently indenting the
  output).
** I wasn't able to find a good way to interleave stdout/stderr
   correctly, so a less-than-desirable workaround was to route the child
   process output to stdout/stderr depending on the exit code.
** Eventually, I would like to structure the output of submodules in a
   report, as =C3=86var suggested [4]. But at this stage, I think that it's
   better to spend time getting user feedback on the submodules
   branching UX and it'll be easier to standardize the output when we've
   implemented more of the UX :)

[1] https://lore.kernel.org/git/xmqqbl1tcptq.fsf@gitster.g
[2] https://lore.kernel.org/git/211123.86r1b7uoil.gmgdl@evledraar.gmail.com
[3] https://lore.kernel.org/git/3ad3941c-de18-41bf-2e44-4238ae868d79@gmail.=
com
[4] https://lore.kernel.org/git/211123.86v90juovj.gmgdl@evledraar.gmail.com

Glen Choo (5):
  branch: move --set-upstream-to behavior to setup_tracking()
  branch: remove forward declaration of validate_branch_start()
  builtin/branch: clean up action-picking logic in cmd_branch()
  branch: add --recurse-submodules option for branch creation
  branch.c: replace questionable exit() codes

 Documentation/config/advice.txt    |   3 +
 Documentation/config/submodule.txt |   8 +
 advice.c                           |   1 +
 advice.h                           |   1 +
 branch.c                           | 336 +++++++++++++++++++++--------
 branch.h                           |  44 +++-
 builtin/branch.c                   |  66 ++++--
 builtin/checkout.c                 |   3 +-
 builtin/submodule--helper.c        |  38 ++++
 submodule-config.c                 |  35 +++
 submodule-config.h                 |  35 +++
 submodule.c                        |  11 +-
 submodule.h                        |   3 +
 t/t3200-branch.sh                  |  17 ++
 t/t3207-branch-submodule.sh        | 284 ++++++++++++++++++++++++
 15 files changed, 765 insertions(+), 120 deletions(-)
 create mode 100755 t/t3207-branch-submodule.sh

Range-diff against v2:
1:  cc212dcd39 ! 1:  8241c0b51a branch: move --set-upstream-to behavior to =
setup_tracking()
    @@ Commit message
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
      ## branch.c ##
    -@@ branch.c: int install_branch_config(int flag, const char *local, co=
nst char *origin, const
    - 	return -1;
    +@@ branch.c: static int inherit_tracking(struct tracking *tracking, co=
nst char *orig_ref)
    + 	return 0;
      }
     =20
     -/*
    @@ branch.c: int install_branch_config(int flag, const char *local, con=
st char *ori
     - */
     -static void setup_tracking(const char *new_ref, const char *orig_ref,
     -			   enum branch_track track, int quiet)
    --{
    --	struct tracking tracking;
    --	int config_flags =3D quiet ? 0 : BRANCH_CONFIG_VERBOSE;
    --
    --	memset(&tracking, 0, sizeof(tracking));
    ++static void validate_branch_start(struct repository *r, const char *s=
tart_name,
    ++				  enum branch_track track,
    ++				  struct object_id *oid, char **real_ref);
    ++
    ++void setup_tracking(const char *new_ref, const char *orig_ref,
    ++			   enum branch_track track, int quiet, int expand_orig)
    + {
    + 	struct tracking tracking;
    + 	struct string_list tracking_srcs =3D STRING_LIST_INIT_DUP;
    + 	int config_flags =3D quiet ? 0 : BRANCH_CONFIG_VERBOSE;
    ++	char *full_orig_ref;
    ++	struct object_id unused_oid;
    +=20
    + 	memset(&tracking, 0, sizeof(tracking));
     -	tracking.spec.dst =3D (char *)orig_ref;
    --	if (for_each_remote(find_tracked_branch, &tracking))
    --		return;
    --
    --	if (!tracking.matches)
    --		switch (track) {
    --		case BRANCH_TRACK_ALWAYS:
    --		case BRANCH_TRACK_EXPLICIT:
    --		case BRANCH_TRACK_OVERRIDE:
    --			break;
    --		default:
    ++	if (expand_orig)
    ++		validate_branch_start(the_repository, orig_ref, track, &unused_oid,=
 &full_orig_ref);
    ++	else
    ++		full_orig_ref =3D xstrdup(orig_ref);
    ++
    ++	tracking.spec.dst =3D full_orig_ref;
    + 	tracking.srcs =3D &tracking_srcs;
    + 	if (track !=3D BRANCH_TRACK_INHERIT)
    + 		for_each_remote(find_tracked_branch, &tracking);
    +@@ branch.c: static void setup_tracking(const char *new_ref, const cha=
r *orig_ref,
    + 		case BRANCH_TRACK_OVERRIDE:
    + 			break;
    + 		default:
     -			return;
    --		}
    --
    --	if (tracking.matches > 1)
    --		die(_("Not tracking: ambiguous information for ref %s"),
    ++			goto cleanup;
    + 		}
    +=20
    + 	if (tracking.matches > 1)
    + 		die(_("Not tracking: ambiguous information for ref %s"),
     -		    orig_ref);
    --
    --	if (install_branch_config(config_flags, new_ref, tracking.remote,
    --			      tracking.src ? tracking.src : orig_ref) < 0)
    --		exit(-1);
    --
    --	free(tracking.src);
    --}
    --
    ++		    full_orig_ref);
    +=20
    + 	if (tracking.srcs->nr < 1)
    +-		string_list_append(tracking.srcs, orig_ref);
    ++		string_list_append(tracking.srcs, full_orig_ref);
    + 	if (install_branch_config_multiple_remotes(config_flags, new_ref, tr=
acking.remote,
    + 			      tracking.srcs) < 0)
    + 		exit(-1);
    +=20
    ++cleanup:
    + 	string_list_clear(tracking.srcs, 0);
    ++	free(full_orig_ref);
    + }
    +=20
      int read_branch_desc(struct strbuf *buf, const char *branch_name)
    - {
    - 	char *v =3D NULL;
     @@ branch.c: N_("\n"
      "will track its remote counterpart, you may want to use\n"
      "\"git push -u\" to set the upstream config as you push.");
    @@ branch.c: void create_branch(struct repository *r,
     +	oidcpy(oid, &commit->object.oid);
     +}
     +
    -+void setup_tracking(const char *new_ref, const char *orig_ref,
    -+			   enum branch_track track, int quiet, int expand_orig)
    -+{
    -+	struct tracking tracking;
    -+	int config_flags =3D quiet ? 0 : BRANCH_CONFIG_VERBOSE;
    -+	char *full_orig_ref;
    -+	struct object_id unused_oid;
    -+
    -+	memset(&tracking, 0, sizeof(tracking));
    -+	if (expand_orig)
    -+		validate_branch_start(the_repository, orig_ref, track, &unused_oid,=
 &full_orig_ref);
    -+	else
    -+		full_orig_ref =3D xstrdup(orig_ref);
    -+
    -+	tracking.spec.dst =3D full_orig_ref;
    -+	if (for_each_remote(find_tracked_branch, &tracking))
    -+		goto cleanup;
    -+
    -+	if (!tracking.matches)
    -+		switch (track) {
    -+		case BRANCH_TRACK_ALWAYS:
    -+		case BRANCH_TRACK_EXPLICIT:
    -+		case BRANCH_TRACK_OVERRIDE:
    -+			break;
    -+		default:
    -+			goto cleanup;
    -+		}
    -+
    -+	if (tracking.matches > 1)
    -+		die(_("Not tracking: ambiguous information for ref %s"),
    -+		    full_orig_ref);
    -+
    -+	if (install_branch_config(config_flags, new_ref, tracking.remote,
    -+			      tracking.src ? tracking.src : full_orig_ref) < 0)
    -+		exit(-1);
    -+
    -+cleanup:
    -+	free(tracking.src);
    -+	free(full_orig_ref);
    -+}
    -+
     +void create_branch(struct repository *r, const char *name,
     +		   const char *start_name, int force, int clobber_head_ok,
     +		   int reflog, int quiet, enum branch_track track)
-:  ---------- > 2:  b74bcbaade branch: remove forward declaration of valid=
ate_branch_start()
2:  320749cc82 =3D 3:  235173efc9 builtin/branch: clean up action-picking l=
ogic in cmd_branch()
3:  c0441c6691 =3D 4:  3dabb8e2fa branch: add --recurse-submodules option f=
or branch creation
-:  ---------- > 5:  70fb03f882 branch.c: replace questionable exit() codes
--=20
2.33.GIT

