Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DF2C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFCD20656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ti92Xh2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgHURE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgHUQ7l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:59:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31484C061574
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 09:59:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so2550415wmj.5
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yZIvkey6Uj4REB4QipV6iY4qH4NvmcwxVFGQ4lFzb+o=;
        b=ti92Xh2Zwe8iKPvJ8KFVwWnH6NzBzBgbkgswFtAE+DiJaLSTAQCgHT3yDvxC6AWdVv
         vprmVBgSQpJ84dladvBKrU+suksCa+W3aN1Pj6TPDY54DBj/3obPiwWtU/qyYupqp5MX
         9y1HKxA5efuhuznS3HPlT0VaAulxiGvJP6PtmTn2K9inxO+olFhlOd3mMyqgXh7MFnFp
         4TCX45MsYV+t3bTseQvd6dd2bX56aNik/1jGAGbx2Kp/KwmnQvjIfNi7HtOBawBvXcP2
         nT3/yZP+jOwWabV9RddEU2C9rs6sDunl1DdnQMl5C1N2YqttDCCYQu+llBvZ+0c1SGMY
         KCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yZIvkey6Uj4REB4QipV6iY4qH4NvmcwxVFGQ4lFzb+o=;
        b=jzCNg3DPEIR9FeFhwffLQCAAhU6a1iWocM+5YZZ1nDskahu5WtUSiPqqnEyIlHdnyA
         N1Tmh81GwLSsL2ORQV5g4cVqf4km81m4nG9o1/dYNUm1tcdEuctOIgTHlsmCxB7TJcfZ
         ez6dV6Z97fk8EQt7CF3OMyeO6dvICr5wZUe09AzPm8myb5yYs7xWSVsj7Uq1tD0sCCXu
         anxoYUNmAbkrs5h1Va9Pv++l2Zsc9ee9hINUN+zMbUpvkHSzWlPEnD7UKlBNTRxzCwyX
         Uwwh9H1MXW2N5TJb75m4rDscOdpmqc4ZH37dDckwHljh3DCN3KN966BYODIWfTLCieI3
         qsrw==
X-Gm-Message-State: AOAM532iMwhdkqwYeDPeLwZsctuoR//u+7bA1Sf67UMgEgP1TybwIXvH
        7i3h6AKbgOhpHQ9Gov7Q/n0sE5dO57c=
X-Google-Smtp-Source: ABdhPJwPvYSUJDdhU7hG+ULrhZaDDIJ38vfdPABYN8bHhvT+SEm+2LK2lMyDqwFaOFXiarACRFeNhQ==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr3852817wmb.7.1598029179693;
        Fri, 21 Aug 2020 09:59:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm5529724wrv.50.2020.08.21.09.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 09:59:39 -0700 (PDT)
Message-Id: <bfea176682f271588577be38ecd84b87cfcbd942.1598029177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.706.v3.git.1598029177.gitgitgadget@gmail.com>
References: <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
        <pull.706.v3.git.1598029177.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 16:59:34 +0000
Subject: [PATCH v3 1/4] refs: make refs_ref_exists public
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

This will be necessary to replace file existence checks for pseudorefs.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 2 +-
 refs.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index cf91711968..d46080f4b6 100644
--- a/refs.c
+++ b/refs.c
@@ -313,7 +313,7 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
-static int refs_ref_exists(struct ref_store *refs, const char *refname)
+int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
 	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
 }
diff --git a/refs.h b/refs.h
index 29e28124cd..04bd25019f 100644
--- a/refs.h
+++ b/refs.h
@@ -105,6 +105,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 				  const struct string_list *skip,
 				  struct strbuf *err);
 
+int refs_ref_exists(struct ref_store *refs, const char *refname);
+
 int ref_exists(const char *refname);
 
 int should_autocreate_reflog(const char *refname);
-- 
gitgitgadget

