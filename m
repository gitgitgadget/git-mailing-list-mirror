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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66751C433E9
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 23:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3B1207A9
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 23:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgL3Xak (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 18:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgL3Xak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 18:30:40 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3843BC06179C
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 15:30:00 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id n42so16768400ota.12
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 15:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=smZocRqMF3CWtA6vOntnj7QESILxz+VTtrQ1xn/eGzc=;
        b=rRQMFHjNQ8/UivvPNbfbwgS8belHyb3JURuPFH/pdqBbt3muh3s/jmfjo3sd+iHIsW
         oLXFtLUm1IE/WES3qO4AbaErdt/EoRCh/aD1osk2htLFmpBWWySdJYoV44UuqKr5xsu0
         MvcKOOYucaKJCBslHwNrAPr0cfP/ZQTJxGhV4xBFyXrHTWpmEn9PYDuqrwQBvX78fllF
         YLdgmK+XXmGJFHOkK7KZXNJQyQ86CxZOKl5/yG4Qgp4SdfkoxwGy05LY0PAqixwFrFDo
         URVa874qxwtG8uFSEwofpnISJG6UIqeyJslXc0Hv1bFXcaPfnlNmh2peDLaBT3yZmOk5
         TxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=smZocRqMF3CWtA6vOntnj7QESILxz+VTtrQ1xn/eGzc=;
        b=p96qFCguiYjUidG2nn8sCOnFPSkdC2n4w8DE5NkNvdKi3De2vACvcTUr2xK+w01OmB
         19z16UO/nQqyHnPsuLvM0x0q7z4cs00fsWb++F9/YBghRH1DcdcbEvQB5DAZSiHmY76S
         8aZwhowABOMM9co9Sva66syOyVlz7lCRbLJuK5heiNMuYWySoGDx+8XhqyLgI2eaCxer
         pYGQBal4VSmNMBuvVAEZGOFXHkkHiFdg+ik92MJHVEmxyjR3TVCrwE9nfArk8bklsq9r
         OOEAo7fXG++sDNiYpJJER656i3ecsh+1r2qu8PrQFTmhhsGyMSI9DOVXFVj7QxvoLIfs
         U+Og==
X-Gm-Message-State: AOAM530D/WiU8xSTYYqLwRs15pe+lP3UN0Mj6LGuv4HZlwuz0HPsVXXr
        tvAgHOTRmLC/SGPaSFgKHRJ6+0VM82rsaQ==
X-Google-Smtp-Source: ABdhPJy6ehxs0034w7ABpSx/zpRt3or3WDTPkpMVE4wt8fiY5Pif33clIT+uMjQOdPmV3jkR3JGmcw==
X-Received: by 2002:a9d:19aa:: with SMTP id k39mr21442231otk.28.1609370999311;
        Wed, 30 Dec 2020 15:29:59 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t24sm10674156oou.4.2020.12.30.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 15:29:58 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/4] completion: add proper public __git_complete
Date:   Wed, 30 Dec 2020 17:29:50 -0600
Message-Id: <20201230232950.582152-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20201230232950.582152-1-felipe.contreras@gmail.com>
References: <20201230232950.582152-1-felipe.contreras@gmail.com>
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
index 1150d4bf44..4b1f4264a6 100644
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
@@ -3497,10 +3506,7 @@ __git_func_wrap ()
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
@@ -3508,13 +3514,33 @@ __git_complete ()
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

