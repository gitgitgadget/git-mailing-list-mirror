Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82CFC43603
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA17564FC0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhCLUUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhCLUUK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:20:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65582C061762
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 7so5499931wrz.0
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Dz1zr8n39D/q2P9IL0Jw3lNhMszXFSjhNCDEQ18nlzQ=;
        b=YfXQWKbzCJrikCqWc/FYFL/ZXzYH6nk+X937HswSMEWhtGdCnP4/25vhqMmFAtxI+V
         whBL/SDwPPS9KrgXEuJXDY8Y2x9+viA47fIgUgyZIldS6V7qABJlIiXdvDcmz8rE8DVb
         7GBpkUvTkbsusPXFEyA3x8Qjtm3wKvavh5W9xKv6L6GJA9pZas7j3kvWmku/VUiUZxGz
         R1lFmevmpPgdVB1456qA8cYg4EaKMOMvlwM7VJNuTNO7QMXRI6u0xWJ0as6g4/oSbpaj
         2VXId03GMWDmQrWM20K4C8ui/B7t19BlYEMSShXISEAVIusWpFZqSNW1D1iliWv2yVl0
         oqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Dz1zr8n39D/q2P9IL0Jw3lNhMszXFSjhNCDEQ18nlzQ=;
        b=BJ4N5DYvkEB0foaysY/0kJ9Y9e6eOgqJXKoo4MvEihy5VOOc3+EiC3IXl8nywMozHf
         rW/RjyZ0OxMBxMLrH4eHKXt7jH4sMCCK266NNvDVpTnXjo5bQj9NVGoISjsG2qZu+QFy
         uZZCyKBiYT9TAz5MzeMswgNuWhzJtDPI9BRl6yj5TwKL/JXc39a39Non10aZaycvZcMK
         s74+tmRlCFbeEQTh/BnYygc+j2lC+Vmpq74zPL19JBER4SXzSvlyXPwVckY9iOOTPuNy
         1kwY2xR75t3RKOcJCePyi4lW2PU7SkcDQs/KdYGPmymsZodLmyJTDvmCGvcXVD2JKEkW
         WPkg==
X-Gm-Message-State: AOAM53125qHU+VaxVsL4EqB2OUA/4FuHCdMcfpgXTVOn8CHyKA0U4yvQ
        8SNmkNt/Z+a+tMgQQYzxpmI8F+/6zUI=
X-Google-Smtp-Source: ABdhPJx3yO7CdNIIdD2rCmQsNBlQXDPdiQHe0P7CEngecMyS1SO3B7TH7OQk3Cf/uur3rSpMHmGfkg==
X-Received: by 2002:a05:6000:186f:: with SMTP id d15mr15908579wri.237.1615580409124;
        Fri, 12 Mar 2021 12:20:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c131sm3523505wma.37.2021.03.12.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:20:08 -0800 (PST)
Message-Id: <0d9477941678cc59a4200b30c81c8cf177a2d544.1615580397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
        <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 12 Mar 2021 20:19:55 +0000
Subject: [PATCH v5 14/15] git-prompt: prepare for reftable refs backend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

In our git-prompt script we strive to use Bash builtins wherever
possible, because fork()-ing subshells for command substitutions and
fork()+exec()-ing Git commands are expensive on some platforms.  We
even read and parse '.git/HEAD' using Bash builtins to get the name of
the current branch [1].  However, the upcoming reftable refs backend
won't use '.git/HEAD' at all, but will write an invalid refname as
placeholder for backwards compatibility instead, which will break our
git-prompt script.

Update the git-prompt script to recognize the placeholder '.git/HEAD'
written by the reftable backend (its content is specified in the
reftable specs), and then fall back to use 'git symbolic-ref' to get
the name of the current branch.

[1] 3a43c4b5bd (bash prompt: use bash builtins to find out current
    branch, 2011-03-31)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-prompt.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 4640a1535d15..2e5a5d80271d 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -478,10 +478,15 @@ __git_ps1 ()
 			if ! __git_eread "$g/HEAD" head; then
 				return $exit
 			fi
-			# is it a symbolic ref?
 			b="${head#ref: }"
 			if [ "$head" = "$b" ]; then
 				detached=yes
+			elif [ "$b" = "refs/heads/.invalid" ]; then
+				# Reftable
+				b="$(git symbolic-ref HEAD 2>/dev/null)" ||
+				detached=yes
+			fi
+			if [ "$detached" = yes ]; then
 				b="$(
 				case "${GIT_PS1_DESCRIBE_STYLE-}" in
 				(contains)
-- 
gitgitgadget

