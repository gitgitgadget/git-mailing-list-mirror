Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A7DC433E1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEFE4206E2
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckghYm+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgFVVzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbgFVVz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364B1C061573
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z13so6566175wrw.5
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sD08nvPKEureMPWUl3ZPXZUlGgVzCFnRDJ8XWySzO9I=;
        b=ckghYm+FoWUw53zhRHKnpPEtwLizMszW8DRH19B9+Nv4IKjsqNXOr9LAysQTN0OnKQ
         Ro1FNSB84RKgtmqVcBbpmU/v75uiG1njc5ML2dBy4Fj7rdvzinsBLERZZbaLSowehpWo
         ymWO6FHcu+oitKHU0GXgc8n9AXg+Q4HmZwPOsUrdVPO/KBOkobma/uB0EgPReG+ll+X2
         WKX19o39TPBDkQtZrDjVqYXbNAYrmvqyjfYY9J04dx+/N8D4GJLr1kDcnhR3ONPjA1uG
         xba3uhzKSiThVkOQiMZU4WiuJAhRcZi7cWPc3txRtqY9CR9an4QcBxIllhXgF3uKaNcB
         3CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sD08nvPKEureMPWUl3ZPXZUlGgVzCFnRDJ8XWySzO9I=;
        b=J2uEcImsxK8uFuzC8fAop96GhdL2bnkNYtAiMvxOgiwi30yKC++xB+GPAiDxPHLVBC
         NLGDSYhgtljWaZmwHCbf6r3ZFqJD0ZgmzoVsd6ePm3u/BvuBxRLH+BRhKfO70XY/Dlal
         zGqNoxpRHpJ/xuF7stZ7mmlsGk0PpKAS/3mMlS+TkTnmkmbj5WIzlQmy1/+qBxKv7nL4
         bB273RSTlgk+2fmA3qwjG4iCaCim6T2bGvURTRK/J6gbsgIMDA5Kd7rf3fAoTJ73UzE4
         +OqTfUUSEZhA1nQJwI6LcuJ3lkTr9lM1FUcZ7ztttgBQxZL+zuveHJ/BJZN/hS1G2OOH
         UnfQ==
X-Gm-Message-State: AOAM533IJvBkprezvOw+UjHiTP272Jo4PEgTH+juy9MyNeA7F+Z8EWs3
        TuQ3WkBU3z5yTTdotcQdrt4llnhH
X-Google-Smtp-Source: ABdhPJzsy7wn4sdZzNPvmZgeIQwh1C07OYHbCMmcl6eo+0/HX5VkNr0Vorq2B7+X1ePGZ6VJUGJ/8A==
X-Received: by 2002:a5d:5549:: with SMTP id g9mr18025594wrw.419.1592862926775;
        Mon, 22 Jun 2020 14:55:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm20548906wra.42.2020.06.22.14.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:26 -0700 (PDT)
Message-Id: <a5bce2e3fe61d82ca81b1980499879c872cbc1d5.1592862920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:05 +0000
Subject: [PATCH v18 04/19] Make refs_ref_exists public
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 2 +-
 refs.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 12908066b13..812fee47108 100644
--- a/refs.c
+++ b/refs.c
@@ -311,7 +311,7 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
-static int refs_ref_exists(struct ref_store *refs, const char *refname)
+int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
 	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
 }
diff --git a/refs.h b/refs.h
index 4dad8f24914..7aaa1226551 100644
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

