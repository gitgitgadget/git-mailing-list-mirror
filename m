Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E267C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiCAEmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiCAEmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:18 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BDA6D844
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:36 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso8974622pfa.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Od54INuWS8Br0LlrrOk8oM0mOJ5oeONRboAXw0fFJE0=;
        b=g7dNSBJRcheKGHoxm5JlLGQE8BpoNvp2z+xwi6cKQuigSQpJ5mcaUU5MMqyOZXRfh9
         G6r8m3u1n5xNCbpFT7xEIcKRP7Cn8eYSzrtTKxmPao3Pw1Fm6EY2E9te2R31b3RefNl9
         ClKtB9VR/To7WkGWti0eaTKOAsfd3/D9s/kaxuX9qHaJtVsd7IzP+TmQzRrVpF8zouv5
         t8B3PldDnZrv4ICEGFdQyeMSbb2r0xAyc3U/xDcBChTLxaobxjeJLlVUZgQifO/nmO+g
         mxEGwqQGKFejOIv29O8QytSHeCXkaj/1EZJ2Uw45Mcx8w5wY83tdKX77PXZs7trp3g8S
         jD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Od54INuWS8Br0LlrrOk8oM0mOJ5oeONRboAXw0fFJE0=;
        b=rfJ8uVOA5Tn/siwZ7c9tBRiJ6nIdhiKEo5ceVYj7heDbZuH2oNDsQnxMfahYvPglRw
         ItB7j0Z6dVHhxc7d9ytfEqGVz4jFcGLUcJydLDmAdQwxrYgQPWiMIl6fjOQ4muY5w7BT
         sxDZWsRonRtDDVTKvwXD6pf8pIAVgwHwErcBOm59WR4fLp8flqeSgwImy/kf/VOizaFE
         CMsZDIgRuLMy6L8+eJFbmSVQ8xknIuJgE14rvCeCrKsVVFCvpr3izC36CG+1M/cnKZ6X
         vx98oZaNH0FtgsDTl65jTuDBMC6vpx2rMt9xslC6+jtGWB8z7NPZ+lVR1KZU8VYsqfA1
         3/BA==
X-Gm-Message-State: AOAM530anU8uSL6UIfIKKoK4kbcrcZfAw3wirvPSIA+RZeSOoOMCTFaY
        pHwXlU6e/qy4AIVu6viAP/W8ei35Qos2dWXlTFCHmB7SDcPI50EK0h/ClBJQQVpeEB1o3yuNOzW
        J3eN0j4Z1i+fnhjlbGucWnFdnqX26JGr5HFIfp3lWT4yywI14clGY8EAsXh4/pTo=
X-Google-Smtp-Source: ABdhPJzF2Ijs0WEF0SZ5JP2ZABh8ShJ/un8/z6FuYT076b8n7aOeQ4etfeSNx0xbLUAyiY5HKgWM0juAanX88g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:82cc:b0:14f:949b:5678 with SMTP
 id u12-20020a17090282cc00b0014f949b5678mr23986493plz.141.1646109695534; Mon,
 28 Feb 2022 20:41:35 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:19 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301044132.39474-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 00/13] submodule: convert parts of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original series: https://lore.kernel.org/git/20220210092833.55360-1-choogle=
