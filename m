Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546EEC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D59B61370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhGNU0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhGNU0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:26:41 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44FCC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 13:23:48 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so3857730otl.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 13:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtuLQTHjvI/OzIGxO7bH5adP4dfN1Bnrk4O7VJVwSTc=;
        b=fWf3qkTTt6JkP3wmPrXkzoBaOPTJ7eSC/vhsUdQxC5lhcrgd6snxuwCUEx9cR3bpLA
         m1sOuG/2emM1UXjTsjOfea4RTo6goyBu8Eofye4gSFGtuVcxmOPSfpRQhOL0r737othn
         zR4eC9XwfqTDWhIxd6/rgruQ1wgRlBmpmVKNUhd+6FGIQBi4G5PBbRkib3d1nkCE8Hae
         kFH0WghFBZONvEadp8wus0NekV+QN91VkaRSJE0F54iB4Nlb48/QRSBAVYzeUiu6xapp
         dgIG3/eANfzMYh4byIf3QQBauXk8EchILY6JvHpNFF9pz9RQcTwabp+r0EuLA+52lbv2
         FdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtuLQTHjvI/OzIGxO7bH5adP4dfN1Bnrk4O7VJVwSTc=;
        b=rSKbOkBzENBfTzYIiDF3AjxqRJkO0b0+AJRA8AYvvbGAEncQWdYRMZNzYhRaXxEHFE
         0kgKOe2h2CrD1RX96IQJ0v3IJya0Dab2OpTTNZ0L6MJBZEhCNroxBOjibkwBkb3VEane
         CneSC18VEC8cjdmcJVUCuvMuUocSgrpDyArBrE06Lsxe9gZSCpyX5MKn+/VvEGW2UHGd
         dWZK9Z/89dGRTYoKi1gE+Xu6ex5SnVk9mOfqbDdCxMVi3OoaJMCszD3HuW/YMNSWHFRO
         HGBGbMJWf88ZMkRImIVIUuf1E/Bj06wNbCW305DVCO4g0aLB+5Xwl7kScTePxrybcW/E
         /1EQ==
X-Gm-Message-State: AOAM532NRbQEnEsAeWAVCSX1UC3aCKuRon85hlTnKEItrIU9FwBLufGt
        iu8x0sZmntPZozawX65bNUV39RcXarg=
X-Google-Smtp-Source: ABdhPJxK7l2W/SJKLLwNSzSh/xwpU2nihlSWCUMj7xqupFDdjuZgC6+X59Coyc9ZNcxEaxlO9oQabw==
X-Received: by 2002:a9d:1b05:: with SMTP id l5mr9448006otl.335.1626294228049;
        Wed, 14 Jul 2021 13:23:48 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id x29sm601963ooj.10.2021.07.14.13.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:23:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/1] completion: graduate out of contrib
Date:   Wed, 14 Jul 2021 15:23:44 -0500
Message-Id: <20210714202344.614468-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.38.g1d70fa854e
In-Reply-To: <20210714202344.614468-1-felipe.contreras@gmail.com>
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
 <20210714202344.614468-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These have been stable and widely used for quite a long time, they even
have tests outside of the contrib area, and most distributions ship
them, so they can be considered part of the core already.

We should be consistent and either we move the tests to contrib, or we
move the completions out of contrib.

Let's move them out of contrib and provide an installation target
install-extra.

By default bash-completion installs the completions to
$(pkgdatadir)/completions, which is
$(prefix)/share/bash-completion/completions. And since most distributions do
not change this, it is obviously the right default that distributions
can override with bashcompdir.

By default zsh looks for completions in
$(prefix)/share/zsh/site-functions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile                                          | 10 ++++++++++
 {contrib => extra}/completion/git-completion.bash |  0
 {contrib => extra}/completion/git-completion.zsh  |  0
 {contrib => extra}/completion/git-prompt.sh       |  0
 t/t9902-completion.sh                             |  8 ++++----
 t/t9903-bash-prompt.sh                            |  2 +-
 6 files changed, 15 insertions(+), 5 deletions(-)
 rename {contrib => extra}/completion/git-completion.bash (100%)
 rename {contrib => extra}/completion/git-completion.zsh (100%)
 rename {contrib => extra}/completion/git-prompt.sh (100%)

