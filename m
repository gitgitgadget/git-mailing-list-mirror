Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B7C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjBBJx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjBBJx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:28 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E4C22DEE
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:10 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so912215wms.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSfKwPOTPhummvWdXQiuGlyL7ZXHQm30fRx7ZuVDWTw=;
        b=KaU4oTIgmRZgSNyJbAIya5Vk//CJGPlDIvspf6kM2W8qB1Mw9fvavnRHp28YqzpTXY
         fe7BWGmX2ba0buZXwqieMSdMMPpvO/xmK8RkRrZ+DfeDwAW7XQ8FGOakV/nrDseEjH1l
         Md7RY4V9i8iLBbXJFiv8XKICAYMAyhvCVskamejv+jrvl844YBRroz2qsS0XPkDEyVT4
         bEtsQFsuDqKWMt4f2DkMhKWvXCrtP6g5WhZxyO3JD6zrRqq//CpSYKFb2devPIOStI5H
         0sCbeZtNNrHWEr+ZRjX5NFdj2WeoVhjxsygoeB2Yu/Vcrc2TBhKAFJGucfBJ+NiPxY1+
         nw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSfKwPOTPhummvWdXQiuGlyL7ZXHQm30fRx7ZuVDWTw=;
        b=5nN/1EFPTuPEj0T27PXUZE+Q/j3p6G8o4IvbxXSfvzU+718KgM5dqwqKAC7czT3DVU
         tXJbxFoKYoGSgFO4sMqEO8uA3Pzm886cAu9C8PkVT5Vni9zFB4QFpA4wyS4ruShugXOj
         oEcwXfgRmZiITs2UPq9lF7kpbiiV2YO1MMOfuhqlqunAEUVB157hS1ybHgU0mqIoYRf/
         4Gu7VpKqpec0AaIne6UymoqHQoxOFH0BWVd62fcsxBdmue4pXNHg2F46jHb0O4ymVF1B
         9+y5AVJuLBjRYnvk1QsJNugjYibYjRvhOx5oUPqYzha8JusrKxE3ThX/u1dZHKBLpTSk
         vPfQ==
X-Gm-Message-State: AO0yUKVh6n+iWrr4os8ZwR2bsl0LMKyJtNmdkrgEiRx2j1zrQ4tTyhTL
        0eOv6FQnvDAPMYKNK8Wje3zgN9KakbiYUxa0
X-Google-Smtp-Source: AK7set/mUtEVBIKOikbNkah1eY0tSwArvkat/B26lxmWI0YP9qDBxaILqWvvfYknP0gQuxGcHXjPEg==
X-Received: by 2002:a05:600c:35c6:b0:3df:9858:c034 with SMTP id r6-20020a05600c35c600b003df9858c034mr1419484wmq.9.1675331588904;
        Thu, 02 Feb 2023 01:53:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 12/19] show-branch: free() allocated "head" before return
Date:   Thu,  2 Feb 2023 10:52:43 +0100
Message-Id: <patch-v6-12.19-3b1d47b9d62-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
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
2.39.1.1392.g63e6d408230

