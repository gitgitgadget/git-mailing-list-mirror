Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCC0C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C91D22B37
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgL1TXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 14:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgL1TXt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:23:49 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0BC061796
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:23:09 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id n42so9992118ota.12
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZVARGIqUCFVHLs76eJHmBQC6CmJf8wqjEC2IOZVttw=;
        b=czImC1ulf3oqSQxNAc2HVGeihoyXiV3dW0Xx4AdSOKDAIWHNCHK+MHMNlw2Fm5PCnK
         SE4gPxcfLxTQHOB2D/HKpyV7pwIiiLA8jOEbsTWLps3ZCE5eYHeYt2WqQMudXLjetZ+6
         8gN1umwX/EPlVJFYYmNwdhtBovs4kBAqpu1frUshd5ODVjQVXeP4Honf9bkMIP5qUwjN
         BnJfpncXa7MustQom/SbixdL1/rLvhkWog+Zj/w4nUsZtqY2BnwGXMQHBT/aljjD8AWi
         1/+VZeRH0kA6aJAGSJtSi0nfbJoneRNtUswMenVNhfbfaUtrXI45/AYw4ilEFU9hq9Ez
         Vt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZVARGIqUCFVHLs76eJHmBQC6CmJf8wqjEC2IOZVttw=;
        b=eGqXRzLYMuc/D5zoCFsWJ+tWxQ/4n0D7IzT7epjPnVOcm2PRJ8xNAq12MhuccB32gA
         rRvpuCICR0L3gOfWqLQSU5mVHu9AaMcbAL8JTXasrUMgv9RC7tD3fhkhD1U9Yd3ttOzR
         a0eqnIhZh4q7Ue1aftmGW5zu/d2yTwZbq2SyEL5zG5fnlBWTvwhzeZmwEcom5VjrxHI7
         xil5n438kc6dKl2kN6vS4QdAx2YXqgxdSkLyjeLFD3GSRDgZdoqCEk3Sgzp5TY1I1tyW
         gYZtAGGaCejzAFlPRqgbFFu5vb9DR4sJe0QzJ/9tMBp7E1nC1tGm6Or5SVhBLuBbHfY2
         cR1A==
X-Gm-Message-State: AOAM531ZxWx1cBEliXN+L4xfg5hVAAoXtK/iSkHsnWK7W2EFnI6PYcUb
        5Jhrs2eI0KvK+sh9WYmH73tCS417vR5Bag==
X-Google-Smtp-Source: ABdhPJyEdSdC9zevqknG8j1G9w/adQJdtpaAqwgnrwObQvQOXMt7ltXH5qBfQMYN6UHKCmgIqTg4Hg==
X-Received: by 2002:a05:6830:1de8:: with SMTP id b8mr33023931otj.204.1609183388098;
        Mon, 28 Dec 2020 11:23:08 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l12sm1410578ooq.22.2020.12.28.11.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:23:07 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] completion: add proper public __git_complete
Date:   Mon, 28 Dec 2020 13:23:02 -0600
Message-Id: <20201228192302.80467-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20201228192302.80467-1-felipe.contreras@gmail.com>
References: <20201228192302.80467-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in 2012 I argued [1] for the introduction of a helper that would
allow users to specify aliases like:

  git_complete gf git_fetch

Back then there was pushback because there was no clear guideline for
public functions (git_complete vs _git_complete vs _GIT_complete), and
some aliases didn't actually work.

Fast-forward to 2020 and there's still no guideline for public
functions, and those aliases still don't work (even though I sent the
fixes).

This has not prevented people from using this function that is clearly
needed to setup custom aliases [2], and in fact it's the recommended
way. But it is cumbersome that the user must type:

  __git_complete gf _git_fetch

Or worse:

  __git_complete gk __gitk_main

8 years is more than enough time to stop waiting for the perfect to
come; let's define a public function (with the same name) that is
actually user-friendly:

  __git_complete gf git_fetch
  __git_complete gk gitk

While also maintaining backwards compatibility.

The logic is:

 1. If $2 exists, use it directly
 2. If not, check if __$2_main exists
 3. If not, check if _$2 exists
 4. If not, fail

[1] https://lore.kernel.org/git/1334524814-13581-1-git-send-email-felipe.contreras@gmail.com/
[2] https://stackoverflow.com/questions/342969/how-do-i-get-bash-completion-to-work-with-aliases

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 31 ++++++++++++++++++++------
 t/t9902-completion.sh                  | 15 ++++++++++++-
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 463a3124da..6b0432a72d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3493,10 +3493,7 @@ __git_func_wrap ()
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
@@ -3504,13 +3501,33 @@ __git_complete ()
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
+	if [[ "$(type -t $2)" == function ]]; then
+		func=$2
+	elif [[ "$(type -t __$2_main)" == function ]]; then
+		func=__$2_main
+	elif [[ "$(type -t _$2)" == function ]]; then
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
index 2e59fe4de0..53669a36f1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2381,10 +2381,23 @@ test_expect_success 'sourcing the completion script clears cached --options' '
 '
 
 test_expect_success '__git_complete' '
+	unset -f __git_wrap__git_main &&
+
 	__git_complete foo __git_main &&
 	test "$(type -t __git_wrap__git_main)" == function &&
+	unset -f __git_wrap__git_main &&
+
 	__git_complete gf _git_fetch &&
-	test "$(type -t __git_wrap_git_fetch)" == function
+	test "$(type -t __git_wrap_git_fetch)" == function &&
+
+	__git_complete foo git &&
+	test "$(type -t __git_wrap__git_main)" == function &&
+	unset -f __git_wrap__git_main &&
+
+	__git_complete gd git_diff &&
+	test "$(type -t __git_wrap_git_diff)" == function &&
+
+	test_must_fail __git_complete ga missing
 '
 
 test_done
-- 
2.30.0.rc2

