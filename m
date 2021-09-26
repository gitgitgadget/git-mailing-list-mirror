Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCD5C433EF
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32AC960EE4
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhIZTFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 15:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhIZTFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 15:05:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55DC061769
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x20so728554wrg.10
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBanF96Un0N3wZuBcysKAvacpqSENpQbHTlJA+31n7A=;
        b=Dpjl2/xNG6NTn3qeUY1KZYFFYlf0B7yUP7HT5n0zElUSNsZUV0rU7xF5Cc/83FjWBT
         nStykCKpOmZxtKD8S7FQqDkpBGA/dWKg5fFSWEw58Gr6WS8hLSf9MZ8RAVVo9kwvcGDZ
         j6iYCUO6CEBBKXPUGLhii2/89Rl5ne1SbqlFZd9W+4yyoIesLE0dvm4gKodM6uLG56iP
         CVesNpSIlpZR9Jz0CtAhottQ8a0Rpyu08aoicahvwvEPr7P4SzNDWmMpzbs0HDV5Hpqt
         C2uMRwh/9+W00d1dvYUjlpc5AooAMdkME1uvZgyateoWFQg5ouNX+wW7RCJOcCy5Swox
         xTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBanF96Un0N3wZuBcysKAvacpqSENpQbHTlJA+31n7A=;
        b=0KS04BsqpPIx1u7EgDQGZbxojt/mjsXGi7sm/qVcrGC/uhA6A8XfJtbP/qg6h9v0h9
         ol8ZXXjfqASs9Ww+e58X7lWbppk8kF3TGEvm9xTgZ2PEHZtq+8KyLiZa63WSI7MPtCEE
         OTNmK/q4qswGKFYIa9oH2S3M5GHIfHT9fWg1LBbn1sdEuhxlzOG8Y67vN0vyjLcPCKQN
         ZhhDMhJkHGcytELoiWHEO70dSBuTUTet1lCd2uj04Pncp7A300K2lezPy4TrOKAoH74b
         erg7RQlIvW0884RZMFA0EU/6R+7tZHMgRqlkqTs7NColU72JBnKfUi2vskqAZSs5fmB3
         AsyA==
X-Gm-Message-State: AOAM533myM8mWGI2jGJU86JKeROd7pn/9amZA7cC7MgRFjfyrsPIQ3y/
        G3iCNuQw07fKPi1A3KWV9f3Ehd+hvSMDZg==
X-Google-Smtp-Source: ABdhPJyAxLmkVu8BBSeVnoYMKVgggqCmg2+ymnmIQwAQFs+1omTJYr6j2bVA0bieZKaw/X5L51PW2w==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr12306658wmi.77.1632683017201;
        Sun, 26 Sep 2021 12:03:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm14691523wra.73.2021.09.26.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:03:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] hook.c: add a hook_exists() wrapper and use it in bugreport.c
Date:   Sun, 26 Sep 2021 21:03:27 +0200
Message-Id: <patch-v2-6.8-4eabe7ca39f-20210926T185800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1291.g8857a6a91ac
In-Reply-To: <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
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
index c30a360d695..a02c2540bb1 100644
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
index ba70b314718..55e1145a4b7 100644
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
index 68624f16059..6aa36fc7ff9 100644
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
2.33.0.1291.g8857a6a91ac