n@google.com
(I've trimmed the cc list down to the 'most interested' parties)

=3D Overview

This is part 1 of 2 series that will supersede ar/submodule-update (as laid=
 out
in [1]). This series prepares for the eventual conversion of "git submodule
update" to C by doing 'obvious' conversions first, and leaving more involve=
d
conversions for later.

Part 1 is a lot simpler than the original series in its entirety, and shoul=
d
play better with topics that Junio identified:

- This series is based off a later version of 'master' that already has
  'js/apply-partial-clone-filters-recursively' merged in [2].
- There is only one, trivial, conflict with 'es/superproject-aware-submodul=
es'
  (both add tests to the end of t7406) [3].

Most of these patches were originally from ar/submodule-update, but because=
 of
the new organization, some commit messages have been amended to make more s=
ense
in context. However, patches 12 and 13 are new - they were added to handle =
the
"--filter" option introduced by 'js/apply-partial-clone-filters-recursively=
'.

Cc-ed Josh, who might be interested in "--filter" changes e.g. the new
tests.

[1] https://lore.kernel.org/git/kl6lmtig40l4.fsf@chooglen-macbookpro.roam.c=
orp.google.com
[2] This also fixes some trivial merge conflicts with 'master'.
[3] Part 2 has nontrival conflicts though. Offline, Emily mentioned that
    conflicts might go away in the next iteration of
    'es/superproject-aware-submodules', but if not, the next round of patch=
es
    will probably be based on a merge of this series +
    'es/superproject-aware-submodules'.

=3D Patch summary

I'm not certain whether to keep patch 13, see the extra discussion in
the --- description for details.

- Patch 1 adds extra tests to "git submodule update" to make sure we
  don't break anything
- Patch 2 removes dead code that used to be part of "git submodule
  update"
- Patch 3 prepares for later changes by introducing the C function that
  will hold most of the newly converted code
- Patch 4 moves run-update-procedure's --suboid option into C
- Patch 5 moves ensure-core-worktree into C
- Patches 6-8 move run-update-procedure's --remote option into C
- Patches 9-11 move "git submodule update"'s --init into C
- Patches 12-13 move "git submodule update"'s --filter option into C

=3D Changes

Since v1:
- Fix compilation error due to bad rebase
- Remove accidentally included tests
- Fix a NEEDSWORK (it was a leftover from ar/submodule-update)

Atharva Raykar (3):
  submodule--helper: get remote names from any repository
  submodule--helper: refactor get_submodule_displaypath()
  submodule--helper: allow setting superprefix for init_submodule()

Glen Choo (8):
  submodule--helper: remove update-module-mode
  submodule--helper: reorganize code for sh to C conversion
  submodule--helper run-update-procedure: remove --suboid
  submodule--helper: remove ensure-core-worktree
  submodule--helper run-update-procedure: learn --remote
  submodule--helper update-clone: learn --init
  submodule update: add tests for --filter
  submodule--helper update-clone: check for --filter and --init

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  submodule tests: test for init and update failure output
  submodule--helper: don't use bitfield indirection for parse_options()

 builtin/submodule--helper.c    | 246 +++++++++++++++++++--------------
 git-submodule.sh               |  54 +-------
 t/t7406-submodule-update.sh    |  27 +++-
 t/t7408-submodule-reference.sh |  14 +-
 4 files changed, 182 insertions(+), 159 deletions(-)

Range-diff against v1:
 1:  6138f4682c =3D  1:  6138f4682c submodule tests: test for init and upda=
te failure output
 2:  6c83c78819 =3D  2:  6c83c78819 submodule--helper: remove update-module=
-mode
 3:  9524986096 =3D  3:  9524986096 submodule--helper: reorganize code for =
sh to C conversion
 4:  f42f3de2b7 =3D  4:  f42f3de2b7 submodule--helper run-update-procedure:=
 remove --suboid
 5:  b0a0cae633 =3D  5:  b0a0cae633 submodule--helper: remove ensure-core-w=
orktree
 6:  976cfa6d24 !  6:  3bde7ccd61 submodule--helper: get remote names from =
any repository
    @@ builtin/submodule--helper.c
      	struct strbuf sb =3D STRBUF_INIT;
     -	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, NULL);
     +	struct ref_store *store =3D get_main_ref_store(repo);
    -+	int ignore_errno;
     +	const char *refname =3D refs_resolve_ref_unsafe(store, "HEAD", 0, NU=
LL,
    -+						      NULL, &ignore_errno);
    ++						      NULL);
     =20
      	if (!refname)
      		die(_("No such ref: %s"), "HEAD");
 7:  4a3c07aa4f =3D  7:  3b2caf7a35 submodule--helper: don't use bitfield i=
ndirection for parse_options()
 8:  bbfc2278c5 !  8:  81e9da8d42 submodule--helper run-update-procedure: l=
