Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A12C43217
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbhLVD75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbhLVD7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79713C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v7so1990887wrv.12
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sUftsF+Vt2B9b7tO2kQbmd0BoTEf9vxJh1ljVQUvns=;
        b=OEAV9JwCUE8QcOdvpAvgwvgYaaOVQs63NV4WApwu9pbKy0WVoqXOxoBQWMafn101G+
         SaejS/tsJWBV3XurGZGR6J+OIEXB4fP0/48OcEwUQLVA0IOdCLlK/1NIxZm6yOY8RPjJ
         yT02WFCWVya3LgwLncRDxBm93Fzhbm7Tr/tNXfzKRmdbCWXxdNf0n9L6ZmahRtQgfc+h
         g35lQbj/Cv/TfjW7kFoGqqAkyshaIdY/KJ/khBgYgl7Td08J2dIziNAfEdogBtatIX1a
         rxuu5dH3ICGdzzFHTbyGOQsUfC/uTt9VpnBbA5llPrl2YsuvITNTc7tPTDyWxpp1GZie
         NkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sUftsF+Vt2B9b7tO2kQbmd0BoTEf9vxJh1ljVQUvns=;
        b=q3vze9H30a3e9qhatF+oLqEP1uu4W3YJRCM+Po8OK/3+b9WsHbPwk0tOdCkiy7Lj19
         WRgyjEreMWLYJSAMUG89UIMpdJgnHfav85w5FJ1uw2pRzUGEAdfgJvEP6yr03xEFPrsW
         wiAHxub93vi6jyBtsnthstzuEWQ6DiHEC1tD63jyK73v1IqQtWARitQP/hUYCf97kcBK
         UENWFGOX4YxDGkhqhWsCd5Ix5p59t5FRbnFySzL7bw9/8M2Im9Odv3JDMhaZBw3xiFbf
         ptO6pZ/PxCiKywvsmVUUp6t5cAs9W2iIk0j6RPhlVA2H685u3QZLBb8rYLnY31z+IadH
         Wfpw==
X-Gm-Message-State: AOAM531VDkKXZFYnh2bJYvVeZo83SfHSWyefscApWJ1Eex9WCJpTeWQy
        VpHi8mcxZ71iw1FsULE+Qzt6Jb6q0mAeYQ==
X-Google-Smtp-Source: ABdhPJymKac8XsgJrvfl1snnN1x6FV4LzccZrYeSZAqEAdw/a4Q3RATdzCL7J2x2u3meguK2bRsEbQ==
X-Received: by 2002:adf:bc89:: with SMTP id g9mr689285wrh.578.1640145590845;
        Tue, 21 Dec 2021 19:59:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:50 -0800 (PST)
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
Subject: [PATCH v6 05/17] hook API: add a run_hooks_l() wrapper
Date:   Wed, 22 Dec 2021 04:59:31 +0100
Message-Id: <patch-v6-05.17-d6162fbef80-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
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
2.34.1.1146.gb52885e7c44

