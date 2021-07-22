Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347C3C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A83460E8F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhGVUs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhGVUsT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E19CC06175F
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r2so231641wrl.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GxdkICMfkJfONoA52legBp7SYC+/2dCgdEj9w1NHQXQ=;
        b=qm5xl9P1p0mnEYL8lZf4ypqmHORQn7iBYC80qDLgIJLLqBI7jqgz0ME4PHRAP/GCAg
         M19SIye2n1GEKSdCZbuD0GdzIjkF2/a1KZbpVJDGr8/z3hGUT7G1JogGdO2QqyzpTQ6G
         5ZVTa4jouhQZnfPWLJDV54yL36wv/YTZ8far9MoyPEPJ/ycUITsOPtTW/oZJRKrWkvPD
         xjngKrJD8f2wH15O5A7AOenfcCgLhi9kAQ/+PbMB61b/GzKd2P1SmfLTqd4dRkmyrFfM
         fccgb3tqoQWJZ/XiinQu1jmKBgVBXXflBF9WjIR29SEjtvR2hkqyGtTyXD28U67twIlY
         JwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GxdkICMfkJfONoA52legBp7SYC+/2dCgdEj9w1NHQXQ=;
        b=Ji0yCCEo7zwxxDQmbhjot9idGaXDpePt6qq0FKEESC/8vwf1Mqs9maQRYd8w7Y9A4l
         IQKlzjn1uqMu+QmMy5XJhnYhGU4h+PehecBAO6x43IDJZn42QpBndqk3jLpkcKbOnlDS
         IYP8sjrMmmAj35EdI7FBJDnZ2lxgQnS+1M1D1roWA8W5U9k06v+PbdkY5dEbeSU29mxQ
         3xxsVIyNi6D8VwmecPkKlPFR8GF9ajx5TZKdy6PiQs43KjHHtsEIEtGciUWFkN+TfXxz
         PYSGHC7Ae75xU/yhLqdXIUw30JNUr8DYR9Xw6m9auyh7mojQf66gvFAQtE66T49PW/xR
         ZX6w==
X-Gm-Message-State: AOAM533xdRBU/G9u3CUiommhHCYtFZYABjiZJwsXVfdj2nBJt6QlLWGz
        Ob/4xr8IzGcWoJIIqslrbkTg0gKllro=
X-Google-Smtp-Source: ABdhPJwNQot+aIDeK+BkZ+AZKZ4gKf529VpEOUEsr0bG26CwlGc1fRKdhmoipFCrmzrei7t050J5eQ==
X-Received: by 2002:adf:f7cc:: with SMTP id a12mr1875904wrq.278.1626989332092;
        Thu, 22 Jul 2021 14:28:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm33317020wrg.68.2021.07.22.14.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:51 -0700 (PDT)
Message-Id: <eb2c53d19cf90432ff4fd5af9ca6f4abc636cd7d.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:42 +0000
Subject: [PATCH v2 06/11] t1405: use 'git reflog exists' to check reflog
 existence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This fixes a test failure for reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1405-main-ref-store.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a237d9880ea..92b04873247 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -98,12 +98,12 @@ test_expect_success 'reflog_exists(HEAD)' '
 
 test_expect_success 'delete_reflog(HEAD)' '
 	$RUN delete-reflog HEAD &&
-	! test -f .git/logs/HEAD
+	test_must_fail git reflog exists HEAD
 '
 
 test_expect_success 'create-reflog(HEAD)' '
 	$RUN create-reflog HEAD 1 &&
-	test -f .git/logs/HEAD
+	git reflog exists HEAD
 '
 
 test_expect_success 'delete_ref(refs/heads/foo)' '
-- 
gitgitgadget

