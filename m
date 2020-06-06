Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C6FC433E0
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 04:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5078B207F9
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 04:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnArjCVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgFFEdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Jun 2020 00:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgFFEdn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jun 2020 00:33:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB0FC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 21:33:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l10so11683334wrr.10
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 21:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tXKRIpT0YZrgsqkOsFn+9oRCTb4cyTx9CaO/wFdHmZc=;
        b=WnArjCVt5rl6vCzc2yQoMBnft2har0/Qc5We29+jXciPy32WSN9k46LzmWqaMk1MUf
         QP+xxaenUY5qSIL4GG+C0mGRqUnm2z3Ganck+vCqbD3RwI4JYSNKrwK2RNIcjb0UyKb6
         jk/ekQYGCaWDqHOBeSobl2SioqJW3Gs6Gz/0S8+sFeFhz4artLT3iwmxncgrHsA2CqSs
         r/hpt1DBq1vqhG+IUiUGhh6VlVnedw0uN0wv25FC753MEFwstBbdfzcgAB1+zLtXTZrY
         Xi2os/NRd0+OO+uIqxyTUczAd4PNvNVADpapXYrIc/wkby/SgcWRBxptPXKmsvtgWn89
         oqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tXKRIpT0YZrgsqkOsFn+9oRCTb4cyTx9CaO/wFdHmZc=;
        b=EBns3XjC3yS5D0K16fY2aV4ZNce10ICk+gWnPH30T5Wa/t2teVzYZ5R6BsmS+0rsRA
         y7686kqrwqv9KkkmNJyZmdvfyFQahWNAhyib2XXr5ektZZ/RQXAd7N9pKQVmo5ATjazn
         rcOli8XZ9/J0+rDj79j94J/3v/HcOn0jgYMUxegd+st/4GlClV2w2xgUutqsUohsQJe1
         +QIYrhMiFiHdOLyQMP93zS6GHrEEwekqRnPhOGHhUYY4Piu1l7GOTQ8pxlC7dHESgYH/
         lnJBGG7aPe6NN4btRI+kd29NCd36b8r7AoccjzkQE33GFgpS/DImYtVecZdP8B/O8yuR
         eD8Q==
X-Gm-Message-State: AOAM531ysQbJqDpulHQyxjGhcR/AtJYxo6Yjf/tLrdj0c42SIyNxqKMI
        FnDEFtxpxW4G9x+7FzHULwwOLH/R
X-Google-Smtp-Source: ABdhPJzEr063Wz7+YfOMqwHCdj8jY6B3WbsjXHNOGHmZSRtcawd6dxFqfPR9/ei5hs9HU/2w76cDlQ==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr12618332wrv.112.1591418020298;
        Fri, 05 Jun 2020 21:33:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b201sm13590665wmb.36.2020.06.05.21.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 21:33:39 -0700 (PDT)
Message-Id: <pull.644.v2.git.1591418019023.gitgitgadget@gmail.com>
In-Reply-To: <pull.644.git.1590507201474.gitgitgadget@gmail.com>
References: <pull.644.git.1590507201474.gitgitgadget@gmail.com>
From:   "Mikhail Terekhov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Jun 2020 04:33:38 +0000
Subject: [PATCH v2] git-gui: allow opening work trees from the startup dialog
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mikhail Terekhov <termim@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Mikhail Terekhov <termim@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mikhail Terekhov <termim@gmail.com>

In proc _is_git check that supplied path is a valid work tree path.
This allows the choose_repository::pick dialog to accept path to a
work tree directory.

Signed-off-by: Mikhail Terekhov <termim@gmail.com>
---
    git-gui: allow opening work trees from the startup dialog
    
    Trying to open a working tree from the "Open Existing Repository" link
    of the git-gui startup dialog results in an error: Not a Git repository:
    .... This patch fixes that error.
    
    Changes since v1:
    
     * Use git rev-parse instead of rolling our own logic to check if
       something is a worktree as suggested by Pratyush Yadav 
       me@yadavpratyush.com [me@yadavpratyush.com] and Eric Sunshine 
       sunshine@sunshineco.com [sunshine@sunshineco.com].

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-644%2Ftermim%2Fgit-gui-open-worktree-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-644/termim/git-gui-open-worktree-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/644

Range-diff vs v1:

 1:  ca55ec3adb4 < -:  ----------- git-gui: allow opening work trees from the startup dialog
 -:  ----------- > 1:  c3b378fe397 git-gui: allow opening work trees from the startup dialog


 lib/choose_repository.tcl | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index e54f3e66d8f..07f29b0b13b 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -357,31 +357,12 @@ proc _is_git {path {outdir_var ""}} {
 	if {$outdir_var ne ""} {
 		upvar 1 $outdir_var outdir
 	}
-	if {[file isfile $path]} {
-		set fp [open $path r]
-		gets $fp line
-		close $fp
-		if {[regexp "^gitdir: (.+)$" $line line link_target]} {
-			set path [file join [file dirname $path] $link_target]
-			set path [file normalize $path]
-		}
-	}
-
-	if {[file exists [file join $path HEAD]]
-	 && [file exists [file join $path objects]]
-	 && [file exists [file join $path config]]} {
-		set outdir $path
-		return 1
-	}
-	if {[is_Cygwin]} {
-		if {[file exists [file join $path HEAD]]
-		 && [file exists [file join $path objects.lnk]]
-		 && [file exists [file join $path config.lnk]]} {
-			set outdir $path
-			return 1
-		}
+	if {[catch { 
+		set outdir [git rev-parse --resolve-git-dir $path] 
+		} ]} {
+			return 0
 	}
-	return 0
+	return 1
 }
 
 proc _objdir {path} {

base-commit: c195247812f8cd38ba7e1c603112e6c1d8d8e71e
-- 
gitgitgadget
