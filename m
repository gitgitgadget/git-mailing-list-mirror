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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659B4C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3692E61004
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhFNEhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 00:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhFNEhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 00:37:02 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6AC061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 21:34:53 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h9so13048248oih.4
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 21:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1B8e6v7e2V8HqgBe/7TmVxPXTAspkCTfSIUCbceIX/A=;
        b=JFVdaXQMthrCq1uMn0i3vUYuHbYu4AMNCZsPypVBTyh4n9YPnrC4i1o9sOLEzK9cEr
         j+Hh+8fS8KBjwaoTviG9XK+f1HmbS9nKfKAd/W7qkZMpwFKVsVvpZ0hf5rPIMKAeI6k+
         TCyx5ETDncX3ZYoWC8NPIP6sxW+fgzjhGQ2XlfwD6pJ/Wy6CVNN5/AqB9QEICS+sbgJ+
         K3majaKwp/RlyG3OpraFCSVAZz8okZa0Ni0hl6J9Ttr4xmpNbj1LSSKQdMp0w3xpxcLk
         C7slFGXyBSVdMOY3GFWnPX8aI+t+CSdiepxWrehtX35efsBortLNalDfPyEF6NqhBfOK
         OK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1B8e6v7e2V8HqgBe/7TmVxPXTAspkCTfSIUCbceIX/A=;
        b=Yozm7ssyCj+eFtRxfDosecdl6ooq7wXwHzjeTxx7bXvoS3hnlX0QLL105IPMiBvTam
         r6bLata8PG4IVknQ4MtI2phSxsT2+X5G7t42YPr1kgRhQZAmZ7f1M1EgDLY6OR2afJLi
         4mbC/rJCZqsOezIyw+oDAd7LfIxGGLCMUSg8cfx+s27ZVGXrRRA+46XiDCDwyp0vXgjl
         8hXk2nhPaDR2IN3DQBpHmy7kX2Jf+UKxP2UDz6ULBwz8oups1WqoxJ0k4e649PmOmRzu
         nhvZatIY8qUK/8Rul2awYE/ERe8q61deqBuA1UVYsabA52A0SMdgw9qV5uKQFD7Ao4Oq
         i7bQ==
X-Gm-Message-State: AOAM533uIWYA18KMEI+ExxIh+Ej+OXebsLjCvagIV2CeAluv7B6gOgQh
        vUoKI1B0sUquDfxAg17sf5KSDVeo8/Qd0g==
X-Google-Smtp-Source: ABdhPJwMfAKuFbYwTlJvbNCD9Uv2mAfRX9vFTIak/W7tgogOPIdXoPPzESMYJ/7Z/zSeUT6O6mHofQ==
X-Received: by 2002:aca:a9c9:: with SMTP id s192mr9400119oie.130.1623645292852;
        Sun, 13 Jun 2021 21:34:52 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t26sm3122203oth.14.2021.06.13.21.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 21:34:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] extra: new concept of extra components
Date:   Sun, 13 Jun 2021 23:34:48 -0500
Message-Id: <20210614043450.1047571-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces the concept of extra components. These are
components which are not yet part of the core but are good enough for
distributions to ship, and in fact, they already do.

The measuring stick I'm using to gauge if a component in contrib belongs
in extra is simple: are we already running tests for them with
'make test'?

We might want to move more components from contrib to extra once their
tests are being run reliably.

And we might move some components from the core which aren't realy part
of the core to extra, like gitk, git-gui, git-p4, and git-svn.

For now only contrib/completion and contrib/workdir are graduated to the
new area.

Felipe Contreras (2):
  completion: graduate out of contrib
  git-new-workdir: graduate out of contrib

 Makefile                                      |  3 +++
 extra/Makefile                                | 20 +++++++++++++++++++
 .../completion/git-completion.bash            |  0
 .../completion/git-completion.zsh             |  0
 {contrib => extra}/completion/git-prompt.sh   |  0
 {contrib => extra}/workdir/.gitattributes     |  0
 {contrib => extra}/workdir/git-new-workdir    |  0
 t/t1021-rerere-in-workdir.sh                  |  6 +++---
 t/t3000-ls-files-others.sh                    |  2 +-
 t/t9902-completion.sh                         |  8 ++++----
 t/t9903-bash-prompt.sh                        |  2 +-
 11 files changed, 32 insertions(+), 9 deletions(-)
 create mode 100644 extra/Makefile
 rename {contrib => extra}/completion/git-completion.bash (100%)
 rename {contrib => extra}/completion/git-completion.zsh (100%)
 rename {contrib => extra}/completion/git-prompt.sh (100%)
 rename {contrib => extra}/workdir/.gitattributes (100%)
 rename {contrib => extra}/workdir/git-new-workdir (100%)

-- 
2.32.0

