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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12577C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC68611CC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhFRS1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbhFRS1x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:53 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E945C0617AE
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:43 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso10527754otl.13
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VuLnN/lxBtwAh1MO6JMTqTWyXbeVKvt+EdEUlOD9RYY=;
        b=Qtc8oMAgPeqHcVxIICtA6bsA7hs0NNFrSeGSdndJ+6o90m8A3vJYMgQo6V9smcQal4
         OeaOmBdYTchQjBUkjqtBHWYdr9GBF2ZLXb5dgOxdbqPsWGLAUIE61kHJvqYJHB3stvlc
         bKyPq4fCRvArCNVtvaPgZemH0nqVCU6/O8MaWshs03pxuwdqftg6N3G1Bzw1D8ToXPlQ
         B0clcA//Mmse0xExxnlz3bTVP9xhEzTmfTifXxIpmzr7uXiy+0wbobRyD5kxDdVzeMJb
         xkB0bNXKqW5yccNlq5vOff5vb7XxPHeNspCdPRYm4/WppQXIjDePoAJQsM6JyX+vufB0
         865A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VuLnN/lxBtwAh1MO6JMTqTWyXbeVKvt+EdEUlOD9RYY=;
        b=rWWZyK3oEw6f+zVU1puYfZ321xZpRrMy4zLPqwjcbhhrdTSNN+0CF0EWgwzyxaRCBM
         9ghWTrE9vqmHwPcC07azB1ozFx17cp9Z0ZIqAlyC442EwqKecIMhKZqeQIrJOp6e5+nS
         Ot262hx5GVC37E5cusx5+tq7BVKzwYslKEXBxWYCzBS+Tu3SwAgO3jEeKkc9QIhn8fPg
         TFD0qf6P9pZYiKOTPDnvvnRkq0KfAQRyM8edQ/G/uryQLiCsgvvCLcWvIL6ipodmIU+j
         jEODeDk0U86v5SBnD+uU/qaDBRPAzpwH/oqMUPmvLqwyXApE5d4CWRN0IumkP438dbrE
         j5LA==
X-Gm-Message-State: AOAM533a66CEvPjijOks39UIxnNUfH9iBZl5JfTTpJnmPvxf7AKZlPLo
        dEeys4xvuaiYQXIipk4V3iKogjpLL3qwTQ==
X-Google-Smtp-Source: ABdhPJxU/fz/E92cMfUtRjeZIuU35/LhUe9a63Hpp3qM8iNPxUSTn1FVXdbUdUKSDVUxCon+lcKV7A==
X-Received: by 2002:a05:6830:1548:: with SMTP id l8mr9848134otp.95.1624040742420;
        Fri, 18 Jun 2021 11:25:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id m66sm1945943oia.28.2021.06.18.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/45] completion: bash: remove non-append functionality
Date:   Fri, 18 Jun 2021 13:24:45 -0500
Message-Id: <20210618182518.697912-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in setting COMPREPLY only to override it later, and in
fact; we don't do that.

Therefore there's no functional difference between __gitcomp_direct()
and __gitcomp_direct_append(), since __gitcomp_direct() *always*
operates on empty COMPREPLY.

The same goes for __gitcomp_nl().

This patch makes the functionality of append and non-append functions
the same.

There should be no functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bede8a7e2a..8f72e0f66b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -307,7 +307,7 @@ __gitcomp_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 }
 
 # Similar to __gitcomp_direct, but appends to COMPREPLY instead.
@@ -459,7 +459,6 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	COMPREPLY=()
 	__gitcomp_nl_append "$@"
 }
 
-- 
2.32.0

