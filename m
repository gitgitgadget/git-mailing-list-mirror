Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5A9C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 01:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiCAB34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 20:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiCAB3x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 20:29:53 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4AD2659
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 17:29:13 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b5-20020a170902e94500b0014f6d0a417bso5410746pll.6
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 17:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LRplzxxmMZp+qHOObO2FRK3ySnMLCNGlS1beJplcAzk=;
        b=XyuxPiIzVrdQf6Z8BfDrEbpJ4jq9aR8CnLXu2Xkke1q4/e2hKoD0WpKf4HvCtFCq2K
         jyCmo/LFNOnwVlxLFvF2CzovZV7eyws8k9JQ7f/tDwoHUMCN63Gyp5GYPirUd9fekXCs
         opIXyBlI6NdJbhxZIgYsQbQSGyaHauM2x0M8h9ypl3/89rOmnUPHJKuNe3TK75tZ58px
         lOMlldagrB0VvV18OgykNBPWKoNvabGlEuTWb0M4zo+tXYUjfEOTTNCTyyhzJKTzn9Gs
         qEKHzZeR62UeG+llvbz8hIFlgXonEkjuHu5ghs1LYkkJtroSdhMfcbt+t2UsNl1hAVws
         cJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LRplzxxmMZp+qHOObO2FRK3ySnMLCNGlS1beJplcAzk=;
        b=BCp8W3l2RWJCwlz7q+A0S7W9wa/zSt5rppKSiofuPSaF/3Hrc/zacZSld0zLS33ZBo
         inIfcsmTjeoOAGg5/61Ec1d7Z5YeYfyRikAUFgPK4j/N/tVNX93HspmEm38ONr6Sm5bM
         Nt6Q6NYtYXyse9l7dNqS0PLDk6JoUJhz3YP1gaOmxVOw5dPBoiGGeSJ3E8s7ktn8BJDS
         NeDOGvEcfcNPvS+UcC7Eda6LhJYpKILTDGKjvK9ydhXtdIIigFkffuphjVLmuc8Mx52c
         UcOQ8Nf0PXt48B9oKsFWm8gRpcx3CMFG2IdROhEqGsGaTf9OYGR/STIbhj4/DQzqAEVG
         m8ew==
X-Gm-Message-State: AOAM5334pid6oZ23mlmAxQzYgmzqocbayRfOT+PNiviS5tJFWCHsS4IC
        HeH/LA7bhapHm6ybJ3V3udiS4sG+OgXHyEI4Z3R3TzhTgIxBlZXfbLTRwzca1M3MRB/+eWBBbCb
        R5NId9qmhRz9ehVNTcW66xxba2s1sM0+RiH+LPg8i81Xe2SSUTePa/u/G8QpT+W4=
X-Google-Smtp-Source: ABdhPJzV7vDKSuIXt2u+CHHSF4eW8r+aF6pb3rSVuhRJNLgPbi4xbrNdiQ+6mVOL1JcuBIuU+mG9zb1u8/gFjQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:d64d:0:b0:374:6edc:989c with SMTP id
 d13-20020a63d64d000000b003746edc989cmr19324187pgj.434.1646098152608; Mon, 28
 Feb 2022 17:29:12 -0800 (PST)
Date:   Mon, 28 Feb 2022 17:29:10 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <kl6l35k2pijd.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
Subject: Re: [PATCH 00/13] submodule: convert parts of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Original series: https://lore.kernel.org/git/20220210092833.55360-1-choog=
len@google.com
> (I've trimmed the cc list down to the 'most interested' parties)
>
> =3D Overview
>
> This is part 1 of 2 series that will supersede ar/submodule-update (as la=
id out
> in [1]). This series prepares for the eventual conversion of "git submodu=
le
> update" to C by doing 'obvious' conversions first, and leaving more invol=
ved
> conversions for later.
>
> Part 1 is a lot simpler than the original series in its entirety, and sho=
uld
> play better with topics that Junio identified:
>
> - This series is based off a later version of 'master' that already has
>   'js/apply-partial-clone-filters-recursively' merged in [2].
> - There is only one, trivial, conflict with 'es/superproject-aware-submod=
ules'
>   (both add tests to the end of t7406) [3].
>
> Most of these patches were originally from ar/submodule-update, but becau=
se of
> the new organization, some commit messages have been amended to make more=
 sense
> in context. However, patches 12 and 13 are new - they were added to handl=
e the
> "--filter" option introduced by 'js/apply-partial-clone-filters-recursive=
ly'.
>
> Cc-ed Josh, who might be interested in "--filter" changes e.g. the new
> tests.
>
> [1] https://lore.kernel.org/git/kl6lmtig40l4.fsf@chooglen-macbookpro.roam=
.corp.google.com
> [2] This also fixes some trivial merge conflicts with 'master'.
> [3] Part 2 has nontrival conflicts though. Offline, Emily mentioned that
>     conflicts might go away in the next iteration of
>     'es/superproject-aware-submodules', but if not, the next round of pat=
ches
>     will probably be based on a merge of this series +
>     'es/superproject-aware-submodules'.
>
> =3D Patch summary
>
> I'm not certain whether to keep patch 13, see the extra discussion in
> the --- description for details.
>
> - Patch 1 adds extra tests to "git submodule update" to make sure we
>   don't break anything
> - Patch 2 removes dead code that used to be part of "git submodule
>   update"
> - Patch 3 prepares for later changes by introducing the C function that
>   will hold most of the newly converted code
> - Patch 4 moves run-update-procedure's --suboid option into C
> - Patch 5 moves ensure-core-worktree into C
> - Patches 6-8 move run-update-procedure's --remote option into C
> - Patches 9-11 move "git submodule update"'s --init into C
> - Patches 12-13 move "git submodule update"'s --filter option into C
>
> Atharva Raykar (3):
>   submodule--helper: get remote names from any repository
>   submodule--helper: refactor get_submodule_displaypath()
>   submodule--helper: allow setting superprefix for init_submodule()
>
> Glen Choo (8):
>   submodule--helper: remove update-module-mode
>   submodule--helper: reorganize code for sh to C conversion
>   submodule--helper run-update-procedure: remove --suboid
>   submodule--helper: remove ensure-core-worktree
>   submodule--helper run-update-procedure: learn --remote
>   submodule--helper update-clone: learn --init
>   submodule update: add tests for --filter
>   submodule--helper update-clone: check for --filter and --init
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   submodule tests: test for init and update failure output
>   submodule--helper: don't use bitfield indirection for parse_options()
>
>  builtin/submodule--helper.c    | 230 ++++++++++++++++++++-------------
>  git-submodule.sh               |  54 +-------
>  t/t7406-submodule-update.sh    |  54 +++++++-
>  t/t7408-submodule-reference.sh |  14 +-
>  4 files changed, 211 insertions(+), 141 deletions(-)
>
>
> base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
> --=20
> 2.33.GIT

Ugh, this version doesn't compile (I rebased it onto 'master' and forgot
to take into account ce14de03db (refs API: remove "failure_errno" from
refs_resolve_ref_unsafe(), 2022-01-26)).

This version is still reviewable, but I'll run this through CI again
before I send out v2.
