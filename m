Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E836C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhKWLtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbhKWLtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15C2C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso1960196wms.3
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyNb1suCSqW3g8YzXeaOzn+qvYklup8sHtg8NBE9Vok=;
        b=CYwpJ7PWtASjSvsejdZkzTKyq/+u6RSLc1ifDsQ33kC9Ft0lYWvKBsYHZq+keynQwq
         xvdr0uL/1tPji1bB+O71jkc0tGRsJIw1p5jpPzDlPl4mYvbvieAQE1UnKP2UvOfPHZJl
         RYS5j8MiUSu2ZrUJHyEJlx607dY8Qaox25c5taIIl6ttgEkow502wg+ghM2mf0YbaPqc
         P78E66JBHpAednNONq7C0p5BX0i4yZgBbai/9VW0xvG/OvAptSKYBiPQ8+bz6j4Kn0kZ
         oXTD5SnMDgegLoVXVfj9Zsf+019x8RykTFI6i+0/Js9G0UYiwuTEWrlreDqqjYibDtjt
         iR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyNb1suCSqW3g8YzXeaOzn+qvYklup8sHtg8NBE9Vok=;
        b=AaC3ptOKE/YO8A5kJxj8Jd41+Mn83zp4QNJotcQHnwsJthD8ng8w2imq7VLUJ0MiEm
         hxSb3tP5IMIw8J0ce7uosNStl1VmX8r235PYgeZys1m2PiktvU8OKeUwaZiW1Hg5QtZo
         4o8kjzZYf6k5mRzM9fKQu3D/Hkm2qJKPeAO04tuhRHWL7tnepYeZa6b2hb8JDdh6fljo
         7K98VGCLjfE8/jmTX/kjcijnHNLyu+CAmmj1DvxSltauACpsao5NjctTtUOaLSL+5aC8
         550jkKFq9j4Y42r3Lt8ugqwN8mzZT3lsICEMol4l9bi7xATGLUnnVy0F2d4Vwch6HYp7
         SPLw==
X-Gm-Message-State: AOAM530y1TZJ5H3PN0RUDnr2DYsMOIceWYqYod5+OgKOHmVLK7Dvpq+a
        3HpDaFrmyl35R1TJZk1bpX0g7jpIjPkuFg==
X-Google-Smtp-Source: ABdhPJwsd21QM03La9EpZj6yZ910ByhzD2ZameSLUvKa0cUUL+bvphP+G7oxv+skoBylPgODIf5t5g==
X-Received: by 2002:a7b:c744:: with SMTP id w4mr2382880wmk.50.1637667982070;
        Tue, 23 Nov 2021 03:46:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:21 -0800 (PST)
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
Subject: [PATCH v5 02/17] hook API: add a run_hooks() wrapper
Date:   Tue, 23 Nov 2021 12:46:01 +0100
Message-Id: <patch-v5-02.17-6275b97a306-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
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
index a0917cf877c..d67a114e62d 100644
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
2.34.0.831.gd33babec0d1

