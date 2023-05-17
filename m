Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D07C7EE22
	for <git@archiver.kernel.org>; Wed, 17 May 2023 23:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEQX4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 19:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEQX4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 19:56:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648813AA2
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:56:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba88ec544ddso811216276.1
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684367794; x=1686959794;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o/Sj4GArNF/SZJmKGEU2zY3hbH1bdZiadnbfVyt+HWE=;
        b=0RlNDt1gLl7oeeOWzeLQ9FOU9l22CoQpIVKhnNaL0E9NWNq/XJiwkNJm9KIVxhteBY
         N3uKlIuCe6JdYjLlL+XycyPSvIrgwYRmDbUWO8W0OGu8AAoE1aBPhPUlAg2/8IKHGD4U
         CMMJi/Vkx5ABC6ZLkgjBrOWVfaRBaunUT6mkVR/iewYPlgpfV7BGOCrQblUR85vrQ6UL
         XVwNJuP5bzdQtxxBjeerIZeHowqB7eAmLPIR7kXVLwJP5Hi4bfxYRQLn+GYO7wUJVStY
         Yxoffd1rsZkJDjdOylzQgxCvb/3I6szUrF4O7zqEa/VHr1V5r8gWYV09P9Uz2ffs6t7a
         pzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684367794; x=1686959794;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/Sj4GArNF/SZJmKGEU2zY3hbH1bdZiadnbfVyt+HWE=;
        b=RVbQbZzTqhTqAp9nqb7wQCLnZO8ICKazrVoTDI7epaxj37AVaF/OegYA3nEfqLHAWb
         bBygL8EanCf6DQ/0qQGSZerjPxqTnteoYITxxPxJzEtzdUXXbScYf7wKCCXYuSWhHKX5
         RvjOTqwRNXlBIleS7hF/ld6qiuURtAPOic4zupBDjolQnBObm3464Loy0v/WhA5VHuxX
         nlDNoUsWiZABxYSJISuS+TDKLdNTmlYxT7ltEr6T/KCD4C74WTBA9wrKXEzU25jE3w96
         f9KzyPmzr4R5nhznolqD4sD/KWD42L94WifxOjJa+/E1/3PzYKE4nVwhfiRkN8Br+YEl
         eBuQ==
X-Gm-Message-State: AC+VfDywXgC/BlQQNyCWDokm6bxc/ouOYRdxTUGgFsV21tLJQpkEtCDe
        dztOTmARBzM/UEvzctQi+N+cw2iMnuoO+TAaSo59pWkZSBE3G+PtbKrnK/et/qGe848ADCME+5P
        kfBRrSzVurWqG141OIKzIDFdKEcbB26pynTShdCM2IgIvSiYFVLtv2U3J9R3SN4Q=
X-Google-Smtp-Source: ACHHUZ5zmEwhNq0c1y/bcpIgqNt2k01bJrfHCoj7AAEdiUui0X7C49juri02dwJrzNibAdhIik9QSDf2Swz84A==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:f597:a1b7:3c54:2bc8])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1504:b0:ba8:939b:6574 with SMTP
 id q4-20020a056902150400b00ba8939b6574mr422938ybu.12.1684367794494; Wed, 17
 May 2023 16:56:34 -0700 (PDT)
Date:   Wed, 17 May 2023 16:56:30 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK5pZWQC/x2NQQqDQAwAvyI5N7BuK7a9FnxAr9JDXGPNwa0kq
 xTEv3ftcRiG2cBYhQ3uxQbKq5h8YgZ/KiCMFN+M0mcG7/zZVWWNS5SEiS0Zrh5vl6FyVIfQXwl y05ExdkoxjEc1kSXWQ8zKg3z/oxaezQNe+/4DANVBL30AAAA=
X-Mailer: b4 0.12.2
Message-ID: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
Subject: [PATCH RFC v2 0/4] Add an external testing library for unit tests
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, calvinwan@gmail.com,
        szeder.dev@gmail.com, phillip.wood123@gmail.com,
        chooglen@google.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net, Calvin Wan <calvinwan@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our current testing environment, we spend a significant amount of
effort crafting end-to-end tests for error conditions that could easily
be captured by unit tests (or we simply forgo some hard-to-setup and
rare error conditions). Unit tests additionally provide stability to the
codebase and can simplify debugging through isolation. Turning parts of
Git into libraries[1] gives us the ability to run unit tests on the
libraries and to write unit tests in C. Writing unit tests in pure C,
rather than with our current shell/test-tool helper setup, simplifies
test setup, simplifies passing data around (no shell-isms required), and
reduces testing runtime by not spawning a separate process for every
test invocation.

Unit testing in C requires a separate testing harness that we ideally
would like to be TAP-style and to come with a non-restrictive license.
Fortunately, there already exists a C TAP harness library[2] with an MIT
license (at least for the files included in this series). Phillip Wood
has also proposed an alternative implementation[3]. I have not had a
chance to review that patch in much detail, but I have hopefully made
the Makefile integration here somewhat pluggable so that we can easily
switch to his version if it proves superior. For now, I have continued
with the C TAP library.

The first patch is a small cleanup to allow linking common_exit()
separately from common-main.o. In the second patch, I've added a rough
draft project plan listing some goals. Patch 3 adds the C TAP libraries.
Patch 4 is a modified version of Calvin's previous implemenation with
better integration to our Makefiles.

[1] https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com/
[2] https://github.com/rra/c-tap-harness/
[3]: https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Calvin Wan (1):
      Add C TAP harness

Josh Steadmon (3):
      common-main: split common_exit() into a new file
      unit tests: Add a project plan document
      unit test: add basic example and build rules

 .gitignore                             |    2 +
 Documentation/Makefile                 |    1 +
 Documentation/technical/unit-tests.txt |   47 +
 Makefile                               |   25 +-
 common-exit.c                          |   26 +
 common-main.c                          |   24 -
 t/Makefile                             |   10 +
 t/runtests.c                           | 1789 ++++++++++++++++++++++++++++++++
 t/strbuf-test.c                        |   54 +
 t/tap/basic.c                          | 1029 ++++++++++++++++++
 t/tap/basic.h                          |  198 ++++
 t/tap/macros.h                         |  109 ++
 12 files changed, 3289 insertions(+), 25 deletions(-)
---
base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
change-id: 20230517-unit-tests-v2-94f50a7ccd8a

Best regards,
-- 
Josh Steadmon <steadmon@google.com>

