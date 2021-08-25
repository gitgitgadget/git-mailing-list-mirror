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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92372C4320A
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC2D61184
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhHYCXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbhHYCXU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:23:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9795AC0617AE
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so3145621pjb.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qQjliPr0/s7baFkmaMyhWgWFFttSbuWmEbFgxprA7E=;
        b=LtjozlB4Fl71ep91cPQctdebOIU0mEIaUClMMUVUP5pyk5jjSV+v5t39ZSZVmErzjK
         gu4dF5UwgNoSWi6G2qNI2dZmSZZsqQ1NbkPexhmzxYPhK4kW0jY8GO8k8qn2z+c/5Rgn
         5No7StXgmKT+V95h+iJzftXBF3FZG0ec++Huxbv8/TZAfsNWEmRh0NXJ4NYVbFFVHRcj
         jHy/rn+0QSn5KgEX4GV+Noin7wLgbLpnqdQ9Q5wBsIxlF8SDHmmqsM8lgct41osor7o/
         oX4PaEttPagoRGz7wmmu15D8xWK0uYlTn37vh4Rx0Hyq7AfzqBiui78/+49tKaBV7Tzw
         xrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qQjliPr0/s7baFkmaMyhWgWFFttSbuWmEbFgxprA7E=;
        b=uJGO8RIXlwa0xOqHbeWv75Zo10EkmFtAyhciGgnPD7EwUGfLXNvikj/PPCDdJYONLI
         Wmuhv3qZoQ+P6A0gMMPjfbipyPUIJq2nNKos3vlpgX91jerEo6mNdCDOH+kOoKqUxWaR
         4TCh5c58cGeu86RzbQIj0ToqmwiYLJ8lDiTSDTKdpPJ8iUahte1Q1qfZ9W/7y3IEZo8z
         fFwJotHM2iO+9CtOPIwYuA6ebyU8TRiC87ZYG3D9CKXlXYfOj9gzRWJlptj4CYJUjxqi
         DFpUwNHpFbODc50d3qUT7sd4sU4y5HyA1wIr4EN4EvbVGFR1r2JcSPOBeVLS7kzDKCBO
         u55w==
X-Gm-Message-State: AOAM530SQq9upEg8j4Stmk5wzHQpXZ1KcxeuZEGGWRHhwFeWFoExApyJ
        BDe4T2WFYrIT1WKOWQ3nvQg=
X-Google-Smtp-Source: ABdhPJxX0IEu8JqQVV6ouwcMXu5T/SiZcCV3GjJpDRkxecJhDWTIGmZTmwN5wqjerZ/S6hEp1Ojf6Q==
X-Received: by 2002:a17:90a:db96:: with SMTP id h22mr7957354pjv.212.1629858155174;
        Tue, 24 Aug 2021 19:22:35 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:34 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 10/14] object.h: add referred tags in `referred_objects` struct
Date:   Wed, 25 Aug 2021 10:21:54 +0800
Message-Id: <824844499f3761b9bdc7952a5ace3721f3c92432.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 object.c | 1 +
 object.h | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 69ba0baf95..b25b2e2919 100644
--- a/object.c
+++ b/object.c
@@ -341,6 +341,7 @@ void add_object_array_with_path_and_referred_commit(struct object *obj, const ch
 	}
 	referred_objs->commit = referred_commit;
 	referred_objs->trees = NULL;
+	referred_objs->tags = NULL;
 	entry = &objects[nr];
 	entry->item = obj;
 	entry->referred_objects = referred_objs;
diff --git a/object.h b/object.h
index 3785546adf..bd59eaa6d9 100644
--- a/object.h
+++ b/object.h
@@ -54,8 +54,8 @@ struct object_array {
 		unsigned mode;
 		 /*
 		 * referred_objects or NULL.  If non-NULL, it will
-		 * temporary storage the referred commit and trees when
-		 * traversing the specified object. Space for time,
+		 * temporary storage the referred commit, trees and tags
+		 * when traversing the specified object. Space for time,
 		 * reduce related computing costs (such as packfile-uri
 		 * exclusion), clean up when the traversal is over.
 		 */
@@ -68,6 +68,7 @@ struct object_array {
 struct referred_objects{
     struct object *commit;
     struct object_list *trees;
+    struct object_list *tags;
 };
 /*
  * object flag allocation:
-- 
2.31.1.456.gec51e24953

