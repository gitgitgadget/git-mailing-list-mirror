Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93337C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E51223B88
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgLRVLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLRVLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:09 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4B9C0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:29 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id x13so3229024oto.8
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9XGjcYEjbhPNDgdBbyjUMQUs81emDrEmus68Kgc/+M=;
        b=uvN9QgaN7Y1cVSOW3EWLT9Lx9ZzTdo7XehZt5htWuxGV4I7mfSzfyyFy7U2yTvryTM
         HeMzRNVpKigKsHufT9XR5cxSPCodbIZAYDY/gVeY2Ja+nlnArw3cGhHWZfakyPh1b4e4
         iyykX+r/3F68aA88k5H4ldsb3OaZnvcVDxwNLIaEaDz5zCkxeKMSOEDqya4yIFZfkeTI
         Ixz4DpKYmh8YOQojTJunbedoLRfGqbxzgGx9xgCQIcrZAuSWg7OLFhpcgggV8ay2glCI
         +9TlyiT8Yxm9H41znqj8DgvZqfNoANxRT8M2ygnD/6+J21dDLt6HmGEZfsTfUPtFDDl6
         8sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9XGjcYEjbhPNDgdBbyjUMQUs81emDrEmus68Kgc/+M=;
        b=KIYoFwY2ap6T56E66+z4xu8mvr1Xx5OqGcobIfVAdxZXFDC7PLFQBR6EoK57wZuql1
         4+2ixvq1fax+noGdtONWVNP+PofKC60ZmBGvuWgQC+8uQGBMFSh/QU+p/H24gFzUfe9Q
         rAxicsRxi2fhdlgKr7b1k0B/obQPY/VdKNnkot6tUuA8c/ZGUGiLd9rIrTHNlytlAzTx
         5YR44CMM4lOPME6ll/BvaumXtYa6rqKanoZGoDqHORNokDb8O/2MvgWepHwMs5yJpAf7
         0iK9Z/zReFyPLmfYEQO605EDh8qKr21uTnzVhO14JcpSWZJLFgHkNeF/8gfeOTp5LNg2
         Ux8Q==
X-Gm-Message-State: AOAM531JoN0+fqcBBP2IzZ+pMKS6zU94MyGOBNknC4ZXZLt4AVFlWg+w
        x7aT20suM9ekqz4LIuoYKxPVqKr3fqUoWQ==
X-Google-Smtp-Source: ABdhPJzwFD3Qf8MecJxoBYNCp+3er5fjz48GHqS3k6zh7aVEDE3bbGLNgOvZNpnivMN1wMXJo3jYrA==
X-Received: by 2002:a9d:7548:: with SMTP id b8mr4234390otl.142.1608325828109;
        Fri, 18 Dec 2020 13:10:28 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k3sm2158305oor.19.2020.12.18.13.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:27 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/13] pull: pull mode part 2
Date:   Fri, 18 Dec 2020 15:10:13 -0600
Message-Id: <20201218211026.1937168-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series depends on fc/fc/pull-merge-rebase.

It's basically a collection of all the pull.mode patches rebased on top
of what Junio merged to jch.

Except that while re-reading the old threads I noticed a suggestion by 
Theodore Ts'o that went unnoticed [1]. It would be very useful to make
the pull.mode configuration per-repository, instead of per-branch.

This way we can have two different configurations for:

  git pull origin *
  git pull john *

This also could allow us in the future to have a "merge-inverted" mode
so users could finally merge correctly an update from the upstream
branch: master to origin/master, not origin/master to master.

This in addition allows us to consider yet another possible future
default:

  git pull                # default mode: merge-inverted
  git pull origin master  # default mode: merge

Also, based on Junio's feedback [2] regarding the logic of opt_ff I
decided to remove it completely, since it's clear they don't
implicitely mean a merge.

And finally; I noticed some quirkiness with semantics of --rebase and
pull.rebase, which I handled in the last patch.

Changes since v1:

 * Added more cleanups
 * Added --merge option
 * Added REBASE_DEFAULT
 * Added warning with --ff options
 * Added pull.mode
 * Added pull.mode=fast-forward (previously ff-only)
 * Improved --rebase and pull.rebase interaction

Changes since previous patch series:

 * Add remote.<name>.pullmode
 * Remove branch.<name>.pullmode
 * pull.mode now overrides pull.rebase

[1] https://lore.kernel.org/git/20130312212027.GE14792@thunk.org
[2] https://lore.kernel.org/git/20201214202647.3340193-1-gitster@pobox.com

Felipe Contreras (13):
  doc: pull: explain what is a fast-forward
  pull: improve default warning
  pull: cleanup autostash check
  pull: trivial cleanup
  pull: trivial whitespace style fix
  pull: introduce --merge option
  rebase: add REBASE_DEFAULT
  pull: move configurations fetches
  pull: show warning with --ff options
  pull: add pull.mode
  pull: add pull.mode=fast-forward
  pull: reorganize mode conditionals
  pull: improve --rebase and pull.rebase interaction

 Documentation/config/pull.txt   |   6 ++
 Documentation/config/remote.txt |   6 ++
 Documentation/git-pull.txt      |  49 ++++++++--
 builtin/pull.c                  | 165 +++++++++++++++++++++++---------
 rebase.c                        |  12 +++
 rebase.h                        |  13 ++-
 t/t5520-pull.sh                 | 108 +++++++++++++++++++++
 t/t7601-merge-pull-config.sh    |  34 +++++--
 8 files changed, 330 insertions(+), 63 deletions(-)

Range-diff:
 1:  0925821483 !  1:  eb72fa24fa doc: pull: explain what is a fast-forward
    @@ Documentation/git-pull.txt: Assume the following history exists and the current
     +synchronize the local, and remote brances.
     +
     +In these situations `git pull` will warn you about your possible
    -+options, which are either merge, or rebase. However, by default it will
    -+continue doing a merge.
    ++options, which are either merge (`--no-rebase`), or rebase (`--rebase`).
    ++However, by default it will continue doing a merge.
     +
     +A merge will create a new commit with two parent commits (`G` and `C`)
     +and a log message describing the changes, which you can edit.
    @@ Documentation/git-pull.txt: and a log message from the user describing the chang
      
      In Git 1.7.0 or later, to cancel a conflicting merge, use
      `git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
    +@@ Documentation/git-pull.txt: version.
    + 
    + SEE ALSO
    + --------
    +-linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-config[1]
    ++linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-rebase[1],
    ++linkgit:git-config[1]
    + 
    + GIT
    + ---
 2:  46c14cf851 =  2:  37d1dcecfd pull: improve default warning
 3:  aeb17014f5 =  3:  e3d29270ac pull: cleanup autostash check
 -:  ---------- >  4:  214bbbfcff pull: trivial cleanup
 -:  ---------- >  5:  69c1073064 pull: trivial whitespace style fix
 -:  ---------- >  6:  7561b4e7a8 pull: introduce --merge option
 -:  ---------- >  7:  17bf94fb5d rebase: add REBASE_DEFAULT
 -:  ---------- >  8:  8bd30852dd pull: move configurations fetches
 -:  ---------- >  9:  107fd4e0db pull: show warning with --ff options
 -:  ---------- > 10:  18d4caec8f pull: add pull.mode
 -:  ---------- > 11:  38feb507ce pull: add pull.mode=fast-forward
 -:  ---------- > 12:  80cd35372a pull: reorganize mode conditionals
 -:  ---------- > 13:  dc2819720a pull: improve --rebase and pull.rebase interaction
-- 
2.30.0.rc0

