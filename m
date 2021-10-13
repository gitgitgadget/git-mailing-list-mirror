Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6111FC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE1060E8B
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbhJMFVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhJMFUx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 01:20:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECBBC061714
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23so1331363pji.0
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3CB00U6KchGlEdE4K8+5i37LJ+Qu7UdCj3Ax3kaK1RQ=;
        b=GnhtWQ/xQkjgwMkussjVUJXTWv3kNrIWmIBATQnq/x6wwEL0azM1bQYJZw/l52mTER
         MgNvTFsrl2LAudmI+r2PtnfVbAA+USZhDbctQamJlAtZ4SdqE5AyLFSc25mA/dp63E/H
         il9Al/mqFOXBLcK8Q1WkOGKnoWgguuYSesK93gVTBwWo6mzfojXto6SLAr2KBJAb3eUT
         Oo6vDjSVtviSifMumbDqAWgb+Bpwg8RCsXbxZKPwYmUhlLZhA4ij9IiUuhDO0/tuY3dU
         JeCjNF0a48dS6/CuiUbqq+5ql6VTWayghvzwhVjHMiiPOHT/op7krMyvCsMDJHgIXwGm
         eF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CB00U6KchGlEdE4K8+5i37LJ+Qu7UdCj3Ax3kaK1RQ=;
        b=KFiEnm+frYCbrxpGME/wkEqsi3EBKdV2fTt76HJfloUTnbcJZHgNp5W8NfzreC++si
         WzLTWcMaD2IKoW4cNwelsZje4I4iVFZzhJRG9Q2/HVEe0sqXf6Pve1XLdD3TSsjTQodS
         wShAkwZkxNGZCKs+CNM0HmdbWOg1B7asm7Zc5XU5//sMz6G9YB3gZSH+JOl6CbHaXYlz
         jHtbLYKbZ03hZvrb9cTfBKffJ06kz8HTeU0NNp66re0K0SsLVz1AF7/mWPjNS03RO4eX
         4l80jRFgdzPszUPonEgPDSgmJmQpq6L4SXTU33jtqS7argJhdWwzjIdMm5XOaH393zlk
         Sh6A==
X-Gm-Message-State: AOAM532ZxiixOeW228SlxlNnhBOZ08d5DXiQeaDfq1Q5B8fJTeyD6B9L
        65SYjEp28VJ8kyDbxpQ0Q5k=
X-Google-Smtp-Source: ABdhPJyPGyCaxSbnNuxuqoaP1xG1Djay1e36Rs75BiVtSukYmByo26839ulrJuHOy2Is4TfAw6tnVg==
X-Received: by 2002:a17:90b:2349:: with SMTP id ms9mr11167852pjb.45.1634102329760;
        Tue, 12 Oct 2021 22:18:49 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.111])
        by smtp.gmail.com with ESMTPSA id 12sm12481197pfz.133.2021.10.12.22.18.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:18:49 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v3 5/9] submodule--helper: allow setting superprefix for init_submodule()
Date:   Wed, 13 Oct 2021 10:48:01 +0530
Message-Id: <20211013051805.45662-6-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211013051805.45662-1-raykar.ath@gmail.com>
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We allow callers of the `init_submodule()` function to optionally
override the superprefix from the environment.

We need to enable this option because in our conversion of the update
command that will follow, the '--init' option will be handled through
this API. We will need to change the superprefix at that time to ensure
the display paths show correctly in the output messages.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5b4f1dbcbd..74f084a9c9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -606,18 +606,22 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 struct init_cb {
 	const char *prefix;
+	const char *superprefix;
 	unsigned int flags;
 };
-#define INIT_CB_INIT { NULL, 0 }
+#define INIT_CB_INIT { 0 }
 
 static void init_submodule(const char *path, const char *prefix,
-			   unsigned int flags)
+			   const char *superprefix, unsigned int flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	/* try superprefix from the environment, if it is not passed explicitly */
+	if (!superprefix)
+		superprefix = get_super_prefix();
+	displaypath = do_get_submodule_displaypath(path, prefix, superprefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -691,7 +695,7 @@ static void init_submodule(const char *path, const char *prefix,
 static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
 {
 	struct init_cb *info = cb_data;
-	init_submodule(list_item->name, info->prefix, info->flags);
+	init_submodule(list_item->name, info->prefix, info->superprefix, info->flags);
 }
 
 static int module_init(int argc, const char **argv, const char *prefix)
-- 
2.32.0

