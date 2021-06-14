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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD9AC48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8300D61283
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhFNEiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 00:38:14 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39510 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhFNEiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 00:38:14 -0400
Received: by mail-oi1-f170.google.com with SMTP id m137so13091170oig.6
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mj7l7sgW83TyvYXZvUOI7p02FijEOH8JesSKjL4fhW4=;
        b=SHidLSSFbR7M5S9uU0y7sMbMiUCHthUdZp0z7Qi9fhEF7li1p48lCNP65CeC4p5IkI
         5jgoQLjZTMhAbGlH2Dlgdw4QujorQRiJwnoJyZJ/45yIz+4qe21f1QlnaUTqbse1XIXA
         w7BMIMCy3MKgMUlvOBADANGTqfZ0TVn00qjbgEX5tkA+qGc9bzSMM8PCYiw7LAAYUY0X
         aXbIRXvhHNWMTnugn9H0SkacEYep2KEvbLRblih2xr/38iR+SUkax3rCGTzI4C8eB53n
         +dgM+yVSD7t/V0XUk+EF4iGEeHtt3h3mLldw+E1h5ogDkdEyriDP4RAIz9zY2rmAgmp6
         BXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mj7l7sgW83TyvYXZvUOI7p02FijEOH8JesSKjL4fhW4=;
        b=dCw8Maku8NSlzTa1/Z2RdXFG7NkihgkV0jAm6B/lIY7VHfP8GWMtoLUAOYgy2LcUU3
         ow7aGXTRNLF5NEB6t4/iSZmlRT1blQd2y3IlD24U+lQogq+ucpkeYbBfqtzjb+R8rQs1
         15wfsJ34IvxRqLsh+qqZ7MDmyojz495RKCkiUWy7gu7g1Ndh+2a9hB7dxH7aZ9SFpcDV
         pZVxwaaWTHQzGHn1YQ4RhRHaddipCZXEPIY/dPOsS5oZJVPu3PCmAb+FjmB7UgcCBay+
         pL2nqC4e7+LfdTkrxbeQ6FxKw1jYJjLfuPGVRqN/d0Xo1bMTrVODsluFGRpXqsVKtYsi
         zd2g==
X-Gm-Message-State: AOAM531BQiiiz+6SY/xo0ATtYUh5kxhW8KEu+R6dUaVWeQoaeao3o+S8
        t77d6qypluAzHep5UmmsOGpzpjTzKrNESg==
X-Google-Smtp-Source: ABdhPJybbB6CQ0Jjlf+4ZgmRRhMNUHhkneCTQmOkZw3f25yOD8EaalYOMdhuAEmGkoqFV3WSEgTiuA==
X-Received: by 2002:aca:c349:: with SMTP id t70mr15198238oif.153.1623645295792;
        Sun, 13 Jun 2021 21:34:55 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l18sm3021110otr.50.2021.06.13.21.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 21:34:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] git-new-workdir: graduate out of contrib
Date:   Sun, 13 Jun 2021 23:34:50 -0500
Message-Id: <20210614043450.1047571-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614043450.1047571-1-felipe.contreras@gmail.com>
References: <20210614043450.1047571-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 extra/Makefile                             | 5 ++++-
 {contrib => extra}/workdir/.gitattributes  | 0
 {contrib => extra}/workdir/git-new-workdir | 0
 t/t1021-rerere-in-workdir.sh               | 6 +++---
 t/t3000-ls-files-others.sh                 | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)
 rename {contrib => extra}/workdir/.gitattributes (100%)
 rename {contrib => extra}/workdir/git-new-workdir (100%)

diff --git a/extra/Makefile b/extra/Makefile
index 26d8be55b0..66a1cdcdf4 100644
--- a/extra/Makefile
+++ b/extra/Makefile
@@ -9,9 +9,12 @@ INSTALL ?= install
 
 all:
 
-install: install-completion
+install: install-completion install-workdir
 
 install-completion:
 	$(INSTALL) -D -m 644 completion/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
 	$(INSTALL) -D -m 644 completion/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
 	$(INSTALL) -D -m 644 completion/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
+
+install-workdir:
+	$(INSTALL) -D workdir/git-new-workdir '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/git-new-workdir
diff --git a/contrib/workdir/.gitattributes b/extra/workdir/.gitattributes
similarity index 100%
rename from contrib/workdir/.gitattributes
rename to extra/workdir/.gitattributes
diff --git a/contrib/workdir/git-new-workdir b/extra/workdir/git-new-workdir
similarity index 100%
rename from contrib/workdir/git-new-workdir
rename to extra/workdir/git-new-workdir
diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
index 0b892894eb..035a92c0e7 100755
--- a/t/t1021-rerere-in-workdir.sh
+++ b/t/t1021-rerere-in-workdir.sh
@@ -27,7 +27,7 @@ test_expect_success SYMLINKS setup '
 
 test_expect_success SYMLINKS 'rerere in workdir' '
 	rm -rf .git/rr-cache &&
-	"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" . work &&
+	"$SHELL_PATH" "$TEST_DIRECTORY/../extra/workdir/git-new-workdir" . work &&
 	(
 		cd work &&
 		test_must_fail git merge side &&
@@ -38,12 +38,12 @@ test_expect_success SYMLINKS 'rerere in workdir' '
 '
 
 # This fails because we don't resolve relative symlink in mkdir_in_gitdir()
-# For the purpose of helping contrib/workdir/git-new-workdir users, we do not
+# For the purpose of helping extra/workdir/git-new-workdir users, we do not
 # have to support relative symlinks, but it might be nicer to make this work
 # with a relative symbolic link someday.
 test_expect_failure SYMLINKS 'rerere in workdir (relative)' '
 	rm -rf .git/rr-cache &&
-	"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" . krow &&
+	"$SHELL_PATH" "$TEST_DIRECTORY/../extra/workdir/git-new-workdir" . krow &&
 	(
 		cd krow &&
 		rm -f .git/rr-cache &&
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 740ce56eab..86240a1b98 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -84,7 +84,7 @@ test_expect_success SYMLINKS 'ls-files --others with symlinked submodule' '
 	) &&
 	(
 		cd super &&
-		"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" ../sub sub &&
+		"$SHELL_PATH" "$TEST_DIRECTORY/../extra/workdir/git-new-workdir" ../sub sub &&
 		git ls-files --others --exclude-standard >../actual
 	) &&
 	echo sub/ >expect &&
-- 
2.32.0

