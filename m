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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE253C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B806136E
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhFAOhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAOhn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 10:37:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A9C06174A
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:36:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so1411853wmc.0
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3AXu24ydnivcYSibTkwZRF+cgSfhiAQigd01K96tjw4=;
        b=UOvtXT83jXSAcelLmwqeTpB9yo4kY8ory1HtMe2zlxrr1SaWetxKW9GxlFbYzUVXAN
         yfD2sPzHzGjSFO5SbyK4AkVaJUQUfrjGq1HZYdf3XzeeqdVvD5AX2AULY1hTaHziApV/
         sgStgETYvGwSK6tDsokP5EI4Y2znVaWtZ5I8wwGMaYzi4l9rZDaMXkgZ45HJwkzi2H5Z
         kIEyODHwnwpWsR+QrYEtPMw053B+LGEvklnTkZJNQgV6BStkI0iO2bOrFsLxzLemOTsG
         JXG2AbqfpPYv25nG1CfAEJFsm5mphMUofbmpz/jQsjB5PiePrS/xiR4l9ccQzi8LX4Qs
         U9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3AXu24ydnivcYSibTkwZRF+cgSfhiAQigd01K96tjw4=;
        b=RxfARizbA83AE43KA7sE9YAWtqw3RVgq+uFhQKMgwUqnlwn/AQR6lfPr9+CQhls7eO
         pulxGIK1F0E+FXyZOLvmCe0VtHNoa2ojLAlRTRMjs31F/rqpJoMKn9I3cJcF93WFl617
         xLDzuJGi/ccrbwx6xche60PkZpJwnqAeQNV8T3NB1ZTM7zEa0xBMFjG4byrlzEvjdgt8
         KWig40Lv9mg+JjFnfp1p3vld1x+xCgQpYZ37OMd/zxqThsZAxpDiQitWMa1/cG2bcld/
         mrdbP7XDHILm4lYbf/IVCIkxYfbHyvzkt/u+ixzlcxJV4829bA5M66J82Y3b2RWhe7dK
         +SGw==
X-Gm-Message-State: AOAM533f+qjnqWR3hqrlbQKFHRu6fNwY/ZkJcFcj1S4molMjF6mQYni/
        ROc+v3oaicAmkgrLuMqOnF+2+MolqSI=
X-Google-Smtp-Source: ABdhPJwrQpBCmvHFc47L0XEqt1gx6LnjHxtE8bl/HGRu1ThL9iMHRbGCNaGQ24fEgI/P93alalTmyQ==
X-Received: by 2002:a1c:9807:: with SMTP id a7mr265701wme.10.1622558160016;
        Tue, 01 Jun 2021 07:36:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm3638945wro.21.2021.06.01.07.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:35:59 -0700 (PDT)
Message-Id: <f02c1144d916bd36bd32069e439cfc08b2a7898a.1622558157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.967.git.1622558157.gitgitgadget@gmail.com>
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Jun 2021 14:35:57 +0000
Subject: [PATCH 2/2]  [GSOC] cat-file: merge two block into one
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

 Because the two "if (opt->all_objects)" block
 are redundant, merge them into one, to provide
 better readability.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 02461bb5ea6f..243fe6844bc6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -520,14 +520,11 @@ static int batch_objects(struct batch_options *opt)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
+		struct object_cb_data cb;
 		struct object_info empty = OBJECT_INFO_INIT;
 
 		if (!memcmp(&data.info, &empty, sizeof(empty)))
 			data.skip_object_info = 1;
-	}
-
-	if (opt->all_objects) {
-		struct object_cb_data cb;
 
 		if (has_promisor_remote())
 			warning("This repository uses promisor remotes. Some objects may not be loaded.");
-- 
gitgitgadget
