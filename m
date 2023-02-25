Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48162C64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 18:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBYSE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 13:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBYSEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 13:04:54 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104A136EB
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 10:04:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i5so1027531pla.2
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 10:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66u6kFxLGyKurqX98ZqIv2PYO2DTt643b9/RS1J4zvQ=;
        b=UCVMCtLFCBOZlGcgfTVncRSznfcr75xYngT5Nl+JyJq2ZF3w/k3OSqnpLTA0V6q/A/
         PQ05RB7pKX/9suVX341smcQke+PTyqOwchaGHyV8p6aRszKhMVtXfnFgjlus/9ESbaVP
         LMrSfPHVxR4AmQTg+P2lS2qWudSTyWAq7NEg3MhXouSr9rcUN+rnKSEoSYOiol9nmjUc
         NIWMqmVzcSZtnEGtQjZcSIWdG38Dh7AIzh1+uhMeoRJ9kKCp1cRDwGkSzRlW7aSMWSIO
         9a909X/v/XpaGhS/wbY8Rs9DdSJLrq9h3ZWHTS8rWe9TxlhtiAtjOpFqbVElquV3G5T0
         DSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66u6kFxLGyKurqX98ZqIv2PYO2DTt643b9/RS1J4zvQ=;
        b=C9Osy7hXueZ2Ju1G54VGs1OUbSxfJmLI2VrzbmQKFNUQyKZtE4oimdHT3t16Kkh1Cu
         BX7ILORLsiHCNI5hRVmFxUWgNhz8Ky9NCK7hqHERBT0sm8BZac9QUdZ0syMyXwI4/w+D
         ETrrZjBwU8+FvtFiNFMTeSo9XqEyZH7XnefLmznSGeR4mK3G3GuYlLo3GLxuUkDVtahd
         al7FemNqTfv6Vgu0Mehk7XLldyxPBmCWdFdDZZR/F5mIjt8o+Kt9I0SWQxzF7sIG9M5d
         7nWw7+rdX1vXnjamcX1xBoNYccEEfnOoU7fl4rXT1am+IuvJ94xYSz21m20MWg0efW7W
         76cw==
X-Gm-Message-State: AO0yUKWmb8Pj54nfdlwEgRCtgYNfyLcJA0xi0gh0fYTz0PFYwUADOYCp
        Hftl1ej/J0spe7kudt3wJkBfA6Ma91w=
X-Google-Smtp-Source: AK7set84qJu84pM9XJwxH1297aVK9oyOoEsc20ybauWdsvqSKr2vBVug/q2H2k5OS7NpIiPLmYp2WQ==
X-Received: by 2002:a05:6a20:7f94:b0:cb:86be:d504 with SMTP id d20-20020a056a207f9400b000cb86bed504mr18883809pzj.39.1677348293152;
        Sat, 25 Feb 2023 10:04:53 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id x18-20020a62fb12000000b005cd17607358sm1473547pfm.87.2023.02.25.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 10:04:52 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5 2/3] rebase: deprecate --rebase-merges=""
Date:   Sat, 25 Feb 2023 11:03:24 -0700
Message-Id: <20230225180325.796624-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225180325.796624-1-alexhenrie24@gmail.com>
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
empty string argument) has been an undocumented synonym of
--rebase-merges=no-rebase-cousins. Deprecate that syntax to avoid
confusion when a rebase.merges config option is introduced, where
rebase.merges="" will be equivalent to --no-rebase-merges.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/rebase.c         | 8 ++++++--
 t/t3430-rebase-merges.sh | 5 +++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d52..ccc13200b5 100644
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
@@ -1438,7 +1438,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (rebase_merges) {
 		if (!*rebase_merges)
-			; /* default mode; do nothing */
+			warning(_("--rebase-merges with an empty string "
+				  "argument is deprecated and will stop "
+				  "working in a future version of Git. Use "
+				  "--rebase-merges=no-rebase-cousins "
+				  "instead."));
 		else if (!strcmp("rebase-cousins", rebase_merges))
 			options.rebase_cousins = 1;
 		else if (strcmp("no-rebase-cousins", rebase_merges))
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index d46d9545f2..f50fbf1390 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -278,6 +278,11 @@ test_expect_success 'do not rebase cousins unless asked for' '
 	EOF
 '
 
+test_expect_success '--rebase-merges="" is deprecated' '
+	git rebase --rebase-merges="" HEAD^ 2>actual &&
+	grep deprecated actual
+'
+
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
-- 
2.39.2

