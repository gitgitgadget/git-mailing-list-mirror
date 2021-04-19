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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD02C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A6961166
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhDSLlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbhDSLiw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D050BC061350
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p6so26945384wrn.9
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Dz1zr8n39D/q2P9IL0Jw3lNhMszXFSjhNCDEQ18nlzQ=;
        b=qO/+hu6wCbq6UapB8FBg/pZyjnkBfZsdPbJyEqMgKha3Ejf1z8DqmiIJaD5nfY5bKY
         iDiHRKRbfSYdCxA4ol85avbJ4yrOkSVGCOklBoxeZ/GQBuV3gtOw5O6E0rErnwqUy+Xu
         J/g809RbRRsh2BdFyo06wwISmJBn5RRhtv+v6GDjg1mXrofYApC1hUk09cN0s0AJGv3o
         4ZdimIQweM6MGSaVtbyZ+XOjlhnkBzsOrInCDVUFyCRw43SoLA3qhKcbkaRs9fdhza++
         0fGjCJfx0CSjdO5ClC9ZieK6Z4Yvbzhq/ACKz5TxzhgEb/OhuLwdOQA6fMFjEVsf3L67
         l23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Dz1zr8n39D/q2P9IL0Jw3lNhMszXFSjhNCDEQ18nlzQ=;
        b=boIko6M8nQubCtk+OkM5bmIt4lk/ffpprMlvhB4hRxQjB+W+Ga0Rxc0cKK5SfBSrQd
         8ECsbz6RfNA0TrSGMJkytI2be/FGv1qBe3pqHNjegj6PICXUUhxwR/1zAXphXTrqFs3D
         FH3WDQ7nu54cOf//3kHNgRDT04IhBCWlU1RGGy1YXp3uWLFcWJmGusOC3a6JzFKWG6VU
         M+VPYtBREhXO8ukdDsnDvviqqoQCuO1xUxr1rVXJaB5DLSREfPDPcUY48S8JyyG8dPka
         8y3nEl3UiA8Ji8J/ycLJIZLrveHewEpvFJ04m0fFBHBbINhFXHikIhjeFNff7scwmf/X
         pkMg==
X-Gm-Message-State: AOAM5320AJDW0smRX8FXXh9AwpC3ZbfEU+eGjQ34t79OlkiB79iWsIC/
        WFf6pxnAe+ggEbLW3m5WunFGvdlxIS4=
X-Google-Smtp-Source: ABdhPJylJV4vTZkDRWLlAJ2rBF2OLHhrspSLHycXEORmYeNY9llc2Gkb9H7VMoke6HOdOB8pAyYLmA==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr14141910wrt.291.1618832295678;
        Mon, 19 Apr 2021 04:38:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22sm21987502wrh.5.2021.04.19.04.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:15 -0700 (PDT)
Message-Id: <742d716e451061540ec3a1df53e0c9dbb08d9124.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:52 +0000
Subject: [PATCH v7 24/28] git-prompt: prepare for reftable refs backend
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
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

