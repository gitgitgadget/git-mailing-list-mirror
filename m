Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE4CC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiCCA62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiCCA60 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BBD150421
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:57:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r13-20020a25ac4d000000b00628b47f44afso1874212ybd.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=dyiuGobgAxSQqND9yByDjSpJ+fkfCbo74XaAz8y+MpU=;
        b=ZXiLqv3bylHbSEgWm/4hE150QL3ZIOBfN37OoPUMvhBfGqFFD+CN3TAs/081b/1b9T
         gxCBKcCsVhr9joa6Vb2PHouNB6U5OjUclmBH/7wJLBSwia2LxFsVGsZPIMlg/1BYr6VO
         4qOBOroD2UMpgvjmpFrMoFcKeOkiQ5NQo/4fvUcdGNKZsmppjVBia9qYGoUzZjXj7Hm9
         X9BK+axzwhlWtGqAwMse4ZW3XKBxRgU47LuuSrd/qVW5M/s/Xh/4VnT5HYStxfebGSA5
         Rg6UUUSKvIJCkx2XPhgCgX4sCNTw4ViE2fjz71b3KDDQjWw3Jq3GYnqPQTak0dnEzNWx
         gTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=dyiuGobgAxSQqND9yByDjSpJ+fkfCbo74XaAz8y+MpU=;
        b=Ty3zFmBLXzgzXKOJ5RuBc38SP4vv6pxTX+FaASCkI8EzK7lwIvkV3Xi1BcFiabJPW6
         r0msE1qhhrba+10s/3uTij0o6w1HJxRDUL6v1qsPYLHR76GnFbfnXNuGntZ+9nfsZAk1
         FmU5B/T9FY8wNxRG36vReXwyJl04vO1hhdxXS5Qes7kkrR3Xxr4ZYqJZ2+KagLtXfb2I
         o5GHCZOAkuc0gU9ZZCchox41uKMmc7yp/eeQJRa7ysxe1LaCJAM8kZoDpd6URsgbDB4S
         8hWc9c3jSwZk1pZqEdeGJ+EbY6+0V+PQn5rg7clp6qJrLFLqi4nuIpdflqFpxISRSv4q
         pXTA==
X-Gm-Message-State: AOAM532uiX2fBmNSK9P2OQsdtnkTx7JEZqbjwM4sFAqB+gmNDPxUydbv
        Ye9Au7wkPbznkWxXVGFxo93YqKw44Dgp8YnDkev+CC40PnJBv0K/XxHzGWTPVx3Oveguh9sL0ME
        SyULzSgM5eOB6rN0t4pMWCtiMXZ2+uETwf5affgY/AsMz01z865i36UH/0raAB7w=
X-Google-Smtp-Source: ABdhPJzX5a/8tGezRBhHahNcrAPYo2/Gg6IwBdYODUQYqy24pKgDcutaM51DpXhoQbOHKhSFWMpBZb4JnyTapw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:ff11:0:b0:624:daf7:a884 with SMTP id
 c17-20020a25ff11000000b00624daf7a884mr32142521ybe.294.1646269061001; Wed, 02
 Mar 2022 16:57:41 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:14 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220303005727.69270-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 00/13] submodule: convert parts of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original series: https://lore.kernel.org/git/20220210092833.55360-1-choogle=
n@google.com
(I've trimmed the cc list down to the 'most interested' parties)

Thanks for the input, =C3=86var :) This just fixes up a few small issues in
the previous version.

=3D Patch summary

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

Since v2:
- Patch 6: Fix a stale commit message that said 'in the next patch'.
- Patch 9: Fix an overly long line (spotted by =C3=86var in an older iterat=
ion of
  ar/submodule-update)
- Patch 12: Test for usage using test_expect_code
- Patch 13: Add missing spaces to the usage string

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

 builtin/submodule--helper.c    | 248 +++++++++++++++++++--------------
 git-submodule.sh               |  54 +------
 t/t7406-submodule-update.sh    |  26 +++-
 t/t7408-submodule-reference.sh |  14 +-
 4 files changed, 183 insertions(+), 159 deletions(-)

Range-diff against v2:
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
 6:  3bde7ccd61 !  6:  8dc7bc5894 submodule--helper: get remote names from =
any repository
    @@ Commit message
         submodule, all within the same process.
    =20
         We can now use this function to save an unnecessary subprocess spa=
wn in
    -    `sync_submodule()`, and also in the next patch, which will require=
 this
    -    functionality.
    +    `sync_submodule()`, and also in a subsequent patch, which will req=
uire
    +    this functionality.
    =20
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
 7:  3b2caf7a35 =3D  7:  feaf9f45d8 submodule--helper: don't use bitfield i=
ndirection for parse_options()
 8:  81e9da8d42 =3D  8:  91e8e1a007 submodule--helper run-update-procedure:=
 learn --remote
 9:  122da84ce4 !  9:  aba851e71e submodule--helper: refactor get_submodule=
_displaypath()
    @@ builtin/submodule--helper.c: static int resolve_relative_url_test(in=
t argc, cons
     =20
     -/* the result should be freed by the caller. */
     -static char *get_submodule_displaypath(const char *path, const char *=
prefix)
    -+static char *do_get_submodule_displaypath(const char *path, const cha=
r *prefix, const char *super_prefix)
    ++static char *do_get_submodule_displaypath(const char *path,
    ++					  const char *prefix,
    ++					  const char *super_prefix)
      {
     -	const char *super_prefix =3D get_super_prefix();
     -
10:  fd52d6a2c3 =3D 10:  2155c049a2 submodule--helper: allow setting superp=
refix for init_submodule()
11:  9422c2ecac =3D 11:  03bbc39a06 submodule--helper update-clone: learn -=
-init
12:  0a3e93998d ! 12:  e49b26ad94 submodule update: add tests for --filter
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update -=
-quiet passe
      '
     =20
     +test_expect_success 'submodule update --filter requires --init' '
    -+	test_must_fail git -C super submodule update --filter blob:none 2>er=
r &&
    -+	grep "usage:" err
    ++	test_expect_code 129 git -C super submodule update --filter blob:non=
e
     +'
     +
     +test_expect_success 'submodule update --filter sets partial clone set=
tings' '
13:  6e1ef27191 ! 13:  c97c97948a submodule--helper update-clone: check for=
 --filter and --init
    @@ builtin/submodule--helper.c: static int update_clone(int argc, const=
 char **argv
      	const char *const git_submodule_helper_usage[] =3D {
     -		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path>.=
..]"),
     +		N_("git submodule [--quiet] update"
    -+		"[--init [--filter=3D<filter-spec>]] [--remote]"
    -+		"[-N|--no-fetch] [-f|--force]"
    -+		"[--checkout|--merge|--rebase]"
    -+		"[--[no-]recommend-shallow] [--reference <repository>]"
    -+		"[--recursive] [--[no-]single-branch] [--] [<path>...]"),
    ++		" [--init [--filter=3D<filter-spec>]] [--remote]"
    ++		" [-N|--no-fetch] [-f|--force]"
    ++		" [--checkout|--merge|--rebase]"
    ++		" [--[no-]recommend-shallow] [--reference <repository>]"
    ++		" [--recursive] [--[no-]single-branch] [--] [<path>...]"),
      		NULL
      	};
      	suc.prefix =3D prefix;

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
--=20
2.33.GIT

