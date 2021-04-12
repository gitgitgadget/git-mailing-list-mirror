Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D1AC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9094E60200
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245277AbhDLT04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245290AbhDLT0d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:26:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98E7C061342
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:26:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so29511wma.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Dz1zr8n39D/q2P9IL0Jw3lNhMszXFSjhNCDEQ18nlzQ=;
        b=HyQA8YZdekBfh1GDGraCXMEpNwrfoJr9+5q+kRfwhPsesDrdg0M+/KUD9oMYlpVeV+
         +UPMG6Gc1Pc3oyB4lcOtNimoPtc2WG8ERRM4T1LM4x9Z+UhuIkSEj9GcBxSptSKzPVWT
         o+K1lSe3B+x4YQoJPscyVSProJsF0hlZzqadXSTsbAS9JmSViXRgYfKZHxNuZ2O6Xijj
         sAMms52bAv3CtdyLRIq6/pHyE7cvoZAbxM6m48laxDgrWbtikUo9Egf7YdcyP09ca9q3
         J/lnkQxkvC/ESHgnsuxl9bebvl7adqypLWGOjzfZ21bj+m6pQJGNP0c/LdE0yv9zdWJY
         1KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Dz1zr8n39D/q2P9IL0Jw3lNhMszXFSjhNCDEQ18nlzQ=;
        b=RZl2YwwHdVbSlv6GQ/d5ZEObI+FskWU4g5eekl5cW9EqpMAMWgxiC0fS6XGbPDy5Ow
         7fpQYkaaStJrKHzQ73lAPBAESokCW2Nn2hcF5Iu+5KgEOKCdRA9SkBupKiWqPuN7Ix+A
         7DowDYifGDUUPD91tqf+/Zyfw3LaLtC0/AtCRazT6VyzzMWi9m5DyNPLUSf1t/+xbNkt
         nZieL0jeiTCG2JxvDU94GTDSN4X72nWaGD7SGJ5qlcbJliuMbaLNWKrAksDkl/cBehQy
         qded4sjaEK8dCsdLpOmesN6IYErLNakjTGzsRKxgPn3sbcFaR6p4KdtuDGU19v2tIRqj
         kwcg==
X-Gm-Message-State: AOAM533Z2Yq4WJMKSyaG3rosxAiPbR2ZGuEZxlZMxt7jv3yzsBdwvkrv
        Z7NJE7n/OS2w5KXDeDp7vS7EVRNiz44=
X-Google-Smtp-Source: ABdhPJz3PtrFMlGwtvXpEj/LFeCuredoVx3GL6hw1vlv50Jum6+kb1aSF2HxNxhwaJYVTnA+KkSqLw==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr584590wmc.51.1618255566588;
        Mon, 12 Apr 2021 12:26:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11sm6643857wrt.41.2021.04.12.12.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:26:06 -0700 (PDT)
Message-Id: <b2fa6ea62c16932ec2528f2698a43a9fb3cbf004.1618255553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 19:25:51 +0000
Subject: [PATCH v6 19/20] git-prompt: prepare for reftable refs backend
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
        Derrick Stolee <stolee@gmail.com>,
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

