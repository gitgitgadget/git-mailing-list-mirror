Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6230C433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D45207FB
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAmlbHUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgGPSpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbgGPSpr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 14:45:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026FC061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 11:45:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so8088110wrw.12
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dqiBREn1JkCHHo274rBaLgYRiUYsSP4+AcndhNbv6/c=;
        b=YAmlbHUpNoggkeqq5gbfziqYEITSPVSr96FFxUq2y/F24KajG0jlIm/2pgJg03hZby
         nbrFH0cRbUo160S895hHxWktBJOProgLtia9Fp3R+EXPNGtWGs7ViVEIdbQDhLrQLM7t
         1nneQ5Wq7B2jvS+OprEgKkohhB2LVECKWzm9Ott4QFFGcnhlXMtEddeH4jW6zkFhUerK
         0mXdlEJgcFw0jMCpZImwVub5bdsLf1HQ7Pr2d1jHcFvYybTpgJeA03RNqQIISmB2SAOL
         LD77mvA9ei7Y2hpsFL7H8Q8/V8VbB0+BF/MVFGLd2to+EPq/8fWcrI0agADuv+3XUh1X
         FQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dqiBREn1JkCHHo274rBaLgYRiUYsSP4+AcndhNbv6/c=;
        b=OOzEWJbLVTIOqKtxSZK+dvDV1gZv/pXs6aVq8Rk3jUfl4PqIA4dLh7B40s6WkutGxJ
         kCGGltYp/bcZdeOYNbuww0hDNhPjpPV1pw0Y1ORjo9XOf1j04TCZzXvt7IHK345n8FCX
         yiEKhwsXXDTdlqJlrF1HNtVCnuIc0JMUbAN7e5YZ8hxBLB/gPhE+Of13w5Kt+XzmOQOb
         4OKuDIDe3/YdVVgf0WP5VHNjsOKMRqJ7cICoCTz4EVN3TCiMw8tZ2mcCkIkfIcyZaPE0
         AsKLPHIgNq3HF0BxJvrbQATKppe4ctXyZs9AqaXUyY4sniKg7kqyiihnsrhR78AMkqiP
         DeGw==
X-Gm-Message-State: AOAM533QkTlErzH+E5Qoa19mRCOG1o89rjZSMpIFePLgE8p8byaO37lp
        nBK23jtnysIRnfgOx2U0AieQSTQn
X-Google-Smtp-Source: ABdhPJzgOXx9cqRfqXHSUz9s7VA2qbVgNIq3VPbRtNXdIMEmCSaU9MJ70o1cA4uPZTTkv8KV34mBVg==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr6037220wrq.425.1594925145074;
        Thu, 16 Jul 2020 11:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 68sm9969800wmz.40.2020.07.16.11.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 11:45:44 -0700 (PDT)
Message-Id: <3ab9f2f04ef35956600a738004780dc0c53d1faa.1594925141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jul 2020 18:45:41 +0000
Subject: [PATCH v3 3/3] Make HEAD a PSEUDOREF rather than PER_WORKTREE.
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
