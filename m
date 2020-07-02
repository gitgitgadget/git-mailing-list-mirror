Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4971C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB62221E9
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcev5rOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgGBTYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGBTYn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 15:24:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE96C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 12:24:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w19so998459ply.9
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bgHWYxreXXAxzehR/RJ4xOa8+i3UMV7zTHWTRsgDE4=;
        b=qcev5rOXVNo4CEkE8JPYjXQ1OlkOtNUyDv/CkDmb+PsLnT60bU4T8AO7TjNhrbdLsP
         /J8grVq6CR6TCoeC7j52tDcijKyPjR+KwDwhpvQHPlnkfkwnnSPMY9yimwAxXJ0hmpWO
         H/cYmTp84rCFBrKRc7icBlY01bOBj5pdmpL/lmlyM4vAF4fxIywQzEkD+KU84dluqtXD
         H6KGbVZGqImK37kzl2Nb02ewCAK3QMZy4TAMHDfiz6Ptc4BeRFH2o940640FKrbRVMcN
         DW//SQHlq21PKLCKz90Yj+fsUpWh1CqeAbfnx3YH4tC4Gy04seaoptTwKgwB4Lb4kS1r
         yj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bgHWYxreXXAxzehR/RJ4xOa8+i3UMV7zTHWTRsgDE4=;
        b=FUFcKv8WTxhyRu0KCd/yPngS8VchuSkcdInCd6GIyKouz8OLdJbW/PbbD/xtjUIPtF
         o8gzczmwhzvxOHOrFCipnqoZCJcs5jmi2B3Jy1KvEKBvpl0YTPPsLrsoOid1n47gj79x
         4WBYxupDGyj6v3R4AVE9djdgYm62oT92luqjx8Kgys0HowcvY2p+ph1IexEJrzGTEnR2
         OwpONDRyTve3a49uhs9STkoblGLJFlpoSFayBFovFqpQkac8+KaWC4Mfu1xiXXoHvfP3
         kuqKWAHRz9ls+olZqAaMJxMYFlRnJb/JknuV5j1ZRgyoRXD10ASBspNOAYE7L7+Vgw+M
         F/8w==
X-Gm-Message-State: AOAM532/dOjLSjloNqVZAg6uuJvHhr8HRX5RcsF9+ByTdAetbmlao0sT
        2EXFu1nYe2GmKg1aohFEkqnMSEuEI+Odow==
X-Google-Smtp-Source: ABdhPJwqyQsN6HJca9CHI2N5FSO9YNE8BWQZ862Gbf1yrmIumuF67nVq8cX3APt1gVD87LNMWCW9RA==
X-Received: by 2002:a17:902:10e:: with SMTP id 14mr27871714plb.12.1593717882016;
        Thu, 02 Jul 2020 12:24:42 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.244])
        by smtp.gmail.com with ESMTPSA id c2sm9266739pgk.77.2020.07.02.12.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 12:24:41 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, sbeller@google.com, pclouds@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] submodule: amend extra line feed between callback struct and macro
Date:   Fri,  3 Jul 2020 00:54:06 +0530
Message-Id: <20200702192409.21865-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All subcommands of 'git submodule' using a callback mechanism had
absence of an extra linefeed between their callback structs and
macros. Subcommands 'init', 'status' and 'sync' did not follow suit.
Amend the extra line feed.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 59c1e1217c..eea3932c40 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -612,7 +612,6 @@ struct init_cb {
 	const char *prefix;
 	unsigned int flags;
 };
-
 #define INIT_CB_INIT { NULL, 0 }
 
 static void init_submodule(const char *path, const char *prefix,
@@ -742,7 +741,6 @@ struct status_cb {
 	const char *prefix;
 	unsigned int flags;
 };
-
 #define STATUS_CB_INIT { NULL, 0 }
 
 static void print_status(unsigned int flags, char state, const char *path,
@@ -933,7 +931,6 @@ struct sync_cb {
 	const char *prefix;
 	unsigned int flags;
 };
-
 #define SYNC_CB_INIT { NULL, 0 }
 
 static void sync_submodule(const char *path, const char *prefix,
-- 
2.27.0

