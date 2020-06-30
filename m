Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E7C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8563D2073E
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMSNMS/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgF3MFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbgF3MFn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 08:05:43 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A4C03E979
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 05:05:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id z17so15912767edr.9
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9Y9G09uoQ1HI9DUwS0y565jgtqOpuBU2UCVXX1xcnvg=;
        b=DMSNMS/hREAag8GJ+70sQmEZLk858VgxV37BxfyQBn74Oj2AJPe6ICJ/9M1ttQqd/p
         2LuoNjEYUhwMb+H1SwMKindI7Vhc4I29HVJYa0i49izu6r1gqA5mfy4e0LSKazxf8QTC
         hYg6tmORjbHt83bAQp+BjAUWGjB76DRStTv2crgHYIEscFUtdxVK/UzGo/JrJb4Cmsfl
         K1nLdXVDdqPaFJRqsSZwitfBPvgb0fmiNyRv2Tt1daiIuTn+Y3GrhR8gD+M8PA90c0pJ
         7+y/pmB6V8ijf5l3I3ZpqEjd//OuuFPZuTqsmFra+4RNNibKftw72QuENAQGPdMv6wd0
         TMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9Y9G09uoQ1HI9DUwS0y565jgtqOpuBU2UCVXX1xcnvg=;
        b=Kj22Y9lAviBPPocDXCo1kLH+7tJtD6Q9YgpXtPRS9Fy1SZM6+eC8y/ubAHks8l5a8u
         lrwDt58UWl0LkbXftrlnmTogKOaUWLwpfM/UmJJSy0AZvgeMSuqZQY7uBahlvy9Pr5qf
         QRhoeHxPdlKcQtc8fgLcMIuOqLqs0TlJf60PaihMcAgA1ZQx8Y8HvoDVwslh7k8Q48Sx
         KWatN69EIZB9Eqw3STEs9qVX/KYv+sPeuw8FO0ug+5ZbjTlVtvStYxByDYDabE1le3j/
         b8SqjkHf36LrPdIa/dbbyJeQW2IFjvRJrGGbvg/yZdGB726Y7MPTtLl1GZX0PDajOlav
         Ucpg==
X-Gm-Message-State: AOAM532EAiByRUY2IP9rHBTgRxes2DSH9GOWYM/CKUjq2U0KwJtQuQFd
        LWG0M8gu7etYxQjtsrCEE3t53mAyaBc=
X-Google-Smtp-Source: ABdhPJz3Q1h/6gtxeH0xoNMN+cUQufpcwICYaR2XnP3jK4mCAb5UxXk/YIWANtfJmedSUtYC66Oa/A==
X-Received: by 2002:aa7:c3d8:: with SMTP id l24mr15998015edr.97.1593518741742;
        Tue, 30 Jun 2020 05:05:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16sm1810737ejn.77.2020.06.30.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:05:41 -0700 (PDT)
Message-Id: <8a62cc26686b1bb2f04cb01c79e336dca397a330.1593518738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.669.git.1593518738.gitgitgadget@gmail.com>
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Jun 2020 12:05:37 +0000
Subject: [PATCH 3/4] checkout: add '\n' to reflog message
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

This makes check consistent with the rest of the git code, which tends to use a
trailing '\n' when writing reflog messages.  (The storage layer adds a '\n'
when it is missing.)

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/checkout.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index af849c644f..bb11fcc4e9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -884,8 +884,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
 	if (!reflog_msg)
-		strbuf_addf(&msg, "checkout: moving from %s to %s",
-			old_desc ? old_desc : "(invalid)", new_branch_info->name);
+		strbuf_addf(&msg, "checkout: moving from %s to %s\n",
+			    old_desc ? old_desc : "(invalid)",
+			    new_branch_info->name);
 	else
 		strbuf_insertstr(&msg, 0, reflog_msg);
 
-- 
gitgitgadget

