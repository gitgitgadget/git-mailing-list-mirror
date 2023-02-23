Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CDEC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 05:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjBWFeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjBWFer (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 00:34:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A3E04F
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:34:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id pt11so12226374pjb.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL04JieBI0gvtYFp0bggEsvKDI2A3ibBIjkSWhu7dSA=;
        b=GBFUf4XUhvWczxsIgt7u6DxkixdvLbsfGyQ2K4WIS/12RwdXxhQhTqNqrDIawU2g1U
         ukIzyusv0OFWSA7FTQAqNRVuQHvTHsy3DyJgRN1g+0Jumu81yvuZhRRZw2CfUa1fAFa2
         GO/d9tnpR4ctIv4FVMwXjjb8M0Pr4tjJlRE1WjS3jj4Dv6nCU/edOtNmFNFxnVCYa3+3
         A1FBLtev70L/lPqSyKAniB05/EK2HZrn/tMBOALPp43xvk/FT1LB3stqDYlURl810O4x
         p07S+X5LXEjremfGxUXxgbX4CdW57Ev/NysR7BBlUrd3LYzTUkkO3HYh00XRoQ/Dt9+v
         wATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL04JieBI0gvtYFp0bggEsvKDI2A3ibBIjkSWhu7dSA=;
        b=rW5IY1NPFU7I+QMMbDb+97L63srJMjgAAtAF8VPpeD6MAaM3CDySp07cXFFTNEndFW
         KduZuA5Ho+uKVEZjQ+g9Ohr4o6Qm8Ue+B82sPIfTX3ipQ3TYoI5fGVUUmFQA1JjlFBJE
         jC5BEJhJw3EA4yxvI30jlde8a4lWyM7aEG+Xkx28vKfbNho3JL1AenzrjGgV17LYejfA
         iPe4hnQ9gT4PYFagxUJobWlxpWfGX3sHj3BIHIaJWZ2UE6v3z6cGdeF/FsNjlNZ1mKC9
         LFiqKdDDmMKAli7vjh27C7BhqyY92r33+OnF+4VRMhrSYAI/PHQOB33DBRycpJaQ/Qvh
         MfNg==
X-Gm-Message-State: AO0yUKX/lQPYuvcgnflTYetQg8tswVE+LkTX7mQmjGp50YZlfyHhp/yp
        HJBDyVJOBc4oS9dMCqLOtYbK2rlUiEI=
X-Google-Smtp-Source: AK7set+ookBsR2Nb3kn+Kbhr15couLW/XpSvt8YKrMeVfQVtOtjOhMkCKY+ll0PsOw8u7vN11r3Efg==
X-Received: by 2002:a17:90a:15:b0:237:161e:33bc with SMTP id 21-20020a17090a001500b00237161e33bcmr9480084pja.16.1677130485921;
        Wed, 22 Feb 2023 21:34:45 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090a728d00b00233aacab89esm3943608pjg.48.2023.02.22.21.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 21:34:45 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4 2/3] rebase: stop accepting --rebase-merges=""
Date:   Wed, 22 Feb 2023 22:34:09 -0700
Message-Id: <20230223053410.644503-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223053410.644503-1-alexhenrie24@gmail.com>
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
empty string argument) has been an undocumented synonym of
--rebase-merges=no-rebase-cousins. Stop accepting that syntax to avoid
confusion when a rebase.merges config option is introduced, where
rebase.merges="" will be equivalent to not passing --rebase-merges.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/rebase.c         | 6 ++----
 t/t3430-rebase-merges.sh | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d52..b68fc2fbb7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1140,7 +1140,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
+			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
@@ -1437,9 +1437,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		imply_merge(&options, "--exec");
 
 	if (rebase_merges) {
-		if (!*rebase_merges)
-			; /* default mode; do nothing */
-		else if (!strcmp("rebase-cousins", rebase_merges))
+		if (!strcmp("rebase-cousins", rebase_merges))
 			options.rebase_cousins = 1;
 		else if (strcmp("no-rebase-cousins", rebase_merges))
 			die(_("Unknown mode: %s"), rebase_merges);
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index d46d9545f2..c73949df18 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -278,6 +278,12 @@ test_expect_success 'do not rebase cousins unless asked for' '
 	EOF
 '
 
+test_expect_success '--rebase-merges="" is invalid syntax' '
+	echo "fatal: Unknown mode: " >expect &&
+	test_must_fail git rebase --rebase-merges="" HEAD^ 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
-- 
2.39.2

