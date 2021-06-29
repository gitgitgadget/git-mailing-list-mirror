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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A8C11F69
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 18:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0D461D84
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 18:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhF2S46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbhF2S4w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 14:56:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05D5C061767
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 11:54:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n33so258257wms.2
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Arqb+YKlaGPIXcELVOJi/Fcn2FhlR4YsbU9HyKrUrRU=;
        b=vPo5NI/rDElXEiPZ4heqNLDAP3aMZS1jCS33xUdKFF7Xdtnf1sJIOgNiTYBOCjBGdb
         hQuOqqnVIgO9TxBZtJ6IYep3oDDSbTpUJro6LEN2PG612tiPAey5RbGYcYtxEirvpyM4
         c3yaG30jUKb1zp5rFivIrctyOGOAaY+eKSlNrGqeJgrzVSpzqY1BN0NqnZGiBjaULrZC
         nkWkYsYQDYHTj9awrR1xWBOcOJaBbsWBq3fciD/VmumAesoXCgYEiE0XEke2aNCak4qI
         qyfstURwp3vFwd5E8Op7jDJdl0zLXG28WdhXcZBuHwKYgyAtfXuQiRovIHzGBiGFm8De
         BseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Arqb+YKlaGPIXcELVOJi/Fcn2FhlR4YsbU9HyKrUrRU=;
        b=lD/waUt1NSwNViZjDh/WShVPL+agYzhSkcIbbWKpyo9drGo8+mZn+HGxVqo2WEBIO7
         gMzDtouz5PREgJ9/4EcQ9itEfSwD/bu8SIk9epsxeugOXl7xY+oL3NhGCg4IJ0rcPHoT
         22kNMaNGQlnwMZi1yKCtLb+DjpFIRh2dlAPUZ1otaNSEDCGHX4XEujXhkBy1Gvve6Adl
         Cc3awThD8lBnxNMkY3sfJNOA/R3YRrIPhgp8/8q9L5rnlX0bXJN611GTTGOXj8Q04Qu9
         1NIVHfNHbuVtcICkywNU7vGGIxOHttovsD+esPofTn5I0Y6tDr3PDWTE3uiHypcO3x4s
         v6yA==
X-Gm-Message-State: AOAM532DHmMgYHj0nhmUe82TinsXPVxuZmCbJ8y3PwpkIFWT4TXwS84Q
        fy+Qn3OXaILL8i3O+fYN/vftAWp8HKY/yQ==
X-Google-Smtp-Source: ABdhPJzFStvstDvrey8OvAY5tmnWAnkXsfH3FfThXpBRnqlWtFFJ/3vlTMGW2xTlsnFmaj3T1VBwlg==
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr34191005wmj.30.1624992862293;
        Tue, 29 Jun 2021 11:54:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k13sm19025218wrp.73.2021.06.29.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 11:54:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] hook.c: add a hook_exists() wrapper and use it in bugreport.c
Date:   Tue, 29 Jun 2021 20:54:01 +0200
Message-Id: <patch-2.3-0cf7e078ef-20210629T183325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.615.g90fb4d7369
In-Reply-To: <cover-0.3-0000000000-20210629T183325Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com> <cover-0.3-0000000000-20210629T183325Z-avarab@gmail.com>
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
index 596f079a7f..941c8d5e27 100644
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
index c4dbef1d0e..97cd799a32 100644
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
index 68624f1605..4c547ac15e 100644
--- a/hook.h
+++ b/hook.h
@@ -8,4 +8,9 @@
  */
 const char *find_hook(const char *name);
 
+/*
+ * A boolean version of find_hook()
+ */
+int hook_exists(const char *hookname);
+
 #endif
-- 
2.32.0.615.g90fb4d7369

