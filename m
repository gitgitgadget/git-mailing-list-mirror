Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544B6C43333
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 389D164EB0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhCNSs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbhCNSrt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 14:47:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1253C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so18961130wml.2
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GagUwiP0HL+zZ0S6XbUDvsJLMDayoR/u1iElHCEGZxE=;
        b=qPeeo321Z2SuMsm/y/Qj/cSy0qS+tJCxoVaECOGiPt2edxj47xU+hMKjrtLB4sVRHy
         aMXSdrKtxyHrPxMYiZRXiFkXEI0Xzb90jeHmzuML0XRlY41zgG7R3FWllmA0A/YNJL6o
         ETq99zQK4+Y3rB492w4cCtEr7jQm9Ju0xWgqqXy0jiLypankmvS9g11TA/yJYyHCvNH1
         RjU21HK65CHucwgFAnDyNZGn46YA8spjNYCueBFwh/SBHAoXmMWv/pfpE54OCN2ATVEA
         hbcQI+r7WF38/ROV19UXRx38BhSHgo++eruf8M2K67yCFNU2+n0qt0fIXGZg4pR51nh0
         2VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GagUwiP0HL+zZ0S6XbUDvsJLMDayoR/u1iElHCEGZxE=;
        b=aGKWXmmgXnxIro/AcfCVgq99DY5EDHzuKEP3JxayRw3m9oG0ARksbIbbJsqyLb9Loa
         BkE1Pyx9em8NHnPDD05MunSQi5uSh4/FoOO/NNsJ+F5CVFZlF2tjsC+dqB0cktuLDU2G
         JqdsbQ0/JSAJ/aYHX4rj+KZ4VOUIO9W6Gh4JhP64OjlKjCTpUHb4XkcJbhvUBdKIHG8v
         d/dC3XB096HSBfOGfpgB7QxUuHlucjjlq/6o/IWCF/ZT3xx/wprj+JdVxXij8hklRAn7
         4XekkmJThtyu/g3EZuz5nqg7KoXXI0Xf+/iH+IuKFXFV32YkK0mRDIRMaizwhgMmejiC
         LLeA==
X-Gm-Message-State: AOAM531FQpG4csa1/teZ9PLLeSQokIj3bIQjfsgf6agVcUlVzob3xBKf
        3PPMpb0zFsJS3N3v6leO+3QHtlsgTJQ=
X-Google-Smtp-Source: ABdhPJwKp8fiYU8oB/0+QqbvZpgYGXHNMRwKdUCDkZkQOSvTMZxEkaXoNSx74IULWk27yliLvFpAWg==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr23123919wmc.114.1615747666749;
        Sun, 14 Mar 2021 11:47:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm10109641wmj.9.2021.03.14.11.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:47:46 -0700 (PDT)
Message-Id: <aa345e50782f242ce8fad6bc0ccc121a0545e83c.1615747662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
        <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 18:47:39 +0000
Subject: [PATCH v2 6/9] init-db: silence template_dir leak when converting to
 absolute path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

template_dir starts off pointing to either argv or nothing. However if
the value supplied in argv is a relative path, absolute_pathdup() is
used to turn it into an absolute path. absolute_pathdup() allocates
a new string, and we then "leak" it when cmd_init_db() completes.

We don't bother to actually free the return value (instead we UNLEAK
it), because there's no significant advantage to doing so here.
Correctly freeing it would require more significant changes to code flow
which would be more noisy than beneficial.

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/init-db.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index d31dbc883746..efc66523e22c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -561,8 +561,10 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir = real_pathdup(real_git_dir, 1);
 
-	if (template_dir && *template_dir && !is_absolute_path(template_dir))
+	if (template_dir && *template_dir && !is_absolute_path(template_dir)) {
 		template_dir = absolute_pathdup(template_dir);
+		UNLEAK(template_dir);
+	}
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
-- 
gitgitgadget

