Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128EC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C334160D07
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhJUSj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUSj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 14:39:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B5C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 11:37:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k7so885031wrd.13
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFZUYcVK0MByPrZv1WXQWvlKgEDPvCt7OlY0il8swaQ=;
        b=PElsgUNmwnl2gGEC6tcdBRYqDShSz+mysl/MesF/7BILn7buob3O06X/6GBclFg8SD
         Lp5BK3h/RtnL0j1qTdMJ7WPCGyD89yE/dJrihFBwwcV/jLQlB2EuD1uXb3XDrm3dfIXE
         gLUx9OipsCXP1jAmELVThuB17KtBdv9FRh+GoQ23JnxNvWXgbdOXbGb30OFWqhanFYBg
         tkqjTmQTg3tPdU5mjPWQTvcDVIplAM9Yx8/BNGQv/H99Jf+WeRtLm20GznmWunStfEXA
         09TUTYIAdMOxlel90R2i4UwLeDJCgnY15YEsYUcjw2Bn9tBrJQVPsptg+7lnWmjtxGSG
         443w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFZUYcVK0MByPrZv1WXQWvlKgEDPvCt7OlY0il8swaQ=;
        b=WNVP9Xi7wn52bJ/29V8BeUoxoZjYB+ayLGka/jP0lVT2phBSk+Iv8jaIApbTAKuBLP
         0JP/Y+pfcv4raV+EF4Y32RBqCz8sgSbR80IUCPPx8ccSXvIPosL7FZ/y7UNJQD1jsMbZ
         qjQCmVlV5du+CJxUxgYY6FNKH3DKv/Glreb3o6YEob0dZOaKUutWhamDoFaY47Dk4T+T
         3Xd97jzH4OgeoEpCCPzWUsyEeTDx1C9TfHGUadsu+o9CyTuMbgMFLLml8JyknzwnT4Qz
         ebF1byZbm6cFqyC5MYWswL6YPJ7hH+KH3ai6XJNbcPT+bJKxdrncM/prhN0aA3jvBqQA
         zPnA==
X-Gm-Message-State: AOAM533hXQEZMwuSdIZ2fcW6p8SRq+8EoqnersWKUbfpUvHOp7XbnBhr
        yYOjw9tTIqSPWiaPBI05A8D3XgkwxYjK+g==
X-Google-Smtp-Source: ABdhPJx6AgnCVCgFkH0OCRPuhrWxdQbVC2fOQXGNvQ9R1xxztUCGR2mcte/D+SRV7LEPL9RMYNzihw==
X-Received: by 2002:a5d:4a8e:: with SMTP id o14mr241616wrq.131.1634841458445;
        Thu, 21 Oct 2021 11:37:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm7048278wrs.5.2021.10.21.11.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:37:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] git-sh-setup: remove messaging supporting --preserve-merges
Date:   Thu, 21 Oct 2021 20:37:33 +0200
Message-Id: <patch-2.2-556cf184fc9-20211021T183627Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.2-00000000000-20211021T183627Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211021T183627Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove messages that were last used by the code removed in
a74b35081c5 (rebase: drop support for `--preserve-merges`,
2021-09-07).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-setup.sh | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index cee053cdc38..960982f9d53 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -217,9 +217,6 @@ require_clean_work_tree () {
 	then
 		action=$1
 		case "$action" in
-		rebase)
-			gettextln "Cannot rebase: You have unstaged changes." >&2
-			;;
 		"rewrite branches")
 			gettextln "Cannot rewrite branches: You have unstaged changes." >&2
 			;;
@@ -235,14 +232,7 @@ require_clean_work_tree () {
 		if test $err = 0
 		then
 			action=$1
-			case "$action" in
-			rebase)
-				gettextln "Cannot rebase: Your index contains uncommitted changes." >&2
-				;;
-			*)
-				eval_gettextln "Cannot \$action: Your index contains uncommitted changes." >&2
-				;;
-			esac
+			eval_gettextln "Cannot \$action: Your index contains uncommitted changes." >&2
 		else
 		    gettextln "Additionally, your index contains uncommitted changes." >&2
 		fi
-- 
2.33.1.1494.g88b39a443e1

