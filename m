Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2EC433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0568C2076C
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbhAACSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbhAACSS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:18:18 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A58C06179E
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:37 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 9so4624323ooy.7
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqlNEyQgXBAg8UxAKJt7ZDBk3cjQ/Mu8YTHw7lZzjIU=;
        b=A3ARsU0fM6JqImZDgJFsLyKu0uq6bVM3dd8/WCTnXjLfZAHYI1Ed6I0RBKBwsq9zrN
         NLKKfGDgJSyK4qKyvUyMmUSlNqm1hiAWa7R4+TNYhKErsP26csYhNrb7sbmp0/dGi8vc
         SLDwz78OCS4bUUZcuNBCfJhP/mnuBGBx8mgZDX0bE9Gsm5dl9QEgzsycS1SxoAP8cui9
         tEstMlw2FQSDUR4F6JY2BvzttiRXWeU981O7q1HCShUD/YGNEAf2qRqEKprtqpO8pgEd
         sHu0zvI9CFqMpK08NQgEtikfUcbYn0W7BF7ReRURB1rW7Q/lqTNM+dl+5MZa1HfHZuHp
         GJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqlNEyQgXBAg8UxAKJt7ZDBk3cjQ/Mu8YTHw7lZzjIU=;
        b=tz2vRiTOvba7PkzagAlGuw+960Ewov5LVF75v5bg15VBz/hQmtW5eeozbadxmkkWYi
         wre9YTYDePnFNi3ChghQ2IOnkmGG7Ks5G6+YM/EQ+P0lVDoPfSV/o06OUNeBaDTHgfnp
         V/LG22cedW9cYjirzGUFdr9IvEv6pDFca01i2XizKWSDujK00JkBojuZPAWNRkDb42w7
         5/ZGi4EZG/PAo/2FkLGzyLoGP6s5ZJJ6KmlYTJW67fLuJooHczOVwb6REpz/4LWTvcbW
         /1LGnwAvnTaovUxJCZs/y4LuhkKs1zRMs5yAx671tqSCeklWiEAEbfnvCDx/YJFPka+t
         dddA==
X-Gm-Message-State: AOAM533EPJrMxtontqRe+A5dl9xNER34RsNETOnYn+vCekyjbOv/Ma7n
        +99wwyZVAHsOg1Ol1Oc5XlgtNtHCy5IUuQ==
X-Google-Smtp-Source: ABdhPJyVvxv9ftoe3OUd5pvQO13j6OkeSgRAG9eVZJ+Cv9vwM9h5T+3bqNDd/LRYfkFmyf04N1YQQg==
X-Received: by 2002:a4a:751a:: with SMTP id j26mr40846115ooc.68.1609467457071;
        Thu, 31 Dec 2020 18:17:37 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id o49sm11461121ota.51.2020.12.31.18.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:36 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 46/47] completion: add proper public __git_complete
Date:   Thu, 31 Dec 2020 20:16:21 -0600
Message-Id: <20210101021622.798041-47-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
 contrib/completion/git-completion.bash | 40 +++++++++++++++++++++-----
 t/t9902-completion.sh                  | 14 ++++++++-
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 11a9433363..a0e5752217 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -29,6 +29,15 @@
 # tell the completion to use commit completion.  This also works with aliases
 # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
 #
+# If you have a command that is not part of git, but you would still
+# like completion, you can use __git_complete:
+#
+#   __git_complete gl git_log
+#
+# Or if it's a main command (i.e. git or gitk):
+#
+#   __git_complete gk gitk
+#
 # Compatible with bash 3.2.57.
 #
 # You can set the following environment variables to influence the behavior of
@@ -3429,10 +3438,7 @@ __git_func_wrap ()
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
@@ -3440,13 +3446,33 @@ __git_complete ()
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
index 01984692bb..b9490637f9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2381,10 +2381,22 @@ test_expect_success 'sourcing the completion script clears cached --options' '
 
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

