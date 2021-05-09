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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E690C433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 21:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0287B61026
	for <git@archiver.kernel.org>; Sun,  9 May 2021 21:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhEIVYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 17:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhEIVYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 17:24:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD69EC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 14:23:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b15so12255701pfl.4
        for <git@vger.kernel.org>; Sun, 09 May 2021 14:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eof1hiswkffhc/zt/ZsTQgDOf3RaCG36magdMOZ0IUs=;
        b=lSoIpuEmioXi+agNTB60wgzcLvpHPbDi34We1bcNoshgUBugKSJm3hHt87vCdqNz9C
         rSqsOszQMT7TtcDCYYC1otpDmlZz/+TiXEzwbsExkGzwgBj4EYGq3pls1PpBSRD5y8jP
         pUc3Dpako5JgOEixybcCteMn3JOMvvuaIwogpmPf36FmUcBBxeOohucNXeijLDPFDgSj
         3jBi+Jo9Z1MfQ3sUA1TXiM5ebvT0y0pAyiswmQwy1DDRuhwOhiMMmtpDLyX0nPTfpMX2
         /VjYcmL1am6yiG7T8hUlr7QcRLKeTqJC7iRgBaj5ZLZwkHbrdtg0TvTOHk2TsbZuJW7A
         Fz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eof1hiswkffhc/zt/ZsTQgDOf3RaCG36magdMOZ0IUs=;
        b=q9EjIfFykse+0VwCxuusBxf5q6jCVYayCHuszqs0u/8irlmkrRliin0S2MVylDDvSJ
         gd9P1akYZ2RbpNUQH/dkjOPMEq7nUJYlNzL6hrReIKxrkg5+sNaYiZ71mP+PCAcLhS+z
         OoDeZbfqhlevCWibLlMoa8twpOfkCDfwtwtOeKIflIyI7toRKmr14iIAp4fMGczM4ZF9
         DwOYU6JEBp1uqcfV0Qa0IjN3kaWgbK0us77kiksR24aZuWk4lfT+lrtpHdySNNPbLdYC
         dzd/s1I7ODsUtkFKq6EK5fkdzw2jhBjjISuhNehdZ+lzZh3o5TXrhM6hOgtHgreC3TZm
         Qm9w==
X-Gm-Message-State: AOAM530Q3iB+0PJQe6kgomP1nEcMqwGehrqeR8MNguwfNU5OKUJ9Gjqr
        MTxBWoM8QG/AeuSSzXc1+Z/E4KHSx5w=
X-Google-Smtp-Source: ABdhPJx83GIpHHKly8YbQOQHp8cf0GMRpVH3oJFma/2EfgXeqj6nwynI3UDSzWhtVD3SqOchx4ERrQ==
X-Received: by 2002:a63:3242:: with SMTP id y63mr21387478pgy.87.1620595382046;
        Sun, 09 May 2021 14:23:02 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id gb9sm16779614pjb.7.2021.05.09.14.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 14:23:01 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] graph: improve grammar of "invalid color" error message
Date:   Sun,  9 May 2021 15:22:20 -0600
Message-Id: <20210509212220.29557-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without the "d", it sounds like a command, not an error, and is liable
to be translated incorrectly.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index c128ad0cce..e3828eb8f2 100644
--- a/graph.c
+++ b/graph.c
@@ -95,7 +95,7 @@ static void parse_graph_colors_config(struct strvec *colors, const char *string)
 		if (!color_parse_mem(start, comma - start, color))
 			strvec_push(colors, color);
 		else
-			warning(_("ignore invalid color '%.*s' in log.graphColors"),
+			warning(_("ignored invalid color '%.*s' in log.graphColors"),
 				(int)(comma - start), start);
 		start = comma + 1;
 	}
-- 
2.31.1

