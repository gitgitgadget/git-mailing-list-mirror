Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE35C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiCAAJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCAAJB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:01 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3251696815
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:21 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id j22-20020a17090aeb1600b001bc32977e07so369450pjz.7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=NUrPep/15sIy2S0XfJjfpFwlLbbFZ6+V3NUod6JhKQE=;
        b=MTZAmknvR/keCu15EelAO3PpQHzNExmXFg9MPrnSqW5xKU4aokvDfJVplwg5k1kfNM
         pq58hHCtOopu+humYLpzDEo0Uo+Wh9ZX2/0YxwdEf1jSpShlltSzpNh1QOr1iShnFzO/
         YK15SHWb3EJD6H8xk0R8YFwh6rphuPC3eN6cXhrkCXzekzbdetDnR5yOY4IdAtrNn+yC
         +7jcbRCYPiXHw57izQlQ5P/yr3K+WcRaoJULrYDdqI0bD9pmvd2PWORoZIB4FsfURlv1
         xui3PolK+JRRyV7q5YD0WKjSXC9p7RlANoU4Z7b6OvOVZoVBqYSxGIlld0iGi/JMcvpc
         vz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=NUrPep/15sIy2S0XfJjfpFwlLbbFZ6+V3NUod6JhKQE=;
        b=kSwiLqx+S7gKc167aCBsc77rqKW4+35i01jHwZJP+YUjURlh0WCmZPH4iSPGfmlyMR
         mIiVOhrwbVrET1gBFqBZa/IdEpvatKyx4YCXoDderBggJct2ZzHjoQzjItfJfoVvbK+y
         oSTU6L0k9JFQ3yJhgekruvshSvhXcVv1S3zfqadxymD3nMwPUq28b5veBAoVxfMPmV3S
         H5iJu+OuLxma0qk3G0i4mUvHEddyRw7xCTDeIlCD10iipEUDaJeK5uifVEhMtkiVaPWW
         +o7w1Z6v1ixDKsl5MQngFHRSME4wjtwWSOO9MKT+C/kWi5Bscs5Mp2nArcKs9O60grsP
         ZnxQ==
X-Gm-Message-State: AOAM532oCyRKt4ESkTSeHM7QSqSbkJTu4yGcO6csXuDJ6e5LW6E4QTs6
        F1LvFS0YpJIpqX5wLPNdn67RhgxOb+lcbVDfdXJq4xY6IXWWKUfAwmbIY4QwMxcsN5oiK2ti8xg
        09hWJHq9d0X2IXfMtSZPPGIbBPIv7ZLN+W9uNOeIrnOoVzZFuVAC1ANOntkzKhGo=
X-Google-Smtp-Source: ABdhPJymoNXSGWrSfQ15MklVd4fn4TCyBSn/gRA4lU/LzAPEkIqdaDCP/CRQ7l/waBwG92eZth2gvgAUk9XqrQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:32ca:b0:151:440d:a147 with SMTP
 id i10-20020a17090332ca00b00151440da147mr14724616plr.37.1646093300539; Mon,
 28 Feb 2022 16:08:20 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:03 -0800
Message-Id: <20220301000816.56177-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 00/13] submodule: convert parts of 'update' to C
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

 builtin/submodule--helper.c    | 230 ++++++++++++++++++++-------------
 git-submodule.sh               |  54 +-------
 t/t7406-submodule-update.sh    |  54 +++++++-
 t/t7408-submodule-reference.sh |  14 +-
 4 files changed, 211 insertions(+), 141 deletions(-)


base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
--=20
2.33.GIT

