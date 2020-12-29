Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB577C433E6
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 17:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C64122225
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgL2RJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 12:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2RJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 12:09:27 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E2C061798
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 09:08:47 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 15so15225934oix.8
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 09:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzyrYwUzR99rlHvRQUbf4IquxyYXFyP02eQV6zlQddI=;
        b=R1N9NAzlvV0QQZGoMw9GsPknXGhqydr6hT6pMhuByFtoIvn3dF9wy92q+ZtQ4pE5N4
         m+moKZ4KiUBUSorbwg6CHyHOibbElMIyrQ/uZAwZJ6gRPRktv8mETz2Ub3mZrGVjssa1
         SWVcEu+P4cep4GpNxAzDrRhYhjjCa4ngQbS898NaJzwzOMIzcfGd5QO7m8eNW5EBmuuw
         sMaZF0WN4O2eewkTJwMm/SaXOckQkI/qTMT2sOr4pJLFj3FCaHL57Z3mgMjvSTTtNcPQ
         r/sYF5xDM4/nkXZP72ko/+1DO7FZ/71nwsOgZzSYLMRJkRnQ85TrNA553lib2Mjkbfq2
         4bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzyrYwUzR99rlHvRQUbf4IquxyYXFyP02eQV6zlQddI=;
        b=XUFjUNrDeNjUGJ7G/4LUEID9abDxdZljFG+u1yyCs4CduvpAzjpMhAgTBkvkPO2W8Q
         d6hSCZ5+5ww9uMX9fjIoBUi+a8Ycl4Tc3dsbRYMu+K0C3E26hvorx9eec4sgq718yucN
         wHDmGGqooz8RCwZ9vGJpu3z8lyPSbdivrzE3G4+uN1xVpGbwyAG3L8PZpdEMOB7xakv4
         sAsyT1VFl1v8xRTq0umJPv2QxNCAUs9u0aUBJTkftJzu2vKnhxU4IBVQm2p7ngjlr479
         ZBo4gfG2ADjKjC8drkS6RJGqe4BvkzRNpqLhpFFpsgrHr9Mefk4aZOalfTdrYWQA76W9
         cEQQ==
X-Gm-Message-State: AOAM530TIfmbfiJkNZ7/bz27OJWXBZ+8NTlg9f8lo0YOb7vreohHSBbL
        3jj22y1gb2LDSuy4LtmrL0iDosBhLcUFOQ==
X-Google-Smtp-Source: ABdhPJx3L4mnzoSibYgv1f14fuOeLle2J1Ts8DRa/BkfO65g5OGXO3mFiZwXSgglb0wZBC/EZPEykQ==
X-Received: by 2002:a54:400f:: with SMTP id x15mr2928530oie.38.1609261726511;
        Tue, 29 Dec 2020 09:08:46 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t19sm10813102otp.36.2020.12.29.09.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 09:08:46 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/3] completion: add proper public __git_complete
Date:   Tue, 29 Dec 2020 11:08:37 -0600
Message-Id: <20201229170837.297857-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20201229170837.297857-1-felipe.contreras@gmail.com>
References: <20201229170837.297857-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When __git_complete was introduced, it was meant to be temporarily, while
a proper guideline for public shell functions was established
(tentatively _GIT_complete), but since that never happened, people
in the wild started to use __git_complete, even though it was marked as
not public.

Eight years is more than enough wait, let's mark this function as
public, and make it a bit more user-friendly.

So that instead of doing:

  __git_complete gk __gitk_main

The user can do:

  __git_complete gk gitk

And instead of:

  __git_complete gf _git_fetch

Do:

  __git_complete gf git_fetch

Backwards compatibility is maintained.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 31 ++++++++++++++++++++------
 t/t9902-completion.sh                  | 14 +++++++++++-
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 869c73ee2c..1179bd2876 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3497,10 +3497,7 @@ __git_func_wrap ()
 	$1
 }
 
-# Setup completion for certain functions defined above by setting common
-# variables and workarounds.
-# This is NOT a public function; use at your own risk.
-__git_complete ()
+___git_complete ()
 {
 	local wrapper="__git_wrap${2}"
 	eval "$wrapper () { __git_func_wrap $2 ; }"
@@ -3508,13 +3505,33 @@ __git_complete ()
 		|| complete -o default -o nospace -F $wrapper $1
 }
 
-__git_complete git __git_main
-__git_complete gitk __gitk_main
+# Setup the completion for git commands
+# 1: command or alias
+# 2: function to call (e.g. `git`, `gitk`, `git_fetch`)
+__git_complete ()
+{
+	local func
+
+	if __git_have_func $2; then
+		func=$2
+	elif __git_have_func __$2_main; then
+		func=__$2_main
+	elif __git_have_func _$2; then
+		func=_$2
+	else
+		echo "ERROR: could not find function '$2'" 1>&2
+		return 1
+	fi
+	___git_complete $1 $func
+}
+
+___git_complete git __git_main
+___git_complete gitk __gitk_main
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
 if [ "$OSTYPE" = cygwin ]; then
-	__git_complete git.exe __git_main
+	___git_complete git.exe __git_main
 fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index c0b4380eae..c4a7758409 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2382,10 +2382,22 @@ test_expect_success 'sourcing the completion script clears cached --options' '
 
 test_expect_success '__git_complete' '
 	unset -f __git_wrap__git_main &&
+
 	__git_complete foo __git_main &&
 	__git_have_func __git_wrap__git_main &&
+	unset -f __git_wrap__git_main &&
+
 	__git_complete gf _git_fetch &&
-	__git_have_func __git_wrap_git_fetch
+	__git_have_func __git_wrap_git_fetch &&
+
+	__git_complete foo git &&
+	__git_have_func __git_wrap__git_main &&
+	unset -f __git_wrap__git_main &&
+
+	__git_complete gd git_diff &&
+	__git_have_func __git_wrap_git_diff &&
+
+	test_must_fail __git_complete ga missing
 '
 
 test_done
-- 
2.30.0

