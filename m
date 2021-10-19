Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4828AC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A16361183
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJSXYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhJSXX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68731C061769
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n40-20020a05600c3ba800b0030da2439b21so6335372wms.0
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afo6mndBoG0nBvcdj/zyZLwuv53S7FbjY4yYvbnVL7M=;
        b=bmga5GEHFwtkmQzTKJuQKM0CvwdEX6z/CQaTA0Ndm0K60wyhEM8tystW9/T95kFZdK
         y3//pr81POcrEj44aokGbntwwdlHmbB0KgL6vBnc4RBnyPOq3Mq0EBIFmwPnsLDlzPtG
         sxpS5g9h+f2lA/Y8SgrP5Lsoz5Zx9D+gb37UekaAOz719QX4Y6Lua4oxBXIHoaydbf/l
         4NVBee2ovN3oxfSc1RC/nsEgF4V73EpoeKt6wpd7h7pKcy0y3gNzsODWUMguZ6Wsguig
         6wmXWPBB9JcFDdKpg5IjrqsGV9AcCRJqBb43PSK04f8wMMvKT2oe73lC9XeZRf8TBkEF
         MAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afo6mndBoG0nBvcdj/zyZLwuv53S7FbjY4yYvbnVL7M=;
        b=3mjjlUIGXjFkHw3I51jK67mMXu4HrxC4h9UdCR1zfRLspv+zR2gEqtyzjHmre9wrbS
         BsPkQCGJJxU9ENgurdOcZIJ3+yTxpka8+JojY1kFczLLUkO/RKpUOTStJGOk9v0dJitr
         p/GKi6bFa0FpPdFT+uDs1VHVwq4itzzt/LeEmrI6qRzcIKKqVgdP6RN+AQsCVUcV2BA7
         FVoS+q7mW9PiTWXI5NECHEg6xZfGVuogUvn+pSz7TBWkc31TbRJr+bY3Pyby24JCzCAi
         8niYrf1dCK0QDxKsotcH7D2K3mZ+e6VjLuk+xkODIp/+Oo9fev5/96tsucniZESq+24R
         I+zw==
X-Gm-Message-State: AOAM533m81Y3fkEFOZ5SRDoZei+NTy296Whf/+MlsrkqaUK7qt9G+tcR
        eLXIIS+yp5m0hOS2+nnxnOSGHs5UlXp2NQ==
X-Google-Smtp-Source: ABdhPJwuouHZbRDGpUO+zWk4jzH0ZyhCT3GTy8QjSh+juaOi2Qdk9Y1JULbkarsDwIWRIJbxztjLfg==
X-Received: by 2002:a7b:c214:: with SMTP id x20mr9140173wmi.103.1634685703737;
        Tue, 19 Oct 2021 16:21:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/13] receive-pack: convert push-to-checkout hook to hook.h
Date:   Wed, 20 Oct 2021 01:20:50 +0200
Message-Id: <patch-v3-12.13-9818078f1e5-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the push-to-checkout hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of run_hook_le(), so we could remove
that function now, but let's leave that to a follow-up cleanup commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 25cc0c907e1..22e7a431728 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1435,9 +1435,12 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
-			hash_to_hex(hash), NULL))
+	strvec_pushv(&opt.env, env->v);
+	strvec_push(&opt.args, hash_to_hex(hash));
+	if (run_hooks_oneshot(push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;
-- 
2.33.1.1338.g20da966911a

