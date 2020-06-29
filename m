Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAED4C433E1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C952E206F1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAAyzKTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgF2VO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgF2S5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD3FC031C40
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so15651091wmf.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=T+cnAhd0CaI3iCFAp5DGTvkBUE5bpcVITLNVyrV2byA=;
        b=YAAyzKTuLsfyCwe+6j7+f93Frbre+AUdOM2o7+v5uBeJEZh9hITM0ChQGQIsIgZcAu
         ddX0VDdo+7TAyrpNKH1lCxEAtBERRX7GLN0M1tnFEQd5Kvt7/th4GEjuDYZergpuyELH
         0V565sBtfCwWkbHGPW4XgNTMyc6JsCItGE+AKLAHjdjtPxu8S9yPpbFgRlNmoASI5LtF
         9ZkKDAOEfeR+o++Owg0t4qVvgILpLG9oy1IBjuI3pzB125KtChC46piwph1wawXpfMFk
         gnXOwj9fUI+T3V/5I1kBiyBRakz2lKRKCY5mMQfDI1iXjumMy6ZJlMGjpme851yzy6/D
         RX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=T+cnAhd0CaI3iCFAp5DGTvkBUE5bpcVITLNVyrV2byA=;
        b=jLJbzdsbKnjr6XmJKmtv4pIg23zjxWg59e5JDwxM/61L9B0OKslW7upHfTk5WbItFP
         cxydl3Fs+HL88rB06mRdqXyOj3uyxscnAJADiiXSZN5BdnInWuHZydV1ZXOHvRxDP2iR
         LE3AI4HoQAnC14FqdYFzdlapZUDwTdRYSuB7v/J8grCfHdQ4NUSRPXGbEvAWPrUpyh7H
         J9aJWotznqEYZQiyvDZW9aHz4CiT3qQ/Sn1XoEBDZTVAeB/wrq+gl8c24/MAl3lQSguM
         9Y/ISG40tgxHxJ5VPuf08lzE5YlV+bCKzNtCaphrwy6144kfV6DiNMZuwp814lO9FwFV
         hMuw==
X-Gm-Message-State: AOAM531ebgJglOmMACA/EJ0hQuWQPqhT6RFCiK9HOT0UJ7dfFJTBzHys
        1C8OxifvuFyDxN2MD3xUvA10VmX/EFs=
X-Google-Smtp-Source: ABdhPJxUj+Q4LZtBjsT99xkrkLVdOef+g9PwPLBKgIsrVaISxO3ZanOOXLGny4SPihP5JaJAjJv3Pg==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr17634320wmg.27.1593457036624;
        Mon, 29 Jun 2020 11:57:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm792906wrc.22.2020.06.29.11.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:16 -0700 (PDT)
Message-Id: <d4dc1deae515519eaaf38925bba35d80ad331cf8.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:56 +0000
Subject: [PATCH v19 18/20] git-prompt: prepare for reftable refs backend
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
index e6cd5464e5..e8fdb678d4 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -476,10 +476,15 @@ __git_ps1 ()
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

