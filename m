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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E2BC48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9378F613AB
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhFNEhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 00:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhFNEhK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 00:37:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C25DC061756
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 21:34:55 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so7283492ott.1
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7ZSuW9x9OmNV7z5Ql8p19f7S8Lv2OqDgczi6ChLIpE=;
        b=UoaNo0OKgIQqFoMgIc2AF0Q1+jZ2RTVKiYEnqbvWjxHmMRUGhOCcD1JSaF3/b/EVGX
         ScIFjc3kkrMtL/fJPeA8CK+5mqlhr+w6EgvQp6YJQCYRj86yuR+wjKc7Ilee0xMr3sKm
         QcS12je8/tjCDChDOR1ulbWlE6Tnd7kW2YExE5AdYy2O+ISZeXcYSHPvqaJLODr1o5l+
         rSRfJWhHfr8sElYxF8s4xtqa2TPKbARZL8ylEORByxU0dmgwaQKD7w2aaaj6fSxTIBAf
         E7G8sjXli5OKDzpquTxP9D0UobTdisuZwziNiIdMkqbv7Rze23Cvcvi05lJeQVr81hiu
         /b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7ZSuW9x9OmNV7z5Ql8p19f7S8Lv2OqDgczi6ChLIpE=;
        b=l2IK6eUS3PuNZgHnp0Iq4QOeZyhkzKicSSAKnnSgqihyGH23ARrFcQsx5g9ZJumcZy
         ob4rmRXE5SCKMDPYFPYFpX4jF14Z/TKjFKfe/8RVRLCM3+SKRkY+hn4G2BTJgcjaF9JQ
         5b11rIXVFwEM1Vfc1Eonqj+S/fUQF//D144HGEiIWWjdncXeRE8HDpShlU9+J+XQxtxB
         jQ85AIoMsQqjg/WoQOahCsgnbrzWQq7SM0uFEbdAP0vIPaM/kFkEWjkfP3IHLvCxTVcf
         fuRxvphff81mXNJSkalACWSVdw3djv4uUHCl+FQIXSv9EqGP5ysRIa8FZid9Dei+yk1E
         jlRA==
X-Gm-Message-State: AOAM531dfrd5um0MtMGyIqZGztvhmT4f8+cytn8fXiK/js7M0Il3X3LM
        FAghKKPj0r/YW6E13hm1PmxBhmn9M1VTyQ==
X-Google-Smtp-Source: ABdhPJwhW62p2ZhWUQHN3hc5GMYpX0Scee2w2539ObMb74icyqz+NPblhSFOneZ+0cpoTejuElLMAQ==
X-Received: by 2002:a9d:5a15:: with SMTP id v21mr12378109oth.112.1623645294341;
        Sun, 13 Jun 2021 21:34:54 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n127sm2699345oif.55.2021.06.13.21.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 21:34:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] completion: graduate out of contrib
Date:   Sun, 13 Jun 2021 23:34:49 -0500
Message-Id: <20210614043450.1047571-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614043450.1047571-1-felipe.contreras@gmail.com>
References: <20210614043450.1047571-1-felipe.contreras@gmail.com>
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
 Makefile                                        |  3 +++
 extra/Makefile                                  | 17 +++++++++++++++++
 .../completion/git-completion.bash              |  0
 .../completion/git-completion.zsh               |  0
 {contrib => extra}/completion/git-prompt.sh     |  0
 t/t9902-completion.sh                           |  8 ++++----
 t/t9903-bash-prompt.sh                          |  2 +-
 7 files changed, 25 insertions(+), 5 deletions(-)
 create mode 100644 extra/Makefile
 rename {contrib => extra}/completion/git-completion.bash (100%)
 rename {contrib => extra}/completion/git-completion.zsh (100%)
 rename {contrib => extra}/completion/git-prompt.sh (100%)

diff --git a/Makefile b/Makefile
index c3565fc0f8..5bb03808b3 100644
--- a/Makefile
+++ b/Makefile
@@ -3105,6 +3105,9 @@ quick-install-man:
 quick-install-html:
 	$(MAKE) -C Documentation quick-install-html
 
+install-extra:
+	$(MAKE) -C extra install
+
 
 
 ### Maintainer's dist rules
diff --git a/extra/Makefile b/extra/Makefile
new file mode 100644
index 0000000000..26d8be55b0
--- /dev/null
+++ b/extra/Makefile
@@ -0,0 +1,17 @@
+bashcompdir = $(sharedir)/bash-completion/completions
+
+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+sharedir_SQ = $(subst ','\'',$(sharedir))
+bashcompdir_SQ = $(subst ','\'',$(bashcompdir))
+gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
+
+INSTALL ?= install
+
+all:
+
+install: install-completion
+
+install-completion:
+	$(INSTALL) -D -m 644 completion/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
+	$(INSTALL) -D -m 644 completion/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
+	$(INSTALL) -D -m 644 completion/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
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
2.32.0

