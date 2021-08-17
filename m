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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D290DC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B882360FBF
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbhHQNmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbhHQNmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:42:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B48C0612AC
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k29so28684773wrd.7
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SQqi9xjGISpoDsU6k7XeqVuwZGxStXX5SNt3T0ckhZg=;
        b=NZtaYvgyfg7kzC4+kY3SQCrkB8ePN/Q1ny3vklp8KcTTx4hwPt+9woldu+8I05D1nH
         R+zGn5gEColdlzB3Dq5wrA5/UlZm8GGqTMj6vedCMpThLSO4Nx0uifVvbAWp0PGzFlSt
         8G+Kvkgtj0uuBeYrUEojFYPq4TfTk/EF2HKc3718uwD0ZSon18OQnzhwwB0N4KxbQwLm
         S75WnajETuRE2LZHIzC8BWQgLZVxL7Om1p9u7KZMinFsXz8GgZGTs0vmrggLSruZQUdC
         3Wv0MmzyUgINsVtVwPwTY+Hyh6hh36/rEsVs8Bx9yYWTy+DA3GFNYE1t+F2ENQhE3CSE
         wy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SQqi9xjGISpoDsU6k7XeqVuwZGxStXX5SNt3T0ckhZg=;
        b=JduzhNd2vhqFner4n6pCjUneM06bzPA/u2ImwRC+zJy8+9KVMd5hYsGntNQ1sHdo3H
         N/KZ+y1w0kQqDB9uqwSdfhR1iZSKSY/C91Ukh/r05r71VdRQ38f5+mLQ5Fk7XUabb5Ac
         ZFByvwaH+KAqN9T9lieROtlZP5lwtkoCWpOxqcrGyb3DkTsdaqyfaIn27PZY02oNRohP
         FJajsmNc9ih/Ssm38alv1R1EmbKyFFjnYy4vKW1Xx0j+cIwifsw46DrDXWcaS60TwonX
         f84mJfs0WcLSy0/FFRgCxta3073p/v8Y3dQ0ZKFVYac/zF+wnQCmnWdWh9dCZn8LsMxp
         /O+A==
X-Gm-Message-State: AOAM5313p3wwJWOXC7WxWudFRpEDg4BNrLTB6keyg9YjHG/MKSPpaH65
        xWv6LZA85Hjg0cF2O9TAbEi+CV1cphw=
X-Google-Smtp-Source: ABdhPJz2RIkng+/LUdhLkyIwbB4gYHiZ6aQFha1WmTWqstywMHnnV7wZYNDoP5CkirFLpyoWibky7A==
X-Received: by 2002:a05:6000:1a86:: with SMTP id f6mr4293670wry.345.1629207648109;
        Tue, 17 Aug 2021 06:40:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm2555568wro.15.2021.08.17.06.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:47 -0700 (PDT)
Message-Id: <460658a13cb0fbba3921d18ba3c84083aba65d52.1629207607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
        <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:40:03 +0000
Subject: [PATCH v3 21/25] git-prompt: prepare for reftable refs backend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
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

