Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C150C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiHGCuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHGCtx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:49:53 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F2E03B
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:49:52 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id x1-20020a056830278100b00636774b0e54so4395835otu.4
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2a1m4RR191LhWnsDjwZEol4vmC98c02ABQmvFxc9DG0=;
        b=boL2IvXlprdL9eOb3kQdhDFSDSwlKk2TEJE62iUjnQHpgltTJrw0EP62M86qZMOftT
         FBmGgoUqGpqzGuACSzpQriC/z9kWVOcG/v2U34XIsadJNYAcbieBq4tslcaYWqfPIAYu
         DCLADvtNYTMTzuJsA6yyWHGukC0oFf/hCbiFAJ8r1EekVfn7sczAyVI88KIfknIaPKnU
         Co8vB8nH4ICtB0h3uuf/uEdTUKdL22jPs01W8FleOZub9KhFXvlJeAgT4XecPvvJQ+Wb
         Vk3FA+aVTiDMayccOBVmKp4I+2S2pE7a6MwRUyiru1j5C6g7CxRAR6jXm43duyZx5fIo
         hNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2a1m4RR191LhWnsDjwZEol4vmC98c02ABQmvFxc9DG0=;
        b=V0HNtJx4E40J4rbExgXEfxgh+8X37l7S3dinuDUC8mmfk88v/yxOyxPatm/jOaoZfA
         7OiiUkpQ6dZ6kvyrcsGX3rXxowG/23fXmkCOw51AiH84lSXpMpyk/CGGhi5sRbCVyG2K
         ux4nmpLGOV8BaddI9ex0+13aPAHA/Vch9Nm4gy20vNLQd8g7N81dK5/3cIKy/LJ3Wb92
         NIGhofYPSdBQwUrLzoHM7ws8fOQN80ditYEGAbzfNuQ8COyM5F2RjOpAdnPTgRCxS/mi
         kLyU+h4bAIFM3UOZtVPfuAj18OizCxT2jT1scHfpBq+qGSL1yAdVdHdsKMtxcwIN0wjz
         g/Bg==
X-Gm-Message-State: ACgBeo0+9gLMk0pZ8ibx3wOLpzUfsi1n6U/YtoF9mhzgLR0+pT9AI0XD
        QCNKwpwOB+l+s1bgoeX++UVROLVmzOM=
X-Google-Smtp-Source: AA6agR6esQBew6qlqX4ZcOwHeD82NLk/tVKLXm9i9fwap333wkllsSlqmk7h+B4ctTxMdhuWcpKO7w==
X-Received: by 2002:a05:6830:1f59:b0:636:9611:478e with SMTP id u25-20020a0568301f5900b006369611478emr4981588oth.113.1659840591249;
        Sat, 06 Aug 2022 19:49:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z5-20020a9d4685000000b006368d4ec202sm1508213ote.16.2022.08.06.19.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:49:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/9] mergetools: vimdiff: fix for diffopt
Date:   Sat,  6 Aug 2022 21:49:38 -0500
Message-Id: <20220807024941.222018-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.378.g3f95da6bac
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When diffopt has hiddenoff set and there's only one window (as is the
case in the single window mode) the diff mode is turned off.

We don't want that, so turn that option off.

Cc: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index fbca6f5c96..68e399768c 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -325,7 +325,7 @@ gen_cmd () {
 	if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
 	then
 		buf=$(get_buf "$LAYOUT")
-		FINAL_CMD="-c \"echo | set hidden | ${buf}b | silent bufdo diffthis\" -c \"tabfirst\""
+		FINAL_CMD="-c \"echo | set hidden diffopt-=hiddenoff | ${buf}b | silent bufdo diffthis\" -c \"tabfirst\""
 		return
 	fi
 
@@ -560,7 +560,7 @@ run_unit_tests () {
 	EXPECTED_CMD_01="-c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_02="-c \"echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_03="-c \"echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"echo | set hidden | 4b | silent bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"echo | set hidden diffopt-=hiddenoff | 4b | silent bufdo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_05="-c \"echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_06="-c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_07="-c \"echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-- 
2.37.1.378.g3f95da6bac

