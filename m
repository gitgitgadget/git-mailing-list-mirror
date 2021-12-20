Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F07BC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 23:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhLTXfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLTXfM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 18:35:12 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087C7C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:35:12 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q65-20020a17090a4fc700b001b104a22194so403741pjh.7
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=KdiRIi6a3dDtZ5VR8kOP0u44BGpr6F0ULADbljeJGpg=;
        b=Gt2aTfVAGCjYQjm69G43tS7C2NThRpnj6kruZ8wADVf7Ghl95zmguc3Z+eCUpWxbLs
         OHFNJsRM68cu6HECJPi99MYaniT0HXd9Dg0n7BgcmqPOuA6/Ezu2mf3a6EQD0ETkTOVb
         je6NYzEQxc0FfLPAz/IzMpTXSmfwkEXyrQSJIugIr5YiXZfyVxFNvC0xo6HnT5YfJn/V
         YTE2hASKCCBjE4QPSqDCaCOmdtl7eMRMU2F4KD/PK9NExXwnJKdVzqZQoYa0mZsSCP73
         f5njEAGkQis6Bpm7xWyimPTz+j7DULRVCel6KEKPOQY6DlOLz2um2h8C5oazqZM9vWLe
         Kh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=KdiRIi6a3dDtZ5VR8kOP0u44BGpr6F0ULADbljeJGpg=;
        b=x/gxheRW0Y79m/rkn7I61fFOsyC7sg+VkM79dtPLaBIJcUkJZUK3BNMZgcvb5dwzeT
         tJry8rInIGEa/8f0byn4l3m6c8ab5TMRMlhhVEm/TYNm/nm729kZnIKGMEBk9u8Qs1/v
         jILE9Pi92sM3QBDR8mlVsi/SKj21yP2t+kl0WJ3hpft2/Dria1gJ+qXu/CHc1t2I1MtH
         m8LDhhkTCXefVsFMz1Wt1uL8Svb/cMgl3i0qeAg9UriE1Auq5jlPEAdeECg7dHQ1x0aC
         k7GqFXWwRLH1Dk9/TkApghdnInJsfi3XUomKSV/LylZejwgnQPb9tA0rIUi/32z35WNe
         4Ljw==
X-Gm-Message-State: AOAM532TBpujgxxZ9S2uTm60ML/fBGk4NHYsiFMjg37hPDOjxQD1q3wg
        81/nnP3SbtczGiDN0pnENdBPrGC+L8qybZZJWlItl33jaoV+3X+2NHAagHfwoQv8lHMM9VUPcXe
        bW7LcPwJno2UQCw9m8AqOTmqkw0lefJRVKFoXUWlFjqF7UTUYz4ymOZGxrjo4XXo=
X-Google-Smtp-Source: ABdhPJyCRwJLovXXx5J6a7gCTDGPJEY1PpHCKJGNB/XEqOQHNVwHr3exRcsaZ7z58ZItUngfMeAL0JckXOWGHA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1a8b:: with SMTP id
 ng11mr659893pjb.13.1640043311372; Mon, 20 Dec 2021 15:35:11 -0800 (PST)
Date:   Mon, 20 Dec 2021 15:34:54 -0800
In-Reply-To: <20211216233324.65126-1-chooglen@google.com>
Message-Id: <20211220233459.45739-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211216233324.65126-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v6 0/5] implement branch --recurse-submodules
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

v6 fixes v5's bad rebase; it was based off a merge commit in 'seen'
instead of js/branch-track-inherit. Since v5 is mostly a no-op, I will
also include a range-diff against v4, which is the last version that
anyone except Junio would care about.

This version is based off Josh's js/branch-track-inherit v7. Because that
is not yet in 'seen', I applied those patches onto abe6bb3905 (The first
batch to start the current cycle, 2021-11-29). The base commit can be
found at https://github.com/chooglen/git/tree/js/branch-track-inherit-v7.
I really hope I got right this time, but if not, hopefully the paper
trail is obvious.

Future work:
* `git branch -d --recurse-submodules` so that users can clean up
  extraneous branches.
* `git [checkout | switch] --recurse-submodules` +
  submodule.propagateBranches so that users can actually checkout the
  branches.
* After [1], it seems clear that --recurse-submodules parsing could
  really benefit from some standardization. It's not obvious which
  RECURSE_SUBMODULE_* enums are applicable to which commands, and there
  is no way to distinguish between an explicit --recurse-submodules from
  argv vs submodule.recurse from the config.

  I chose not to use them in this series because their usage is already
  inconsistent (grep.c doesn't use them either), and it would be _more_
  confusing to use the enum (handling RECURSE_SUBMODULES_DEFAULT =3D 1 is
  trickier than boolean 0 and 1).

  At this point, I think it would be too noisy to introduce the enum,
  but this would be a nice cleanup to do later.
* As documented in branch.c, we create branches using a child process
  only because install_branch_config() does not support submodules.
  It should be possible to remove the child process once we make the
  appropriate changes to config.c. I attempted this in [2] but chose to
  punt it because it was too time-consuming at the time.

Changes since v5:
* Rebase onto v7 of js/branch-track-inherit
  (https://lore.kernel.org/git/cover.1639717481.git.steadmon@google.com)

Changes since v4:
* Rebase correctly onto 'gitster/seen^{/^Merge branch .js/branch-track-inhe=
rit.}'
  (see base-commit) as suggested in [3] (thanks Junio!)
* These patches were also verified on top of 'next'.

Changes since v3:
* Split up the old patch 1. Patch 1 had a big diff because it used to
  move lines, remove dead code and introduce repo_* functions (thanks
  Jonathan!)
** repo_* functions have been dropped; they added noise and are not
   necessary for correctness.
* Use a new, harder-to-misuse function in --set-upstream-to,
  dwim_and_setup_tracking(). Now, setup_tracking() never does DWIM and
  dwim_and_setup_tracking() always does DWIM.
* Move create_branch() dry_run to its own patch.
* Fix an oversight where submodules in subtrees were ignored. This was
  because submodules_of_tree() and tree_entry() didn't recurse into
  subtrees. Test this accordingly (thanks Jonathan!).
* cmd_branch() possible actions are more consistently ordered.
* Documentation fixes (thanks Philippe!).
* Additional comments and explanation.
* Drop patch 5 (optional cleanup).
* Rebase onto js/branch-track-inherit v6.

Changes since v2:
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
  number of allocations made by the caller. Move this functionality
  to patch 3 (formerly patch 4) and drop patch 1.
* Make submodules_of_tree() ignore inactive submodules
* Structure the output of the submodules a bit better by adding prefixes
  to the child process' output (instead of inconsistently indenting the
  output).
