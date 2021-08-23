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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCB4C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C74361391
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbhHWMO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbhHWMOO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:14:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E64C0611C6
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k29so25950519wrd.7
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=blIbeWiTzDQi1cV7LAawWCN2+PThD8wt9jy3STuB5Mg=;
        b=qzxOFl+gpqlsFIh+XN23TlTJNYv6GwyfOpXTQdNJt1RGR3PlMFe7zwT32b903CPG0A
         eQrtIj+LsHH3jMG2mhE45fm6Pg5KxBhN1dBHmtr7jkqDshOMPbFhQXab1eZtrJtQu9Lh
         UT4VH9gzUaWKHH5tJ/M6O6Gch7DkBYOhVjoKQcjszOwlpdravDgr3cmVLpsMq3v7k6dG
         p7rkG5B8myIMrvAoX8FsU5e2G+xwd7y3IpHDTpI1DggfQgBToMBFoWfmPd1eyIubhdNM
         bHsvSwMVlmzTnAzi0o4prAYrxWLtPClwXKCZJmM5b5NETGEExsX9fbhlZBcDYzwFPnyY
         0GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=blIbeWiTzDQi1cV7LAawWCN2+PThD8wt9jy3STuB5Mg=;
        b=Oa57sYfnMryt40NzaTdXb6iBbbdBFirUsTt0EXrKfPu8y5u6aMyEyOGDFMo1MM2w7M
         /jvrArSGN9DG6gu0Eig4Bez/ngCPCLB0Thj0Ga1YyvFi6fRHDCv26bjl/TExl6vUjhjn
         Vlzet17JyQRU5cUJDx5jPFlvEnzT2b4mEhJ/IhcGkjE96wzuswZQI9Wdkpp3QvR8/mB/
         00sRABMZ9Sm2jrR8l63RP4yt4AccgeybAwLuo4sPfhDkjb4TksDe74TrG88OUNfOzlTi
         h2WBcpCWS/w1WYyBCc3u0Qh2qoCZEQiGZzj8aGkqLKqtbSu91TLzxNm0ZnpwUMD6+G7q
         8dfA==
X-Gm-Message-State: AOAM533Xqx09Q31TqAKyTFp0ms6g9nTzll92zT7YfOxVA7R0wu01dmnm
        PXPk8UCYTSbBlzRe4b6rqBqyGTKBjVH4vbxj
X-Google-Smtp-Source: ABdhPJy9W/L/V55vMTQP+bNqcfh9RlsRtb0A0QY0T+eKZT/11vpeg029/U25sGyXQ7ITGk8pkieoWA==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr13208676wru.261.1629720793710;
        Mon, 23 Aug 2021 05:13:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 21/28] git-prompt: prepare for reftable refs backend
Date:   Mon, 23 Aug 2021 14:12:32 +0200
Message-Id: <patch-v4-21.28-443bdebfb5d-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

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
2.33.0.662.gbaddc25a55e

