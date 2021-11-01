Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92719C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7022160EE9
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhKATAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhKAS7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 14:59:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55916C061766
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so171219wme.0
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VDVE2Axqlu/cjWiNeDr8w3VB4+md4u+RP7MrPFtgws=;
        b=SnKI78+/GEGnesZ8zLZ1leeprjjvXthXSKIzNWAlrwwSykC7eEwdG3GUU7ovk7g2iB
         9k4qolBypaXRJG/1oyEn+1aDCrFNwgFYwIjAla6Hy59uLZKKOo4l/XtMLoWNcAwHcNBl
         ICMQugqVMmqMT14ewtxV9Nd98irc/JzUjUDebtZWwkYOWK9rRQcC+8aHARlacowMbQ11
         s8fmke0BrpxaSEId2AqdwYBMPL7sTyzr3gMG1Oefs9j52L8Y5MetUhQRQrKDy3CgEqrD
         nq6yYTFZzgSUxrnSo4pmKji9KxAds0uJy1wX8N9+apL/mtK6feXZFnAEtbhnnqjn8cSQ
         pAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VDVE2Axqlu/cjWiNeDr8w3VB4+md4u+RP7MrPFtgws=;
        b=GZ8beROlCa1Br+GV5y4l9V8sCDtGuQYX8S3r4BMwI9NsmpiFrch4PfuXm7o/rQzMRF
         ce7qe2UQPq872ghJaTaaaoO4vuwDSZ0pPh4kJpxbbAY8LYDAcHy5YdFOlQpYyPrkUTqS
         EGZeT3aCerShHBJfaR1lCbEfU8h8oNLuL9MebIB4YW1btUzLBtAnj00YOdCFPVgLKf+5
         hNNSkDTimjLDidE6zSxC1SMQSWQPd+E+QjYjEDu87YANZGBiTpJuFGCnQ6ciwa09mIkW
         hUTAKgnP+W1AlnIrCbnoxuKrfH4UWuiIHsujO5kwQ35JjdS5eDEM1vpFmNOFNLL3lqRX
         yjuw==
X-Gm-Message-State: AOAM533hjH4fUCBbA6XaoVyh3NzBFXxsTBoajHDEFXI6eWxTwVOLRcjC
        AfbcucFRpyXAAmAhzrmqdk1Iym0hKqNbe6UM
X-Google-Smtp-Source: ABdhPJxenFWe8f/cjht5o/VU9csiYCyPEulDbMkAp/VXz9MIZJJ68a/SZ2VZzGzZ7VGCYBONkTcW3Q==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr860449wmj.84.1635792986710;
        Mon, 01 Nov 2021 11:56:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:25 -0700 (PDT)
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
Subject: [PATCH v4 02/17] hook API: add a run_hooks() wrapper
Date:   Mon,  1 Nov 2021 19:56:07 +0100
Message-Id: <patch-v4-02.17-ca6464f7d5e-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a run_hooks() wrapper, we'll use it in subsequent commits for the
simple cases of wanting to run a single hook under a given name,
without providing options such as "env" or "args".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 7 +++++++
 hook.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/hook.c b/hook.c
index 64d3608e45e..720994bf4f6 100644
--- a/hook.c
+++ b/hook.c
@@ -142,3 +142,10 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 	run_hooks_opt_clear(options);
 	return ret;
 }
+
+int run_hooks(const char *hook_name)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
+	return run_hooks_opt(hook_name, &opt);
+}
diff --git a/hook.h b/hook.h
index 782385cc235..9c358789958 100644
--- a/hook.h
+++ b/hook.h
@@ -48,4 +48,10 @@ int hook_exists(const char *hookname);
  * error().
  */
 int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options);
+
+/**
+ * A wrapper for run_hooks_opt() which provides a dummy "struct
+ * run_hooks_opt" initialized with "RUN_HOOKS_OPT_INIT".
+ */
+int run_hooks(const char *hook_name);
 #endif
-- 
2.33.1.1570.g069344fdd45

