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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EEFC4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4AA1650FD
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbhCPP7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbhCPP66 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954EFC06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g8so10396741wmd.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugpkTIyIItR1wrajx1pDmqo9XfOb+gcquU0XddKkqVA=;
        b=OL1OeCPLdNvmkqhxbj2aQeA7J6Jr72Kwrq0oFPJEYgr0l39fjqQhzXOEdRW19yBqkI
         yo3tDiVsO3xUKE3Ows6ZVFCAT4Xc42rhlTrOerJkJVSYS6RgnXnsjpL0UE41M2x+24VP
         uWBzlSTfI6P+dcWRrDbEf2pw8c4cmn6yNsVUlMxHXBRaZTQJC5wAv6zzFM6kbR/llmc1
         ReY2VaohqDH4KRQzUPuvPTT0h3k0WiyfpeA3/7ZlUxHQiaFf85WSxLIvRVLEBvJC9WnL
         KIvYg/ahzr8HLK7L0Wnru6mxayjwQ1ZaJbUcnHCuFWuASTCr6QHgwNn/0l+wyBPz4r8j
         7grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugpkTIyIItR1wrajx1pDmqo9XfOb+gcquU0XddKkqVA=;
        b=pylsdpV/Z8QGOot18yF310Q3a4Qz1QDGD3W7dewW76s4CDB9J2RcnEdtLooUgGLwnI
         V/hRFoyvKRcKhu3jZakLjwwS4jTOHWy4xS23lWbVNyDr1dnPFKubNBEJPRolBMg5XtqT
         Ev/R7Xr3O+gC4OCU39bZ/dGtPIfezNKLjYnb+YRYje+okCb2nuh5cinwx+Sah7i1EOgF
         MgYCsVpEyHiv+BxEKZ2kg6dkQMKmYSjqnqNapMsULhwQjVtPXD77N1LD54vpDXsPMYPU
         o+nHizhn+cJcH8OpsiJR7UzscL5Y1WYWT6w2UL6P7LWXnCNC6TYdI7NAN7dA0g8zRD2v
         dE5g==
X-Gm-Message-State: AOAM532Sr4074aGzTnXNhUqjeztMnB+GPBMzKn6+tyC7TOnud5utgCST
        X3ah6eV8SMpgEIW+WKRnAQTmo//GgHOtOQ==
X-Google-Smtp-Source: ABdhPJw0RRgqlxNBp644aDDtzoXOIenj+39pkrfRK8joyGZxwcRsMBoWXm7paxA5qMd0xJ8nT2W18w==
X-Received: by 2002:a7b:c096:: with SMTP id r22mr325896wmh.102.1615910335069;
        Tue, 16 Mar 2021 08:58:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 19/32] merge-ort: correct reference to test in 62fdec17a11
Date:   Tue, 16 Mar 2021 16:58:16 +0100
Message-Id: <20210316155829.31242-20-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a comment added in 62fdec17a11 (merge-ort: flesh out
implementation of handle_content_merge(), 2021-01-01).

The test being referred to here was moved from t6036 in
919df319555 (Collect merge-related tests to t64xx, 2020-08-10).

It has also had the plural of "mode" in the name ever since being
introduced in 5d1daf30cce (t6036: add a failed conflict detection
case: regular files, different modes, 2018-06-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4375027914..e54be179bd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1079,7 +1079,7 @@ static int handle_content_merge(struct merge_options *opt,
 		/*
 		 * FIXME: If opt->priv->call_depth && !clean, then we really
 		 * should not make result->mode match either a->mode or
-		 * b->mode; that causes t6036 "check conflicting mode for
+		 * b->mode; that causes t6416 "check conflicting modes for
 		 * regular file" to fail.  It would be best to use some other
 		 * mode, but we'll confuse all kinds of stuff if we use one
 		 * where S_ISREG(result->mode) isn't true, and if we use
-- 
2.31.0.256.gf0ddda3145