earn --remote
    @@ Commit message
    =20
         Teach run-update-procedure to handle --remote instead of parsing
         --remote in git-submodule.sh. As a result, "git submodule--helper
    -    print-default-remote" has no more callers, so remove it.
    +    [print-default-remote|remote-branch]" have no more callers, so rem=
ove
    +    them.
    =20
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
    @@ builtin/submodule--helper.c: static int run_update_procedure(int arg=
c, const cha
      		OPT_END()
      	};
     =20
    +@@ builtin/submodule--helper.c: static const char *remote_submodule_br=
anch(const char *path)
    + 	return branch;
    + }
    +=20
    +-static int resolve_remote_submodule_branch(int argc, const char **arg=
v,
    +-		const char *prefix)
    +-{
    +-	const char *ret;
    +-	struct strbuf sb =3D STRBUF_INIT;
    +-	if (argc !=3D 2)
    +-		die("submodule--helper remote-branch takes exactly one arguments, g=
ot %d", argc);
    +-
    +-	ret =3D remote_submodule_branch(argv[1]);
    +-	if (!ret)
    +-		die("submodule %s doesn't exist", argv[1]);
    +-
    +-	printf("%s", ret);
    +-	strbuf_release(&sb);
    +-	return 0;
    +-}
    +-
    + static int push_check(int argc, const char **argv, const char *prefix=
)
    + {
    + 	struct remote *remote;
     @@ builtin/submodule--helper.c: static int update_submodule2(struct up=
date_data *update_data)
      		die(_("Unable to find current revision in submodule path '%s'"),
      			update_data->displaypath);
    @@ builtin/submodule--helper.c: static struct cmd_struct commands[] =3D=
 {
      	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
      	{"deinit", module_deinit, 0},
      	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
    -+	/* NEEDSWORK: remote-branch is also obsolete */
    - 	{"remote-branch", resolve_remote_submodule_branch, 0},
    +-	{"remote-branch", resolve_remote_submodule_branch, 0},
      	{"push-check", push_check, 0},
      	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
    + 	{"is-active", is_active, 0},
    =20
      ## git-submodule.sh ##
     @@ git-submodule.sh: cmd_deinit()
 9:  765cd21505 =3D  9:  122da84ce4 submodule--helper: refactor get_submodu=
le_displaypath()
10:  0c5e922f32 =3D 10:  fd52d6a2c3 submodule--helper: allow setting superp=
refix for init_submodule()
11:  287f36122a =3D 11:  9422c2ecac submodule--helper update-clone: learn -=
-init
12:  91cac6e236 ! 12:  0a3e93998d submodule update: add tests for --filter
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update -=
-quiet passe
      	)
      '
     =20
    -+test_expect_success 'submodule update adds superproject gitdir to old=
er repos' '
    -+	(cd super &&
    -+	 git -C submodule config --unset submodule.superprojectGitdir &&
    -+	 git submodule update &&
    -+	 test-tool path-utils relative_path \
    -+		"$(git rev-parse --absolute-git-dir)" \
    -+		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
    -+	 git -C submodule config submodule.superprojectGitdir >actual &&
    -+	 test_cmp expect actual
    -+	)
    -+'
    -+
    -+test_expect_success 'submodule update uses config.worktree if applica=
ble' '
    -+	(cd super &&
    -+	 git -C submodule config --unset submodule.superprojectGitDir &&
    -+	 git -C submodule config extensions.worktreeConfig true &&
    -+	 git submodule update &&
    -+	 test-tool path-utils relative_path \
    -+		"$(git rev-parse --absolute-git-dir)" \
    -+		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
    -+	 git -C submodule config submodule.superprojectGitdir >actual &&
    -+	 test_cmp expect actual &&
    -+
    -+	 test_file_not_empty "$(git -C submodule rev-parse --absolute-git-di=
r)/config.worktree"
    -+	)
    -+'
    -+
     +test_expect_success 'submodule update --filter requires --init' '
     +	test_must_fail git -C super submodule update --filter blob:none 2>er=
r &&
     +	grep "usage:" err
13:  f637c23a48 =3D 13:  6e1ef27191 submodule--helper update-clone: check f=
or --filter and --init

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
--=20
2.33.GIT

