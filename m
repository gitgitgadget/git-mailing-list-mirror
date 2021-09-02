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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D92C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B75610D0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbhIBNM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345015AbhIBNMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3358CC061757
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v10so2853958wrd.4
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RaVYmn7tkPYTewAfFPVulJvTmrL+DdB+FOfQqAqpQmw=;
        b=Sv56NSBP+rKe0s9lNcmOGrpyjlluU1RKbypDNRJo3dj+NtIZi54iWGjCrDqojD8dyq
         bLma1fWDfM1I/7vmbAlcVP0Y3Mit7n1yfb2ZcBUZDh03TgzNxbalzPKig8CfR6gIw9VQ
         lpByIdwcS80HLs02ebnFKlKCWLRM8JLHCtZ1tnlNzV1sKs8g28BXIlXK65uxSU1idMdr
         rTvwL/2LE1injjXoJmwHCSgCeU4OWdMz4xyNLosT00EEADfURasNrUSmGWe/moVOO3Fy
         XNY4f/tclq0Zg20IqTOIU5/WYRR625+71cv027MDhH5+QyvIoJzErReVd0pyh/deZrHv
         xddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RaVYmn7tkPYTewAfFPVulJvTmrL+DdB+FOfQqAqpQmw=;
        b=VznnYJbZzD8PdM+vSRYcCVMPUzbblTRXR/cQfRlUzIDyzbM8mamp62K0SaLLPV7WbV
         PR9k4DygidQ9h4Rb5NNHK/7fTq+0NjZCoiF1GkIOP7ltmcRnd3/IQbt97AatoKkWzy0W
         DB16WId8/BI/dXIHCcE9kDVtgz6B/BPqmEW1Mr4LeVqcfCn3aLHwARNLLNQ6Zim1saGh
         dLmVV2dEutmwQ25kT3jkZNIfOvXGZuVlE2+hNXR+kYiKKbTdIOWJbwwQH8mWhZXxob25
         OnIdBJ5SVkj8YXtJh8KHuradNOMn43yWZOxfAly6xKNJBCsn8SozSgCO58WYEpfwZXQd
         gbmA==
X-Gm-Message-State: AOAM533xyUzvFB30DqnKjioN7X6Vyr3WX8Gv30AMs1TbUJr0vi9La19y
        zOidNTe2rb3KumJMDVCDPhLC/0+Mj5vBpw==
X-Google-Smtp-Source: ABdhPJy+93Ud2EDTq+Xzc9jvo/UulV+YLEjOwN9d9ICR3IsbIpkhOzZEFzjls0N2opz/qZ5cO8z95g==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr3584017wru.103.1630588306519;
        Thu, 02 Sep 2021 06:11:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:46 -0700 (PDT)
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
Subject: [PATCH v5 05/36] hook.c: add a hook_exists() wrapper and use it in bugreport.c
Date:   Thu,  2 Sep 2021 15:11:05 +0200
Message-Id: <patch-v5-05.36-a9bc4519e9a-20210902T125110Z-avarab@gmail.com>
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

Add a boolean version of the find_hook() function for those callers
who are only interested in checking whether the hook exists, not what
the path to it is.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 hook.c              | 5 +++++
 hook.h              | 5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

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
index c4dbef1d0ef..97cd799a320 100644
--- a/hook.c
+++ b/hook.c
@@ -35,3 +35,8 @@ const char *find_hook(const char *name)
 	}
 	return path.buf;
 }
+
+int hook_exists(const char *name)
+{
+	return !!find_hook(name);
+}
diff --git a/hook.h b/hook.h
index 56a7b3c9164..368754b1201 100644
--- a/hook.h
+++ b/hook.h
@@ -8,4 +8,9 @@
  */
 const char *find_hook(const char *name);
 
+/**
+ * A boolean version of find_hook()
+ */
+int hook_exists(const char *hookname);
+
 #endif
-- 
2.33.0.816.g1ba32acadee

