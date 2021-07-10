Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50480C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 23:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B9E61360
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 23:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGJXtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGJXtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 19:49:18 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E763AC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 16:46:31 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so14007962otl.3
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 16:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qk8aEfSOmUY9mcrSgAVuYOzj+mF2fmhE6S4qbeLgtiU=;
        b=sihMwfFYxrZJhbisE71cBRHFzAoSElVa9OFzBIUYbqvYR3AK/HfQmn6cz8c1BS7ibB
         8UnL85vNnCNX1BSHqbinkNL4eyRLaPUyUps/YMNF0z4sSFEBjvwR27+rN0YBfr3lG1TA
         00MfnIcpW9Faz+lh5AarESa9+WzJwyNrjN0sTn1nJwNpVj+f6xl9n1/r/5ma7+6zgP2/
         3om29d0Ah1Bsqyh//8rHUcJ9WlwaTZ2R2nM+AL5cONcoJ+GG9BPSDPFzgk9ZIEqNMRb3
         VFGWbSfDgRVVHd5IoQ9lw6ZhaN+xhJzzWsn3VKWbPfarSgt/VQd+JwIddWfde/8bdg2k
         Y9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qk8aEfSOmUY9mcrSgAVuYOzj+mF2fmhE6S4qbeLgtiU=;
        b=p+Kz3uo4Z49ckVkIQ4IDt10R3cx4ux0IYHlNf3lVHriC1x4AopXsk/C6lk0j6Y3HIK
         +7tIL/pTS8BsxO+jjEK5DCaaAbRySVUt9DlZPua3yKYySYNVxHyDHvyY2hoLgZfOG4e9
         Zt6OcvwJUvWM5hnIXrVSJ+YV12l1ac441pAr4Yfkq/djprm8sZ+MyvtD9R0dF6LjXbE5
         npqDrfCrMhq8zQOLNWhiF4dh/0fLRlcwRi2T31m0loLxcNym8vcodL5nQWc2Wecmgfcb
         sMGjiNuIBaKy50eYlCTtjXYWBpHrkViK0XzO0UHURYNTokJWR6qyXoIk3ybuy1csI12H
         XHPg==
X-Gm-Message-State: AOAM530VVBzdSFl3bGAprdxuBrL54giKVro0jkYAZoytMvJCRHqOr5Jt
        B9FJ2QIFX2mYf836l1+JxrIxaA8EoFQ=
X-Google-Smtp-Source: ABdhPJyWl0RkiyUNRaxvsXFLWdTxWBrnZ+VyxuXKho50B6T9T3VpJrtahvlBNnifwmU8oCkSNYE/qQ==
X-Received: by 2002:a9d:7008:: with SMTP id k8mr6681243otj.61.1625960790923;
        Sat, 10 Jul 2021 16:46:30 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id y61sm2049722ota.31.2021.07.10.16.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 16:46:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] extra: new concept of extra components
Date:   Sat, 10 Jul 2021 18:46:27 -0500
Message-Id: <20210710234629.17197-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces the concept of extra components. These are
components which are not yet part of the core but are good enough for
distributions to ship, and in fact, they already do.

This benefits everyone:

 1. Distribution packagers that just want to do `make install`
 2. People who download git's source code and just want to do
    `make install`
 3. Developers who have no idea what's production-level quality in
    contrib/ and just want to do `make install`.

For now they'll have to do `make install install-extra`. But if the
result is deemed correct, we might choose to add "install-extra" to the
"install" target.

The measuring stick I'm using to gauge if a component in contrib belongs
in extra is simple: are we already running tests for them with
'make test'? If the answer is "yes, we do run tests", then the answer is
"yes, it belongs in contrib".

We might want to move more components from contrib to extra once their
tests are being run reliably.

And we might move some components from the core which aren't really part
of the core to extra, like gitk, git-gui, git-p4, and git-svn.

For now only contrib/completion and contrib/workdir are graduated to the
new area.

Since v1 I removed extra/Makefile in favor having the targets in the
top-level Makfile as Ævar suggested.

Felipe Contreras (2):
  completion: graduate out of contrib
  git-new-workdir: graduate out of contrib

 Makefile                                          | 13 +++++++++++++
 {contrib => extra}/completion/git-completion.bash |  0
 {contrib => extra}/completion/git-completion.zsh  |  0
 {contrib => extra}/completion/git-prompt.sh       |  0
 {contrib => extra}/workdir/.gitattributes         |  0
 {contrib => extra}/workdir/git-new-workdir        |  0
 t/t1021-rerere-in-workdir.sh                      |  6 +++---
 t/t3000-ls-files-others.sh                        |  2 +-
 t/t9902-completion.sh                             |  8 ++++----
 t/t9903-bash-prompt.sh                            |  2 +-
 10 files changed, 22 insertions(+), 9 deletions(-)
 rename {contrib => extra}/completion/git-completion.bash (100%)
 rename {contrib => extra}/completion/git-completion.zsh (100%)
 rename {contrib => extra}/completion/git-prompt.sh (100%)
 rename {contrib => extra}/workdir/.gitattributes (100%)
 rename {contrib => extra}/workdir/git-new-workdir (100%)