** I wasn't able to find a good way to interleave stdout/stderr
   correctly, so a less-than-desirable workaround was to route the child
   process output to stdout/stderr depending on the exit code.
** Eventually, I would like to structure the output of submodules in a
   report, as =C3=86var suggested. But at this stage, I think that it's
   better to spend time getting user feedback on the submodules
   branching UX and it'll be easier to standardize the output when we've
   implemented more of the UX :)

[1] https://lore.kernel.org/git/kl6lbl1p9zjf.fsf@chooglen-macbookpro.roam.c=
orp.google.com/
[2] https://lore.kernel.org/git/kl6lv90ytd4v.fsf@chooglen-macbookpro.roam.c=
orp.google.com/
[3] https://lore.kernel.org/git/xmqqlf0lz6os.fsf@gitster.g=20

Glen Choo (5):
  branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
  branch: make create_branch() always create a branch
  branch: add a dry_run parameter to create_branch()
  builtin/branch: clean up action-picking logic in cmd_branch()
  branch: add --recurse-submodules option for branch creation

 Documentation/config/advice.txt    |   3 +
 Documentation/config/submodule.txt |  24 ++-
 Documentation/git-branch.txt       |  11 +-
 advice.c                           |   1 +
 advice.h                           |   1 +
 branch.c                           | 257 ++++++++++++++++++++-----
 branch.h                           |  57 +++++-
 builtin/branch.c                   |  70 +++++--
 builtin/checkout.c                 |   3 +-
 builtin/submodule--helper.c        |  38 ++++
 submodule-config.c                 |  60 ++++++
 submodule-config.h                 |  34 ++++
 submodule.c                        |  11 +-
 submodule.h                        |   3 +
 t/t3200-branch.sh                  |  17 ++
 t/t3207-branch-submodule.sh        | 291 +++++++++++++++++++++++++++++
 16 files changed, 805 insertions(+), 76 deletions(-)
 create mode 100755 t/t3207-branch-submodule.sh

Range-diff against v5:
1:  a9d1108b3e ! 1:  29669c57b4 branch: move --set-upstream-to behavior to =
dwim_and_setup_tracking()
    @@ branch.c: static void setup_tracking(const char *new_ref, const char=
 *orig_ref,
     =20
      	if (tracking.matches > 1)
     @@ branch.c: static void setup_tracking(const char *new_ref, const cha=
r *orig_ref,
    - 			      tracking.srcs) < 0)
    + 				tracking.remote, tracking.srcs) < 0)
      		exit(-1);
     =20
     +cleanup:
    @@ branch.c: N_("\n"
     @@ branch.c: void create_branch(struct repository *r,
     =20
      	if ((commit =3D lookup_commit_reference(r, &oid)) =3D=3D NULL)
    - 		die(_("not a valid branch point: '%s'"), start_name);
    + 		die(_("Not a valid branch point: '%s'."), start_name);
     -	oidcpy(&oid, &commit->object.oid);
     +	if (out_real_ref)
     +		*out_real_ref =3D real_ref ? xstrdup(real_ref) : NULL;
2:  c543c1412a =3D 2:  ac2532a953 branch: make create_branch() always creat=
e a branch
3:  dddd434d7a =3D 3:  a0ed3fa438 branch: add a dry_run parameter to create=
_branch()
4:  41cca3bd52 =3D 4:  ebded31c96 builtin/branch: clean up action-picking l=
ogic in cmd_branch()
5:  540eeab183 ! 5:  0a7ec6ee75 branch: add --recurse-submodules option for=
 branch creation
    @@ t/t3207-branch-submodule.sh (new)
     +		test_must_fail git rev-parse branch-a &&
     +
     +		cat >expected <<-EOF &&
    -+		submodule ${SQ}sub${SQ}: fatal: a branch named ${SQ}branch-a${SQ} a=
lready exists
    ++		submodule ${SQ}sub${SQ}: fatal: A branch named ${SQ}branch-a${SQ} a=
lready exists.
     +		fatal: submodule ${SQ}sub${SQ}: cannot create branch ${SQ}branch-a$=
{SQ}
     +		EOF
     +		test_cmp expected actual

base-commit: e1c6879cf24f90693ca108542ec1db970764e1dc
--=20
2.33.GIT

