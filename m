Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D32EC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4E460EBB
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhKATB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhKAS7E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 14:59:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A34C061767
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k7so29409047wrd.13
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFtcvG8JjBHSuPRk0su8BXG9BUBW5rwJ/V74TzzkztE=;
        b=R0j6MdweHZqywZ861E6fdVRUzq9waoeTy/TMcJ9jQhm2mBFp4IOekcdnb2bKovqAUX
         /rNq1RMGLIlAK83lOeDNaDxZiA+mdVbaC2+i8OWdBad7tIPRZi9jsKPr8EHrv+0pDIF+
         9aznCRRV80sut1PWBmOpoSvA69ua55NvOHWHzGzRG5b63JeOUqrzgYjeIBfILn3wau2o
         0UH+7JR+heqEkaeT6TK7eCKf8HxDVq3BuO3f8040PNuCr+sVDOfegPQaudwWrKnU2QPe
         soM588SnY6yeuXYtvz/9gW/5uzafSwMMrHSFwdix+zPIGdfcN3AuXuT763HZVMKtVTK7
         ZtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFtcvG8JjBHSuPRk0su8BXG9BUBW5rwJ/V74TzzkztE=;
        b=vlTnnue4qMjt5izi14P/Yzl/VGv0E7z3htJ8B+lkjvQlgyNB0lDrkmMi5j7GbkBfgy
         3nYEZhPNUpC7UEjg5Ji0uWEbcQz6XvZgzJ2/mzkD9YrsYfDeXLr2yoaiiFgdqRoR2OVJ
         OQC78DXjYu8jy7Agcdsenbo6sui3UFzdVGSGXfzKyb6n5ZiPI42gXZJ4dVqZw2/YlOe3
         sf4V6m6QOox1539dLmtJA72uooo9pdyRWfsKYzvgRFsgg2FamUFjQQVaBeZXn0rNiKzq
         pOKfXJo38IhtonRjkpKdnDfnSGkyn5IE5FVrIlDCXOp/1bv498lD2Zxdw0XkDrmdGv1z
         RsZQ==
X-Gm-Message-State: AOAM533gAjTTHluD8QOTl8ShjBrDy84D7ZxOI1OZWpu5XSIXmGpnsl/B
        kGriPVCFSEdiCZ8q1PLBA2bNFCNxrKzinQr5
X-Google-Smtp-Source: ABdhPJz4UjqrYkt7Ko9G8YMKbUK2zsxbnQNIfaQlGN89ic5OvcspO5LY94NPKc8z8cvIqALWfFRBFA==
X-Received: by 2002:a05:6000:552:: with SMTP id b18mr40788346wrf.112.1635792989019;
        Mon, 01 Nov 2021 11:56:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:28 -0700 (PDT)
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
Subject: [PATCH v4 05/17] hook API: add a run_hooks_l() wrapper
Date:   Mon,  1 Nov 2021 19:56:10 +0100
Message-Id: <patch-v4-05.17-74f459db287-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
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
index 720994bf4f6..cf6d099f83a 100644
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
2.33.1.1570.g069344fdd45

