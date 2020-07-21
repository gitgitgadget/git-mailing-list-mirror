Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C733C433E3
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7641722B4E
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5KYgbad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgGUAPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgGUAPe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 20:15:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81CEC061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:15:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so1081158wme.5
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8+YsBq/e0H7Zvp/XsVzS22w1DNxPG/eAqXPwRmpDHxo=;
        b=f5KYgbads2g8VJ3CGi0qaTCUSJq//zCWzuSgtiSEhr5uHbMX8rP4HVzKXRPXGY8M5s
         N7fmJIidfQKMWRrBwNu/u9/CSTNzNPDgBRGqekbhBSC/3ISxq78IhZqDVzXh4c6rRbYu
         b/gdZorakCTJpt20uuyJoorp3FyPL3wvi3G7kwpnHSk79F7VmGlVXb/LSJzBFQqf1ITW
         Emt2G1Vj38xX7wBq0tl/HJ/EngtjRdwXKPS6+r9kEEG4trKbaaIIxmUYbWAo4Cllo+4U
         pHyvjKTFyaLREqG+Z3DAkBXc4MAONi0TMNuYLlCG7y7bsOz1gNkpAUt3TGECi4G1XCjG
         U6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8+YsBq/e0H7Zvp/XsVzS22w1DNxPG/eAqXPwRmpDHxo=;
        b=Z20CAM4xr0grBSSLOXt6Bo1/8qPcw0d7ZUV/rnlKZIOGPA0M9jmU4wk3KJ/ITmlJsP
         gEKf79gYqxxlgkvvBEG+QIY6urvDYSPb601hMHAxHRz53xxF7GYXg2ZsYPqG8uoiykzt
         WBEozf/j04QaVzXnYd+xiGwXVcmOe+eR0xx65aVdsVvNw4ruaPsvmae3KoBOnzddDGXi
         bZFskVdX0aZIsxwpW3KfgzlJdk0/WP4CfnVOO0p5nVNYII+X4vP8vwlK39QBwTSgqRPx
         Uy0lUEX16vTul/p2DqKmofbxcUOenS80MunhaUhcCBDy05KBf+Ffh6oaW6KM6E3RIRvl
         8Taw==
X-Gm-Message-State: AOAM530vVZ6nyQAqHlnqrK4U9IiHwVW0JIo3qpuF2/F71IaXe09Dyt5f
        c2k33TC+D+IWFg9LsuhBSnGCKQTG
X-Google-Smtp-Source: ABdhPJxMi52sPE5znkQ59dOvyLM59IHHCn/6FHOr/CipJy09MZF7RPjv7Rgb8x685yPwZs3Mcz5IMg==
X-Received: by 2002:a1c:286:: with SMTP id 128mr1002012wmc.37.1595290532529;
        Mon, 20 Jul 2020 17:15:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j145sm1417140wmj.7.2020.07.20.17.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 17:15:32 -0700 (PDT)
Message-Id: <pull.679.v2.git.1595290531264.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.1595287052428.gitgitgadget@gmail.com>
References: <pull.679.git.1595287052428.gitgitgadget@gmail.com>
From:   "David J. Malan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jul 2020 00:15:31 +0000
Subject: [PATCH v2] git-prompt: change == to = for zsh's sake
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

When using git-prompt.sh with zsh, __git_ps1 currently errs
when inside a repo with:

__git_ps1:96: = not found

Avoid using non-portable "==" that is only understood by bash
and not zsh. Change to "=" so that the prompt script becomes
usable with zsh again.

Signed-off-by: David J. Malan <malan@harvard.edu>
---
    Change == to = for zsh's sake in git-prompt.sh
    
    Upon installing git-prompt.sh
    [https://github.com/gitgitgadget/git/blob/master/contrib/completion/git-prompt.sh] 
    on macOS Catalina, I noticed that 
    https://github.com/gitgitgadget/git/commit/afda36dbf3b4f5a489ab44c00d5210c1fa894a40 
    seems to have introduced an issue for Zsh whereby __git_ps1 errs with
    
    __git_ps1:96: = not found
    
    when inside a repo. Changing == to = would seem to address for both Bash
    and Zsh.
    
    Changes since v1:
    
     * Commit message rewritten to use imperative mood.
     * Commit message rewritten to elaborate on reason for change.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-679%2Fdmalan%2Fpatch-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-679/dmalan/patch-1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/679

Range-diff vs v1:

 1:  95be513ed1 ! 1:  f5402f1512 git-prompt: changes == to = for zsh's sake
     @@ Metadata
      Author: David J. Malan <malan@harvard.edu>
      
       ## Commit message ##
     -    git-prompt: changes == to = for zsh's sake
     +    git-prompt: change == to = for zsh's sake
      
     -    When using git-prompt.sh with Zsh, __git_ps1 currently errs
     +    When using git-prompt.sh with zsh, __git_ps1 currently errs
          when inside a repo with:
      
          __git_ps1:96: = not found
      
     -    This commit changes `==` to `=` for both Bash and Zsh.
     +    Avoid using non-portable "==" that is only understood by bash
     +    and not zsh. Change to "=" so that the prompt script becomes
     +    usable with zsh again.
      
          Signed-off-by: David J. Malan <malan@harvard.edu>
      


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
