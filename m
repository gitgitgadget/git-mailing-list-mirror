Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C7BECAAD3
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 08:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiIGI1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGI1O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 04:27:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA41AA2A8A
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 01:27:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t14so11861064wrx.8
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3hSh8/gGA8XNq9huZNCQP/4kRs+H1iLYwkNE6FQL3Wg=;
        b=Tyc2v2VNna7g0bH32iCQ0ccBAO2KUk9YIOBJqPL7Cu+jx8kirrSAJmvi6TkM6n/y6O
         vCJPIte5AiDoSaL9cV4KDcHPIdhvNix/Dwo34YIaK00ygfUG3onwhXYy5D8gpKXOWJ15
         phPIUJ1ZpAxTq6F0HISY8B5f0LfarMwlxrXNjQt56ZHoEEHyLfoGcz3ee5Z3/ajSBhNA
         vJi9MTAj67Sc9ISjhZ8/sRpQxJyhosL153u526Z2xGqD3wkmf7EEbZJwO70R7YlfFL7r
         wBH5Arty8n09vhnX+0A9bEhqOQYmpYITq/tWG5vATjW7ehkt0tzm5qYvC24TulTY63kp
         ifKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3hSh8/gGA8XNq9huZNCQP/4kRs+H1iLYwkNE6FQL3Wg=;
        b=NZ+NfiVVsKvliDPSFZ/5aFITLbHWRFlzj5bgX7eM9//1oLqLUu+t2DUmEAWsmgxVWq
         1JTDEe75OGR4dewmlXpNJZBZZIZoDPvokdE9ybrDFwz4FYzZ6WLdKDRQvtsFHigqZ5rY
         VdUP/8zrDINCA0N39/xOAgkgO+zlmTVPiwBadjMYT5+CZ8NDHVLdZk5V59/fpSFkbSIF
         ookbU17o2HnKkTAP+yNx807PLypp/n7DJ5XU6gxiBGIvdJARwx3N//jBRHq4vvQ7HCzE
         Ds1xdV9mCQFuOAKA929FUrpqD1R3iOo5JlGnXO/WDO5ync5bTUj+legLNzlfwYPWGNsK
         xeNw==
X-Gm-Message-State: ACgBeo2dd9gws5GeKcxbgvr+mFht1DTbRN906ZAJS4JqQ1u1lXD+fWs4
        ibUgZfCgacLry+yea6+XidHJEJsI+u8=
X-Google-Smtp-Source: AA6agR4+S9+5+ApjIkJmVEsPSNF0X7z2PAqNQktIo/JbKrdIwMwWU72T06Faiiq4TAnGVLNb1jEyOg==
X-Received: by 2002:a5d:6f0c:0:b0:226:eda7:ee93 with SMTP id ay12-20020a5d6f0c000000b00226eda7ee93mr1320829wrb.657.1662539231622;
        Wed, 07 Sep 2022 01:27:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a3170a7af9sm19532096wmq.4.2022.09.07.01.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:27:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/9] docs: de-duplicate sections, add more CONFIGURATION sections
