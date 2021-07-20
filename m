Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFEEC636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BF4610CC
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhGTQ1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhGTQY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:26 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B8CC061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m2so26813172wrq.2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SQqi9xjGISpoDsU6k7XeqVuwZGxStXX5SNt3T0ckhZg=;
        b=TpxdjKjQgmJDM15L+v7/dnHcKMOsineD+Xf4Z+wPseD7wAICTZfCbyzX8mIVmF8OiK
         pMml11kNFwcOGUrssCWT7Fm4013/R26ulJhU4Ind2lUhsJssbOPbYfBVDwqlfYTzUsaa
         hxnG/Ml7JE8cDUE4cJBYISxcyoauPxqcXhV9ghGEjuAVw3Vu+G0JSbb2yfb6+d+m2m9h
         xvcCXv2Kfj/zXZ5h90DT0G68s7fDib29KZWOt70wO5y8tQocMo6SmJsTWbHOu9s32XGY
         EY/FTtZ6mW0G1I6wvET/XWvGvxmeFovT3eIkQFEbnwxd2hzJNZzWdxyZbs+05LYocNRK
         nvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SQqi9xjGISpoDsU6k7XeqVuwZGxStXX5SNt3T0ckhZg=;
        b=X6cWTLkgt/zH4VRklD05IpeiPfB3+MdI2P+G3OTmdJa3YYVY5DkCEkPLEthkqEw9Bl
         bHe+GaMKilv1noP8H9l6gseKFdO1+PeYQ0oQXn9ysY+37hgPIyBBhKcEw4qHaJcsdH/z
         xbaHI2vgV0N+PhW+9kfAjgS5gpor8zhmTffX45ib4dOnY2/nscAPJJmL9i9UkxgvdBgl
         5dIrK8o8WEmuxJ0uXPTUBOMb7PLWHWPd0FT/pC0M4BYCFGn06/Vq8VCduxT7Fjr0dlzY
         ZfHW+vQO4Z2yiUgquvwVhMK8k6Zr+BaA3mCrl246641I8tan7V1FIfTpEcM/nbfCkxfm
         VI0A==
X-Gm-Message-State: AOAM533/RE9GkjgDPeMCM1OJtR8W5atcHT2xtCYQfwpTycjr6AgM0CLD
        tnskcNRT//vstr6LjrAfiA2yO+4auWk=
X-Google-Smtp-Source: ABdhPJy1zuGyibPzsv5Is2eAngsu5ZaycftgHbK6JQOEi9Cjph868OtuX8MwMqjpZUBw2br5fogJWQ==
X-Received: by 2002:a5d:5645:: with SMTP id j5mr17969768wrw.426.1626800702055;
        Tue, 20 Jul 2021 10:05:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm20275724wmu.17.2021.07.20.10.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:05:01 -0700 (PDT)
Message-Id: <7541a4b8d6dbdffbad06779e7c295a8e730ed9af.1626800687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:41 +0000
Subject: [PATCH 21/26] git-prompt: prepare for reftable refs backend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index db7c0068fb5..4177274bea4 100644
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

