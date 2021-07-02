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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DAAC11F69
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCBA61410
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhGBKHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhGBKHq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:07:46 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654A0C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 03:05:14 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s17so10797646oij.0
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aU8pQLf6/QBNZ9cPMTMBbUGqhfH272vUBgEyKs2UqTc=;
        b=T4EiyQ7n9BFQgwF+4+Q+WZqXfL+V2jdGlhjYvBjmkQ1tBC2My26MrU4ztteLOtxW5B
         D9NYym8Z3dAmI+20N3ElImWbVhHLGLFUX1HeF0RUeuN9r5FyJMyBkUwsSMXEQszuLem4
         gm4MpbmllPg2lRqB+14MINzAmf5XGAOc+ZY90WCacHmdi64rBF8K5XfSgPAPN3rdny+A
         pilZMsIvvIS/NRaURO3uLnWmLmu/Ba3ZurUXyeMvvwCo678YWz3E8LzqOHhPf8urF3Mt
         ieVnwJo3sTENkAc+Y/DfrOBcNlwk0qbMbICkl31nWU2v8h+oJPiT50rgP6Fz3CTLAmY3
         OYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aU8pQLf6/QBNZ9cPMTMBbUGqhfH272vUBgEyKs2UqTc=;
        b=qslxTyMoF7bQV68Zuyr2Jssn9lk7CkFyWE56ZdfdC6DH/5pP41qH/zdnG3QomzunPN
         A5WgVFEkwd3M4PuIaDk9RN1ARETAFLDcp7mYeY2jZt7TKFvZsg1eZckGQdTlymq4Qy7T
         IlBpvSsiztNLPh+7Qtsu4f2sUB5uC7w4TOopAzpuxBNWlU+svpIU1hx3zruPIjAaFIX4
         tzqO6GaQeYxXd8QmLxtdlwkVH4ca2FYy2hAhEgd7EUJS8vezBjsWTB/uQWqQ8CAAqsWo
         4imACXI18GHV6N4EGW1Ymk9S87qlqnNprPeCoU+QpBMvoaU5iMkEnKd0DjoR/5skaClO
         HQKQ==
X-Gm-Message-State: AOAM531j65Qxdo7o84bSejfUgsHMo+QAEDVB6SerTt8LedujnemftI1V
        Lh1sw+Q+qii2U0hQaxhSr5Lmg5cZ2T6jxw==
X-Google-Smtp-Source: ABdhPJwYMwVdFzEJ0XkZXpIUBtAtk1eciLwijwjiw/x36XanFV9pAZk4Rnz0b5sFBIbJD60gXmhbeQ==
X-Received: by 2002:a05:6808:b33:: with SMTP id t19mr8353153oij.88.1625220313657;
        Fri, 02 Jul 2021 03:05:13 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id k2sm522013otb.35.2021.07.02.03.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:05:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/5] config: trivial struct initialization cleanup
Date:   Fri,  2 Jul 2021 05:05:04 -0500
Message-Id: <20210702100506.1422429-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.94.g4574ca548c
In-Reply-To: <20210702100506.1422429-1-felipe.contreras@gmail.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 config.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index dc896c434e..9172c96c54 100644
--- a/config.c
+++ b/config.c
@@ -2265,11 +2265,11 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 /* Functions use to read configuration from a repository */
 static void repo_read_config(struct repository *repo)
 {
-	struct config_options opts = { 0 };
-
-	opts.respect_includes = 1;
-	opts.commondir = repo->commondir;
-	opts.git_dir = repo->gitdir;
+	struct config_options opts = {
+		.respect_includes = 1,
+		.commondir = repo->commondir,
+		.git_dir = repo->gitdir,
+	};
 
 	if (!repo->config)
 		CALLOC_ARRAY(repo->config, 1);
-- 
2.32.0.94.g4574ca548c