Date:   Wed,  7 Sep 2022 10:26:56 +0200
Message-Id: <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1490.g9adf4224da0
In-Reply-To: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series:

 * De-duplicates and combines configuration discussion that was split
   or spread across Documentation/config/*.txt and
   Documentation/git-*.txt, moving it to Documentation/config/*.txt.

 * Includes that relevant Documentation/config/*.txt in the
   Documentation/git-*.txt files.

 * Introduces and uses included prose for those "CONFIGURATION"
   sections in various Documentation/git-*.txt files, informing the
   reader that what they see there is included from "git-config(1)".

This v4 addresses the feedback from Matheus Tavares on v3 (thanks for
the review!): A hunk belonged in 9/9, not 8/9 (init's config is used
by e.g. "clone" too). The end-state at the end of this series is
exactly the same.

1. https://lore.kernel.org/git/CAHd-oW4QpPBUqo5ToWXtBg7-LHbEam7aqSALSrwaA3OABma8ng@mail.gmail.com/

Ævar Arnfjörð Bjarmason (9):
  docs: add and use include template for config/* includes
  grep docs: de-duplicate configuration sections
  send-email docs: de-duplicate configuration sections
  apply docs: de-duplicate configuration sections
  notes docs: de-duplicate and combine configuration sections
  difftool docs: de-duplicate configuration sections
  log docs: de-duplicate configuration sections
  docs: add CONFIGURATION sections that map to a built-in
  docs: add CONFIGURATION sections that fuzzy map to built-ins

 Documentation/Makefile                        |  1 +
 Documentation/config/diff.txt                 | 15 -----
 Documentation/config/difftool.txt             | 28 +++++++++-
 Documentation/config/grep.txt                 |  7 ++-
 Documentation/config/log.txt                  |  4 ++
 Documentation/config/notes.txt                | 43 +++++++++------
 Documentation/config/sendemail.txt            | 40 +++++++++++++-
 Documentation/git-add.txt                     |  7 +++
 Documentation/git-am.txt                      |  7 +++
 Documentation/git-apply.txt                   | 10 +---
 Documentation/git-blame.txt                   |  6 ++
 Documentation/git-branch.txt                  |  4 ++
 Documentation/git-checkout.txt                |  7 +++
 Documentation/git-clean.txt                   |  7 +++
 Documentation/git-clone.txt                   |  9 +++
 Documentation/git-column.txt                  |  7 +++
 Documentation/git-commit-graph.txt            |  7 +++
 Documentation/git-commit.txt                  |  4 ++
 Documentation/git-diff.txt                    |  7 +++
 Documentation/git-difftool.txt                | 27 ++-------
 Documentation/git-fast-import.txt             |  7 +++
 Documentation/git-fetch.txt                   |  7 +++
 Documentation/git-fsck.txt                    |  2 +
 Documentation/git-gc.txt                      |  3 +-
 Documentation/git-grep.txt                    | 29 +---------
 Documentation/git-imap-send.txt               |  2 +
 Documentation/git-init.txt                    |  7 +++
 Documentation/git-log.txt                     | 46 ++--------------
 Documentation/git-mailinfo.txt                |  7 +++
 Documentation/git-maintenance.txt             |  7 +++
 Documentation/git-merge.txt                   |  5 +-
 Documentation/git-mergetool.txt               |  3 +
 Documentation/git-notes.txt                   | 55 ++-----------------
 Documentation/git-push.txt                    |  7 +++
 Documentation/git-rebase.txt                  |  2 +
 Documentation/git-revert.txt                  |  7 +++
 Documentation/git-send-email.txt              | 36 +-----------
 Documentation/git-show-branch.txt             |  7 +++
 Documentation/git-stash.txt                   |  7 +++
 Documentation/git-switch.txt                  |  7 +++
 .../includes/cmd-config-section-all.txt       |  3 +
 .../includes/cmd-config-section-rest.txt      |  3 +
 42 files changed, 280 insertions(+), 226 deletions(-)
 create mode 100644 Documentation/includes/cmd-config-section-all.txt
 create mode 100644 Documentation/includes/cmd-config-section-rest.txt

Range-diff against v3:
 1:  da21c19978c =  1:  ddcae390002 docs: add and use include template for config/* includes
 2:  d16e927caa2 =  2:  e5ad838e1d7 grep docs: de-duplicate configuration sections
 3:  c36feb6f35a =  3:  f73c148a06e send-email docs: de-duplicate configuration sections
 4:  5707c9dd635 =  4:  5523095fe7e apply docs: de-duplicate configuration sections
 5:  5b0ea00aa33 =  5:  9f1b90298d8 notes docs: de-duplicate and combine configuration sections
 6:  c4c3fa14190 =  6:  73e6804db13 difftool docs: de-duplicate configuration sections
 7:  e07585ba085 =  7:  6465a98ec0a log docs: de-duplicate configuration sections
 8:  af912e9ca65 !  8:  929fd693bdf docs: add CONFIGURATION sections that map to a built-in
    @@ Documentation/git-fast-import.txt: operator can use this facility to peek at the
      --------
      linkgit:git-fast-export[1]
     
    - ## Documentation/git-init.txt ##
    -@@ Documentation/git-init.txt: $ git commit    <3>
    - <2> Add all existing files to the index.
    - <3> Record the pristine state as the first commit in the history.
    - 
    -+CONFIGURATION
    -+-------------
    -+
    -+include::includes/cmd-config-section-all.txt[]
    -+
    -+include::config/init.txt[]
    -+
    - GIT
    - ---
    - Part of the linkgit:git[1] suite
    -
      ## Documentation/git-mailinfo.txt ##
     @@ Documentation/git-mailinfo.txt: If no such configuration option has been set, `warn` will be used.
      <patch>::
 9:  5ef36654bba !  9:  738ee46512d docs: add CONFIGURATION sections that fuzzy map to built-ins
    @@ Documentation/git-fetch.txt: linkgit:git-gc[1]).
      ----
      Using --recurse-submodules can only fetch new commits in submodules that are
     
    + ## Documentation/git-init.txt ##
    +@@ Documentation/git-init.txt: $ git commit    <3>
    + <2> Add all existing files to the index.
    + <3> Record the pristine state as the first commit in the history.
    + 
    ++CONFIGURATION
    ++-------------
    ++
    ++include::includes/cmd-config-section-all.txt[]
    ++
    ++include::config/init.txt[]
    ++
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
    +
      ## Documentation/git-switch.txt ##
     @@ Documentation/git-switch.txt: always create a new name for it (without switching away):
      $ git switch -c good-surprises
-- 
2.37.3.1490.g9adf4224da0