Range-diff against v1:
1:  3a2c2402af ! 1:  3f44bc3253 completion: graduate out of contrib
    @@ Commit message
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Makefile ##
    +@@ Makefile: sharedir = $(prefix)/share
    + gitwebdir = $(sharedir)/gitweb
    + perllibdir = $(sharedir)/perl5
    + localedir = $(sharedir)/locale
    ++bashcompdir = $(sharedir)/bash-completion/completions
    + template_dir = share/git-core/templates
    + htmldir = $(prefix)/share/doc/git-doc
    + ETC_GITCONFIG = $(sysconfdir)/gitconfig
    +@@ Makefile: bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
    + mandir_SQ = $(subst ','\'',$(mandir))
    + mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
    + infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
    ++sharedir_SQ = $(subst ','\'',$(sharedir))
    + perllibdir_SQ = $(subst ','\'',$(perllibdir))
    + localedir_SQ = $(subst ','\'',$(localedir))
    + localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
    +@@ Makefile: htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
    + prefix_SQ = $(subst ','\'',$(prefix))
    + perllibdir_relative_SQ = $(subst ','\'',$(perllibdir_relative))
    + gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
    ++bashcompdir_SQ = $(subst ','\'',$(bashcompdir))
    + 
    + SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
    + TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
     @@ Makefile: quick-install-man:
      quick-install-html:
      	$(MAKE) -C Documentation quick-install-html
      
    -+install-extra:
    -+	$(MAKE) -C extra install
    ++install-extra: install-completion
    ++
    ++install-completion:
    ++	$(INSTALL) -D -m 644 extra/completion/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
    ++	$(INSTALL) -D -m 644 extra/completion/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
    ++	$(INSTALL) -D -m 644 extra/completion/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
     +
      
      
      ### Maintainer's dist rules
     
    - ## extra/Makefile (new) ##
    -@@
    -+bashcompdir = $(sharedir)/bash-completion/completions
    -+
    -+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
    -+sharedir_SQ = $(subst ','\'',$(sharedir))
    -+bashcompdir_SQ = $(subst ','\'',$(bashcompdir))
    -+gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
    -+
    -+INSTALL ?= install
    -+
    -+all:
    -+
    -+install: install-completion
    -+
    -+install-completion:
    -+	$(INSTALL) -D -m 644 completion/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
    -+	$(INSTALL) -D -m 644 completion/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
    -+	$(INSTALL) -D -m 644 completion/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
    -
      ## contrib/completion/git-completion.bash => extra/completion/git-completion.bash ##
     
      ## contrib/completion/git-completion.zsh => extra/completion/git-completion.zsh ##
2:  81836329cd ! 2:  af9b24eeb1 git-new-workdir: graduate out of contrib
    @@ Commit message
     
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
    - ## extra/Makefile ##
    -@@ extra/Makefile: INSTALL ?= install
    + ## Makefile ##
    +@@ Makefile: quick-install-man:
    + quick-install-html:
    + 	$(MAKE) -C Documentation quick-install-html
      
    - all:
    - 
    --install: install-completion
    -+install: install-completion install-workdir
    +-install-extra: install-completion
    ++install-extra: install-completion install-workdir
      
      install-completion:
    - 	$(INSTALL) -D -m 644 completion/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
    - 	$(INSTALL) -D -m 644 completion/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
    - 	$(INSTALL) -D -m 644 completion/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
    -+
    + 	$(INSTALL) -D -m 644 extra/completion/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
    + 	$(INSTALL) -D -m 644 extra/completion/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
    + 	$(INSTALL) -D -m 644 extra/completion/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
    + 
     +install-workdir:
    -+	$(INSTALL) -D workdir/git-new-workdir '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/git-new-workdir
    ++	$(INSTALL) -D extra/workdir/git-new-workdir '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/git-new-workdir
    ++
    + 
    + 
    + ### Maintainer's dist rules
     
      ## contrib/workdir/.gitattributes => extra/workdir/.gitattributes ##
     
-- 
2.32.0.36.g70aac2b1aa

