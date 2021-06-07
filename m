Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAC9C47095
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2D9610A1
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFGRqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGRqq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 13:46:46 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0DC061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 10:44:49 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so17558849oth.8
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hVefZrLCA15u6e+2FiZAVjVe62Qx76V3U/valnlMLmQ=;
        b=tLaIsUGiVgNfALRHWE3o+hFwWTfOeGa2htZkUwUdEj1/+QAT0SvOeojShysVNgrP0s
         Ye1TG+cUnxl5uZ1CKep+SPW5u5xuTXh8D1PzCpUZCPqbuPHHLxA+H/vqYm82Axmipoy4
         ZkJqura0gP4QlipeZ2u8fmtHxE8I0/DhKYZs5N1Fifupfvy+TbtaWnXJs93hfAj3thD8
         s0ooHBLIcGHYQOSDGQJWWw44/z1lbBa4LIZZO9I6EdXLFxWtRxqqGXToLkNlNxCwEhWL
         Ud5CNS0bu9dktOeUdEi7U2gAfxzwTw4dG6pUFAfa3bKo/StG9dnJKJzEQBKCINbSLfRx
         07OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hVefZrLCA15u6e+2FiZAVjVe62Qx76V3U/valnlMLmQ=;
        b=n3ypqjQrAxRhiaa6m+xJIrM2nAEh2wO2lLh0bS9Ek5JacCuFul2NpwE9WBEqxbmJED
         1OzsIWuumCwqcsGu5PnSW1O9Qebin5Zz6kHiADCSKLceZwpajkTZ+6WZaDQU4mU8k2nP
         TJem+8wICanjXbYaMgV98FOiZM0D+s0LZsOv7EaZB4JnR8bBP76m4Lg5+uN2T4XfVH+B
         6oTQ8T+8QBeWtUjfOvh8XpRpUJhyd/bHHLMET2bPlzRXszcwdqHaPSyzX/P555mi9FFE
         krnxBNxXeCI9fxxkLYtLodIp/qVAtPdLS4wdjYUT6xBneplcyd0M2wAxsXc9HfTnql/k
         M6Xg==
X-Gm-Message-State: AOAM533QwQnQ/TkUQm216l9uU1WKO8hLCxYHflccjuJvyqhTa31BXV04
        6nU5sK4LBD0VDvFRpL8PnZnkTgsfcn6Yuk0befh8OO1jisz1/g==
X-Google-Smtp-Source: ABdhPJyckyyJkzqZlMpYiD87ZewECAr6CCLML/kD4CXBPaGbI0JoMQnetjsy87RI4bC0vERiyk8gcpzPGIZCoO7HmE4=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr14412399otn.162.1623087888182;
 Mon, 07 Jun 2021 10:44:48 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Jun 2021 10:44:37 -0700
Message-ID: <CABPp-BE-2s+0vOg+icJGBgR5X6BpoTieJd2KH39SbXW1WAA1Ew@mail.gmail.com>
Subject: [ANNOUNCE] git-filter-repo 2.32.0
To:     Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest release of git-filter-repo, v2.32.0, is now available.  It
is comprised of 32 non-merge commits since v2.29.0, including 20
changes from five new contributors.

The public repo of filter-repo is at

    https://github.com/newren/git-filter-repo

The tarballs can be found at:

    https://github.com/newren/git-filter-repo/releases

git-filter-repo can also be installed via a variety of package managers
across Windows, Mac OS, or Linux (and maybe others)[1].

New contributors whose contributions weren't in v2.29.0 are as follows.
Welcome to the git-filter-repo development community!

  * Johannes Schindelin
  * Stefano Rivera
  * Lassi Kortela
  * Shezan Baig
  * =E6=9E=97=E5=8D=9A=E4=BB=81(Buo-ren Lin)

[1] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md

----------------------------------------------------------------

git-filter-repo 2.32 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

(Note: Additional information is available for many release notes at
    https://github.com/newren/git-filter-repo/issues/<NUMBER>)

(Note: Windows users may be interested in the external fixes at
 https://github.com/msys2/msys2-runtime/pull/27 and
 https://github.com/git-for-windows/git/pull/3165, the pair of which
 should improve the experience for many users who try to run
 git-filter-repo on Windows.)

* Fixes:
  * sanity check that the --path-rename argument has exactly one ':' (#206)
  * fix --use-mailmap (#185)
  * improve invalid repository error message

* Enhancements:
  * Allow callback bodies to be loaded from a file (#246)

* Documentation:
  * update Windows section of INSTALL.md
  * link from main README.md to nicely formatted external copy of documenta=
tion
  * add some clarifications around replace refs (#235)
  * link to (dangerous but useful) GitHub docs on purging old history (#235=
)

* contrib scripts:
  * bfg-ish: fix relative path compatibility for --replace-text and repo (#=
242)
  * bfg-ish: add some sanity checks on specified repo (#241)
  * lint-history: decode filename to fix Windows portability (#231)
  * lint-history: fix binary blob detection (#223)
  * lint-history: explain filename paths (#147)
  * lint-history: explain how TMPDIR can be used (#147)

* Miscellaneous:
  * lots of fixes for running the testsuite Windows (#231)
  * add a GitHub workflow for continuous integration (#167)
  * add a reusable test runner script (#205)



Changes since v2.29.0 are as follows:

Elijah Newren (12):
      filter-repo: fix --use-mailmap
      lint-history: fix binary blob detection
      t9390: add a testcase for --path-rename with no colon
      filter-repo: improve invalid repository error message
      filter-repo: avoid depending on `wc` binary being present
      README.md: link to external formatting of user manual
      git-filter-repo.txt: add some clarifications around replace refs
      git-filter-repo.txt: link to GitHub docs on purging old history
      bfg-ish: add some sanity checks on the specified repo
      lint-history: explain filename paths
      lint-history: explain how TMPDIR can be used
      INSTALL.md: reference dscho's excellent python on git-for-windows fix=
es

Johannes Schindelin (14):
      Ignore the generated Python cache
      Test data and scripts must have Unix line endings
      t9390: use the correct prereq when using "funny" file names
      t9390: expect the correct line count in `--strip-blobs-with-ids`
      t9390: close link of broken &&-chain
      t9390: avoid using Bash-ism `<(...)`
      t9390: avoid using `colrm`
      t9390: work around clash with MSYS2's Unix<->Win32 path conversion
      t9390: work around yet another Unix<->Win32 path issue
      t9391: don't rely on the system gitconfig defining core.autocrlf=3Dfa=
lse
      t9391: guard `dos2unix` use behind a prereq
      Add a GitHub workflow to test this thing
      Fix the Python path on Windows
      lint-history: do decode bytes

Lassi Kortela (1):
      Fix bug in --path-rename argument without colon

Shezan Baig (1):
      Allow callback body to be loaded from a file

Stefano Rivera (3):
      Break the actual test runner into its own script
      Exit non-zero if the tests fail
      Share implementation with github workflow

=E6=9E=97=E5=8D=9A=E4=BB=81(Buo-ren Lin) (1):
      Fix relative path compatibility for --replace-text and bfg_args.repo
