Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342D7C432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9AC60F22
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhHPUSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhHPUSP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:18:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC12C0612AB
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w24so4516718wmi.5
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SQqi9xjGISpoDsU6k7XeqVuwZGxStXX5SNt3T0ckhZg=;
        b=o+qA1gLwNkecvxbQ24njqLVNnvg+FYtyLG93MYpJLgf2DjyJLHbVoMT8Ex5m6SxU7e
         M05zcuJPNDol3tdWZUEgcEvMN8dMPMuaGQnpzb9NUm7lEPg1i7ApiJlun/vnLDTbwzom
         tXc35e2wr2YjPExPRxO42Xun4Y8mgpNBSRuhSJhHeOK2RDpXH8hSQL+URaxqdEoAXqwx
         R/thkldYwemGU6LNaQBHaRdq2m2LS4a9114+vcQNTi1gaTrlW5dHWU1L4W0JDzIu8yB6
         B0u8MKZND6WqlFdGBJ3hFdTjqYvnefcjm+1hWNLhsbujetUjiRU/JcM4qOL5HsI7A7fE
         HE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SQqi9xjGISpoDsU6k7XeqVuwZGxStXX5SNt3T0ckhZg=;
        b=GxsUWxzdLC/WpvceGPZK0u84NY9uAW2SwdPGMULqLGCxkbAOcv/oX+SdvaJaI+/OM5
         EqYpidww3IUsczjRyDJpHdRLTRrMciyEEcSpWV19aSWBr1aePdrzopZ3HQRZKsEf/vxA
         +ZZLVPrLrzdrpl6e+rygoXQE/nQLkI1pr7LbJIVnBSbIrqYTNveVPKBvfN1ZOoaiQPn6
         IITsJNxvuw+EjyTFjfCBd4P986PKjCk27tt+UUo38wzB2SnwUGbT2Uky9J/dw+hoMe5c
         RcbEXT1jNwxggvKyXKICVdPwr52Xd+k9ado3a1rMw3yjN58zI3KdHe/E8gnwaAehFY4M
         UuJA==
X-Gm-Message-State: AOAM532ZEh14Ggp9FmLHMiTqP6qUDbk8owdJFeRlLjnKOIIEHQk/1loh
        AnACSujHqOKZDHoJJjyrvTUXnQ7i2qk=
X-Google-Smtp-Source: ABdhPJwUITVlSexVLduqBznMUrpQJIU8H2xq9VVcPF4z1ofZTI6VmPzkhttpvmKJpcMld7B69dMcEw==
X-Received: by 2002:a1c:a793:: with SMTP id q141mr98883wme.157.1629145059698;
        Mon, 16 Aug 2021 13:17:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm171353wmm.33.2021.08.16.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:39 -0700 (PDT)
Message-Id: <79c4b90d0f47404d11f94dc1dc946b14b0018b7f.1629145037.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:17:12 +0000
Subject: [PATCH v2 21/25] git-prompt: prepare for reftable refs backend
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

