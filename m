Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D565C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F98561027
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhJOJp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbhJOJpz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:45:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2DC061753
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso1915532wms.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QkZyUfssWfQRqYPef0YK56m6opUNzDnl5f4nD5ey0xI=;
        b=jOuwDlCx1cbAkimUG1z9g86CRCtDzgaOxYzOj/L8sQ4cAQPljGMOSF8BGVGjOJ/9sx
         rAs7ez4R1n/DU59DUbxhI3q5I7uSA4TLAsepvsT7RAMZR3aym38DjtVsjZ42F4IFZ4IW
         dxWd4a7PvXWNDxReDQBEMOsHaj3w/lfrm+PZUCiByMinNyxWr3mtIHzAMUZ46mGQr9PF
         VPv/L4kywFfeds8k3VA5rmTPsG0HU2YNGpPxSKfM+41PYDQ9i0phSrIy/NqM0kS5RWqZ
         0eBUuu/Kr0rv0fVrUpX/09lqMGeXPaAkC8WkwBEQPHgFUdaVGOjeDD0Vnm0wAmosBzIa
         HY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkZyUfssWfQRqYPef0YK56m6opUNzDnl5f4nD5ey0xI=;
        b=tSqrjozHSRD6dq3wVm4y5R6FKjm9OMboAoKRqIisO+2M8Z4oUCAnvOvXwiOWuvlOCD
         hEHdRo4gKPOih7R/Ok+vu9rC+DbbRhOLis3lo5eZ6swzpGSxVfmOMtziUmtNx2AH8RWg
         XQAcFIiGrOpCgVD5mtmBN2LJ0lscJ+RJ86IoQWMh2R/b1zVVK3HjoWltYp7WjVChZdBY
         nWoj7w/eFLzAVyEzqfXfMoZjpK/XSJQCzXPNXja7jKrYhH59sxvcFz7xYDEyGPACmWIQ
         r+XAtJca0BpnBkBUMsM6rGnenUZPol+O78UhcjCZiwTdTQNBQ8vGBZXojY+xIOsu5KFW
         aNZg==
X-Gm-Message-State: AOAM532FKxRtzltkZbhiiSf5l0U4Z2Y5g6iQnoeOtDrQaKIMec+ITvDH
        Ivqcwrr73xy/kInkMrQOxmBJ58yVkADq2g==
X-Google-Smtp-Source: ABdhPJycPMQJ0LUwHc/IlPWQ20Q/LL9eG99zXEVi/8ccY+eP18OoGSnekjIg69BLgIEPb2KuBpDxag==
X-Received: by 2002:a05:600c:1c03:: with SMTP id j3mr24515673wms.171.1634291027421;
        Fri, 15 Oct 2021 02:43:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:46 -0700 (PDT)
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
Subject: [PATCH v2 02/13] gc: use hook library for pre-auto-gc hook
Date:   Fri, 15 Oct 2021 11:43:30 +0200
Message-Id: <patch-v2-02.13-e3dc0aed81b-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-auto-gc hook away from run-command.h to and over to the
new hook.h library.

To do this introduce a simple run_hooks_oneshot() wrapper, we'll be
using it extensively for these simple cases of wanting to run a single
hook under a given name, and having it free the memory we allocate for
us.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c |  3 ++-
 hook.c       | 20 ++++++++++++++++++++
 hook.h       | 13 +++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6b3de3dd514..95939e77f53 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -394,7 +395,7 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hooks_oneshot("pre-auto-gc", NULL))
 		return 0;
 	return 1;
 }
diff --git a/hook.c b/hook.c
index 20a1a4fec33..9951015dc66 100644
--- a/hook.c
+++ b/hook.c
@@ -131,3 +131,23 @@ int run_hooks(const char *hook_name, const char *hook_path,
 
 	return cb_data.rc;
 }
+
+int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
+{
+	const char *hook_path;
+	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
+	int ret = 0;
+
+	if (!options)
+		options = &hook_opt_scratch;
+
+	hook_path = find_hook(hook_name);
+	if (!hook_path)
+		goto cleanup;
+
+	ret = run_hooks(hook_name, hook_path, options);
+cleanup:
+	run_hooks_opt_clear(options);
+
+	return ret;
+}
diff --git a/hook.h b/hook.h
index a9317c3f95e..9e4d10df63e 100644
--- a/hook.h
+++ b/hook.h
@@ -44,7 +44,20 @@ void run_hooks_opt_clear(struct run_hooks_opt *o);
 /**
  * Takes an already resolved hook found via find_hook() and runs
  * it. Does not call run_hooks_opt_clear() for you.
+ *
+ * See run_hooks_oneshot() for the simpler one-shot API.
  */
 int run_hooks(const char *hookname, const char *hook_path,
 	      struct run_hooks_opt *options);
+
+/**
+ * Calls find_hook() on your "hook_name" and runs the hooks (if any)
+ * with run_hooks().
+ *
+ * If "options" is provided calls run_hooks_opt_clear() on it for
+ * you. If "options" is NULL the default options from
+ * RUN_HOOKS_OPT_INIT will be used.
+ */
+int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
+
 #endif
-- 
2.33.1.1338.g20da966911a

