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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9566C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B142C61185
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhFQKLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhFQKLt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:11:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4DC06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:09:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o39-20020a05600c5127b02901d23584fd9bso3175750wms.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbPqMrR/hMx47v3v/4q7U3+/YESVSEx64u3P8grbBLg=;
        b=M5IruwNu/HqLOF6Cl3wIIKftK/YIBjCrQAK6QWmeD24rRz9Ko5RDwbo2z1oQbfFP8t
         HwQRUua4lI7+U9QWq6RE4D/XM8bqnmw13ynzJyOC4sZ3zVXNbP0ZoLzx3HWpSUblCemq
         ghooB/dipw22H9Yh1Y4A6Q95/fpQuVpGn3ojfSCvHCAOEBx2CmmBYaclysu9AQzceEIW
         q7FCrv7Flv1upEoxNl8p3klaPSXCJLZGd4CbUWlyeJJCFVevYHdTuk2AVD7cbsWZJaK+
         dv7bugRSjBc7CVcbJJZyxjb94dQLF3DaDRLyjIlOLAAHlrDmyIrD94FBs7K4OVxQLxxo
         jRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbPqMrR/hMx47v3v/4q7U3+/YESVSEx64u3P8grbBLg=;
        b=jMRVEtD/PiTckCbv3YIcrBVRGHtjHclLb/i0DsRj+CnCJb96azPRLX0AwDsow+nPOw
         IGDignlVq60rd5CmlHWUh4GYVOw1+f8yKFCVsE85vIiAenXKYMT03zHizR1rmhw9SXGR
         zaqDPR20BGDOBxmfiWvNOuvPUbZacSxslDK7Yxn/unRDMiyCLXz7oU7LBYjxGSEQDn7K
         XmEP2IlwI/dYewmBpgPG6XkhN/haJKkUOb1LiP45x/6BgdAPQwE7tbkxAESVo4KPGy14
         wh51XAW3qpdQnddiHn7XygUAkUL9ayc6vzO2FUxHAXZ1a4bDUnVkcWUGvf0QjNjgt9vR
         JfEQ==
X-Gm-Message-State: AOAM531NwkmvVaeYrb/EwhftQ2KlVRvHXN8jpe1dTM1TvFEp27DWaMtQ
        uhHoThmu6WmFOdHIQ+AfxnPneDuwqzk/fg==
X-Google-Smtp-Source: ABdhPJyjBDY6l/iUkG720iGoh5bZ2htMblVNE/aBGWJWKUD9W/O3ozhzRqmmHQmNv8eHOdnlWA9K7w==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr4173492wmj.180.1623924580098;
        Thu, 17 Jun 2021 03:09:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9sm7348425wmm.33.2021.06.17.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:09:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] hook.c: add a hook_exists() wrapper and use it in bugreport.c
Date:   Thu, 17 Jun 2021 12:09:35 +0200
Message-Id: <patch-2.3-0cf7e078ef-20210617T100239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Add a boolean version of the find_hook() function for those callers
who are only interested in checking whether the hook exists, not what
the path to it is.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 hook.c              | 5 +++++
 hook.h              | 5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 596f079a7f..941c8d5e27 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -82,7 +82,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(hook); i++)
-		if (find_hook(hook[i]))
+		if (hook_exists(hook[i]))
 			strbuf_addf(hook_info, "%s\n", hook[i]);
 }
 
diff --git a/hook.c b/hook.c
index c4dbef1d0e..97cd799a32 100644
--- a/hook.c
+++ b/hook.c
@@ -35,3 +35,8 @@ const char *find_hook(const char *name)
 	}
 	return path.buf;
 }
+
+int hook_exists(const char *name)
+{
+	return !!find_hook(name);
+}
diff --git a/hook.h b/hook.h
index 68624f1605..4c547ac15e 100644
--- a/hook.h
+++ b/hook.h
@@ -8,4 +8,9 @@
  */
 const char *find_hook(const char *name);
 
+/*
+ * A boolean version of find_hook()
+ */
+int hook_exists(const char *hookname);
+
 #endif
-- 
2.32.0.576.g59759b6ca7d

