Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393A9C6FA8E
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 14:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjB1O7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjB1O7m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 09:59:42 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1957D166C6
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:59:37 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bm20so8231270oib.7
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUVlhejAkM4GoHflnTRD/iN8RZs1JbTpaTwnS6iblz0=;
        b=BVIwbuHc33Dp10Z/Lq/MBSCdT3rKq4t70y8wFgv1e6tM7cCefMGf0J91b22wA5J+jQ
         rJ+yy2N2x8rQxrVRchTmGmKLPKEbUUrPK6BqsA4L8QVS1nNq1YwEWHFMuEyjgrh4i5sx
         r+vUOlrnWd/upuXn0Obj7KFDXhsdaxwiXMIn5Eday7jW4QhiOOc2IW+QbMYKYwqljYrt
         rTWYPEtXkEA9jgL/C2OydCG6Hb1CIQzKf7Ceye9zwj/bi92IOWS4SJLj9HdALAyCwSDH
         PXEo5FRzsYNjCxLZ2YRKo06WBS5G2FKQdHXNyL9yUrxodFvlNbY81KPdQC4g87yLJ9AD
         9riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUVlhejAkM4GoHflnTRD/iN8RZs1JbTpaTwnS6iblz0=;
        b=vJwp7MU6TDxyHXi3gQb/T4y1i9p1gUV4qBba+RjO0UTTDnNUAOMhjpkXMY2Wd3K+oL
         qN54COKS4Rcuw0UZ2sOWR61rHzBVHkXoXJf+duEbok1i/j1brlRdc3UsVaXj1LtUJ7Gn
         svUGACI5zIPPt8+KG3gL3PU92dG1Gnr3DmV8J6AQ2oVb74MT/NcEJV4Fi9TjtdmNpiLp
         RhZjByDLeVIU9LwMS/vyqTkHa9fyB1xc/JMFL9UF6zCym4lmHr3FTnMDy7kGcR4M8Rks
         edO2+gmMzu21G9I/nrGyHWl1Awp7JRdrBd0NkoN1zigtLfNJ85kWhKJ2w98utoVAqhUw
         WYoQ==
X-Gm-Message-State: AO0yUKXWwVEnssTVMeSXKxicoRHf0ZL9RJlzAJVpmtP5W9/tPMPpMFZs
        AddZmBCNEaLSgW3kofwjGymP3sDJKbU=
X-Google-Smtp-Source: AK7set/0MWGh0RuSWwu2elgcilMhOQSOb4Lf1Sy4gq5YfJUpZqiVonUycyhdHp5JIvRw072UpL3TRQ==
X-Received: by 2002:aca:1c03:0:b0:383:f55f:76d9 with SMTP id c3-20020aca1c03000000b00383f55f76d9mr1200957oic.31.1677596376073;
        Tue, 28 Feb 2023 06:59:36 -0800 (PST)
Received: from localhost ([2806:2f0:4060:3465:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w129-20020aca6287000000b00383bfd8a184sm4486611oib.25.2023.02.28.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:59:35 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Joakim Petersen <joak-pet@online.no>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2] completion: prompt: use generic colors
Date:   Tue, 28 Feb 2023 08:59:34 -0600
Message-Id: <20230228145934.4182166-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the prompt command mode was introduced in 1bfc51ac81 (Allow
__git_ps1 to be used in PROMPT_COMMAND, 2012-10-10) the assumption was
that it was necessary in order to properly add colors to PS1 in bash,
but this wasn't true.

It's true that the \[ \] markers add the information needed to properly
calculate the width of the prompt, and they have to be added directly to
PS1, a function returning them doesn't work.

But that is because bash coverts the \[ \] markers in PS1 to \001 \002,
which is what readline ultimately needs in order to calculate the width.

We don't need bash to do this conversion, we can use \001 \002
ourselves, and then the prompt command mode is not necessary to display
colors.

This is what functions returning colors are supposed to do [1].

[1] http://mywiki.wooledge.org/BashFAQ/053

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 19 +++++++------------
 t/t9903-bash-prompt.sh           |  8 ++++----
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 57972c2845..76ee4ab1e5 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -100,9 +100,7 @@
 #
 # If you would like a colored hint about the current dirty state, set
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
-# the colored output of "git status -sb" and are available only when
-# using __git_ps1 for PROMPT_COMMAND or precmd in Bash,
-# but always available in Zsh.
+# the colored output of "git status -sb".
 #
 # If you would like __git_ps1 to do nothing in the case when the current
 # directory is set up to be ignored by git, then set
@@ -259,12 +257,12 @@ __git_ps1_colorize_gitstring ()
 		local c_lblue='%F{blue}'
 		local c_clear='%f'
 	else
-		# Using \[ and \] around colors is necessary to prevent
+		# Using \001 and \002 around colors is necessary to prevent
 		# issues with command line editing/browsing/completion!
-		local c_red='\[\e[31m\]'
-		local c_green='\[\e[32m\]'
-		local c_lblue='\[\e[1;34m\]'
-		local c_clear='\[\e[0m\]'
+		local c_red=$'\001\e[31m\002'
+		local c_green=$'\001\e[32m\002'
+		local c_lblue=$'\001\e[1;34m\002'
+		local c_clear=$'\001\e[0m\002'
 	fi
 	local bad_color=$c_red
 	local ok_color=$c_green
@@ -574,11 +572,8 @@ __git_ps1 ()
 		b="\${__git_ps1_branch_name}"
 	fi
 
-	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
 	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
-			__git_ps1_colorize_gitstring
-		fi
+		__git_ps1_colorize_gitstring
 	fi
 
 	local f="$h$w$i$s$u$p"
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index d459fae655..d667dda654 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -13,10 +13,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
-c_red='\\[\\e[31m\\]'
-c_green='\\[\\e[32m\\]'
-c_lblue='\\[\\e[1;34m\\]'
-c_clear='\\[\\e[0m\\]'
+c_red='\001\e[31m\002'
+c_green='\001\e[32m\002'
+c_lblue='\001\e[1;34m\002'
+c_clear='\001\e[0m\002'
 
 test_expect_success 'setup for prompt tests' '
 	git init otherrepo &&
-- 
2.39.2

