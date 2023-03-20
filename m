Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D55CC7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 06:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCTGAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 02:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTGAI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 02:00:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024581CAFE
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 23:00:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ja10so11337973plb.5
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 23:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679292007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OcqydCjhMDY5jspeKXxXjsJOwU6BQ4iAns2dmsHl9w=;
        b=WLxhPCqIRxrEANLlXcHLZIsQ0AldEiwO5TvIvwFwiIioDE4q/u/aM+WOZyEEBNM1Nu
         A/gGe08xs5LORKkjNO7D29etwpLt8i6rxVlyhDIr6ldu/1bpRtIRwJIBrv25iHHHkhC6
         qnqmbbDwBYepRofb9nkh0mVO9G4v7s1Yl0ZGMR1zrZbfyJZzfzpvyK+LYWWz3/lAvS/Y
         bc4hqOzl1oQMvXcftkrS2zq1DkYZXc8QdwesKxpT4+i2Jc2qrOWkhvRdL5gBxF+ttSMc
         r5S5ZPZW7+CwMHKSDwN6M98rbRl8qC2hBX0FsaQW+sVQ3fr2v7zhg30FN4vfLKuuiCtu
         QTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OcqydCjhMDY5jspeKXxXjsJOwU6BQ4iAns2dmsHl9w=;
        b=QA0mpcDbAkGOZowPqFY7iVwfLaPewH5rIoCZQQRBTixsE0FrGmm0+o8ZROTQIReHB7
         sqXWWpRtdDk8/AIzGISXaQstr2VrffNfTyy2vsPOOx7CkYXqxJ5kSyPEvjMpFa9RS2d+
         rTFThLj8eusocv6oxdcBj7ISMG8Nxp4X8hYWbQIZcnfr4rdTiGFeDXs7IVabRvKpYj8c
         awvvh42nzNbRYt9QE2QmFB7VwVovgasii7V16qzGoq5r76EiYsrOhb3hf7eqpxLsdf6b
         puj7jvyxnf7dAmOeIsMAVHwR/pGE4a+efBfe197r/b0zVH101J9Lspr0UxMJD973klbW
         Qwzg==
X-Gm-Message-State: AO0yUKWbz7h5edAOe37OoslYPMHluRVZELEHXTiUqZWAy3INUSuUxDOi
        Bn1JLQ0Lyi56exhkOro3rwMGshmaOA7QKQ==
X-Google-Smtp-Source: AK7set84NBE4Tw+VuoORAPGuvSJChq92AH+iNq5Dh3JXOh00mnHkoH5+Hp2JH3zLwGLd40J4zUSBOw==
X-Received: by 2002:a17:90b:1b06:b0:23f:8752:98be with SMTP id nu6-20020a17090b1b0600b0023f875298bemr6952001pjb.4.1679292007201;
        Sun, 19 Mar 2023 23:00:07 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b002353082958csm7814075pjb.10.2023.03.19.23.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:00:06 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v8 2/3] rebase: deprecate --rebase-merges=""
Date:   Sun, 19 Mar 2023 23:59:54 -0600
Message-Id: <20230320055955.461138-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320055955.461138-1-alexhenrie24@gmail.com>
References: <20230312210456.92364-1-alexhenrie24@gmail.com>
 <20230320055955.461138-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
empty string argument) has been an undocumented synonym of
--rebase-merges without an argument. Deprecate that syntax to avoid
confusion when a rebase.rebaseMerges config option is introduced, where
rebase.rebaseMerges="" will be equivalent to --no-rebase-merges.

It is not likely that anyone is actually using this syntax, but just in
case, deprecate the empty string argument instead of dropping support
for it immediately.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/rebase.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index dd31d5ab91..4b3f29a449 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1141,7 +1141,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
+			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
@@ -1439,7 +1439,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (rebase_merges) {
 		if (!*rebase_merges)
-			; /* default mode; do nothing */
+			warning(_("--rebase-merges with an empty string "
+				  "argument is deprecated and will stop "
+				  "working in a future version of Git. Use "
+				  "--rebase-merges without an argument "
+				  "instead, which does the same thing."));
 		else if (!strcmp("rebase-cousins", rebase_merges))
 			options.rebase_cousins = 1;
 		else if (strcmp("no-rebase-cousins", rebase_merges))
-- 
2.40.0

