Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813ADC433E1
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 23:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597212065E
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 23:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIW4tKqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgGTXRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGTXRg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 19:17:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432FC061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 16:17:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id br7so19767824ejb.5
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 16:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+hdMAicT7jUB7KSZakmpOWH336vrsMx5+H9ogpwDjzo=;
        b=KIW4tKqY665H83g+Yep8iCoMyHrbGTFDLXz7RaPf7DoRhiM+hbIxUoIdjeACPKWU+W
         ZmDy0BIql4HcllB3DK4KcbRF0FUxVj5CMB5jLANjexQiXZXRVfDbsRQaQc0+8+HIR0uJ
         76CAXpJNWu6xKw06kGKl+TyNY0QDOJ/xDrLSxPTxkkwYeT+aOe47kUEcHUUcPUl/+Jpr
         GerSGQOTq/9bTUzDEchmLMl08pPjBenygjCclrLzOTmZf9o0B+xiqLJ7HKXXSxFS1JDs
         s4L9KP68cNY3HlDkTNgHOpfBfcko93deb3pOhVDdTxufc4+W52sSJ5XAPH8Vwq2LL72U
         dSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+hdMAicT7jUB7KSZakmpOWH336vrsMx5+H9ogpwDjzo=;
        b=apyjSsVddp+90KFlNDwzkFkqaZS20f6yPcp/jt71287i5h9WWmi20JL7fG2N/umeLz
         kdXYr22WLRAaSeJTiaEWqBFhWOUaJoWSjGHeUX8dw87BUOQX+f/2t6y+A8TPZ57137Ff
         aBKTLGJfeVG2l5vdQpWoHqTJGMP04Rw0a0F+uz632kDOuyPd/pphBfF8HyQ3BAmi+2DV
         GcWfkFfZZp/ZOSrz7ahDeMUE+u5Dn2eMmShBhIuCSXfUJBO6qZvYEaqiM1wsC9ZqKISW
         6gXttgb+EltBgA8gXVa9U2T+QzpOkIOG5+3w/R/sS7Q64LHhAU69bXr+Hmle2Na59pB0
         e09A==
X-Gm-Message-State: AOAM532nzHMexwSpWVnLBkl6PvrImEd93w2r2jCWPqjfZRP5deAyRypY
        ZFJk7rMccS1PodZ7QIHnXuf7t0dU
X-Google-Smtp-Source: ABdhPJxjh/Eui0JevLX7Wfwb1pz0k39Lh9xPBsR923/d2gZjs0VkOLvsQK9gTUMTNOXtjfdvZ3FaJw==
X-Received: by 2002:a17:906:8d5:: with SMTP id o21mr5347722eje.155.1595287053732;
        Mon, 20 Jul 2020 16:17:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be2sm16175104edb.92.2020.07.20.16.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 16:17:33 -0700 (PDT)
Message-Id: <pull.679.git.1595287052428.gitgitgadget@gmail.com>
From:   "David J. Malan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jul 2020 23:17:32 +0000
Subject: [PATCH] git-prompt: changes == to = for zsh's sake
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "David J. Malan" <malan@harvard.edu>,
        "David J. Malan" <malan@harvard.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "David J. Malan" <malan@harvard.edu>

When using git-prompt.sh with Zsh, __git_ps1 currently errs
when inside a repo with:

__git_ps1:96: = not found

This commit changes `==` to `=` for both Bash and Zsh.

Signed-off-by: David J. Malan <malan@harvard.edu>
---
    Changes == to = for zsh's sake in git-prompt.sh
    
    Upon installing git-prompt.sh
    [https://github.com/gitgitgadget/git/blob/master/contrib/completion/git-prompt.sh] 
    on macOS Catalina, I noticed that 
    https://github.com/gitgitgadget/git/commit/afda36dbf3b4f5a489ab44c00d5210c1fa894a40 
    seems to have introduced an issue for Zsh whereby __git_ps1 errs with
    
    __git_ps1:96: = not found
    
    when inside a repo. Changing == to = would seem to address for both Bash
    and Zsh.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-679%2Fdmalan%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-679/dmalan/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/679

 contrib/completion/git-prompt.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index e6cd5464e5..16260bab73 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -433,7 +433,7 @@ __git_ps1 ()
 	local sparse=""
 	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
 	   [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
-	   [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
+	   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
 		sparse="|SPARSE"
 	fi
 
@@ -542,7 +542,7 @@ __git_ps1 ()
 		fi
 
 		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
-		   [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
+		   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
 			h="?"
 		fi
 

base-commit: ae46588be0cd730430dded4491246dfb4eac5557
-- 
gitgitgadget
