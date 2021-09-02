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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D20CC433ED
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1267B60FDA
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhIBQCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346107AbhIBQCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:02:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBA2C061292
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:01:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v10so3756803wrd.4
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qolNeKZxYbSuGw0L4nFMrT6UXk5Hcoeke3BEUa3OocA=;
        b=lslreY2dXoQFiFTQO+dq4NqNUUoYVGx5PWUmXIJp8Ch27AsxsjOIsEr5eiYShAc1xx
         dKaMTzVYIrOa9DICCLZAoGmKMjWZSK9bmvhOy7pPIFSWm/2BP1dieuWUvi9gd4frF+Ky
         JRsYtanTTjE3Nqe/WMmoxYeY2PgtnChbM2hUZa1rNmpQniKyjYo4e01KAVpnHHB/vDu+
         8atljkLbCkgUQFcCjQRFORDbVu8/qfHr6X54L751jOgy0qnAa2U5CEadFFHUvHvM2yla
         McmbXrUGYFLFCU47NOW9FXu4SGn+Uy40ySkxyfw0MKT70pGIM5TvDleF6TT+HqcKgxpN
         OA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qolNeKZxYbSuGw0L4nFMrT6UXk5Hcoeke3BEUa3OocA=;
        b=WCULasP+YPUPfqFPBn2DJBNL/fKnq1AtdlnKkBvbz9oloZ0e/7QdIctiNySq+rh2Xx
         Iv5zj7IwWTmyHbRAQaeVS66lzC90s+PSZTbDFn/yeFA6p+O7ibtR7O/IfxfHQ1FBbt4v
         YM8uHKHeOLT+V1mlSNIMGo/XVLesv/NilnIkvEyw3Nc/uihcG0bCmY804xFHBWgtrzEa
         J8Gr17Qzu49Sne4d32HenakVLMXpwh7ZgEAWe3fD3F/UnpCvY8fsWcJBE9CyUBfvNdRp
         UTe84tv6Rzbia66E+2R98dXhEVfNYvj+LgJOsUrXXCS28T3AqpPDU8ursa+wYnsNs0LB
         AcEg==
X-Gm-Message-State: AOAM530O9Sf7neQazMYPsCoAPDWfCJ1Hrc5O7TkC/Bd3/Zjp+snTxTKS
        zeP1SmmMf5EL49R4rYgivhIDVuaagL9DnQ==
X-Google-Smtp-Source: ABdhPJyvzftqbknVl8uB7xeKlLxP3Omjj2O89KAU/JyqgwynNEDklnAUx3uqzwRI4fdjhU4hCiqK/g==
X-Received: by 2002:a5d:4568:: with SMTP id a8mr4841998wrc.200.1630598490710;
        Thu, 02 Sep 2021 09:01:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u26sm2403215wrd.32.2021.09.02.09.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:01:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/9] git-sh-setup: move peel_committish() function to git-subtree.sh
Date:   Thu,  2 Sep 2021 18:01:14 +0200
Message-Id: <patch-7.9-a3047b93f7d-20210902T155758Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.814.gb82868f05f3
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the peel_committish() function out of git-sh-setup to its only
user, contrib/subtree/git-subtree.sh. Since d03ebd411c6 (rebase:
remove the rebase.useBuiltin setting, 2019-03-18) when
git-legacy-rebase.sh was removed, it has only been used in
git-subtree.sh.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/subtree/git-subtree.sh | 12 ++++++++++++
 git-sh-setup.sh                | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7f767b5c38f..a6deb57bcae 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -818,6 +818,18 @@ cmd_add_repository () {
 	cmd_add_commit FETCH_HEAD
 }
 
+peel_committish () {
+	case "$1" in
+	:/*)
+		peeltmp=$(git rev-parse --verify "$1") &&
+		git rev-parse --verify "${peeltmp}^0"
+		;;
+	*)
+		git rev-parse --verify "${1}^0"
+		;;
+	esac
+}
+
 # Usage: cmd_add_commit REV
 cmd_add_commit () {
 	# The rev has already been validated by cmd_add(), we just
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6a21238dc0e..9243353bc21 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -294,15 +294,3 @@ if test -z "$NONGIT_OK"
 then
 	git_dir_init
 fi
-
-peel_committish () {
-	case "$1" in
-	:/*)
-		peeltmp=$(git rev-parse --verify "$1") &&
-		git rev-parse --verify "${peeltmp}^0"
-		;;
-	*)
-		git rev-parse --verify "${1}^0"
-		;;
-	esac
-}
-- 
2.33.0.814.gb82868f05f3

