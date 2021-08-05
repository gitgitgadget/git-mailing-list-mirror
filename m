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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688AEC4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4804261040
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbhHEHmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbhHEHmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:42:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFA0C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:41:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so7357714pjh.3
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wW5DjSZqp+Dhl/nWLGRg6nwqM/EOuy5TG7n2/Uyyfww=;
        b=ZLfjG2/zjkwY286Qny9dWQ1yIiq91g60SRu5W6DGLhT+J/t6zi38lYd9eq0VQYYyDE
         9vQEgrXaCr14yn0CvbkKDWfPmU2mGGOKDqH80QM6Ptf7DVqSOk8A8hvOsI3hWZib+D0z
         zKQ7kxQ8mgsPyowpo/vJrf+1jCH3csadPFRc7LxaXUhlTQbxCouBdzx7RHJ/JmFD8etw
         n18AMTTQq9pDgN8qDeBdBHb1tKPGbO+XHTWweN0mlXWFzcTg06o9JVBgH0d35p3e6ApF
         aqI279WNVZzmgIWMhb4uaeJkCtGIzLxlhCBpyCD25H+vNQ3F2PaxT6tbNMr/gNgY6bHg
         JzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wW5DjSZqp+Dhl/nWLGRg6nwqM/EOuy5TG7n2/Uyyfww=;
        b=FTir4uwEqAx2f1r/9n/ShoJlRA7TORm1umORfloLHQEBO9IS6TyqkpfqN8Wrw5Fpi4
         GeGRv852irthrTXDt7IAM5KLuxmPDpOEtCS8lzIIwVKHkquHsv52ZVbp7/c9YigQtX+1
         Mpbu4J/INOfSvWESeTimwCoKbSHwE8gJ3HB2haPsO7+L5VSMBncCMIh7IzyEiJuo7pGR
         LNA304xVSbZ+oW9I9aSjIN0uB+7a1c67VrPGKmrYw9se7ruyp8pfwGXL+sFAOOfIYawg
         MNblEcMOHyt6Pi1adj3l8K9Qi/8nlTwfmlZFjX5bkxuOqnnBFyWvfZ/o9g7Jzd+4vg1r
         AP8A==
X-Gm-Message-State: AOAM531W5ZV4YPDY5DyWu7KUg38SkNWNIaHxSCBOgvt+IqLlMe7fWGXv
        CtCc0KM5ywxLLJmEKfa5OE8=
X-Google-Smtp-Source: ABdhPJzTN5juhzZGLJvJfYO8SEIhL6W2Ei+HaWe0tHJL3XeA+iq7BLtzNy2ob4QQR0VF8apbc05ovg==
X-Received: by 2002:a17:90a:a883:: with SMTP id h3mr3449242pjq.226.1628149309003;
        Thu, 05 Aug 2021 00:41:49 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b2sm4885153pjh.18.2021.08.05.00.41.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:41:48 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v2 5/9] submodule--helper: remove constness of sm_path
Date:   Thu,  5 Aug 2021 13:10:50 +0530
Message-Id: <20210805074054.29916-6-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805074054.29916-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is needed so that it can be modified by normalize_path_copy() in
the next patch.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9b676c12f8..99aabf1078 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2748,7 +2748,7 @@ struct add_data {
 	const char *prefix;
 	const char *branch;
 	const char *reference_path;
-	const char *sm_path;
+	char *sm_path;
 	const char *sm_name;
 	const char *repo;
 	const char *realrepo;
-- 
2.32.0

