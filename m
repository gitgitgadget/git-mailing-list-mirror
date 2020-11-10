Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A09C55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C6D20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujfM+LYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgKJVV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731795AbgKJVVy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:54 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C01C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:54 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id n89so136174otn.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cl9UjcXzREbT04f32XAC5DBY8wYEr5MR8dw3hXmoPzs=;
        b=ujfM+LYIuiBkyRNWaH3hUZhkqkGYha2+nByjqv/qmESzCa0NvTEbFdBvmcOn171L6n
         IM1RJjUvRebdTs4SU9UGBIRrpRsEF9I5duhm6g0uT+VnITHcgOMSk1Xfl5tltjbGJOuX
         vDKjQXhp35D74Cim+jzMwIOcJ/XRWmcsJ4aSRV/hk8mj+VG4quX8O9u3BORtCeyAlPzb
         IsjR1+5O7I+oQuDja6dGect5DJbHA1890AumLJi+KE43XD4vjLChbzzRUBVKcVRtnqGM
         C3w9YzjS/7INzepNCJS8wNQwR6LcT2NfSVwosvcu+MoTiSvtRau1a/Ee8Jl22Cms07J+
         U6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cl9UjcXzREbT04f32XAC5DBY8wYEr5MR8dw3hXmoPzs=;
        b=TuJwNlE79K4A0Z0yiGxKgd788xW0xRFgWmOLXVE+B7MLvMEU7s/QT0GfW/5jjPG8si
         zryzqcayNJAuy2l1FqU4Y23KVMaVzu+geUfxpQ25Mh9t30bLFA2TJ/6onsEOnztF5NU8
         tZTAk/JC6K99BN0ilXmCcZu4VT3wg8svGJEMWQ81lQSKI4cYNXwMLiU8b6t41iPO6qf9
         I9ZB4mhjXlv1ij8I8zvD6wi4fFgbvaaMvN5EKnS/HcCyQta+Eu6tRu4Y/yR25euijoYM
         U6AkXOtdzmh8ga7j8uCi8VSijId39r5qymsj6WRw9o8I3Gqj+VW170j7mXNqnu3yeaSD
         2cWg==
X-Gm-Message-State: AOAM532fcfO7ETTLLTlDq6m/bCaE6plDoeYWGMf4vFcUd2SrKb0fQsKq
        4o5R53uzOtR0CMX8zJhEkcebuCtJWa5Vqw==
X-Google-Smtp-Source: ABdhPJxUo/5/2aWjlWjYwn61TF0DSwdsNBIq4yM0JbzHEd8mb1SJJvYXEpaccFXZmNF4K8WFqqNRYg==
X-Received: by 2002:a9d:2cc:: with SMTP id 70mr16284391otl.346.1605043314006;
        Tue, 10 Nov 2020 13:21:54 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id n26sm43932oop.18.2020.11.10.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:53 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/26] completion: bash: remove non-append functionality
Date:   Tue, 10 Nov 2020 15:21:17 -0600
Message-Id: <20201110212136.870769-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
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
index 12275a3558..6a1106f17d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -298,7 +298,7 @@ __gitcomp_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 }
 
 # Similar to __gitcomp_direct, but appends to COMPREPLY instead.
@@ -450,7 +450,6 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	COMPREPLY=()
 	__gitcomp_nl_append "$@"
 }
 
-- 
2.29.2

