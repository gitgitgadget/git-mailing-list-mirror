Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442EBC433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2877661073
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbhJPJmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbhJPJlx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD46C061774
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a196so4264674wme.0
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhFFSMdxvzFbHQKgQfn7DBJML7VzbZVPMMgMUIbnLVg=;
        b=Ssgbz6jKBiwIH2F52cNspy8UcKI4URu93Hnd5KYk3WedOVQxW3e3a8g1XsFj9bQsRG
         O/igAD/1j5gtqKuQXApK0YcljosUpFTZpkoxwd1jRIsVVP+bKFg1vOuNu7r6mYD9MkSs
         sPRnGdZxPtGuOMn1HyRNxz1lzk2Bwdaa+KcKIr62d9QEkhY8O5iP2FOV8M9OTs92OWU0
         vQSkJgTBO1PWwgSM6Unb+Uw5S9vsucFUQqgOBHz7mL+lvlzmEhYbU2kh2gR1Ub7b5/86
         rEhCLgS6rsfqvD1uQrjbPTpDZhGsglLnNiig4D1Y8eoUu5fmgm4lH+s/EeUFGp/6B0ro
         bACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhFFSMdxvzFbHQKgQfn7DBJML7VzbZVPMMgMUIbnLVg=;
        b=riESSThpSEwgEPsS/PJhLBlYZcthtWmnfDmWnXx//iIfoJZAWssmBSI1Y+BhgRYcce
         gcEXXyGtEahAcFr6QomU6ALXHVZgVR8NSL8Mnj2bNz0BSLwoPxdnBcvwIwYTSbkx91XE
         1C6ZSTUf/SbXQImyoMG/R1QBFXT8UE0efXaZABn5cbSgHG+tYCcnTdzcuK6/P+7JxPJa
         Rdtt2wbeaC6755OK0l3sSrfCw/2xa4aFtAAAfc0asbKJJcn5XgGGX8TkgxDT5MtEFU0f
         3vE1iIFYx8pysYAlrJ8LRo3KwlUYMLVpgyxbMjlKfX9J4SZjlyhvsP3cwFaulSne7PUJ
         vecA==
X-Gm-Message-State: AOAM530jKxpZ1djLUt1zqRQQk5Xms5Q5KfnRHyQU8vJBnp0TocIcrsvl
        pdDWOj47XGf3Y3krsxEP4RmMmbVyB/epyA==
X-Google-Smtp-Source: ABdhPJx/Hm+G/tfDzM+4LCtggibPyCVFLPY557puZwm6FXrgKFCGN/sma9StIxYybQpo4OrgzNMaRQ==
X-Received: by 2002:a7b:cc8c:: with SMTP id p12mr18034917wma.105.1634377180519;
        Sat, 16 Oct 2021 02:39:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/21] refs tests: ignore ignore errno in test-ref-store helper
Date:   Sat, 16 Oct 2021 11:39:20 +0200
Message-Id: <patch-v2-14.21-1289d78e4f3-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cmd_resolve_ref() function has always ignored errno on failure,
but let's do so explicitly when using the refs_resolve_ref_unsafe()
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-ref-store.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45b..2f91fb9b227 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -123,9 +123,10 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 	int resolve_flags = arg_flags(*argv++, "resolve-flags");
 	int flags;
 	const char *ref;
+	int ignore_errno;
 
-	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-				      &oid, &flags);
+	ref = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+				      &oid, &flags, &ignore_errno);
 	printf("%s %s 0x%x\n", oid_to_hex(&oid), ref ? ref : "(null)", flags);
 	return ref ? 0 : 1;
 }
-- 
2.33.1.1338.g20da966911a

