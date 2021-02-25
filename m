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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6E8C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3F464E4D
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhBYKQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 05:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhBYKO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 05:14:28 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52A8C061793
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:12:50 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id a24so2915529plm.11
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmbk5xFupGzG2YejLBeRfWELJvtv9IhsvnHEtaHSZMg=;
        b=lMKIYS4M81xjnUUt79dgQxQPKs29VHdhlVGXyhmYrEMXn1Go1gCixgLgHaXlkZqJOJ
         fZcsAHMerQF20Hwn8tGshIz4a/y+Slx2EP1bdcl9ItL1yfqbzLKD/Ku6+aMRFJE+rZue
         sb98WLIsDyIIfFFzzuRKjiXCULUexrebGqItp1PW2zHng95v81RPURBN5HfvpZRO3e3h
         xGVaVO9txxNpeMeZC3aq7fBwybnqxjQ9i1HtMPkV19vuuaLFoOgj3gKt+1uIQEyx5ggg
         Nv3tHrgEmHCIbUlFmSALH+brZ3LrezxSaRRBH4N8odTZHfx6uCToU+9thSWM7yGzkIy8
         h6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmbk5xFupGzG2YejLBeRfWELJvtv9IhsvnHEtaHSZMg=;
        b=Bkpxr3FqXb6gR9MqCcO/CLm+wJU6w2oheG5vqjSM7aJN7gWhv9Nw5rpG1h5/lOBfF7
         iV2z+FoVS1YIjtEiL+vsneEzuQsl14agsHdeeCuodjyMYPh4yaqkl5ocDD7kYji5KFZK
         qdqD+4/oHSseoUJpALe+mlWSjj+mqFKrTicA96a5CTBPyRVW2d4YwpbHhyyb8spaPTRm
         8Gg0uRMZyTpKCIMSSzpSE1ZlQ0FQ0RcZrBhFQVdQAdJumf6bgHzgkoVGhjsSButIqQ1i
         SFUYZp1irwOOAbrJb+6SiSL0DcEu0oBy1nkLHX1Q1UnZQmsd4a8dPAwXc781r2gFRTP0
         MJxg==
X-Gm-Message-State: AOAM532kIBXRhJycgbeKaHWku9H0WMonzwYMk+tA/9bzlgYrsG+iF6D3
        cORCVIwFZaL/YAxBvCkR5sb8lqubcoFGnA==
X-Google-Smtp-Source: ABdhPJyNp2X7lgeJKXki7rL3TwMCjNu0JDbm+VZ2/Psu/06LC4aacApylJXN6VlqS6lbUvm09MiG9g==
X-Received: by 2002:a17:90a:e2ca:: with SMTP id fr10mr2618986pjb.154.1614247970014;
        Thu, 25 Feb 2021 02:12:50 -0800 (PST)
Received: from localhost.localdomain ([223.233.90.42])
        by smtp.googlemail.com with ESMTPSA id 67sm5941188pfb.43.2021.02.25.02.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:12:49 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 0/6][Outreachy] commit: Implementation of "amend!" commit
Date:   Thu, 25 Feb 2021 15:38:52 +0530
Message-Id: <20210225100855.25530-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217072904.16257-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series teaches `git commit --fixup` to create "amend!" commit
as an alternative that works with `git rebase --autosquash`. It allows to
fixup both the content and the commit message of the specified commit.
Here we add two suboptions to the `--fixup`, first `amend` suboption that
creates an "amend!" commit. It takes the staged changes and also allows to
edit the commit message of the commit we are fixing.
Example usuage:
git commit --fixup=amend:<commit>

Secondly, `reword` suboption that creates an empty "amend!" commit i.e it
ignores the staged changes and only allows to reword/edit the commit message
of the commit we are fixing.
Example usuage:
git commit --fixup=reword:<commit>

** This work is rebased on the top of cm/rebase-i-updates.

Changes from v1:
(Thanks Junio C Hamano for the reviews and pointing out the changes required in v1)

* (As `reword` and `amend` suboptions of `--fixup` uses apha
  characters only) add helper function that does strspn(alpha) to
  detect that suboptions are passed to `--fixup` instead of checking
  if ':' occurs before '^' or '@'.

* update the `check_fixup_reword_options()` function and disallow
  `reword` option with path(argc), interactive and patch_interactive.
  Also update the test script (t7500).

* make '-m' commit message option incompatible with `amend` and
  `reword` suboption, as it is more expected to edit the original
  commit message while preparing "amend!" commit and using `-m` for
  directly appending the commit message results in the confusion at
  the user end. So, error out when combined with `m` and update
  the respective tests.

* slight improvements in commit messages and update the documention
  (git-commit.txt) to include the above changes.

Charvi Mendiratta (6):
  sequencer: export subject_length()
  commit: add amend suboption to --fixup to create amend! commit
  commit: add a reword suboption to --fixup
  t7500: add tests for --fixup=[amend|reword] options
  t3437: use --fixup with options to create amend! commit
  doc/git-commit: add documentation for fixup=[amend|reword] options

 Documentation/git-commit.txt              |  39 ++++++-
 Documentation/git-rebase.txt              |  21 ++--
 builtin/commit.c                          | 117 +++++++++++++++++--
 commit.c                                  |  14 +++
 commit.h                                  |   3 +
 sequencer.c                               |  14 ---
 t/t3437-rebase-fixup-options.sh           |  30 +----
 t/t7500-commit-template-squash-signoff.sh | 134 ++++++++++++++++++++++
 8 files changed, 306 insertions(+), 66 deletions(-)

--
2.29.0.rc1

