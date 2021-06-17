Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1279C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 12:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2243610CA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 12:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhFQMpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 08:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhFQMpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 08:45:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DAAC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 05:43:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h12so2868807plf.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3+otodH/QdXZD0zyr+G9FTj3F0xqWPnnk1dxpSzul8=;
        b=XQnukkXlMlWdTukK1AMdEkFsQn0robdrpOz1ktt3AcYXqRNL+q16GSHGM5DTreH+C+
         qO0Hpn3WGHAlZ6w5VdGGE0goPoHog3WOHzKvnotRsKcnucC7u0aEeqR5QASxpyfyuoYx
         ycbxHWErmachN5AQbO1bZbTgsFcxirytltTX1v5oRkr+UnoeLqFlJfiAvQkvCUD29PJt
         eQRLfoCZiv/mIZ276SEFjR3z/57qtMSSSDD3B2jALvb0Q5rIxJ0lRh328CF5LU2zNQGz
         5H2L/HLI2nQCHYiAbeLjj6VZZaRirWpbI0/KQcdkgdJqFGvPJ+j3lL0tCLzyFMxTscGO
         rhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3+otodH/QdXZD0zyr+G9FTj3F0xqWPnnk1dxpSzul8=;
        b=qt1xfG+3H70r1yW+5HQ3d1tTQa3xSZe3mLu/uHzgMrr2OYiuLpTEPXYt3FOJcYw4D2
         FV/LzB/U0eMjVsV0Q3OvZh9ncnfdeYnYkQUNz+TH6XJhjFY+VSIYDL6tBDQdMoGAOf4/
         rjYwG036nFviFQD8KcqO+2QpawF7GIDIOsWvu3JLhWX09Mj11SG5RB5Bl8APkL+EuGO9
         +SPbiy4t8q20uOgYi6EEiBes77Tq5McPZUy8AhTJLB+T5AOABiwSm/u0eE/KyiD4fbYi
         dPKQWZw48BV8ecrmanGCLdnfT9+GOQ8iHYl1OCo3VflGWa+3wuGnHyY46scaxXIyIhew
         zR5w==
X-Gm-Message-State: AOAM530ID7au7DK4PHnNZWnT2OPFAcp+/a3pWtEWAGoiuJYwm0kf1nVZ
        nRU7wkA2pmB7cMWUWgyJcx8=
X-Google-Smtp-Source: ABdhPJwtXEN6lCgpC1ANsVxXbMApMe890ZqslkybkWobXkOFGi59GLLUIgGoxXiJjAOl4OgBabXvkA==
X-Received: by 2002:a17:90a:3d09:: with SMTP id h9mr9825877pjc.78.1623933821639;
        Thu, 17 Jun 2021 05:43:41 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.154])
        by smtp.gmail.com with ESMTPSA id t143sm6532247pgb.93.2021.06.17.05.43.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jun 2021 05:43:41 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 1/2] test-lib-functions: test_create_repo learns --bare
Date:   Thu, 17 Jun 2021 20:43:30 +0800
Message-Id: <20210617124331.17888-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc0.27.g7b1e85181b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"test_create_repo" learns --bare option to create bare repository.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/test-lib-functions.sh | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b823c14027..f6d1afe295 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1216,8 +1216,21 @@ test_atexit () {
 }
 
 # Most tests can use the created repository, but some may need to create more.
-# Usage: test_create_repo <directory>
+# Usage: test_create_repo [--bare] <directory>
 test_create_repo () {
+	bare= &&
+	while test $# -gt 0
+	do
+		case "$1" in
+		--bare)
+			bare=yes
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done &&
 	test "$#" = 1 ||
 	BUG "not 1 parameter to test-create-repo"
 	repo="$1"
@@ -1226,10 +1239,13 @@ test_create_repo () {
 		cd "$repo" || error "Cannot setup test environment"
 		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" -c \
 			init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
-			init \
+			init ${bare:+--bare} \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
-		mv .git/hooks .git/hooks-disabled
+		if test -z "$bare"
+		then
+			mv .git/hooks .git/hooks-disabled
+		fi
 	) || exit
 }
 
-- 
2.32.0.rc0.27.g7b1e85181b

