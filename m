Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3ECC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4D12065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulKcYjmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390849AbgEMUSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732650AbgEMUSC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 16:18:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75800C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:18:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so237542pgb.7
        for <git@vger.kernel.org>; Wed, 13 May 2020 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Imj3wIq3xVDOfLpjQsOikIFNWQZhmNIw20g66/xrbqg=;
        b=ulKcYjmi9550y7xoXRSavVaGv1P9Jup+GqXyF1wePoYeJ9IM3HaKiZmV5fX1gfq9o/
         k+wqsCX/Z85I75Mk+67tJcSvb7j88F7w79SYAVIE9dDUKll8vVMzx9C3vON3kiO3/qpt
         qs36NupnUW0MNhsgeLk8WZVjaOgEINzX+fcfIoIyEvPxLGDAd3WuSuqDFZRyeSHrN5SD
         pPiAOVgo4G8cA8Ji5awRJkmPVywseea/Vp3MV+OozzUl3YtJQLMfjysXd8aNbjRV2b96
         3zbOxnC9xrFvI91070nN4DV606nyePLCBuj83i+7CEsuxVKvbvIhxbPpMMkXLBSXzLvW
         t9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Imj3wIq3xVDOfLpjQsOikIFNWQZhmNIw20g66/xrbqg=;
        b=dRWbif+AqlWEWeUxW35MuYk1uF85fvmpA1/Zl3oILHKeW+kbALRGNCAJvQe0SVbSYG
         JWNiepeSiXl9sMw1z3Qh+c6YU8NRgj6tGU6Ipkf6jb4rLHRPRckBa+RLDD57QnwXJVgV
         T9X15DR/rNd+fBgMiA8NT8v9eYgPgULNKjw1ZqgAjMnfM7GhnEf46PhkVjCUwet/Gy2C
         WCDqOi/nYU5HoJ0OVoEKWngKY+LRD/NUkGnkzJ/lScNNLCjBOmZZ9UnWZ5iXdFoUhxSo
         3x9OAmduF2rDfWf7bSnBP1OSs07OdS1nODg2cOOB9zP78MniUnOfHPJc8wGHiBokv/u1
         BN7g==
X-Gm-Message-State: AOAM531J1ywQRFlzIwj6vH1hXLIh74YILuE5RYqJuQ4swkkZBM1Rkmgg
        BKrg/19kVKdKrdT3x4Rdhf0clM5FPOo=
X-Google-Smtp-Source: ABdhPJx326jRNsYRAq43Vf4by+nLxS9AXRT518DC1KhVqU1AMueuicXIdEkJSqoSIBAqMmOu+7hfow==
X-Received: by 2002:aa7:8b15:: with SMTP id f21mr963989pfd.72.1589401081412;
        Wed, 13 May 2020 13:18:01 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id b1sm342804pfi.140.2020.05.13.13.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 13:18:00 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        gitster@pobox.com, liu.denton@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] submodule: Add 'quiet' option in subcommand 'set-branch'
Date:   Thu, 14 May 2020 01:47:37 +0530
Message-Id: <20200513201737.55778-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subcommand 'set-branch' had the 'quiet' option which was
introduced in b57e8119e6 by Denton Liu but was never utilised due to
not setting of the 'GIT_QUIET' variable. Add functionality to
utilise the 'quiet' function.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
There was an existence of the `quiet` option in the shell version of
'set-branch' but it was not used anywhere. I decided to add a utility
of the option here by setting GIT_QUIET to 1 in case of a `quiet` as
well as ensure proper functioning in the C version regarding the same.
The if-statement is inspired from what Junio suggested me in my previous
conversion of 'set-url'.

 builtin/submodule--helper.c | 6 ++++--
 git-submodule.sh            | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5a8815b76e..36b69df5c4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2321,7 +2321,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		config_name = xstrfmt("submodule.%s.branch", path);
 		config_set_in_gitmodules_file_gently(config_name, newbranch);
 
-		printf(_("Default tracking branch set to '%s' successfully\n"), newbranch);
+		if (!(quiet ? OPT_QUIET : 0))
+			printf(_("Default tracking branch set to '%s' successfully\n"), newbranch);
 		free(config_name);
 	}
 
@@ -2334,7 +2335,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		config_name = xstrfmt("submodule.%s.branch", path);
 		config_set_in_gitmodules_file_gently(config_name, NULL);
 
-		printf(_("Default tracking branch set to 'master' successfully\n"));
+		if (!(quiet ? OPT_QUIET : 0))
+			printf(_("Default tracking branch set to 'master' successfully\n"));
 		free(config_name);
 	}
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 2438ef576e..0cdc77ace6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -725,7 +725,7 @@ cmd_set_branch() {
 	do
 		case "$1" in
 		-q|--quiet)
-			# we don't do anything with this but we need to accept it
+			GIT_QUIET=1
 			;;
 		-d|--default)
 			default=1
-- 
2.26.2

