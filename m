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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9DDC83010
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABE721D7E
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BruM52iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405261AbgKZTmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405257AbgKZTmx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 14:42:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5477C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l1so3331254wrb.9
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3QMmKznweHuYj4WVCmAIuUjESttE99i4jdv3/9cRjJ0=;
        b=BruM52iqaQ49VSNEtKMSOH2hxp27q/QlBei9JRycjdB4cVE/EEOdFkGvAKabMYbcVF
         T/mkmKSIB7iYkQou5XUPnup6tak3RJacPpZ/ybftlhSNdZpNM0/1vUA+CliylPOWO4HJ
         pu7zqA7OyEqcqdlEqpbyl4f/hXvz4tWQl3QGG8Idi51qu59hj3mvKa6DOlJZSEOefuCU
         NvYJSfFWM7h3z7s1TM4ykPqe8nsazbF0WXIrlsdJE0IQe9RBLYs+fqG9Q9t5Bn3V8MzM
         L/TccYY0oEgJ4B+aTzMAQKxoSE/DjjqgkpocB7dDfjDf+O9iWZAoF0wG90qSgcumvBC5
         Y6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=3QMmKznweHuYj4WVCmAIuUjESttE99i4jdv3/9cRjJ0=;
        b=edZQSctlrb5lpdps1uGoqbZa3l+zHnWRJly56pJ4tR9toLNO+ICHpxbDlpdNaxu6r3
         Ht1eW0Ts7w+M/ha+vaEETtBLrf3lDcPsN4yEoteO60Ek/1ci3QgJbaro2Up5g0/gL1aq
         JxYOm704h6H+QK/NeZGhfvn5WS7FSUkgQvz1OF4nKBX9TbYrdZCkoaaKj9x1tRLnL3iJ
         mNfQ5tpF+TNqsdAJlKCrhdyrQl44cMrwDedL3oJtJuTd3l1qfmiEjEot8R5Se6j6L6xH
         m98bKeAeImtktKKnFjiVhF6Fo28duNrkgp4MIViqt7nFie/o+f3KdvahwpieO/a6m/SS
         ni+w==
X-Gm-Message-State: AOAM532ioSvw/tq7wqzpMMPghaAsBxG2lQxnjeskNU8gp4zSM7nKAICA
        w8GRdrkE69KP/PoePtmXdVxedpFJTek=
X-Google-Smtp-Source: ABdhPJzIPqH6LPAchbhAjraQoQ2+Rsudz4RgYPVhVMKW9JUHYWsPdC5X5Al1WkpcRa+vH5tOZ8EQHw==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr5740310wrw.67.1606419770308;
        Thu, 26 Nov 2020 11:42:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8sm9373025wmg.28.2020.11.26.11.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:42:49 -0800 (PST)
Message-Id: <57626bfe2d4ad48481a66f42efbe46f4b2daf549.1606419752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 26 Nov 2020 19:42:30 +0000
Subject: [PATCH v3 15/16] git-prompt: prepare for reftable refs backend
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
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index 4640a1535d..2e5a5d8027 100644
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

