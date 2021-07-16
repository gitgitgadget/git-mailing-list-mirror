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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE9CC636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 20:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A043613F6
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 20:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhGPUR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 16:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhGPURZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 16:17:25 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A17C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 13:14:29 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u11so12330683oiv.1
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VtsAUmk10HA4Od1XEQW+6+pts8cVrih9YZMjDWvW8sM=;
        b=N4OCjgPr/ieQg4Q0NR0l//7ymEt5KkP27t4IJg1E6WOOZjcJFedestI7DEMo0V4l40
         lE2zAFw2vmHKFaWpA3QGd2M06UtYv3zVevXvHEjao+1vbLAiu3D/b2bKO8cqWPvT0Sqe
         mCBQEAQYqYcBruwOx+1kJRgkHnTKw21/jEkiiHpj9RIzhiVjbfkt+9m3D8NIemKPALxJ
         1em9Q0QuKm938c2EbqMZs4gUmMOD+QgS5GoRYfeF13YE2zFAGEuDoal49++I99s+Zb+d
         TMqVEtyJvRyn5Km08jrr2poZhP6tppVd9TJ4XapEniS3PyyJu4AE5pfvlXtgqYWHwZ7R
         Hqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtsAUmk10HA4Od1XEQW+6+pts8cVrih9YZMjDWvW8sM=;
        b=ry+8OSPo8nCF3lFtK872RV7XEXjWkbjFVh17uSBFJuh34o6g+5iq/xL3gvhHGhNyPz
         ZIbEaWCrkC9i2uStNFy9EZ6wvIgVtHeKgM+uVcnvtquj3TQ2kAHPOOtpgwTU2MU37wpY
         WZlYeru0ahaDuTllsEpY7rYOJSgu50Y/LX/nK4UwYO6v4fI6tuUfbp548zvHqq8PRW3d
         sSx+fe9kVjhOaK/BASGIbaMjtpeClhD90yFtxT338GQfQXzXjnOHK/lguOntp9WjS4PH
         U6/v7CZERa0oapZ/eSKg/Nlo8728Gx/2AVpijgrwFlD1MBZEnH15tMoyYuVfw4j+NgSQ
         0rMg==
X-Gm-Message-State: AOAM5318qsohtGWIXaq4Ll1jWuDDICpTDREqoT2+RRcVpStB18FKIWLt
        VzoUgiM8YUh9E/48VC9KVJYkGb+DObJPWg==
X-Google-Smtp-Source: ABdhPJzQbAQlcUklMKmVoYGhYO0Ny7jhLrAG83k6bC/FdpijQKQJqV7SDqUDHrtJwNNAT/bLcra1bg==
X-Received: by 2002:a54:459a:: with SMTP id z26mr294077oib.91.1626466469008;
        Fri, 16 Jul 2021 13:14:29 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id 186sm2284859oid.12.2021.07.16.13.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:14:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/1] extra: new concept of extra components
Date:   Fri, 16 Jul 2021 15:14:26 -0500
Message-Id: <20210716201427.4482-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210710234629.17197-1-felipe.contreras@gmail.com>
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces the concept of extra components. These are
components which are not yet part of the core, but are good enough for
distributions to ship, and in fact: they already do.

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
"yes, it belongs in extra".

We might want to move more components from contrib to extra once their
tests are being run reliably.

And we might move some components from the core which aren't really part
of the core to extra, like gitk, git-gui, git-p4, and git-svn.

For now only part of contrib/completion is graduated to the new area.

Since v3 I added .PHONY to the new targets as Ævar Arnfjörð suggetsed,
and also added a bit for the explanation of extra from the cover letter
to the commit message.

Felipe Contreras (1):
  completion: graduate out of contrib

 Makefile                                          | 11 +++++++++++
 {contrib => extra}/completion/git-completion.bash |  0
 {contrib => extra}/completion/git-completion.zsh  |  0
 {contrib => extra}/completion/git-prompt.sh       |  0
 t/t9902-completion.sh                             |  8 ++++----
 t/t9903-bash-prompt.sh                            |  2 +-
 6 files changed, 16 insertions(+), 5 deletions(-)
 rename {contrib => extra}/completion/git-completion.bash (100%)
 rename {contrib => extra}/completion/git-completion.zsh (100%)
 rename {contrib => extra}/completion/git-prompt.sh (100%)

Range-diff against v3:
1:  3f44bc3253 ! 1:  07eb614ef7 completion: graduate out of contrib
    @@ Commit message
         move the completions out of contrib.
     
         Let's move them out of contrib and provide an installation target
    -    install-extra.
    +    install-extra which be a convenient target for package maintainers and
    +    other people who install git themselves.
    +
    +    The measuring stick for what belongs in "extra" is simple: are we
    +    already running tests for them with 'make test'? Currently only
    +    part of completions fit that bill, but others could be added later.
     
         By default bash-completion installs the completions to
         $(pkgdatadir)/completions, which is
    -    $(prefix)/share/bash-completion/completions. And since most distributions do
    -    not change this, it is obviously the right default that distributions
    -    can override with bashcompdir.
    +    $(prefix)/share/bash-completion/completions. And since most
    +    distributions do not change this, it is obviously the right default that
    +    distributions can override with bashcompdir.
     
         By default zsh looks for completions in
         $(prefix)/share/zsh/site-functions.
    @@ Makefile: htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
      
      SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
      TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
    +@@ Makefile: endif
    + 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
    + 
    + .PHONY: install-gitweb install-doc install-man install-man-perl install-html install-info install-pdf
    ++.PHONY: install-extra install-completion
    + .PHONY: quick-install-doc quick-install-man quick-install-html
    + install-gitweb:
    + 	$(MAKE) -C gitweb install
     @@ Makefile: quick-install-man:
      quick-install-html:
      	$(MAKE) -C Documentation quick-install-html
-- 
2.32.0.40.gb9b36f9b52

