Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D56C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6DC61262
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354888AbhDGRek (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354875AbhDGRee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 13:34:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E1FC061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 10:34:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a6so12824576wrw.8
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzDdjHyE+0HmhV6Jsh0BOjFXzaLyqonGbVOaBw0ZRpE=;
        b=gEMgNLjhxPMLou32jgILpiG5b1XLb8RFxReAVDvD6S8ZDZr71c1tQ7uk7AXYCDKyDT
         griLqbqcwQKQG2QhD1aKO+VEg6cgBJv3nTIjSHh7RMl8yB4tqdaqVwywDugDKtt3Tq3P
         UDnf9R3YNuFQLfOg9iGqDFAM+vYoQEBs98eADRGKpS0V2s5N2ZI+2PkFm9ON1RQCI083
         /KYjqKRU0/34ssM5qDktMQRtntsP0y66cVnK+09ME6MscMszxOK/GFKKBvGDdKyr43dq
         keZM77JJs4uUfYy1r0sJvdsT2mj/RqycgzDO2ZZoWGiH/k/3RQVjwWcjdmM8YhEXmAtz
         f4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzDdjHyE+0HmhV6Jsh0BOjFXzaLyqonGbVOaBw0ZRpE=;
        b=B1okLju34Ej7Jxz1xAcBGVyt6SNKdGuxZ7DtcIHPrMuzkgLRQPbaToWH7SWFphGHO4
         UQTc7TFQhTRu7DyrGlT/I4VKeAqXfqA1stQG83p+rRK0D3n3lv1UmTCq8vARTuU4pK+k
         Tuf8MnPvAR/qs1SVjiaHxE/gInUR9b47EsfEV4gr11c7ZiJSHzGnVEZNwNLfYIIZHBfi
         rZIw4u/VCxNP1boeSBuQ9FehKiqkewyTzmvFrArzsZoamVYKFQhBCL+5V1CJ+5W8xM9g
         9yzKUtOppN6WcXVhpmSeRzineXud3qjGZMfKbiyU06Aw6Wu0ERfyMmQbGCMi93dZdfCk
         nY5g==
X-Gm-Message-State: AOAM531GDsMnTekS3C4BDSzWvZzfsMRQ+DUsS+NEmjE9ic+rWTDRDnIa
        fiIq/BJZDxLWVw6bOMBOyWiFq7x2JXFJ2Q==
X-Google-Smtp-Source: ABdhPJzfWrdqSTwAzKTXnOE25/dk/cQhO47GhRH9auBPXeuluvBQIxm8eRj1v5d90M+QpSjAudUDvQ==
X-Received: by 2002:adf:c186:: with SMTP id x6mr5750554wre.253.1617816863282;
        Wed, 07 Apr 2021 10:34:23 -0700 (PDT)
Received: from localhost.localdomain ([81.0.37.230])
        by smtp.gmail.com with ESMTPSA id o7sm41657197wrs.16.2021.04.07.10.34.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 10:34:22 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 1/4] run-command: make `exists_in_PATH()` non-static
Date:   Wed,  7 Apr 2021 19:33:30 +0200
Message-Id: <20210407173334.68222-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210407173334.68222-1-mirucam@gmail.com>
References: <20210407173334.68222-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Removes the `static` keyword from `exists_in_PATH()` function
and declares the function in `run-command.h` file.
The function will be used in bisect_visualize() in a later
commit.

`exists_in_PATH()` and `locate_in_PATH()` functions don't
depend on file-local variables.

Mentored by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 run-command.c |  2 +-
 run-command.h | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index be6bc128cd..210b8858f7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -211,7 +211,7 @@ static char *locate_in_PATH(const char *file)
 	return NULL;
 }
 
-static int exists_in_PATH(const char *file)
+int exists_in_PATH(const char *file)
 {
 	char *r = locate_in_PATH(file);
 	int found = r != NULL;
diff --git a/run-command.h b/run-command.h
index d08414a92e..a520ad1342 100644
--- a/run-command.h
+++ b/run-command.h
@@ -179,6 +179,16 @@ void child_process_clear(struct child_process *);
 
 int is_executable(const char *name);
 
+/**
+ * Returns if a $PATH given by parameter is found or not (it is NULL). This
+ * function uses locate_in_PATH() function that emulates the path search that
+ * execvp would perform. Memory used to store the resultant path is freed by
+ * the function.
+ *
+ * The caller should ensure that $PATH contains no directory separators.
+ */
+int exists_in_PATH(const char *file);
+
 /**
  * Start a sub-process. Takes a pointer to a `struct child_process`
  * that specifies the details and returns pipe FDs (if requested).
-- 
2.29.2

