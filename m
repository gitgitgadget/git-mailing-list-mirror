Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B198AC7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDKHmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDKHm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE11733
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso10117347pjs.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198938; x=1683790938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfSqcNA/a+SnG3CQuSV9f1W4eUbDkz0vUT3mSxG1xJA=;
        b=XcMd1Upejsitz8HaGZnI1Cfa4Gd4bGzLFdTWLMVGlc9Dh5EDhRbTnHzTQD+gy1IiRj
         PgP+NhD9+gZ1+hUVfiySZdZOx1T7Xy6ezR5RHfrOoTJZJL3N8BOseEgbSUikDkmYJRbw
         ZgOmy4KP1IQTor3sJS/5G3V/EvRfgBFpMq0Mn1FuWJJbRI8rsxrwhZq1W/ijNON5OtVU
         aBE66KP70qjLZxwdeEhvolIW8gkKGpwaI0k449dTBg2zeHV1cMpd6JUTIR8ciENHNBkx
         ocexXBSUeni+/y94a3abUks660u42KywsZBk5isl5rnL6U55AKQen6oRo9UUKxlYitwq
         aF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198938; x=1683790938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfSqcNA/a+SnG3CQuSV9f1W4eUbDkz0vUT3mSxG1xJA=;
        b=u25GAJ+7YAHRjPatyuo9LM4dREmuYyp8o0bxNjsSIBR97lkXDgf66QKnTq21hY2a5b
         2ZjRhz00o6YhL9rs2MpuH0CWPDrnD8ttre/+18yrrsomLyeGNT90fkmhUCaH0bSUmU5g
         vTe7OjmZ2+JT09yRqtSR7AA/xb4ptjBoaH5abzH7ag98B7QsJeyWgjJWlVxgK9qUO81f
         85cVKBG4LT2lmHlj6h9U8oR9JK+ZPzU8mFnxmojU6r9g6Aym4/iyL/O8ewoFGuhJ1172
         EsoLdDOjdj8wtlCpz5Ovwv7S+8r3A2qjnUjlkIUuZXJdLZdFACkzHNR6BueMhzUA0KXT
         mPlw==
X-Gm-Message-State: AAQBX9dKAOUOjcc1EiL/vp0vaWda1jAO6/XK9pTTs5fcanFXrVlclB0r
        LLar++TB6sEYGWPiH4xpmC+izvqhzYg=
X-Google-Smtp-Source: AKy350bqidIQj9Q693EEh5jI58o450h5aA3X8MHPkdxfYXgMHN7cGGMBXlrgMtiLpOWhRz/N8Fzx1Q==
X-Received: by 2002:a17:90b:1e51:b0:23b:4bf6:bbed with SMTP id pi17-20020a17090b1e5100b0023b4bf6bbedmr16646267pjb.24.1681198938463;
        Tue, 11 Apr 2023 00:42:18 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:17 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 11/23] treewide: remove cache.h inclusion due to git-zlib changes
Date:   Tue, 11 Apr 2023 00:41:52 -0700
Message-Id: <20230411074204.3024420-6-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This actually only affects http-backend.c, but the git-zlib changes
are going to be instrumental in pulling out an object-file.h which
will help with several more files.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 http-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-backend.c b/http-backend.c
index d41b3b9e1e7..ac146d85c54 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
-- 
2.40.0.172.g72fe1174621

