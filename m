Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF274C433E1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF222073E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Viy6hPCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgFVVzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbgFVVzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F512C061795
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so1009946wrj.13
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xUqh61MruwfKw3p7EiLGkDfaFiAOzVJSyDHNnuW4lEM=;
        b=Viy6hPCKwNw26gKSJyb+w4ic7oY9ut0Nkps55ZEiPornw6rneH62fqglK3kEcXDMLl
         8oikc0u5lPve3gueMk3KteZQKfYlJasRcPg2lszCPJVED9Q2NMym03rf7M1kyxkrkTVe
         Yll8jnGPlPLvirIrUDUbr02+ubOP90kNxOu/8c7dDCjRq1fUuBz3nXud+pWPS6ukYyiW
         wlXvDb0/1bG7j3B20SXqMLTPswrLNvK+raRLV3YFWqgZUY/KNnSRUP/eoEHE9p4gRTmt
         tn+r3H/49Thdw8j366vZExrQC5GV9RA37ZmRTnbsnrlgQYzbSqxPe2PT3bhIIQOgwjvn
         NObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xUqh61MruwfKw3p7EiLGkDfaFiAOzVJSyDHNnuW4lEM=;
        b=HiHPeDIZhSIIOtB9Ysn/QiIsFg1+Dx7f/g8JenTxSB8C3o1WmaFxvDugZv3z6luvnQ
         0Kn0hUmgEUHVGvJc8Mv/oZsDufGifF7uQJXwSjYVgJ7V0MmI0kLxLRSVH3Dw8irOihty
         DXGJn0wpr1dwYikw4+2XLwc/RfEMO86FRGJG01ILB3Kr70hRjv1MYXmw+VqIuEShsNrH
         unNgGM+Rr2zfa4W7mZD4iXmjnWx5GyelUoXXNdbV+brZkTzxzj+xEeTnyN9Kf9qwS2W4
         spDN6/z0oPBdIxVQGDf/Dp6C+GoIp+gs4MMCaE2Cvjx4Zt57GdXBppOF9tBL2ntUoY80
         xctg==
X-Gm-Message-State: AOAM531AyOPccyy5kquATE1SLZZAyxH/t4vc6nPl/rrsFIgVbbIBGQib
        LmhdvxDBKHGjd72bNx0aCHUtTMfb
X-Google-Smtp-Source: ABdhPJyypPPfvu8xF9XV5ZjJMqZcGS9D/Gqy1y9ambB669kZxrAvYcNEMZ0Ejeu3d8JkdNn/rAcn5A==
X-Received: by 2002:a5d:5310:: with SMTP id e16mr18910717wrv.289.1592862939252;
        Mon, 22 Jun 2020 14:55:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15sm19347018wre.93.2020.06.22.14.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:38 -0700 (PDT)
Message-Id: <9724854088c072714da5b9984578c06a959caaf9.1592862921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:18 +0000
Subject: [PATCH v18 17/19] git-prompt: prepare for reftable refs backend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
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
index 014cd7c3cfc..f96d666d87d 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -460,10 +460,15 @@ __git_ps1 ()
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

