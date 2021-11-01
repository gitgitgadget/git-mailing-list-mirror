Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2F5C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFED60EBB
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhKATBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbhKAS7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 14:59:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104D4C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so171243wme.0
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGfVUS8FR8Cnu73DVRtbFOzUDo2GysTt36dRDbwV83E=;
        b=UqRoCmn3NUi1xIM9WbeUrN6pWJk88ByrejrJ9Q+adPyO+GTp28VBnw/yZyF8fs2swI
         sIUWd8N8D/gY4nhEVPGHZaGE1mbEtMv18vRsU9tMd+mZcVZK85W8A1he3s0yP4zpWylE
         K422ctTnf0+TW5MVSjBcr2p12alkbehEeRuA3fQz7Q5iQ+4Wz0w7Rxf7W4qVQTRv+uJP
         J9fcRDw1YchNcZFNfC0k7K2uEaeIlocYlvqOBKy9oMkNkpzlSgkx83JBjtj12yBnWfE9
         r+PnVOZiwAyTNW+ffvdsZXknDAV/WxNsPSAUInehMpHH02ulJhHt58IA/c2Jl0UHNnA1
         niwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGfVUS8FR8Cnu73DVRtbFOzUDo2GysTt36dRDbwV83E=;
        b=DXDLx3l44PRnrTOXZi9IfQyREU3fyF/qkaCJ1/IwpGVlyN8TQrDp8DgrtY3NUeUIcY
         9NHk4zCJKpKDlPdn78nnJYLp9UtFCkVr6Gl/uDlB3bMZahnG7CmZWxYHvS9dNJNXvfg9
         J3Lc0ucX71ERXo5GVBCSYqiI+Q5rCTzIJvwagoq02sH5lsWHF9Y/Zl9T3Q+2jTq//YXz
         l/Rs0KlpbH3t1s3ftVY6GftQCnKZcuIcUUqJKhk7EPDONoBmOeEdstS3tyf+LU7rwTFt
         KX7AqS0gt5Wt6+mfEqRykurBuYD4cLDMqbVkfQexThVMnZrbZZQ9ESqcwydsu5GwRAFq
         vfow==
X-Gm-Message-State: AOAM530mhG33jq0xwreEaqAT8NxX5JzrMuUjE6H6eEJyKPFDnFWMjIyS
        oFjcHuQ5O/cPpywHfKp7dO86lIZ6cUx5TjG5
X-Google-Smtp-Source: ABdhPJxTZLEgXFoEiN+M0agUbNHqJ79fF2khqAWBuNux3tu0Tk93Tt68OzHhZsYKGQeQ+LzM04HAGw==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr815427wmc.141.1635792987475;
        Mon, 01 Nov 2021 11:56:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:27 -0700 (PDT)
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
Subject: [PATCH v4 03/17] gc: use hook library for pre-auto-gc hook
Date:   Mon,  1 Nov 2021 19:56:08 +0100
Message-Id: <patch-v4-03.17-173860afca1-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-auto-gc hook away from run-command.h to and over to the
new hook.h library. This uses the new run_hooks() wrapper.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6b3de3dd514..f57cbd2d217 100644
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
+	if (run_hooks("pre-auto-gc"))
 		return 0;
 	return 1;
 }
-- 
2.33.1.1570.g069344fdd45

