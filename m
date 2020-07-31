Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCEAC433E3
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D03B2245C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRHqz6MX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbgGaP1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733301AbgGaP1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8028C061756
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so9608278wmi.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=0+lRtlY5Iuf6sWiVZiHyGaoZV+seGLZdsu9ehICdIvU=;
        b=lRHqz6MXNWaLl+AbdJppHW+GiGRfPbGgQ1MTgWDZQT09aeL+XY5Nv7Bu4JuuiQqcOC
         Au40+WTlFIOPr9kFcbtc6lnGnTIPG6+MCxwVjolNB/I6vKV9wl4MJypv0jUg71+bztpB
         wMwBYqabOLG+VxBe0GMeSFBKcwoYKWBEj/b/0tnEn648c5nG5CG1YTlZhsugnxkpSWqN
         u8+5dYqZGu++hTSiWOHJ41Fn9PsbBJ1nBb+x3AehK7Ew3T0+cvoSnfJe0lDufB8DvwIJ
         5WtX3zfKzJ9kXzWnZoH/Og7H2hK15b7fLQSwgE3lR+LSjD2Nsr2K21WOcMBQaXCk9ugO
         vomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=0+lRtlY5Iuf6sWiVZiHyGaoZV+seGLZdsu9ehICdIvU=;
        b=IjHoExk5jsagV4kwid+D7kKluNK4R0Tq7XVDNvo++NtEdRPvzB6mMm3ELV6zCYoBTO
         iDuhU3Y4kJRjBBNQ/fk+Np1W4OlSSf+wm3A66iLV97CjsptYuJoxIUd9K2sC4O+vWUfz
         opnsi3nf6nJPVNHwgTjak8kdCVAU9qQcdMgsdFPdGSXa8o3smDs+9xo31iqRmf/EVXNx
         qI0IG3TZxz435T9W6VkwclrJep8lwi8B8Pf0Q0j4afWVgz4Cl6fk6KN7qON4Zru9H0Bo
         oNyrpBpNThxcF1WCXrD39dXqEapBVqOeS5QDIVPuhWfiOzc/tjWxGz9BJhhMkqSMTZgy
         wh0Q==
X-Gm-Message-State: AOAM530pH0fiaZmxumTWS1m1eA1olmvfhSZo89WKZU8EoL8vWsNkP3CT
        TJfBatpZHnIfFRFDs6nTp/4/l39G
X-Google-Smtp-Source: ABdhPJyw6sVJv2VrqDmd092nJ4A9AbK/X+jzHGDtEehqmVJjhFsXqCqJSrm8ouFb5hgfL2Gpokg/1Q==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr4341567wmc.117.1596209261319;
        Fri, 31 Jul 2020 08:27:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2sm16097470wre.5.2020.07.31.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:40 -0700 (PDT)
Message-Id: <9cd73da381bf30d3c0200097f16ceabe90e5990e.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:15 +0000
Subject: [PATCH v20 19/21] git-prompt: prepare for reftable refs backend
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
index 16260bab73..5086bbdbfe 100644
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

