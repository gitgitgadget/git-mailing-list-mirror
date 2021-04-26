Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7980AC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CED6105A
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhDZQPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhDZQPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:15:45 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD0C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:04 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r3so3552685oic.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+mgh52gyb4RLq3youZf/Zwj9vRdYVZ3BfAvCDZ230I=;
        b=Ng2bNYEBGXrHkOsm55WA6HWmhJ+9Z9GnL55pgAOfMKDRyiy3QUdoPd1qcALlZ8s7v0
         dcMCHSOAl7+8cnTuCIlCQF7myPa6Tz9oQfBqhCg7sY893zA+ZNLvtTGIfctveLmCh5QK
         1Sxjzowig7auHtMPlqN/c/CfHaCF0c4TZNVraRjwnvwXeBwDfpt5BXQksPZ8BZxvJXo7
         3oP987Fd7VEq20zqx6ZE0bMlQlqBzx0GzB2ZI7TFc0yevfieMwyETG4jksa7f3s4/J+y
         zx7vuWFrMTPUk9iqw2r9nq6pG6vtyTE7RX+cn+iBiA6nNrFEkkc4ev7ml1Sl/7BpIU12
         U8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+mgh52gyb4RLq3youZf/Zwj9vRdYVZ3BfAvCDZ230I=;
        b=HOKPE0PH2AUG0Ao5ZpunbEYKBKcu5Vgyf2VIJCMjg1eQHhyGCDkf8BcKUbsdNkBWnh
         DtqjgPsZ1Tv03qUeIVAO0XhXT1RImgA4QkPIQzMEMNvdulBr8jrm5Vy+nSJhrbjItNZa
         ADDTzeNNNDsNFOKCW7KfJ4rDaByixKPv/ZYhGUKFmZCtLHOWy11JdHt+3lEqIluYBk/h
         QOr84MBhp8jNdLQr5Xx9Y35BuOF+A2rMRbqLguvdRFldv6eq9n/lyOoyLFDcgtMXutuH
         a5eFxZwJjBLl1FG646FpMFrcm07NpmuECofzZ9gXNJpdk9SiE51bHpXuNNSg139RCfOm
         i5UA==
X-Gm-Message-State: AOAM530yfkDGw+DW/I3+4tJNTL8MI+1BwGFOY8V02WF2xxKe9YTMLhXp
        XbA9oKmB3fYmeTxP853h4J/87He/8X2Ypw==
X-Google-Smtp-Source: ABdhPJy3BFrBIKTiCtIkeUeEiiALQ3sqIuZCfDJ5vh5XfFeW2W84Mfrd03xyLecHFZEUYwPNlQzdRw==
X-Received: by 2002:aca:eb55:: with SMTP id j82mr12071030oih.93.1619453703213;
        Mon, 26 Apr 2021 09:15:03 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id p64sm3122410oib.57.2021.04.26.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 00/43] completion: git-completion 1.3.1 patches
Date:   Mon, 26 Apr 2021 11:14:15 -0500
Message-Id: <20210426161458.49860-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches represent what comprises git-completion 1.3.1, a friendly
fork I'm maintaining.

Some of these have already been sent, and should be in "seen", but for
some reason they are not [1]. Others have been sent, but probably won't
receive any review soon.

Since the patches for git-completion 1.3.0 the only differece is a
rebase on top of v2.31.0.

Cheers.

[1] https://lore.kernel.org/git/5fea87e816fff_23821208d4@natae.notmuch/

Felipe Contreras (43):
  completion: bash: fix prefix detection in branch.*
  completion: fix for suboptions with value
  completion: bash: fix for multiple dash commands
  completion: bash: add correct suffix in variables
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
  completion: bash: simplify config_variable_name
  test: completion: add missing test
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
  completion: zsh: add higher-priority location

 contrib/completion/git-completion.bash | 654 +++++++++++--------------
 contrib/completion/git-completion.zsh  | 133 +++--
 t/t9902-completion.sh                  | 159 +++---
 3 files changed, 438 insertions(+), 508 deletions(-)

-- 
2.31.0

