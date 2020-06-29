Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328A2C433DF
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C4F204EC
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoFmhb/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgF2S5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbgF2S5E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C097C031C43
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g18so17674621wrm.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KeQPSgQHB6GBlCKxDfeccg4JcRy9zHM+z2ewZQFsCEU=;
        b=CoFmhb/uf41v5IKX6Y/2hQlmvYTe8JBlgUccJj0vBfxQA0vc8B7QBZjX7zGXJB2/G8
         bZu+zvAgEVk2FidknZalLNaSJtGY6IfM5s/B6xxKWe8h9ZrylvnqHhuIKZuKA3LeUrYY
         pt08ba4/nGbwqazEpihRTlIRdMNNELR1HIuT8iZm2x0qv6dxi0rk/su2LLZdGIEpVSMZ
         qbcSKUqc/EmlYRcGWMO/JdCsKAc7jI4Uvbde4Be5vRkvfd7McI+MWGYkS2U2PhlwqnBm
         xLSiFkAXWMjF4Yd/9uooj59MEUpjhQeGgtwrcZbg/JNF878yZjnyIJVHtZwE4U9zThB5
         w0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KeQPSgQHB6GBlCKxDfeccg4JcRy9zHM+z2ewZQFsCEU=;
        b=loSJDsjUivJMI+IR29IO5xYSMo7NiWI7QKaYkBnISHjKpb6ZihBWUd5KvyU/+Gn/Hq
         h+qd9cHHZ2AiOe3ITv3+5XZytMA3IIUxc3m33nwa1u8UbHzCgPLM04mIwB67WHoTUEGS
         uUsoJXyPpR/WJI4RnjI7cmbDl3akJF/lwjqs/ZMOLUVvHPsdi3VWOwNTCLK+ioJDWVAu
         A2QXWTQjLr7uWrd0CJf19BrS0c4RlTNAEQpKQl1deOXmd+Kx2oqwYe1a+SptMzFTusp9
         Zase0Z/o5fAFPR0gQobLDo9ayCEym1touSEjy8uNhXMQubSo4u9F/pQ/v7wkql+zL/yE
         R0GQ==
X-Gm-Message-State: AOAM530cAd2OqIKVBQpd059NbQfrjjG9mvEyo2+7Oc14RifNHpbrTIB5
        Jz2RmWsnlDev55QdvTnIBSh+65MoHOw=
X-Google-Smtp-Source: ABdhPJz89WlIDy3ITWT/8zTnjretAuWXLJKADGjeYoQq65V0UQy79ZgBk36gZnd0PPdd8YUSgXauKQ==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr19509645wrm.40.1593457022740;
        Mon, 29 Jun 2020 11:57:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm843791wmc.2.2020.06.29.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:02 -0700 (PDT)
Message-Id: <125695ce92218ca2ddb9868880db542acb0d2a79.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:41 +0000
Subject: [PATCH v19 03/20] checkout: add '\n' to reflog message
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

