Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DB8C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiCEAPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiCEAPl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:15:41 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759C024317A
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:14:53 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 1-20020a630c41000000b00378d9d6bd91so5298790pgm.17
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=J5SS876hFJE7jU7KaunO31bi5LziKRiKe8zWEWEtIqo=;
        b=T0vVjVJScChioyPLPNb3tmiA1JLls3jxWCTYchJg2cjLciHWb+F5iBhVavWK4SrZPX
         foPvZm9jhkrM78xgwmN2r3WphzlkIEY2S+9hN8yHoV1yTzIVk5fTEU2BCJ4374hnMB+O
         I/cooh+itKUhInX0RzG+Ly3bb266qDpfZItM90I96ko+zzP0HTEIAXKv/dpJpOYdqduf
         SFO5JoW0NlUv5yrJKeXSG8dF46Ldq8mGSc6dkTMY9dIBUql5yHxLtjL1MjlW6Eb7C6pq
         1OZjEX5aM8lz14uLv7lfx60lS6q+F2Cnb0psDC9T9v1b2qZJeRXl/heq5hizlGTYOMU5
         vEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=J5SS876hFJE7jU7KaunO31bi5LziKRiKe8zWEWEtIqo=;
        b=axRQ8/DNzO09YhuWrXmThkHp9Uf7UcJFrLNw4cpB7AoAWr/OjDJhP0ba1HVtp/5bJj
         YUflYYQWcFWmVV3dH69Ck2vSEkEpUm2lg20zKOy5AR1TVXhLykcUHA+QGSjaDMCvpype
         VANDLUsASUxsBUluAZ4P6wFdkBMTjSlZqizbrnsEKtqp4VADLttPl5GwTAu/sLcEJKyP
         HocfNm0Go0go+mW4MznyrLPIe3bxdROPyCoAdze3GNonNAAC8h/ipAtuRyFHE+0jiVR8
         uFuMMaBgLyG9A4NvKZSNLay8HrfQdDnGzKZZsa60AxZu2v0BQXktkQaFjp3TmugxDLkY
         p/bQ==
X-Gm-Message-State: AOAM532tjVLAJxC+XJw4N1XR+pRVABy5eXnlaHmD/kLouaJly3u04BY7
        jtQQeclZHnpx3CqDzJtcN8fEoSD4YHqtZtwyHXW9k5pHVyiiYTBH2qXTrPfACQbcZZS/B5BUvu8
        o0TNEvq3W9RwZINNmOFLEQ9SL99eOvcQsDJ/h43hbr70QlzjP3/lItau5SXrmcOc=
X-Google-Smtp-Source: ABdhPJyZ79QYRNrK9em/poIZn57+qZpt/McwkoINhXqXlTaaVM41UGKVcU03yIbAhY00m2I7eXVrK8UBCyDUjQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8d87:0:b0:4f6:b397:1772 with SMTP id
 i7-20020aa78d87000000b004f6b3971772mr998667pfr.69.1646439292280; Fri, 04 Mar
 2022 16:14:52 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:48 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220305001401.20888-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 00/13] submodule: convert parts of 'update' to C
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

Since v3:
- Move 'remove ensure-core-worktree' towards the end (see
  xmqqbkymaftr.fsf@gitster.g).
- Fix typo

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
  submodule--helper run-update-procedure: learn --remote
  submodule--helper update-clone: learn --init
  submodule--helper: remove ensure-core-worktree
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

Range-diff against v3:
 1:  6138f4682c =3D  1:  6138f4682c submodule tests: test for init and upda=
te failure output
 2:  6c83c78819 =3D  2:  6c83c78819 submodule--helper: remove update-module=
-mode
 3:  9524986096 =3D  3:  9524986096 submodule--helper: reorganize code for =
sh to C conversion
 4:  f42f3de2b7 !  4:  533de2c787 submodule--helper run-update-procedure: r=
emove --suboid
    @@ Commit message
         submodule--helper run-update-procedure: remove --suboid
    =20
         Teach run-update-procedure to determine the oid of the submodule's=
 HEAD
    -    instead of doing it in git-subomdule.sh.
    +    instead of doing it in git-submodule.sh.
    =20
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
 6:  8dc7bc5894 =3D  5:  bcc90c332b submodule--helper: get remote names fro=
m any repository
 7:  feaf9f45d8 =3D  6:  93dd851882 submodule--helper: don't use bitfield i=
ndirection for parse_options()
 8:  91e8e1a007 =3D  7:  1aff3622bc submodule--helper run-update-procedure:=
 learn --remote
 9:  aba851e71e =3D  8:  c59d6a9b3c submodule--helper: refactor get_submodu=
le_displaypath()
10:  2155c049a2 =3D  9:  28bc5887ea submodule--helper: allow setting superp=
refix for init_submodule()
11:  03bbc39a06 =3D 10:  364d996481 submodule--helper update-clone: learn -=
-init
 5:  b0a0cae633 ! 11:  3b7d961ade submodule--helper: remove ensure-core-wor=
ktree
    @@ Commit message
         submodule--helper: remove ensure-core-worktree
    =20
         Move the logic of "git submodule--helper ensure-core-worktree" int=
o
    -    run-update-procedure. Since the ensure-core-worktree command is
    -    obsolete, remove it.
    +    run-update-procedure, and since this makes the ensure-core-worktre=
e
    +    command obsolete, remove it.
    +
    +    As a result, the order of two operations in git-submodule.sh is
    +    reversed: 'set the value of core.worktree' now happens after the c=
all to
    +    "git submodule--helper relative-path". This is safe - "relative-pa=
th"
    +    does not depend on the value of core.worktree.
    =20
         Signed-off-by: Glen Choo <chooglen@google.com>
    =20
12:  e49b26ad94 =3D 12:  70e00d294c submodule update: add tests for --filte=
r
13:  c97c97948a =3D 13:  ed7f8d57dc submodule--helper update-clone: check f=
or --filter and --init

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
--=20
2.33.GIT

