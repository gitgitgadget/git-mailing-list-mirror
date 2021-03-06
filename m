Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F75C433E0
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA9964FEA
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCFLFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhCFLEz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:04:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED87C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:04:54 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a25-20020a1cf0190000b029010b1cbe2dd0so825400wmb.2
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGRqFIoKHneG+YY+uojwZGt5MHMtDD+wJnvmx+G4wJs=;
        b=ndgFFiH6XEUyUd950v50xE3zAI71hpkOc+FV6L/R3YLXSmBVCvZP3yYLXOk11vQMfr
         FEtvCrQmEO/5horbxVSi1rLyG35x1yVz/KFVi+iIAsQ00yOfpDa5j7kjBngVyIMrjp2z
         DAB9/f9ENIunXvUVvwq88PyswefODLDeafKyQF9YuhJmhiZ7G88SmTkWRJJ2iJcWfY4i
         yEeBVDXlZpSMJKXUOncJxJe7kdXVe4zCJP40Y6+Dx0O2bBLkikjbW/5y/HuZtzufsCtg
         zIiVtneZ8AU98XAVnlnCxLYJgZDCvj+zuOXbf0+JNlP4AhkMH4SZAeXZQ1yn1EERSIRn
         K5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGRqFIoKHneG+YY+uojwZGt5MHMtDD+wJnvmx+G4wJs=;
        b=HKZW+/Fgi3nrOSko5HCLk57rWnMLFVX57MyJwNAMgRmRq0gbznu4d7I4Xd9w6/rbNV
         zGNrnnhWexuyHOlHsIhYZU4SjbWZpfwWSAjT8CMPldTyW2NLKhfPkRo59SLlhu/q5ZGE
         yvud9WXZBxHsPQLcZapx7hzUpD0kZ4gGICZzOuwrGXmVwPo4oBE4wBucwpAvQOeIeOq1
         DuO6ccH+38wNomZP7cFquW6wcr3yqZ44GoidcQQkO/VUwsbOlqVY+gKZm3NEs+emPDM2
         ye2i+tmA5mxuOuNwNapgwpRIltNdHtw3+62hMLdI/aBHmUD4o8V7GM9MpObsQzET/fIK
         e0gA==
X-Gm-Message-State: AOAM532Q5isC6EeV/zFH9OVW+h3dOU+zXv8ntV4iA82aJ3y3y81BFYnC
        WrKoF+WgBs8S1PUL1kod5AjobYaTJd7m9A==
X-Google-Smtp-Source: ABdhPJyP2uuDdvGLo261dxyfRJCV673BihqeyW9tw8YFha89TMlUd5sGw9KYc0tROl6qU7VaefUxAQ==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr12986416wmk.63.1615028693237;
        Sat, 06 Mar 2021 03:04:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/22] fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
Date:   Sat,  6 Mar 2021 12:04:19 +0100
Message-Id: <20210306110439.27694-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fsck.h b/fsck.h
index 2274843ba0c..40f3cb3f645 100644
--- a/fsck.h
+++ b/fsck.h
@@ -43,8 +43,22 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, NULL }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, NULL }
+#define FSCK_OPTIONS_DEFAULT { \
+	.walk = NULL, \
+	.error_func = fsck_error_function, \
+	.strict = 0, \
+	.msg_type = NULL, \
+	.skiplist = OIDSET_INIT, \
+	.object_names = NULL, \
+}
+#define FSCK_OPTIONS_STRICT { \
+	.walk = NULL, \
+	.error_func = fsck_error_function, \
+	.strict = 1, \
+	.msg_type = NULL, \
+	.skiplist = OIDSET_INIT, \
+	.object_names = NULL, \
+}
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.31.0.rc0.126.g04f22c5b82

