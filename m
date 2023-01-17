Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC84C54E76
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjAQRMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjAQRLq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:46 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0F367D7
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qx13so18544841ejb.13
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUT9TATv+YLRC2uUCx2k7tfPpdBzKTTjVU9oWfociQA=;
        b=dtVp+a90x93FqMDoW2WLPqASaAPXiOSgpHNTCBhpkQnjE/1m26FRSf0UzNdbsUEYW9
         1QiJ9O8nT1KXzIGaG213bWGcwQ5NIfwdrJWVCHuUmwUkzPF3+YCG250/Xvrr4S7HJTaJ
         PTwC7IdC96O5MCjWFKaxnOHtHvgwEl1uW8XLdsNM7pfQdhXB6iRf3dQUv1Rqjlv5d8cG
         CU9CxG3GmtiB5hl+R/4SbJbsfVrfMmPCz1u8VsOA9PeoVN0FxD4ZztSFCUI85BjMbpxE
         I2FyyCyX1WvDi1z2CwhQFt/KQJG/M5rdE63LtR3PrHs5nsjHTUIyG6uzlXDMp6mhHT0z
         aq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUT9TATv+YLRC2uUCx2k7tfPpdBzKTTjVU9oWfociQA=;
        b=P4rsf7OnA++k6NbOviBQwaYwLORsYxn8TBf098t5WdIR6KmUowEPuJkrrGLV2QOBru
         AWT8mvos5XhjiD6HqhzK3fH9GtDvtOKq2TGJvB3erCRi4t1MR8d6qNk3KM2Jismpaayl
         2RVriFqdG+xQ51zGiadUgojgxysXEeu1y6L8vQ+getk+N12pJ0xDUsmS6OOOQVEStA2T
         bxNrf7UqMycoM6C5qxHda8UYb1UMEwmZzTp+Gdyp9O7nyYHQ0OaMETocpcIVrrswUpkU
         CLJXTXE8nCYhwmEXQeiwnCB4RuHEOcvx0IxfxtGUyPb/Obrzf1n5XRTEhCaoNM+IUZDT
         TYaQ==
X-Gm-Message-State: AFqh2kqJvBlodrmvspssYuvcP1z1JZLe7KlXRsLE8s2Gy9OcmKQK7w48
        4y0FeF/BvPCsJgSGmLvgoXlgaKckkizmMQ==
X-Google-Smtp-Source: AMrXdXtrpoa1J6Nrr892lMAGOocFDKZ2R9JhPJ9JCHBlolSEFfrltXR2/zx/q0SBEWWpv/VYTnrV1g==
X-Received: by 2002:a17:906:e098:b0:870:8beb:9735 with SMTP id gh24-20020a170906e09800b008708beb9735mr3570641ejb.54.1673975496064;
        Tue, 17 Jan 2023 09:11:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 12/19] show-branch: free() allocated "head" before return
Date:   Tue, 17 Jan 2023 18:11:17 +0100
Message-Id: <patch-v4-12.19-9054b353220-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop leaking the "head" variable, which we've been leaking since it
was originally added in [1], and in its current form since [2]

1. ed378ec7e85 (Make ref resolution saner, 2006-09-11)
2. d9e557a320b (show-branch: store resolved head in heap buffer,
   2017-02-14).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index c013abaf942..358ac3e519a 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -956,5 +956,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (shown_merge_point && --extra < 0)
 			break;
 	}
+	free(head);
 	return 0;
 }
-- 
2.39.0.1225.g30a3d88132d

