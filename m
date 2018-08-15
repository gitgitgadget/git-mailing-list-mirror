Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE411F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeHOTQD (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:16:03 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:42557 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbeHOTQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:16:03 -0400
Received: by mail-lf1-f48.google.com with SMTP id 95-v6so1273534lfy.9
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQpIWNmWxkzL2wgwQF80WTUBVaZEhzzqQUIVZnx/J74=;
        b=Pmmg3AoITGSLennxO6FgfVWrDTKhWj9uWOxtGCl31nzzKuug+g3rmBIjBhi1sHrf+G
         BbAEcgegNu2DXepPODdhpX2X/IquMAudoum9aZWywUA7L84cLPHPwxQm5oi5X5H4Ncbl
         l5i8E7e2y4oEXOJ2hotWU2t6j5sX+OXkJqZgIZfDuJqYpJSv5Wj+O5bfpiAq0Be40WZI
         9J/DrRz8pzl3xSiHKiCgkN5Q1Np3hKwbC9KGLbf46bmWj/OtZO4z9egq6pFKum0kMoSf
         cXMYV+Uf9UcJUc73O87SVVdmIN8otit6gpOwIZOJqVRP05yOIKRblFUrqqZ00C0afeOH
         NIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQpIWNmWxkzL2wgwQF80WTUBVaZEhzzqQUIVZnx/J74=;
        b=trHSHZOCLdF4WsmSEISuANK4PlkTl9pcXV6omOwpLcUJW+YomVToS0AhOXUoZfkzQB
         R3gRLba3JGlFPvD7tRMT1dXHbuqcxKq19tQWFW4kmFNl8hu7AnliTY+oPDuHArbN/XUO
         LSF3iww3j7/H1P2JrVOfyf+Wxlko0HrYPRef0OySkvhqq5dQOpyB9Pa6ngpDL01Lu+xk
         0eL2lr5Ii7ZymdynFPTQUX9rkCgW73OTPpWrqHxLaPOm+iAOsqEG89yZ+2/VEwbXjF7V
         N7EWd4VHjcs5sdR3crGn23xc5tTr1ydiG5I5IqI7cNfnd1NZQpCZk5t/G9poFvZJGA9C
         rRaQ==
X-Gm-Message-State: AOUpUlGJ9l1aCt2DVE6kNVKcNqzKlhMmdXw9rzApJ1rXmjasYGPXDsDv
        MpYmzgGAmiQ+ILm1hofhAUwGKXBd
X-Google-Smtp-Source: AA+uWPz5FnI4+yWnFkKBIAZkSU//HKUei1wnHmshQ0yI6gpySvT7g5UBjZg/PPuRPRtOgt6bydiQMw==
X-Received: by 2002:a19:189c:: with SMTP id 28-v6mr1967169lfy.7.1534350192968;
        Wed, 15 Aug 2018 09:23:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h9-v6sm4501354lfc.47.2018.08.15.09.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 09:23:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] cherry-pick: fix --quit not deleting CHERRY_PICK_HEAD
Date:   Wed, 15 Aug 2018 18:23:08 +0200
Message-Id: <20180815162308.17747-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180815162308.17747-1-pclouds@gmail.com>
References: <20180815162308.17747-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--quit is supposed to be --abort but without restoring HEAD. Leaving
CHERRY_PICK_HEAD behind could make other commands mistake that
cherry-pick is still ongoing (e.g. "git commit --amend" will refuse to
work). Clean it too.

For abort, this job of deleting CHERRY_PICK_HEAD is on "git reset" so
we don't need to do anything else.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/revert.c                | 9 +++++++--
 t/t3510-cherry-pick-sequence.sh | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 76f0a35b07..e94a4ead2b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -7,6 +7,7 @@
 #include "rerere.h"
 #include "dir.h"
 #include "sequencer.h"
+#include "branch.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -191,8 +192,12 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
 	opts->strategy = xstrdup_or_null(opts->strategy);
 
-	if (cmd == 'q')
-		return sequencer_remove_state(opts);
+	if (cmd == 'q') {
+		int ret = sequencer_remove_state(opts);
+		if (!ret)
+			remove_branch_state(the_repository);
+		return ret;
+	}
 	if (cmd == 'c')
 		return sequencer_continue(opts);
 	if (cmd == 'a')
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3505b6aa14..9d121f8ce6 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -103,7 +103,8 @@ test_expect_success '--quit cleans up sequencer state' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..picked &&
 	git cherry-pick --quit &&
-	test_path_is_missing .git/sequencer
+	test_path_is_missing .git/sequencer &&
+	test_path_is_missing .git/CHERRY_PICK_HEAD
 '
 
 test_expect_success '--quit keeps HEAD and conflicted index intact' '
-- 
2.18.0.1004.g6639190530

