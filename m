Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49DF9208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeHHR2r (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:28:47 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33986 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHR2r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:28:47 -0400
Received: by mail-ed1-f49.google.com with SMTP id h1-v6so1436829eds.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3SjqkVGDcjXMwiwTRmN1EiI1j8c+J3Mn9b+nGKu6AK0=;
        b=mPfffA3AjVYVHl2FBo3cHHziucQn5zFslFbId6+HlfLB6qwjKJYi1TTfKCoGLHevBK
         lH9zlPoV/5ApXRgj2IgL6FHKChnvABWeldrdAqFw4SXmIf3DIvwQuMbzIMWVo/cFH5R/
         dbO1o1w/52NCPitLtqJJjAIxQV0aGu1JqBT9TL9F7hBDNyM3aRrpGVubyE9WmCihmrqb
         fUgO5fmb0Ob+LVoZ+RuPTearYQx5Jrjc+zigREOLFGooQpc526JkdjD/mpoJDrEVFfl8
         +Yr4jdg5dl3wvDv18QeV0rJ9D8J584ipvotXcZIAHsCWC65m2MGpQx5pREjNRWeBMgyJ
         HuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3SjqkVGDcjXMwiwTRmN1EiI1j8c+J3Mn9b+nGKu6AK0=;
        b=kQDq1H65H/XVE7pOJkZH2oDUCzrvbxvoFJb0gHt1BgMuJhRoOSmOJTm0qC9TYi439L
         pG5Xnx8rGaGNHGhiGagjqLesZC+arMI079Y3p2I7cxeVR0gOlfrdywAmhWuNC9egZgto
         PwMtsbSEc/M/vL50Fzfwqi0rac91aD+DvXuNmKqGh48ut16r7s4RNcI6XcPKuttGn96p
         8wR9viRwLIrn3qoCoOyFrD2DbBmgczGL1Qd/driM6MabFcMHDtafyPgP3AY93pOyHmdf
         xRHS4yfXTQDkH737OAT6FVguoENkFovaIr9Sl7Uem8y0IiFNRFIEKavrc4U+1ksT5RFv
         24dQ==
X-Gm-Message-State: AOUpUlHfJbp9bIERQC8BGHzUP2Q9TI+YxGgGuq1Zt+qZeQ548r+IRPHu
        3SogEq7YpIE/4pcDLJRo9NAhcadR
X-Google-Smtp-Source: AA+uWPzTdq6kNnEqKIhbNpUkJntG0qMNLUnagx80Df4EyD/zIeW3C3xTDcfFohGmByFDHNU0DSAnSw==
X-Received: by 2002:a50:bec2:: with SMTP id e2-v6mr3793633edk.283.1533740921219;
        Wed, 08 Aug 2018 08:08:41 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id w1-v6sm6771259eda.63.2018.08.08.08.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:08:40 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 2/7] builtin rebase: support --skip
Date:   Wed,  8 Aug 2018 20:51:17 +0545
Message-Id: <20180808150622.9614-3-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808150622.9614-1-predatoramigo@gmail.com>
References: <20180808150622.9614-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds the option `--skip` which is used to restart
rebase after skipping the current patch.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 10da4c978b..7a903838b1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -21,6 +21,7 @@
 #include "diff.h"
 #include "wt-status.h"
 #include "revision.h"
+#include "rerere.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -468,6 +469,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	enum {
 		NO_ACTION,
 		ACTION_CONTINUE,
+		ACTION_SKIP,
 	} action = NO_ACTION;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
@@ -492,6 +494,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			REBASE_FORCE),
 		OPT_CMDMODE(0, "continue", &action, N_("continue"),
 			    ACTION_CONTINUE),
+		OPT_CMDMODE(0, "skip", &action,
+			    N_("skip current patch and continue"), ACTION_SKIP),
 		OPT_END(),
 	};
 
@@ -590,6 +594,20 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			exit(1);
 		goto run_rebase;
 	}
+	case ACTION_SKIP: {
+		struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+		options.action = "skip";
+
+		rerere_clear(&merge_rr);
+		string_list_clear(&merge_rr, 1);
+
+		if (reset_head(NULL, "reset", NULL, 0) < 0)
+			die(_("could not discard worktree changes"));
+		if (read_basic_state(&options))
+			exit(1);
+		goto run_rebase;
+	}
 	default:
 		die("TODO");
 	}
-- 
2.18.0

