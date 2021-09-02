Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B749C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22594610E5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345135AbhIBNND (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345048AbhIBNMw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF1CC0613D9
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso1401769wmc.5
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VofH2jXtB6F+iDTJF+KVD2kDW0u+vrl3bs2Z463U/k4=;
        b=bLn8/i+U9PSC1xjqaGhlIuDwFLWxyyUTsZSrjltpEyzX8vF2kwSKamAHf4PlxyTMqx
         eaV+Ma6U4DJyx6hQmg1ct0JMStrl/A1KbYH6RePIULd9Q4pDass7p/2w7vLBjM7QuMgW
         3cfeDNJzmHJ6+kHae+0/ExNgnzGXXSU1hERnIpe5nbplEceOqllBfeyQT8Mh8q7nClaT
         2Ln1dPU8lZQl7Fc23BlqUA8qARKuWEpwh4Wnb4M3wZHYP6yQo3nakfUXZ5uKZDhcVVU5
         WZPtuFn0aX9hxWJahACNImONFOnRcMBJOm+c+BEJr5HRCaVaSBqvzlimqdG1nM51tVtj
         qOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VofH2jXtB6F+iDTJF+KVD2kDW0u+vrl3bs2Z463U/k4=;
        b=NVUbWahWh66QaNOu2qemdY6WZB3St8H0uHbYvAIVBJWZDOEtQDSmmxunbX+KJaNnr3
         eB6Rjtly65LdCJV8zNHFodfyAashKleJRZU8iGMwsH4M/Aemg1x3QLg1MQDgk6eX4uZf
         vA1MtfjX1qUdYfSV2/MeQd6PXP61y7jx9abm9kPK5kn7+Zf3R6gAemfN5xLk14pGgwzQ
         Vxgg31x7jwxfll5c+1JGuY+8zPJNayj3Cm2TxFvrySTqmVAom9R7JALg7cT6HHlr2cMC
         aKPmqvkWoG6anpDWmXnbH9fdpWvDhrRr1Ocx9DbYv7zAG7U9nyWQae/wGr8E3yGuy0VP
         /U/A==
X-Gm-Message-State: AOAM5308WjssFWpG4lY8G2jNJd9u01RoBugwhj+nuUcPHgT5ClXHVhzs
        DLP+UN6NYNsSTaW3P/SmAd7HGyHLo6q10Q==
X-Google-Smtp-Source: ABdhPJxI7V5+rOQ/dA9+hZ4IIDaayT6NFQFewTnTGiLUdqsy0g557UPqnDeB7VdFOJbtrP72qrfDag==
X-Received: by 2002:a1c:7506:: with SMTP id o6mr3267783wmc.112.1630588311095;
        Thu, 02 Sep 2021 06:11:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/36] gc: use hook library for pre-auto-gc hook
Date:   Thu,  2 Sep 2021 15:11:09 +0200
Message-Id: <patch-v5-09.36-821cc9bf11e-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
 hook.c       | 23 +++++++++++++++++++++++
 hook.h       | 13 +++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6ce5ca45126..c91a0786836 100644
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
index dd67801c962..1776895289e 100644
--- a/hook.c
+++ b/hook.c
@@ -141,3 +141,26 @@ int run_hooks(const char *hook_name, const char *hook_path,
 
 	return cb_data.rc;
 }
+
+int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
+{
+	const char *hook_path;
+	int ret;
+	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
+
+	if (!options)
+		options = &hook_opt_scratch;
+
+	hook_path = find_hook(hook_name);
+	if (!hook_path) {
+		ret = 0;
+		goto cleanup;
+	}
+
+	ret = run_hooks(hook_name, hook_path, options);
+
+cleanup:
+	run_hooks_opt_clear(options);
+
+	return ret;
+}
diff --git a/hook.h b/hook.h
index d5bc1dc74c9..b7a106a6e2b 100644
--- a/hook.h
+++ b/hook.h
@@ -49,7 +49,20 @@ void run_hooks_opt_clear(struct run_hooks_opt *o);
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
2.33.0.816.g1ba32acadee

