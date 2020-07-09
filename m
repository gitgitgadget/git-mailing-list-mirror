Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D720CC433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 21:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B322A206E2
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 21:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANI4oEMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgGIVL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgGIVLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 17:11:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE78FC08C5DC
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 14:11:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so3807263wrm.4
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dqiBREn1JkCHHo274rBaLgYRiUYsSP4+AcndhNbv6/c=;
        b=ANI4oEMoH9RTvecQhxx22vYA1heAd+YfWYkdgRF7TR9n8HR2T8O1s8AFHqFBNTgiCv
         g0lwFye2So3vSuB8FIWF6DHwlurYYZo6QgkJ1pXO2597ZynqNweHizG/PHhMfOw4e3LI
         oOsD+uDZwES/b4E1fHc+BgI0BBknrCLHOSTQPxH87cJIxR03pPnPuRichgEdikHiR5bD
         41jV3ebSn7GRUg/QWjfEozWUs9ZQw/wonaaHe8YIJQFT+oFR0BwJrEHyNRq/0fD4MYpy
         RIwhdHfQUyDgQXlp5twt+B2Ts92XW7go2bM6p2uP0Ypy6TAI/3PDtf+IjS5xNbtmBMM2
         cOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dqiBREn1JkCHHo274rBaLgYRiUYsSP4+AcndhNbv6/c=;
        b=Iz/0zdk7f3buuE7YCPw9RIMPNAoqHbsRfVWlYkpWAZV795ipkbRlLgJiKwjnkV7ZPJ
         BJPioIAHrhywd8Uqa20Tlv9pI0eoMucICIUF05WCCIStPTT8jR5V8WT3aoGsLkmyN80i
         y/tqez9uiZ4aiu+wbZx2+6BG5Y7VjKQlmK3GuxkZYRGb62qOBVLfbkTszg6K2yAZ6nQh
         0yH/6WxJPTxnwbuy6wT8qPAMkLf5VVxEeLeV54wWNevSbGgN7DVJN6IC+5ABHQbw1oVJ
         kUpdNfu/5uDFzpk2OBEHedwg8yEZHVp2Wj26GU55sjSG6DLQmJUuojKGwvTfteSlNV60
         OqEg==
X-Gm-Message-State: AOAM533ZF42j7AkZ7fEdImk7/54tLm1OeBxMVRtwj7Ht7/qiwrP2aBKC
        gufzHDoQm4YD7kv1VqKY7Zovju0z
X-Google-Smtp-Source: ABdhPJzB5qO+YKNI6U6tfpeRgQZNUyI9N+6pJzR5KEFU3LvyQ/ooU7o59jfV6Uzu+cseAPke/+Xlmg==
X-Received: by 2002:adf:8462:: with SMTP id 89mr63871864wrf.420.1594329111502;
        Thu, 09 Jul 2020 14:11:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b184sm6773920wmc.20.2020.07.09.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:11:51 -0700 (PDT)
Message-Id: <1c2b9d5f177ab5ebf4d45ce77ebe8e6cec78c3a6.1594329108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
        <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 21:11:48 +0000
Subject: [PATCH v2 3/3] Make HEAD a PSEUDOREF rather than PER_WORKTREE.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is consistent with the definition of REF_TYPE_PSEUDOREF
(uppercase in the root ref namespace).

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index d676acb1f4..5cd71f711f 100644
--- a/refs.c
+++ b/refs.c
@@ -708,10 +708,9 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 
 static int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/worktree/") ||
-		starts_with(refname, "refs/bisect/") ||
-		starts_with(refname, "refs/rewritten/");
+	return starts_with(refname, "refs/worktree/") ||
+	       starts_with(refname, "refs/bisect/") ||
+	       starts_with(refname, "refs/rewritten/");
 }
 
 static int is_pseudoref_syntax(const char *refname)
-- 
gitgitgadget
