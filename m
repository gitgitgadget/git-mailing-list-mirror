Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D3C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhLPXd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhLPXd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:33:28 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC09C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:28 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id l7-20020a622507000000b00494608c84a4so445557pfl.6
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=QSRvnKuIx1rGWYEpfCLgNQeWCgWr/UvwlZ4r8X9dXxk=;
        b=IlpPK8Pw0aKW8YZ5m48eu/degdPb1nj7zFSRaAE/8uvkn85uSz82XKtpqmVaV7/e44
         x6zoYCqIDrqPh9qeDbTysCRse2tCu9Fc9K4oZTD4Cgdk2Wluwu98zGyqz+zhIQA5xMRA
         GwcEA1sy0VjhkeI1cCYupCXi7YOWqTzO2DtMl5QWgOZ5PrdPnEJs0sG2K9Ix7XHB8xIW
         LETPHTrrXo2vJZRjIfTxsxF8ym8TG8U53BR0GEcN0a7PpbvFQW2B7LjiPr2Sd0PT0vVZ
         hJQdyGaOC79+P6dURyN9IU6PTkigbJ7F/XkkPCsRQjgQMLB8clq1wQpZvinxuGyDp9IO
         slCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=QSRvnKuIx1rGWYEpfCLgNQeWCgWr/UvwlZ4r8X9dXxk=;
        b=qb72ZqBo9HXAJQfavXIYaGMGZkyIReWC7zObmqN9ecKCaf6uRnIEBt72izjXZwtLg7
         xciqOl7heXVOgz/db7rVyAKdPwn+NwHr/PHXdSHz6uYBktPewLwdIkhuGAWTREFgXGC3
         gvv1z2w1qqnwLDM2d3UPXOsfmDv9wV6nMRefkSRnFRnUdhvGOKhs9+ARfJunBukrzaiA
         QpjB3a3eOeaqZ41gQ6s+33dlnm6/Z/q83gmQzkYbySkG4+182uqSrBCYOz4JOM4cbBFK
         NzR10c+jQagmY7pZQ17KF5gDXFhCA26i2avEyKL7Xqa2tvoFQX6ACD+uKpprNjGc75gK
         JAYg==
X-Gm-Message-State: AOAM5336h1TQ7GrE/dLagBXu5VKGqvOEFnSzTADlOY0O3sExVNn8K/TF
        gE1jWzr5xDBVR3j4VFwlKPcmTB0x4K3NmA+qQF/PVIwU6RK5fVeS7o7QHSyUhCsSfvOcnRoSi/c
        o8+6mnYk2AGo/NIR0uldI/pZgpjUcZBLTnZZVjqyrCeVmwzlgP4ds3ReQOmVdUQI=
X-Google-Smtp-Source: ABdhPJxXeF2+cwbIO7vOWr8jZNOWnbgnRlc00cr1Cb/hRJpvi9l+eWuuL0jmK2M9LqPmUN0pZE6GHHiwo03ohA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:dac2:b0:148:a2e8:276d with SMTP
 id q2-20020a170902dac200b00148a2e8276dmr237934plx.116.1639697607324; Thu, 16
 Dec 2021 15:33:27 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:33:19 -0800
In-Reply-To: <20211216003213.99135-1-chooglen@google.com>
Message-Id: <20211216233324.65126-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211216003213.99135-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 0/5] implement branch --recurse-submodules
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

Range-diff against v4:
1:  751e8ae566 < -:  ---------- branch: accept multiple upstream branches f=
or tracking
2:  5d1ebe1495 < -:  ---------- branch: add flags and config to inherit tra=
cking
3:  0080a1fb35 < -:  ---------- config: require lowercase for branch.autose=
tupmerge
4:  dfdbbaaca5 ! 1:  a9d1108b3e branch: move --set-upstream-to behavior to =
dwim_and_setup_tracking()
    @@ Commit message
    =20
         This refactor is motivated by a desire to add a "dry_run" paramete=
r to
         create_branch() that will validate whether or not a branch can be
    -    created without actually creating it - this behavior be used in a
    +    created without actually creating it - this behavior will be used =
in a
         subsequent commit that adds `git branch --recurse-submodules topic=
`.
    =20
         Adding "dry_run" is not obvious because create_branch() is also us=
ed to
    @@ branch.c: N_("\n"
     @@ branch.c: void create_branch(struct repository *r,
     =20
      	if ((commit =3D lookup_commit_reference(r, &oid)) =3D=3D NULL)
    - 		die(_("Not a valid branch point: '%s'."), start_name);
    + 		die(_("not a valid branch point: '%s'"), start_name);
     -	oidcpy(&oid, &commit->object.oid);
     +	if (out_real_ref)
     +		*out_real_ref =3D real_ref ? xstrdup(real_ref) : NULL;
5:  e22a177cb7 ! 2:  c543c1412a branch: make create_branch() always create =
a branch
    @@ Commit message
    =20
         create_branch() was formerly used to set tracking without creating=
 a
         branch. Since the previous commit replaces this use case with
    -    setup_tracking(), we can simplify create_branch() so that it alway=
s
    -    creates a branch.
    +    dwim_and_setup_tracking(), we can simplify create_branch() so that=
 it
    +    always creates a branch.
    =20
         Do this simplification, in particular:
    =20
6:  8a895aa401 ! 3:  dddd434d7a branch: add a dry_run parameter to create_b=
ranch()
    @@ builtin/checkout.c: static void update_refs_for_switch(const struct =
checkout_opt
     -				      opts->track);
     +				      opts->track,
     +				      0);
    - 		new_branch_info->name =3D opts->new_branch;
    - 		setup_branch_path(new_branch_info);
    - 	}
    + 		free(new_branch_info->name);
    + 		free(new_branch_info->refname);
    + 		new_branch_info->name =3D xstrdup(opts->new_branch);
7:  971c53ec85 =3D 4:  41cca3bd52 builtin/branch: clean up action-picking l=
ogic in cmd_branch()
8:  cd88f3ad92 ! 5:  540eeab183 branch: add --recurse-submodules option for=
 branch creation
    @@ t/t3207-branch-submodule.sh (new)
     +		test_must_fail git rev-parse branch-a &&
     +
     +		cat >expected <<-EOF &&
    -+		submodule ${SQ}sub${SQ}: fatal: A branch named ${SQ}branch-a${SQ} a=
lready exists.
    ++		submodule ${SQ}sub${SQ}: fatal: a branch named ${SQ}branch-a${SQ} a=
lready exists
     +		fatal: submodule ${SQ}sub${SQ}: cannot create branch ${SQ}branch-a$=
{SQ}
     +		EOF
     +		test_cmp expected actual

base-commit: a1eb3ee8288c96c95d18fef027fc276b5cb3b17a
--=20
2.33.GIT

