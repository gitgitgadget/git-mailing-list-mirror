Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0E9C4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B218207A9
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbgLCQAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLCQAg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:00:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35054C061A53
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 07:59:56 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id e7so2380026wrv.6
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 07:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yesJq5wnA0hx591JRBvr15RHg4DTg5H+wnz64O+LGNU=;
        b=iSAYHRbMT9uDMfC2MfIiNOTE8wxbvnrWuuZ96TdqSg7FfvVy58AthSz4wyJ8WvbQXm
         CqmrpBmnhdNymgOISsJgP9hfNEMBBUFgH425ld248nbUJZci3gECI3FwKAU7DZK/zc/t
         yzR62khTqnFX/hcsoqdMy4VMTW5rm7+bMpK3FGZ2MV/eKIlZk7TcbE4eKDVIwkBVKgss
         uAHgTNFBx5RRHELwbJEE3z7ZYgi9ZLMvsFD1Et8k8m3DPgfkJmrqxD6/MBMDin7vRZ2Z
         WzBcMhrV55E0G8dpNKKln/V1JYID1eqVORgcLl4rmeHwklOHrm7IipcytmqCWneHQbIZ
         RVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yesJq5wnA0hx591JRBvr15RHg4DTg5H+wnz64O+LGNU=;
        b=H4Q88aGprOmk5wKF6E+5I01Q29SEQGuRrGIGxZFbwcXX4azFdZ/NQ4+nCYMqGzmgZX
         CDq8rEQiF5kV5COEHMt9OSvnmoKU4ZJ1B2G9DCKXGac8SdIcElQsrY7w9QL6jTqzu5iC
         49dMRNb4cqwBqStDAbIC/apnTHdwlT5WeCVdZiufp95svBZ4gyinE3uwXMTA+0oIYMPh
         xRgfKnpj+g5i2btRm4dLchSdVNRMtDiJWsEv6mgqaBIMSoYgOp7WH9O0D8aLl3gIGRIU
         c64NsqdF/RKaT9t1DHBg+7RDdt99+7eo0Xftdm4z1MwSxJiCmrxQj5rIzseoCOhJboI0
         alsw==
X-Gm-Message-State: AOAM533Em4+cr89dE7VHDSC9xwi7a5eC6ud/KkoFISYKCVkFqNowsqr2
        ekNAwgkTv4a1qEjG2oVqcV4e7k9CwjU=
X-Google-Smtp-Source: ABdhPJxwGQ3GoBxq6d4QAel3dc5EMs/9W8wNhCjFmY9Db5LZJ5Ncst0tOwULWOxEmJt4fJm2TBc+YQ==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr4443109wrm.278.1607011194721;
        Thu, 03 Dec 2020 07:59:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y130sm2219190wmc.22.2020.12.03.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 07:59:54 -0800 (PST)
Message-Id: <fa0881892de9f0089e2ee79f616fbd8fc5a95467.1607011187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.803.git.1607011187.gitgitgadget@gmail.com>
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 15:59:42 +0000
Subject: [PATCH 3/7] merge-ort: add a path_conflict field to
 merge_options_internal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This field is not yet used, but will be used by both the rename handling
code, and the conflict type handling code in process_entry().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 0654c76c8c..bcd53d3799 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -148,6 +148,13 @@ struct conflict_info {
 	/* Whether this path is/was involved in a directory/file conflict */
 	unsigned df_conflict:1;
 
+	/*
+	 * Whether this path is/was involved in a non-content conflict other
+	 * than a directory/file conflict (e.g. rename/rename, rename/delete,
+	 * file location based on possible directory rename).
+	 */
+	unsigned path_conflict:1;
+
 	/*
 	 * For filemask and dirmask, see tree-walk.h's struct traverse_info,
 	 * particularly the documentation above the "fn" member.  Note that
-- 
gitgitgadget

