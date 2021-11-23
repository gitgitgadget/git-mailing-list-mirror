Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C29DC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhKWLtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbhKWLtj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69808C061756
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i12so18466591wmq.4
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OShlwfF+mae5Bcjh2nUUN9AZwGcvofZJSKoCo9MAg18=;
        b=oTbcEI53VCwOUIwG5LbJ5JjdI4narJwrv0EfrwxPCBCdyAwcHj0qhZ63KVWrybMtu9
         OxlrdZtEIvJRgQlf69qJlb0cWIMLnRW8vFEoqiHk4HTLp7Odp2Ri9SUvW34fxpV3IG+f
         iMNX5ifGjUwiOlTXtQ4/tAzNNPB+gZO1yWlVbukoS2Y7DGd/RyyPXYG1BloMLVH/Cmuv
         /OEFDmvs/ysTu7QSQwRJWEJt5BwSeQVhZnfHkGCfXY4k5mcYWi6Io7a6V6siCHTHpT/t
         9w5R7n3klT4snwAERo/Awdj3UY1goJHrbpQVuSWkQMivrnFSesC9IbEyDtmjUZ910Ddo
         fO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OShlwfF+mae5Bcjh2nUUN9AZwGcvofZJSKoCo9MAg18=;
        b=pL3HMGve0F2CZ1PRpU8rNZlvBvXZzJbC+2ZRLEFYMJsLXM1tpiBVQq066JDMUMYlGS
         FNOXtpp9m/tuCYtiWa0sszN/0UdjZVoejI8PY0tQcNqU0kBpnTM4I1BVkzWG8XJyk9d1
         Rx0GerijTNDSp0nd8PvLi376wIaH5T0Y1K0i39oKvNnKWjWZmBf7JNJcqEFXiJdTbwre
         EjZfGkHmV8LApdPzdRNPDCoWQ3Ai14/yxhkI+R3e55+ipICYwRf38ypKWeI1hpq0TgA5
         HUHma5oEtm9ytJdjX2sqG9tda38srdhm6T47fJ1nAXc+D+s9I4yoYEdmsLI0MMNbUAYX
         u9EA==
X-Gm-Message-State: AOAM531wFDBOPQYdXtTVI++ohHk4DAPv2phmvjsQ35Jfi72fMLH6sNVn
        9XojRKxizJE3l4P8vpgwTa8I8rgBk8wRiQ==
X-Google-Smtp-Source: ABdhPJzngWVcQQjMPHP8/IK6YVFpKKJdXKMWDNf1hyzLufpGxWnlXHBne5EyhXbSSILjrcFMmmEcKg==
X-Received: by 2002:a05:600c:350c:: with SMTP id h12mr2196826wmq.123.1637667984765;
        Tue, 23 Nov 2021 03:46:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/17] hook API: add a run_hooks_l() wrapper
Date:   Tue, 23 Nov 2021 12:46:04 +0100
Message-Id: <patch-v5-05.17-1d8f7b7e4c1-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a run_hooks_l() wrapper, we'll use it in subsequent commits for
the simple cases of wanting to run a single hook under a given name
along with a list of arguments.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 14 ++++++++++++++
 hook.h | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/hook.c b/hook.c
index d67a114e62d..1ad123422b2 100644
--- a/hook.c
+++ b/hook.c
@@ -149,3 +149,17 @@ int run_hooks(const char *hook_name)
 
 	return run_hooks_opt(hook_name, &opt);
 }
+
+int run_hooks_l(const char *hook_name, ...)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	va_list ap;
+	const char *arg;
+
+	va_start(ap, hook_name);
+	while ((arg = va_arg(ap, const char *)))
+		strvec_push(&opt.args, arg);
+	va_end(ap);
+
+	return run_hooks_opt(hook_name, &opt);
+}
diff --git a/hook.h b/hook.h
index 9c358789958..54528395953 100644
--- a/hook.h
+++ b/hook.h
@@ -54,4 +54,14 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options);
  * run_hooks_opt" initialized with "RUN_HOOKS_OPT_INIT".
  */
 int run_hooks(const char *hook_name);
+
+/**
+ * Like run_hooks(), a wrapper for run_hooks_opt().
+ *
+ * In addition to the wrapping behavior provided by run_hooks(), this
+ * wrapper takes a list of strings terminated by a NULL
+ * argument. These things will be used as positional arguments to the
+ * hook. This function behaves like the old run_hook_le() API.
+ */
+int run_hooks_l(const char *hook_name, ...);
 #endif
-- 
2.34.0.831.gd33babec0d1

