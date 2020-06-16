Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB01CC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B663C208B3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCXoaWkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgFPTUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgFPTUs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0189DC06174E
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x6so21911399wrm.13
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XHvhDxDm3h+Bg55kGQ4HXGvee9S1/AYIu1CtQQ4/BpY=;
        b=DCXoaWkhnLkKNdc3a5unBMS950o89b6bPB52ODeVYhwBFVt7056/KkG28kI+bgcClc
         FtzvndyyVttYmHiPNOPV+/Ys4s4C4qp+K2lXsxuKVgJN6LE9/ttRiBcNFxUM5k4V0obD
         EwDP8V6AkvvWm6Ac+CHiL7B3NupUsD4ZUexW/HZRG6CpPunRyZy+0Rg7pgcAGPT3Rmxp
         0hvUuvzjOxHhQe+Ur/GzkLhv/uCyvjwDDsYbq4rrtUjb/EMCnU/SeX27kBPM4/RqHkpf
         mmsdUKpTLbZYGJiDmqNnKbTcJTgVsJQVL77pXWQKLxueXgWDhSxKnk5LbSEvll50NsjQ
         FL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XHvhDxDm3h+Bg55kGQ4HXGvee9S1/AYIu1CtQQ4/BpY=;
        b=B2DDCypDB1fj6bWdileQ1jCEMbXJ8uxYgSBqjxEu0Wz8acV1XOmIJvwoGv4e3N9L2K
         0DFRx+mnv78B0JXWj/q+XZUdpFJHUxJGNh8WWymRbgK2iACpzO0x6CEy9USIb5pGW/PO
         H6bOILdNKA2EYqhQxcG9IXOLp6xxPdVaoxML7A5/y72OoYBsaK/xsVpI504r65+r1lp+
         itebBtm6SttNdEOPAsjU9DJGPBKfQ44JkaSCBkxq41LMRbvuvCiFrb4OdP/iUBGQbi82
         8m55AYDXy4o4+7lmfzlNat0iQ8FeNtEwpEvIsHDriMlrzNw3nOKoXzEo2QfqWcVfvDkd
         mgbA==
X-Gm-Message-State: AOAM531lCuwy2npgeHJqSN1DFcDgT/Live6iuvWf/yCBj+swLNIKlg4V
        5UiyOyz5OL6/r479UQLMYlJihL3m
X-Google-Smtp-Source: ABdhPJyem2GPUXTlr0KXHwD5rIeBPNVIBYoE1s/zPAlaZnStaFLoGfn8P0bQsl04T71qk3pAxY3YlQ==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr4868534wrn.16.1592335246242;
        Tue, 16 Jun 2020 12:20:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm4901132wmi.35.2020.06.16.12.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:45 -0700 (PDT)
Message-Id: <4012d801e3c8e5e0c53731dda9cbd318b629bc9c.1592335242.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:27 +0000
Subject: [PATCH v17 02/17] checkout: add '\n' to reflog message
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

