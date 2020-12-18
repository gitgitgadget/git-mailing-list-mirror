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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22505C2BBD4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C448F23A63
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbgLRFwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732108AbgLRFww (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8BC0611CA
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g25so5248090wmh.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L/WVsRYrspMW4RmRifIMouf1b8GyIYjbnvZIWb8/lPo=;
        b=gMIQhGeUBC8U+ZRbjf4kazJ+Y835lUkJG3aIsEiVKVAI2peqSyC0RSRmJh5tub3YK7
         zCDFKIUT0m1pzl4U/u1iAZcr0yzfIbTmpvUSbgEBDjW1sWBqzR8vnicH2++cgL/52vcR
         toaoQIPJNN7t4ikSR7oXkJmTzjnSt1An+ZA9TUr5mtvVr8syNIxn/nvoW8J+Cvrgl5WK
         HQq1oFYWxekghGUPIWSkeFckio650R3/3UCPjhMJ2H3puc6ygxmuCX+4hywtK02wscWk
         OAX4MNQ3HHgSI97RdtZHoWcx+K0a18QAM3O8fD3N7bMO8elHdcwZhZU0erufmQG1D2Q1
         k6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L/WVsRYrspMW4RmRifIMouf1b8GyIYjbnvZIWb8/lPo=;
        b=haTCu82+keCOJUy5tN/da1tZtOXHiPANg0/tL+QutqaawlnUP9LMH+QXC/a9FibAB6
         A2NXnKyMBNNvNmpSGvNbX8k14WRee0aTcCUclhQa8UX7mW2AFGrdlt5yErNyTzS0mq2T
         R4F1d6bEiDXOHpmcx0L0IbZeI50JWeyoMx/qw6a/d3q4vgG+Joa/Eze0a95nUKfnrIz+
         CpVNMfttIrf2R8vmzy48jAEqkB/3qSBVs3bQQQ8GDMsFldvraOHSuSkpmsPMrTxP8gVh
         Uvc5LDLaigCY2laIu9eNaIOaDE706Io0QUBwIbAVViCFAeQBr16hxxfLUadSnwQgUeED
         ecHg==
X-Gm-Message-State: AOAM531CctlEEA7pZqgVNM3Wt55akoHnvubuuYfyTJRoHX5XnNgXIDEP
        hU2EUNJKFx/AVnd8UodOQkb57IP6kIA=
X-Google-Smtp-Source: ABdhPJw5gRn8jwyWgil8Ry/K566n7X26XjH7TJCGXhytuSgDIcdebE6/xZ2S3v5USJN8a2WT8LKU/w==
X-Received: by 2002:a1c:7f52:: with SMTP id a79mr2427207wmd.157.1608270696098;
        Thu, 17 Dec 2020 21:51:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm12405660wrx.5.2020.12.17.21.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:35 -0800 (PST)
Message-Id: <a640cc0effc0bf692938940df8cc9f6fdc647cf1.1608270687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:25 +0000
Subject: [PATCH 08/10] merge-ort: implement format_commit()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This implementation is based on a mixture of print_commit() and
output_commit_title() from merge-recursive.c so that it can be used to
take over both functions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 2dfab1858fc..bf704bcd34d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -328,7 +328,19 @@ static void format_commit(struct strbuf *sb,
 			  int indent,
 			  struct commit *commit)
 {
-	die("Not yet implemented.");
+	struct merge_remote_desc *desc;
+	struct pretty_print_context ctx = {0};
+	ctx.abbrev = DEFAULT_ABBREV;
+
+	strbuf_addchars(sb, ' ', indent);
+	desc = merge_remote_util(commit);
+	if (desc) {
+		strbuf_addf(sb, "virtual %s\n", desc->name);
+		return;
+	}
+
+	format_commit_message(commit, "%h %s", sb, &ctx);
+	strbuf_addch(sb, '\n');
 }
 
 __attribute__((format (printf, 4, 5)))
-- 
gitgitgadget

