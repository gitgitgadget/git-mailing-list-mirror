Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E325C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFA1206E2
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+R4ydT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgFVVzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgFVVz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B4BC061795
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so18277749wru.12
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XHvhDxDm3h+Bg55kGQ4HXGvee9S1/AYIu1CtQQ4/BpY=;
        b=Q+R4ydT1GiWRt8bWA6WhP/TJzOZncBgj9r8gd01h1PAgOvMArmvze4/NsyYUtys/Sb
         V0OqPgeTgFemitGANVO/Diy0g/rlRSWgRJHleDQP8VN3SHY5ostGh3K10sk19v/aYfY5
         5sP/iP+oqgVwWtiSyFr96xXDBk5RsBYpa1ceSGwoHpQc9dUt6FB8ChYpRX/Rc1x3TnlZ
         ra7nHK5NHVDu5sIyhu9mT1MBANl68Mg1hkRs6ps1qJUf7eHSJNIX6qlG/OHcY8+EpIaF
         giKApqSk0ayCi0GOqBMSjh27X6mNx6h7Wyl+6r/MdDmO+0ITuewwEVoFLoAgL803tLb8
         UDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XHvhDxDm3h+Bg55kGQ4HXGvee9S1/AYIu1CtQQ4/BpY=;
        b=B0uAq9x4pCMuS/XpjE9uVCn3lWWt81l/pPzAGe3Upb1o5wx6AKyxM6ovQHdUjzOMsq
         AXvtMxzjE2eYntejcTcxyNJztPx34w28dbOQSn7cHKYsZId0P1094MlHUoSlYgvMMdXq
         SXh2uzM1RZY1bmjQ0tjdspaCcKcIZXVQTKE6ninZM1Fi4TZwkSC9dy7KPmaBEA+8Pgjk
         RZh6tH4zRbJKJYxMKBqtEhZRRSiKaWJB74YSr6t6v+GA0kvfZUZrUYzZJ91TzgYF9L6D
         8vXtRQyNfT6r6n3URlJ5qw4+tgC7eYzbYYw9f1HjWLmYgp2q5WAFIy2t36N5hzWSwGhQ
         rsaQ==
X-Gm-Message-State: AOAM533Y3uF+1gfaBihu8Qn/x2/thJifNFzTBAdyGtXFOz0C2RZxRjHO
        3f1Chl46ZDtiCTI1+zdiFlrqjFlq
X-Google-Smtp-Source: ABdhPJwbd5WX7BPoT1XvDMh2zcdHHAz37K/aHw9agOF3/LG3zESSnGbROChTAYQxdiOhDHBvdXXQvg==
X-Received: by 2002:a5d:470a:: with SMTP id y10mr8882170wrq.405.1592862924668;
        Mon, 22 Jun 2020 14:55:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4sm10874952wrg.80.2020.06.22.14.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:24 -0700 (PDT)
Message-Id: <5210225977366d3673941d2cd75e64565f2b86d6.1592862920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:03 +0000
Subject: [PATCH v18 02/19] checkout: add '\n' to reflog message
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

Reftable precisely reproduces the given message. This leads to differences,
because the files backend implicitly adds a trailing '\n' to all messages.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/checkout.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index af849c644fe..bb11fcc4e99 100644
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

