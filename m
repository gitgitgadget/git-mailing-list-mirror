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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE055C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C420F6143C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhFNKiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhFNKgP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6281C0611BE
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:48 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o3so13977165wri.8
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xGP99aGKF6yjV0zJ5oCa3cs1y2yVY9yQanaHDRG3WE=;
        b=Hy7acSDkuVjy6usUMwpmbRxpLLPvrgvtcvZcpO6LO+1F/zORKN6GU2G5MRahh3vTS4
         mKBg9mOzvpq8dubub+BcC/ZA1B528vOKC+fWbkcaFzk+GdSMgy4kQX2tt4zM2vKwJzYQ
         PBo67Lr8k9QoErpMH9MhZxNgFYwqMRE9nhq7xVcRR0IqY/UlvWR8lMuHoiuqyjdwprfB
         UtAQGXF0VOdR68SmTrF4zD8j7SXhFtnKE2kVikkOv1fYgLFYurmCynrRL63jeuaMYvTz
         VN0p9jFBS1zw0WyNQpSnDrko0iDBf75clOjhezFZw/6DcR0B+NbB5W+LgArm6RnWA39x
         61sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xGP99aGKF6yjV0zJ5oCa3cs1y2yVY9yQanaHDRG3WE=;
        b=H8TxqO5SD+wI1In1nwbFWH3e3JeOHzSgZl/4KGlS1Mll/f9tz68NcMw88kvMOS30qE
         +LcDw83hz3OSLx8lNoxeiswW2L8/vZ1PLKR2WwiLzQv8jSnr9fLU9W8bwgnyXzV/+Vz5
         ZPr1vsDoPizK3wlbmbm46+pDUafkPT3oxQylhEjD48NXSt6sbvI/j3FoyEtf2VaPR4Qi
         FT949SUHN06rgUq0kK/1RsLisLBdIiQ4INNkMa/cTTNx47FkHnoslaErxC7rcPOvi8v5
         iKiayQPKfW0ZaokjtY8zKPo8IrjkdQIB/zLulbFCHgMleLjdWHoj4IE0dbfoSGCxrGaQ
         gNeg==
X-Gm-Message-State: AOAM531txA8X3z2wTnwwF3mDiR6ZTvcZU9eSYPzQwZON1M/IEaQ4j9eh
        8EHuIMaB1tIFscqPPPCxD7gl58Jw9T0ISw==
X-Google-Smtp-Source: ABdhPJxx5vMCP1yTYmaNtrt1bTpFCykDdveFUwm0g/IGNRzvCO/9DStaR4A/sVg8+H41AQkGPifdxw==
X-Received: by 2002:adf:fe4a:: with SMTP id m10mr17968150wrs.332.1623666827182;
        Mon, 14 Jun 2021 03:33:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:46 -0700 (PDT)
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
Subject: [PATCH v2 03/30] hook.c: add a hook_exists() wrapper and use it in bugreport.c
Date:   Mon, 14 Jun 2021 12:32:52 +0200
Message-Id: <patch-03.30-eb5bdd993c8-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
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
 hook.c              | 5 ++++-
 hook.h              | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 596f079a7f9..941c8d5e270 100644
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
index 06842f50e5c..c7da273822d 100644
--- a/hook.c
+++ b/hook.c
@@ -36,7 +36,10 @@ const char *find_hook(const char *name)
 	return path.buf;
 }
 
-
+int hook_exists(const char *name)
+{
+	return !!find_hook(name);
+}
 
 void run_hooks_opt_clear(struct run_hooks_opt *o)
 {
diff --git a/hook.h b/hook.h
index 291ee19469a..cbda7746a5d 100644
--- a/hook.h
+++ b/hook.h
@@ -44,6 +44,11 @@ struct hook_cb_data {
  */
 const char *find_hook(const char *name);
 
+/*
+ * A boolean version of find_hook()
+ */
+int hook_exists(const char *hookname);
+
 void run_hooks_opt_clear(struct run_hooks_opt *o);
 
 /*
-- 
2.32.0.rc3.434.gd8aed1f08a7

