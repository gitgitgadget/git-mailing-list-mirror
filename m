Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C8AC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351840AbiCOVKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiCOVKu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:10:50 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C5F56233
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:37 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x10-20020a170902a38a00b00151e09a4e15so92050pla.15
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=QvXnnKFud4lbqPrL9JROxr3nywTtKGHRxEwA/JHBWmE=;
        b=cvrQWP18OiOhINgy0f1BzQrNq72I0Ey8YSzKqk6gu/1OCGYcucv+J0PpwyzbVgRR21
         8T9mVbhockbBXU64WvO98baaOcjBtlFdyusdNP/oWyeI1DmoSnfJDA2dJR6q5gf6gkDz
         GXtwgpG99MHFoMfQ7lIX6Y36o1N08GR5hH77FkZdVibg1zvdVxIxmt4KjKDsgHHTBQaa
         KcadT5HdPpsyEgMxg66DW+ETaXOVtIsxXwzk9EKrlsmMCAiCKirb8yJ0FHwW5lgd+ual
         vTkRVGd0aMHB2NtBwwEWwbY+SDYq/qrLtTzsReUEpLsaQswvtfKfAcwNEvBSa+VgbYVQ
         CqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=QvXnnKFud4lbqPrL9JROxr3nywTtKGHRxEwA/JHBWmE=;
        b=P4mviaSN+StGqPSNnSu8iON2cnoGHNBRLcMmnJymRG7qUVV2vLOhQ1dgLLQX/vkJRe
         MW2GN9BZfy5MpKFKxuJzuGr0xI/ZaEbwfg6JmQXydjwc8f8Zfg3bibutuWLVYdyg3Hw7
         O4DojRZeF33euuex0BOyy0Ebsvq+uGi2IWf/AwcYkt5OxJk5gTqDRRXm5UjLU3pRyRi7
         E+Kg1wU7qhBf/nYapNRYuw+72Oc9H+hRs0c09vYfqUqZyDsTXSyocOTpIElWjCLO3ZOh
         I3f1OJeli0yhPr8RTywZYsND4zHb+VJN6GflUCk8QVKx8UF3yl5YWhIU+CYJVnR6JDLV
         orGw==
X-Gm-Message-State: AOAM531cbhCZ1i3vG1uy/m6XWEg4FpiTo4+9NJ51PBqQAz3O8stOb7nL
        zV445Qz0uxVxkN9o9NORqhnd5VcJzQxawx8PRSZk7/cJmYmseFAe55SIq150lT/LC+c2lvG1vkW
        2K5SMFQ4lu7OiU9yfB2Tepbfpc8EH/mkqlpgik94tnPomGgfspQ5WfXyR8a3TxC4=
X-Google-Smtp-Source: ABdhPJyqXUgecynS2KMQeWalnd9UxdhYq95thsVaUPoKMzF1CbnQrxMa+7vSnKk1J0GkP96qREIaIxiF65ihyQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e743:b0:153:a902:8d8c with SMTP
 id p3-20020a170902e74300b00153a9028d8cmr2952977plf.150.1647378576534; Tue, 15
 Mar 2022 14:09:36 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:09:18 -0700
Message-Id: <20220315210925.79289-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 0/7] Finish converting "submodule update" to C
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original series: https://lore.kernel.org/git/20220210092833.55360-1-choogle=
n@google.com
"git submodule update" in C part 1: https://lore.kernel.org/git/20220301000=
816.56177-1-chooglen@google.com/
Based off 'gc/submodule-update-part-1'.

=3D Overview

This is part 2 of 2 series that supersedes ar/submodule-update. This
finishes the conversion of "git submodule update" to C by:

- combining the constituent "git submodule--helper" commands
  ("update-clone" and "run-update-procedure") to create "git
  submodule--helper update"
- converting the --recursive flag to C by teaching "git
  submodule--helper update" to invoke itself

This also fixes a test failure that Junio noted in
https://lore.kernel.org/git/xmqqr18770pc.fsf@gitster.g (see patch 6 for
more details).

=3D Known conflicts

This series is missing some functionality introduced in the in-flight
es/superproject-aware-submodules [1], namely, that "git submodule
update" sets `submodule.hasSuperproject` on all submodules. I intended
for this to go _after_ es/superproject-aware-submodules, and in that
series, Emily and I tried to simplify this conflict by preemptively
doing this in C (see that series' v9 cover letter [1]).

That discussion is still ongoing, but it seems helpful to send this
series anyway (thanks to all who weighed in over IRC [2]). At any rate,
neither series really depends on the other, so this series is still
independently reviewable, but with the caveat that I may add another
patch that adds the missing behavior (it will probably look something
like [3]).

Alternatively, this series might graduate first. In which case, I'll
continue working with Emily to fix the conflict.

=3D Patch organization

This series largely follows the remaining ar/submodule-update patches
that weren't included in part 1 and some additional clean ups. One
notable difference vis-a-vis ar/submodule-update is that the CLI args
for "update-clone" are no longer copied across structs (see patch 4 for
more details).

- Patches 1-2 teaches "run-update-procedure" to exit and report its
  failures in a more idiomatic manner instead of relying on
  git-submodule.sh.
- Patches 3-4 prepare for "run-update-procedure" and
  "update-clone"'s args to be merged into a single struct.
- Patches 5-6 finish the process of implementing `submodule--helper
  update`.
- Patch 7 cleans up a forward declaration that kept the diffs small
  while we were in the process of conversion, but is no longer needed.

[1] https://lore.kernel.org/git/20220310004423.2627181-1-emilyshaffer@googl=
e.com
[2] https://colabti.org/irclogger/irclogger_log/git-devel?date=3D2022-03-14
[3] https://lore.kernel.org/git/kl6l1qz9s6tu.fsf@chooglen-macbookpro.roam.c=
orp.google.com

Atharva Raykar (2):
  submodule--helper: run update using child process struct
  submodule: move core cmd_update() logic to C

Glen Choo (4):
  submodule update: use die_message()
  submodule--helper: teach update_data more options
  submodule--helper: reduce logic in run_update_procedure()
  submodule--helper: remove forward declaration

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
  builtin/submodule--helper.c: rename option struct to "opt"

 builtin/submodule--helper.c | 691 ++++++++++++++++++------------------
 git-submodule.sh            | 105 +-----
 2 files changed, 361 insertions(+), 435 deletions(-)


base-commit: c9d256249375c7b8a1773139791448860b5789ff
--=20
2.33.GIT