diff --git a/Makefile b/Makefile
index 502e0c9a81..0a13e5f077 100644
--- a/Makefile
+++ b/Makefile
@@ -532,6 +532,7 @@ sharedir = $(prefix)/share
 gitwebdir = $(sharedir)/gitweb
 perllibdir = $(sharedir)/perl5
 localedir = $(sharedir)/locale
+bashcompdir = $(sharedir)/bash-completion/completions
 template_dir = share/git-core/templates
 htmldir = $(prefix)/share/doc/git-doc
 ETC_GITCONFIG = $(sysconfdir)/gitconfig
@@ -2015,6 +2016,7 @@ bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_SQ = $(subst ','\'',$(mandir))
 mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
+sharedir_SQ = $(subst ','\'',$(sharedir))
 perllibdir_SQ = $(subst ','\'',$(perllibdir))
 localedir_SQ = $(subst ','\'',$(localedir))
 localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
@@ -2025,6 +2027,7 @@ htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
 perllibdir_relative_SQ = $(subst ','\'',$(perllibdir_relative))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
+bashcompdir_SQ = $(subst ','\'',$(bashcompdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
@@ -3112,6 +3115,13 @@ quick-install-man:
 quick-install-html:
 	$(MAKE) -C Documentation quick-install-html
 
+install-extra: install-completion
+
+install-completion:
+	$(INSTALL) -D -m 644 extra/completion/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
+	$(INSTALL) -D -m 644 extra/completion/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
+	$(INSTALL) -D -m 644 extra/completion/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
+
 
 
 ### Maintainer's dist rules
diff --git a/contrib/completion/git-completion.bash b/extra/completion/git-completion.bash
similarity index 100%
rename from contrib/completion/git-completion.bash
rename to extra/completion/git-completion.bash
diff --git a/contrib/completion/git-completion.zsh b/extra/completion/git-completion.zsh
similarity index 100%
rename from contrib/completion/git-completion.zsh
rename to extra/completion/git-completion.zsh
diff --git a/contrib/completion/git-prompt.sh b/extra/completion/git-prompt.sh
similarity index 100%
rename from contrib/completion/git-prompt.sh
rename to extra/completion/git-prompt.sh
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cb057ef161..32601b755d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -36,7 +36,7 @@ complete ()
 GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr rebase ls-files'
 GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 
-. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
+. "$GIT_BUILD_DIR/extra/completion/git-completion.bash"
 
 # We don't need this function to actually join words or do anything special.
 # Also, it's cleaner to avoid touching bash's internal completion variables.
@@ -2383,14 +2383,14 @@ test_expect_success 'git clone --config= - value' '
 test_expect_success 'sourcing the completion script clears cached commands' '
 	__git_compute_all_commands &&
 	verbose test -n "$__git_all_commands" &&
-	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
 	verbose test -z "$__git_all_commands"
 '
 
 test_expect_success 'sourcing the completion script clears cached merge strategies' '
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&
-	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
 	verbose test -z "$__git_merge_strategies"
 '
 
@@ -2399,7 +2399,7 @@ test_expect_success 'sourcing the completion script clears cached --options' '
 	verbose test -n "$__gitcomp_builtin_checkout" &&
 	__gitcomp_builtin notes_edit &&
 	verbose test -n "$__gitcomp_builtin_notes_edit" &&
-	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
 	verbose test -z "$__gitcomp_builtin_checkout" &&
 	verbose test -z "$__gitcomp_builtin_notes_edit"
 '
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index bbd513bab0..784e523fd4 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-bash.sh
 
-. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
+. "$GIT_BUILD_DIR/extra/completion/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
 c_red='\\[\\e[31m\\]'
-- 
2.32.0.38.g1d70fa854e

