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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB68C07E9B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 23:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567F66135E
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 23:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGJXtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhGJXtV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 19:49:21 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF515C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 16:46:34 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id z18-20020a9d7a520000b02904b28bda1885so12538799otm.7
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 16:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WtjW3A6qHhK+rbarHegKpZad+8Nqg2O0uDtswf5/gis=;
        b=Ye0ZqkU3XxXTUzCK16MUFj/wYOFpCWzj7sIiCfWrP0VxBJogH6UPyY46E9XS27DkFh
         fvqujAuuayDpuArj36jTu6ObOw2OpM71zLxHFmTOe0kfDrhqEz/K8I5IYrzh92GY8oId
         uWDqLAIKXx2reHX+8p9QSJ7pr7hhuQNnuBtYA57ZQf4H3uoUHydhOAo9SGsC04XR/Fh1
         GmLUczReSKQOGK+DnBMGOx2mepB2l+4vYgKB1MOHZvQiXPtH76YUrWchuWko7CySZarF
         D+rg4w823MT3AvTpu8IqbTLS52N0FkqaR7g6C38/7D8wJTAZHheIdlSrn3XdAMFaHgmt
         Q2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WtjW3A6qHhK+rbarHegKpZad+8Nqg2O0uDtswf5/gis=;
        b=YqJ4CVI2CM95g1yDsTuJSmtpXIalG70SgGRhplLxPzX6I9detbpyPeKj/6dLn4EUja
         EBqyJh+FVbVQnnmvtAE04H9aOcDc5JQVRAHy3N4hv/CoOjl/Zt2R6VXsJQyIITkLCjfh
         /P4GB/fwa7Mlwg3hKO3/icJkR+mDbSrEnW5bnX3Ydd4Z+WEpeL50t4IZiE9FmDodVDyC
         zU8czmJzfdcC4r4XY9PjrwvtaNgHKj4jSl7TsEN9Vg6GiBdPVB1tduBTjPa3igo81zu2
         12+qp8eQx8Eh2Ja6Kg5qcUv2umXvHdyptiwgaG+UriO2S/cielvcHAqxp+uKOJLapZpP
         E98w==
X-Gm-Message-State: AOAM530zQheeL3NqyqKRkg5SiI/RqZbo4oGABKdUz5sk5qaeYJhNILGp
        VV5TzxXRgAl975IHgoBWRvdAsShw5Wg=
X-Google-Smtp-Source: ABdhPJxk1K/ZY1WnTCEMgFPLaEQSyOmBRBOlwsQTMgDTCifx5JvHKMqLST63sn8K+P941lADYNBZbQ==
X-Received: by 2002:a05:6830:9:: with SMTP id c9mr19344otp.294.1625960794166;
        Sat, 10 Jul 2021 16:46:34 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id f20sm2067294otq.35.2021.07.10.16.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 16:46:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] git-new-workdir: graduate out of contrib
Date:   Sat, 10 Jul 2021 18:46:29 -0500
Message-Id: <20210710234629.17197-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210710234629.17197-1-felipe.contreras@gmail.com>
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile                                   | 5 ++++-
 {contrib => extra}/workdir/.gitattributes  | 0
 {contrib => extra}/workdir/git-new-workdir | 0
 t/t1021-rerere-in-workdir.sh               | 6 +++---
 t/t3000-ls-files-others.sh                 | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)
 rename {contrib => extra}/workdir/.gitattributes (100%)
 rename {contrib => extra}/workdir/git-new-workdir (100%)

diff --git a/Makefile b/Makefile
index 0a13e5f077..a03387f8d1 100644
--- a/Makefile
+++ b/Makefile
@@ -3115,13 +3115,16 @@ quick-install-man:
 quick-install-html:
 	$(MAKE) -C Documentation quick-install-html
 
-install-extra: install-completion
+install-extra: install-completion install-workdir
 
 install-completion:
 	$(INSTALL) -D -m 644 extra/completion/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
 	$(INSTALL) -D -m 644 extra/completion/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
 	$(INSTALL) -D -m 644 extra/completion/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
 
+install-workdir:
+	$(INSTALL) -D extra/workdir/git-new-workdir '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'/git-new-workdir
+
 
 
 ### Maintainer's dist rules
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
2.32.0.36.g70aac2b1aa

