Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB118ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiH3Jbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH3Jbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:31:42 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416D99D104
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:41 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11ee4649dfcso8936217fac.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0p0yhdqzJ+DUMqNSkqhhOWIzL5d0e1NpTS7d+SWboX8=;
        b=Kax+QodR9ZOdom0KvOIRkWsbX7A9+0pxVvPnbMUX298mcLRBDLEvwii73LJqWe48Vy
         fcXLiVUnpWuHQ0YoxBAvtMZXPkyy+3qOnybBy0bxViwwxf5eVl5+sIfiilBMwyiMAkDr
         HZimnAnq2DTB2aG7m0+ZqIId0n0LNcYQy81GQ8Y3CyiIsyuzc5XACE0khQi8pVgwlaQ5
         PrPh9KiybIfXJxeZfjVeeSoU752QIgR/0N8HDl2ZnIx7OfECw8qMzY9vzKFu0DXQP0Lp
         r+B6ZIBLLwUbXFYGLXR2+rUdStpS7rMHHpEaOyrG9cTfmLUqXHJSX1Vovf4KXogdgyYE
         7dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0p0yhdqzJ+DUMqNSkqhhOWIzL5d0e1NpTS7d+SWboX8=;
        b=7cqdiOL9KMuJ0ukrEoWbtW2IXVAVT6J94AbP8EiET6Jje6OcEPlFJs3F3dJ4yzIhwT
         p8bcVwG7hFVJRvw84Ivl0NhTz7gkJqvtDNDjbSOK400dNCiMBeKJXtEtTkLXQ9QCDKoo
         Zp4oJFEMONBeyXaUwlvkIjPOWnnphsb0DBv8lLs5u1EZlhlt8/7AsiMsTGdwqFfF14Q6
         qwQX5rWDNyH7rUB56CqaJWTAP0bk9ydrwN2X8GOlnhLGk+TONZF1mFOc18P96J5oUfwj
         WY/wJz00tQSwEjC0xtjYPHTQnquk0SmZmnxKPIZvtSbKwIJB7m4qK/nrxadViwx702vP
         ZwGw==
X-Gm-Message-State: ACgBeo2v5yDtljIVR70SU0EARO9+Iwiai5g4zjltvyVBTMF3FQ4McpK0
        VujoSuFIH1hsbf++kSedpnqvpCzfU3E=
X-Google-Smtp-Source: AA6agR6dphAQTWnBd0X9EDI7eJfexWvNuVAtdtljI77Om5HMbJDQrwdTlGkGywxRJ61flBpNc2nldA==
X-Received: by 2002:a05:6808:1495:b0:344:c442:6ca1 with SMTP id e21-20020a056808149500b00344c4426ca1mr8859650oiw.80.1661851900332;
        Tue, 30 Aug 2022 02:31:40 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q17-20020a9d6551000000b006370c0e5be0sm7189660otl.48.2022.08.30.02.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/51] completion: revamp
Date:   Tue, 30 Aug 2022 04:30:47 -0500
Message-Id: <20220830093138.1581538-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series revamps the completion code to git-completion 1.4.

I used to send this series minimizing the delta to git upstream in order
to maximize the chances of it being merged, but it has not received any
feedback since the first time it was sent in 2020 [1], so it is safe to
say upstream has zero interest in getting this merged. It makes no sense
for me to do extra work to maximize the chances of something that will
never happen.

Therefore this series starts with the most intrusive change:
zsh completion tests.

For several years git-completion has been running zsh completion tests
to make sure everything works correctly, not only for bash, but also for
zsh.

The zsh code delta between upstream and git-completion results in 14
tests now passing. The new patch series makes that clear now.

Here's a summary of the differences between upstream and git-completion:

 * Fixed alias regression
 * Make tests work when user has configured GIT_PS1_* variables
 * Enable colors in bash without prompt command
 * Fix suboptions for zsh
 * Fix COMP_WORDBREAKS handling
 * Fix main option handling for zsh
 * Fix -C handling for zsh
 * Fix -c handling for zsh
 * Fix generic completions for zsh
 * Fix configurations with value for zsh (e1e00089da)
 * Fix option relationships for zsh
 * Add improved removable suffix for zsh
 * Plenty of reorganizations and cleanups

For more information check [2].

Cheers.

[1] https://lore.kernel.org/git/20201110212136.870769-1-felipe.contreras@gmail.com/
[2] https://github.com/felipec/git-completion

Felipe Contreras (50):
  test: completion add test for __git_cmd_idx
  test: add zsh completion tests
  completion: fix __git_cmd_idx regression for zsh
  completion: bash: trivial cleanup
  completion: zsh: add higher-priority location
  zsh: simplify realpath dirname idiom
  test: reset environment variables
  completion: prompt: use generic colors
  completion: fix for suboptions with value
  completion: zsh: trivial improvement
  completion: bash: do not modify COMP_WORDBREAKS
  test: completion: fix currently typed words
  test: completion: switch __gitcomp_nl prefix test
  test: completion: add run_func() helper
  completion: bash: remove non-append functionality
  completion: bash: get rid of _append() functions
  completion: bash: get rid of any non-append code
  completion: zsh: fix options with arguments
  completion: zsh: expand --git-dir file argument
  completion: zsh: add support for general -C opts
  completion: zsh: fix for undefined completions
  completion: zsh: add support for general -c opts
  completion: zsh: fix extra space on foo=
  completion: zsh: add excluded options
  completion: zsh: always set compset
  completion: factor out check in __gitcomp
  completion: simplify equal suffix check
  completion: refactor __gitcomp
  completion: simplify __gitcomp
  completion: bash: change suffix check in __gitcomp
  completion: improve __gitcomp suffix code
  test: completion: add missing test
  completion: bash: simplify config_variable_name
  completion: bash: improve __gitcomp description
  completion: add __gitcomp_opts
  completion: bash: cleanup __gitcomp* invocations
  completion: bash: shuffle __gitcomp functions
  completion: zsh: simplify __gitcomp_direct
  completion: zsh: shuffle __gitcomp* functions
  completion: zsh: fix direct quoting
  completion: zsh: add elements individually in __gitcomp_opts
  completion: zsh: add __gitcompadd helper
  completion: zsh: add correct removable suffix
  completion: bash: simplify _get_comp_words_by_ref()
  completion: bash: refactor _get_comp_words_by_ref()
  completion: bash: cleanup _get_comp_words_by_ref()
  completion: bash: trivial cleanup
  completion: bash: rename _get_comp_words_by_ref()
  zsh: remove version
  completion: bash: trivial grammar fix

Michael Bianco (1):
  zsh: resolve symlink of script

 contrib/completion/git-completion.bash |  637 ++++++-------
 contrib/completion/git-completion.zsh  |  146 ++-
 contrib/completion/git-prompt.sh       |   19 +-
 t/t9902-completion.sh                  |  159 ++--
 t/t9903-bash-prompt.sh                 |   16 +-
 t/t9904-zsh-completion.sh              | 1137 ++++++++++++++++++++++++
 t/t9904/.gitignore                     |    1 +
 t/t9904/.zshrc                         |   50 ++
 t/t9904/_git                           |    1 +
 t/t9904/completion                     |   11 +
 10 files changed, 1649 insertions(+), 528 deletions(-)
 create mode 100755 t/t9904-zsh-completion.sh
 create mode 100644 t/t9904/.gitignore
 create mode 100644 t/t9904/.zshrc
 create mode 120000 t/t9904/_git
 create mode 100755 t/t9904/completion

-- 
2.37.2.351.g9bf691b78c.dirty

