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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C30EC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4815623B31
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbgLIOCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732785AbgLIOB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:01:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD0C0611CC
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:00:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id w206so953426wma.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+6PYEuFV+jKAR8TJMsA1Qhghy1Wlzfn68uworvrq0zQ=;
        b=gm8GvRzNVMGrCTkp3ZIPmi3ugqhksdPJI68JgSIpvI0qOt3T78qimkLXwWE7nTwSFQ
         hzup3J/bGN+oto4lBIQ9QECmi5O+zZZhrS8FwP3mmHG6DoCMjZgHnLeTnRhw2i7rOwlW
         owDrW3O5kGFQvKfAP/YLMiGPfq2gbzqzq85sHuaarpyM1zHra8itrf2aoajMwH/ePn3B
         nBrHrASJWtelsbHT5+7734R9dqPXUhGD4H2eK7EuI3cbL+nLi0SLrIIGWVcRjwIWTg5X
         VeTXNv8p5EtE0G2JPevGOmL10iQpXkOXQcVYgiE61+LFVWkmPRFl17pb0q2u3N1ukrYF
         +Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+6PYEuFV+jKAR8TJMsA1Qhghy1Wlzfn68uworvrq0zQ=;
        b=P9qia8cwYatCK7Sn/WDKxSsAcNba0cWBS9BK5t6hy40/SvHXHXyXnT2I1IZDHuz2Mk
         xF3s5DHOHSNV21GSa5/foVDYmNX8Qlp5LMVS+R11MnGw58IuwJG84uiXD9oEASjAGuqh
         LlrYw/1h85JgQ9q9AxBJUPPisXF5Y/bA47aTYV2DYv+PFvL7jIDQuscVMy8GdcHDfnX8
         S37FWf2c2v7BGek06ExbT57UsvnlgV3K6Lx5lp19iTfq2pprAKz/bIYvCn1LbqJRrTGE
         uyNbQte1/ZyMZ1jgqKquw+G6fN9RFCDCHgKB+ZJU6bEaUKn901bqKvLwgBlZA1ZxC8cg
         qZ3Q==
X-Gm-Message-State: AOAM531CezCzcfxzoC9JSSEi8SN01AuI4yIKjxyVo2khNaGt3aeb1gQI
        V0ZJOxV++iSk+B//h6Peu+ZQLfxEuSk=
X-Google-Smtp-Source: ABdhPJww5p1O8gHww2LlDyJkCeGqmzY+DXXV8lSEUKheAbWcjtQU4wvEEEDUBGk3hxwdv2QLNn2EPw==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr2974455wmj.168.1607522445073;
        Wed, 09 Dec 2020 06:00:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm3445074wro.40.2020.12.09.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:00:44 -0800 (PST)
Message-Id: <9df5bc69f971dc2b51d519a2db9a2b0f22f9d87b.1607522430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
        <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 14:00:28 +0000
Subject: [PATCH v4 14/15] git-prompt: prepare for reftable refs backend
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
index 4640a1535d1..2e5a5d80271 100644
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

